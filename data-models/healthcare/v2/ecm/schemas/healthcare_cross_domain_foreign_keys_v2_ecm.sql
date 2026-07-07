-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:16
-- Total cross-domain FK constraints: 2764
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: behavioral_health, billing, claim, clinical, clinical_ai, compliance, consent, digital_health, encounter, facility, finance, genomics, insurance, interoperability, laboratory, order, patient, pharmacy, population_health, post_acute, provider, quality, radiology, reference, research, scheduling, supply, workforce

-- ========= behavioral_health --> clinical (5 constraint(s)) =========
-- Requires: behavioral_health schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);

-- ========= behavioral_health --> consent (4 constraint(s)) =========
-- Requires: behavioral_health schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_consent_record_substance_use_consent_id` FOREIGN KEY (`consent_record_substance_use_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);

-- ========= behavioral_health --> encounter (7 constraint(s)) =========
-- Requires: behavioral_health schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_crisis_visit_id` FOREIGN KEY (`crisis_visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= behavioral_health --> facility (6 constraint(s)) =========
-- Requires: behavioral_health schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= behavioral_health --> patient (12 constraint(s)) =========
-- Requires: behavioral_health schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= behavioral_health --> pharmacy (2 constraint(s)) =========
-- Requires: behavioral_health schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= behavioral_health --> provider (14 constraint(s)) =========
-- Requires: behavioral_health schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_psychiatric_clinician_id` FOREIGN KEY (`psychiatric_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_sud_clinician_id` FOREIGN KEY (`sud_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_mat_clinician_id` FOREIGN KEY (`mat_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_mat_prescribing_clinician_id` FOREIGN KEY (`mat_prescribing_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_otp_clinician_id` FOREIGN KEY (`otp_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_crisis_clinician_id` FOREIGN KEY (`crisis_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_crisis_responding_clinician_id` FOREIGN KEY (`crisis_responding_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ADD CONSTRAINT `fk_behavioral_health_part2_consent_part2_consenting_clinician_id` FOREIGN KEY (`part2_consenting_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= behavioral_health --> reference (1 constraint(s)) =========
-- Requires: behavioral_health schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= billing --> claim (1 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= billing --> consent (1 constraint(s)) =========
-- Requires: billing schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= billing --> encounter (1 constraint(s)) =========
-- Requires: billing schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= billing --> facility (5 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= billing --> finance (1 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= billing --> insurance (3 constraint(s)) =========
-- Requires: billing schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= billing --> order (1 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `vibe_healthcare_v1`.`order`.`fulfillment`(`fulfillment_id`);

-- ========= billing --> patient (3 constraint(s)) =========
-- Requires: billing schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_patient_coverage_id` FOREIGN KEY (`patient_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`patient_coverage`(`patient_coverage_id`);

-- ========= billing --> pharmacy (1 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= billing --> provider (2 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= billing --> reference (5 constraint(s)) =========
-- Requires: billing schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);

-- ========= billing --> supply (3 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= billing --> workforce (5 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_site_employee_id` FOREIGN KEY (`site_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= claim --> billing (5 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);

-- ========= claim --> compliance (4 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);

-- ========= claim --> consent (2 constraint(s)) =========
-- Requires: claim schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_behavioral_health_consent_id` FOREIGN KEY (`behavioral_health_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`behavioral_health_consent`(`behavioral_health_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);

-- ========= claim --> encounter (6 constraint(s)) =========
-- Requires: claim schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= claim --> facility (6 constraint(s)) =========
-- Requires: claim schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= claim --> finance (14 constraint(s)) =========
-- Requires: claim schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= claim --> insurance (16 constraint(s)) =========
-- Requires: claim schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= claim --> interoperability (11 constraint(s)) =========
-- Requires: claim schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= claim --> order (4 constraint(s)) =========
-- Requires: claim schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `vibe_healthcare_v1`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `vibe_healthcare_v1`.`order`.`order_authorization`(`order_authorization_id`);

-- ========= claim --> patient (9 constraint(s)) =========
-- Requires: claim schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_eligibility_mpi_record_id` FOREIGN KEY (`eligibility_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= claim --> provider (12 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= claim --> quality (1 constraint(s)) =========
-- Requires: claim schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);

-- ========= claim --> reference (12 constraint(s)) =========
-- Requires: claim schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= claim --> research (1 constraint(s)) =========
-- Requires: claim schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= claim --> supply (1 constraint(s)) =========
-- Requires: claim schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= claim --> workforce (9 constraint(s)) =========
-- Requires: claim schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_tertiary_appeal_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_appeal_last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`claim`.`attachment` ADD CONSTRAINT `fk_claim_attachment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= clinical --> behavioral_health (29 constraint(s)) =========
-- Requires: clinical schema, behavioral_health schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);

-- ========= clinical --> billing (2 constraint(s)) =========
-- Requires: clinical schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= clinical --> claim (3 constraint(s)) =========
-- Requires: clinical schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_attachment_id` FOREIGN KEY (`attachment_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`attachment`(`attachment_id`);

-- ========= clinical --> clinical_ai (14 constraint(s)) =========
-- Requires: clinical schema, clinical_ai schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_patient_risk_score_id` FOREIGN KEY (`patient_risk_score_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score`(`patient_risk_score_id`);

-- ========= clinical --> compliance (7 constraint(s)) =========
-- Requires: clinical schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= clinical --> consent (1 constraint(s)) =========
-- Requires: clinical schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= clinical --> digital_health (1 constraint(s)) =========
-- Requires: clinical schema, digital_health schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_rpm_device_reading_id` FOREIGN KEY (`rpm_device_reading_id`) REFERENCES `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading`(`rpm_device_reading_id`);

-- ========= clinical --> encounter (22 constraint(s)) =========
-- Requires: clinical schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical --> facility (30 constraint(s)) =========
-- Requires: clinical schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical --> finance (2 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= clinical --> genomics (1 constraint(s)) =========
-- Requires: clinical schema, genomics schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_pharmacogenomics_result_id` FOREIGN KEY (`pharmacogenomics_result_id`) REFERENCES `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result`(`pharmacogenomics_result_id`);

-- ========= clinical --> insurance (7 constraint(s)) =========
-- Requires: clinical schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= clinical --> laboratory (8 constraint(s)) =========
-- Requires: clinical schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_susceptibility_result_id` FOREIGN KEY (`susceptibility_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`susceptibility_result`(`susceptibility_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);

-- ========= clinical --> order (13 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_therapy_order_id` FOREIGN KEY (`therapy_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`therapy_order`(`therapy_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_diet_order_id` FOREIGN KEY (`diet_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical --> patient (31 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= clinical --> pharmacy (8 constraint(s)) =========
-- Requires: clinical schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_medication_therapy_mgmt_id` FOREIGN KEY (`medication_therapy_mgmt_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt`(`medication_therapy_mgmt_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= clinical --> provider (43 constraint(s)) =========
-- Requires: clinical schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_procedure_clinician_id` FOREIGN KEY (`procedure_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_tertiary_procedure_anesthesia_provider_clinician_id` FOREIGN KEY (`tertiary_procedure_anesthesia_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_primary_note_attending_provider_clinician_id` FOREIGN KEY (`primary_note_attending_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_tertiary_note_cosigner_provider_clinician_id` FOREIGN KEY (`tertiary_note_cosigner_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_problem_clinician_id` FOREIGN KEY (`problem_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_tertiary_problem_last_updated_by_provider_clinician_id` FOREIGN KEY (`tertiary_problem_last_updated_by_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_primary_allergy_clinician_id` FOREIGN KEY (`primary_allergy_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_primary_care_physician_clinician_id` FOREIGN KEY (`primary_care_physician_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_tertiary_immunization_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_immunization_ordering_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_primary_care_coordinator_clinician_id` FOREIGN KEY (`primary_care_coordinator_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_tertiary_care_pcp_clinician_id` FOREIGN KEY (`tertiary_care_pcp_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_primary_contact_provider_clinician_id` FOREIGN KEY (`primary_contact_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_primary_care_clinician_id` FOREIGN KEY (`primary_care_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_primary_functional_clinician_id` FOREIGN KEY (`primary_functional_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_primary_nursing_clinician_id` FOREIGN KEY (`primary_nursing_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_procedure_documented_by_clinician_id` FOREIGN KEY (`procedure_documented_by_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_plan_coordinator_clinician_id` FOREIGN KEY (`plan_coordinator_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= clinical --> quality (16 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);

-- ========= clinical --> radiology (6 constraint(s)) =========
-- Requires: clinical schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);

-- ========= clinical --> reference (32 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);

-- ========= clinical --> research (1 constraint(s)) =========
-- Requires: clinical schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= clinical --> supply (7 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= clinical --> workforce (17 constraint(s)) =========
-- Requires: clinical schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_outbreak_employee_id` FOREIGN KEY (`outbreak_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_outbreak_reporting_employee_id` FOREIGN KEY (`outbreak_reporting_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_outbreak_updated_by_user_employee_id` FOREIGN KEY (`outbreak_updated_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= clinical_ai --> clinical (1 constraint(s)) =========
-- Requires: clinical_ai schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);

-- ========= clinical_ai --> encounter (6 constraint(s)) =========
-- Requires: clinical_ai schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_model_visit_id` FOREIGN KEY (`model_visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_feature_store_entity_feature_visit_id` FOREIGN KEY (`feature_visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_feature_store_entity_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical_ai --> facility (1 constraint(s)) =========
-- Requires: clinical_ai schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical_ai --> insurance (2 constraint(s)) =========
-- Requires: clinical_ai schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= clinical_ai --> patient (8 constraint(s)) =========
-- Requires: clinical_ai schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_care_mpi_record_id` FOREIGN KEY (`care_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_model_mpi_record_id` FOREIGN KEY (`model_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_feature_store_entity_feature_mpi_record_id` FOREIGN KEY (`feature_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_feature_store_entity_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= clinical_ai --> provider (1 constraint(s)) =========
-- Requires: clinical_ai schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= clinical_ai --> quality (4 constraint(s)) =========
-- Requires: clinical_ai schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_care_quality_measure_id` FOREIGN KEY (`care_quality_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);

-- ========= clinical_ai --> reference (3 constraint(s)) =========
-- Requires: clinical_ai schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= clinical_ai --> workforce (1 constraint(s)) =========
-- Requires: clinical_ai schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`clinical_ai`.`model_card` ADD CONSTRAINT `fk_clinical_ai_model_card_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= compliance --> clinical (3 constraint(s)) =========
-- Requires: compliance schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);

-- ========= compliance --> encounter (2 constraint(s)) =========
-- Requires: compliance schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= compliance --> facility (13 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= compliance --> finance (16 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> insurance (9 constraint(s)) =========
-- Requires: compliance schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`business_associate_agreement` ADD CONSTRAINT `fk_compliance_business_associate_agreement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_payer_applicability` ADD CONSTRAINT `fk_compliance_policy_payer_applicability_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= compliance --> interoperability (7 constraint(s)) =========
-- Requires: compliance schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);

-- ========= compliance --> patient (3 constraint(s)) =========
-- Requires: compliance schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= compliance --> provider (1 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= compliance --> reference (15 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= compliance --> research (2 constraint(s)) =========
-- Requires: compliance schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_research_regulatory_submission_id` FOREIGN KEY (`research_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_regulatory_submission`(`research_regulatory_submission_id`);

-- ========= compliance --> scheduling (2 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= compliance --> workforce (27 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_tertiary_hipaa_identified_by_employee_id` FOREIGN KEY (`tertiary_hipaa_identified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_primary_compliance_prepared_by_employee_id` FOREIGN KEY (`primary_compliance_prepared_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_tertiary_hotline_employee_id` FOREIGN KEY (`tertiary_hotline_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_investigation_investigator_employee_id` FOREIGN KEY (`investigation_investigator_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_tertiary_osha_employee_id` FOREIGN KEY (`tertiary_osha_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`compliance`.`policy_regulatory_impact` ADD CONSTRAINT `fk_compliance_policy_regulatory_impact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= consent --> behavioral_health (8 constraint(s)) =========
-- Requires: consent schema, behavioral_health schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_part2_consent_workflow_part2_consent_id` FOREIGN KEY (`part2_consent_workflow_part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);

-- ========= consent --> compliance (8 constraint(s)) =========
-- Requires: consent schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_notice_of_privacy_practices_id` FOREIGN KEY (`notice_of_privacy_practices_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= consent --> encounter (13 constraint(s)) =========
-- Requires: consent schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= consent --> facility (22 constraint(s)) =========
-- Requires: consent schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= consent --> insurance (1 constraint(s)) =========
-- Requires: consent schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= consent --> interoperability (7 constraint(s)) =========
-- Requires: consent schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);

-- ========= consent --> patient (27 constraint(s)) =========
-- Requires: consent schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`form_template` ADD CONSTRAINT `fk_consent_form_template_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegation_mpi_record_id` FOREIGN KEY (`delegation_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= consent --> provider (13 constraint(s)) =========
-- Requires: consent schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_tertiary_treatment_performing_provider_clinician_id` FOREIGN KEY (`tertiary_treatment_performing_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= consent --> reference (1 constraint(s)) =========
-- Requires: consent schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= consent --> research (2 constraint(s)) =========
-- Requires: consent schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= consent --> workforce (12 constraint(s)) =========
-- Requires: consent schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_quaternary_delegation_revoked_by_user_employee_id` FOREIGN KEY (`quaternary_delegation_revoked_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_tertiary_delegation_last_updated_by_user_employee_id` FOREIGN KEY (`tertiary_delegation_last_updated_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_tertiary_consent_last_updated_by_user_employee_id` FOREIGN KEY (`tertiary_consent_last_updated_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= digital_health --> encounter (1 constraint(s)) =========
-- Requires: digital_health schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= digital_health --> facility (2 constraint(s)) =========
-- Requires: digital_health schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= digital_health --> patient (13 constraint(s)) =========
-- Requires: digital_health schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`portal_account`(`portal_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device` ADD CONSTRAINT `fk_digital_health_rpm_device_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ADD CONSTRAINT `fk_digital_health_portal_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`portal_session` ADD CONSTRAINT `fk_digital_health_portal_session_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`portal_account`(`portal_account_id`);

-- ========= digital_health --> provider (10 constraint(s)) =========
-- Requires: digital_health schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_rpm_enrolling_clinician_id` FOREIGN KEY (`rpm_enrolling_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_program_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_program_enrollment_rpm_ordering_clinician_id` FOREIGN KEY (`rpm_ordering_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_prom_ordering_clinician_id` FOREIGN KEY (`prom_ordering_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_rpm_enrolling_clinician_id` FOREIGN KEY (`rpm_enrolling_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_rpm_ordering_clinician_id` FOREIGN KEY (`rpm_ordering_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= digital_health --> reference (2 constraint(s)) =========
-- Requires: digital_health schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`device_reading` ADD CONSTRAINT `fk_digital_health_device_reading_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`digital_health`.`alert_threshold` ADD CONSTRAINT `fk_digital_health_alert_threshold_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);

-- ========= encounter --> clinical (1 constraint(s)) =========
-- Requires: encounter schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);

-- ========= encounter --> compliance (4 constraint(s)) =========
-- Requires: encounter schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);

-- ========= encounter --> facility (15 constraint(s)) =========
-- Requires: encounter schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_visit_transfer_destination_facility_care_site_id` FOREIGN KEY (`visit_transfer_destination_facility_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_origin_bed_id` FOREIGN KEY (`origin_bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_primary_transfer_care_site_id` FOREIGN KEY (`primary_transfer_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= encounter --> finance (5 constraint(s)) =========
-- Requires: encounter schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= encounter --> insurance (11 constraint(s)) =========
-- Requires: encounter schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_coverage` ADD CONSTRAINT `fk_encounter_visit_coverage_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_coverage` ADD CONSTRAINT `fk_encounter_visit_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= encounter --> interoperability (5 constraint(s)) =========
-- Requires: encounter schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);

-- ========= encounter --> order (1 constraint(s)) =========
-- Requires: encounter schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);

-- ========= encounter --> patient (17 constraint(s)) =========
-- Requires: encounter schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_visit_mpi_record_id` FOREIGN KEY (`visit_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= encounter --> provider (20 constraint(s)) =========
-- Requires: encounter schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_tertiary_visit_discharging_provider_clinician_id` FOREIGN KEY (`tertiary_visit_discharging_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_tertiary_visit_supervising_provider_clinician_id` FOREIGN KEY (`tertiary_visit_supervising_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_tertiary_discharge_follow_up_provider_clinician_id` FOREIGN KEY (`tertiary_discharge_follow_up_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= encounter --> radiology (1 constraint(s)) =========
-- Requires: encounter schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_interventional_procedure_id` FOREIGN KEY (`interventional_procedure_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`interventional_procedure`(`interventional_procedure_id`);

-- ========= encounter --> reference (11 constraint(s)) =========
-- Requires: encounter schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);

-- ========= encounter --> research (4 constraint(s)) =========
-- Requires: encounter schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= encounter --> supply (4 constraint(s)) =========
-- Requires: encounter schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);

-- ========= encounter --> workforce (10 constraint(s)) =========
-- Requires: encounter schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= facility --> encounter (2 constraint(s)) =========
-- Requires: facility schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= facility --> finance (2 constraint(s)) =========
-- Requires: facility schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= facility --> insurance (2 constraint(s)) =========
-- Requires: facility schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= facility --> patient (2 constraint(s)) =========
-- Requires: facility schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= facility --> provider (3 constraint(s)) =========
-- Requires: facility schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= facility --> quality (1 constraint(s)) =========
-- Requires: facility schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);

-- ========= facility --> reference (2 constraint(s)) =========
-- Requires: facility schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= facility --> supply (2 constraint(s)) =========
-- Requires: facility schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);

-- ========= facility --> workforce (8 constraint(s)) =========
-- Requires: facility schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> facility (14 constraint(s)) =========
-- Requires: finance schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_entity` ADD CONSTRAINT `fk_finance_financial_entity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);

-- ========= finance --> patient (2 constraint(s)) =========
-- Requires: finance schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_identity_merge_history_id` FOREIGN KEY (`identity_merge_history_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`identity_merge_history`(`identity_merge_history_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`donor` ADD CONSTRAINT `fk_finance_donor_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= finance --> provider (1 constraint(s)) =========
-- Requires: finance schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= finance --> radiology (1 constraint(s)) =========
-- Requires: finance schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`modality`(`modality_id`);

-- ========= finance --> reference (1 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);

-- ========= finance --> supply (7 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> workforce (78 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_tertiary_journal_approved_by_user_employee_id` FOREIGN KEY (`tertiary_journal_approved_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fte_budget_id` FOREIGN KEY (`fte_budget_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`fte_budget`(`fte_budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_primary_budget_employee_id` FOREIGN KEY (`primary_budget_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_budget_modified_by_user_employee_id` FOREIGN KEY (`budget_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`budget_transfer` ADD CONSTRAINT `fk_finance_budget_transfer_primary_budget_requestor_employee_id` FOREIGN KEY (`primary_budget_requestor_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_tertiary_ap_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ap_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_tertiary_ar_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ar_last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_capital_modified_by_employee_id` FOREIGN KEY (`capital_modified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_capital_employee_id` FOREIGN KEY (`primary_capital_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_capital_modified_by_employee_id` FOREIGN KEY (`capital_modified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_primary_capital_employee_id` FOREIGN KEY (`primary_capital_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_modified_by_employee_id` FOREIGN KEY (`tertiary_cost_modified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_allocation_modified_by_employee_id` FOREIGN KEY (`allocation_modified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_primary_allocation_employee_id` FOREIGN KEY (`primary_allocation_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_bank_employee_id` FOREIGN KEY (`primary_bank_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_recon_employee_id` FOREIGN KEY (`primary_recon_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_financial_employee_id` FOREIGN KEY (`financial_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_financial_modified_by_employee_id` FOREIGN KEY (`financial_modified_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_close_employee_id` FOREIGN KEY (`primary_close_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_financial_employee_id` FOREIGN KEY (`primary_financial_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_financial_employee_id` FOREIGN KEY (`financial_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_financial_modified_by_user_employee_id` FOREIGN KEY (`financial_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_primary_financial_preparer_employee_id` FOREIGN KEY (`primary_financial_preparer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_payment_employee_id` FOREIGN KEY (`payment_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_primary_batch_employee_id` FOREIGN KEY (`primary_batch_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_approved_by_user_employee_id` FOREIGN KEY (`transaction_approved_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_employee_id` FOREIGN KEY (`transaction_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_modified_by_user_employee_id` FOREIGN KEY (`transaction_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_posted_by_user_employee_id` FOREIGN KEY (`transaction_posted_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_allocation_employee_id` FOREIGN KEY (`allocation_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_primary_run_employee_id` FOREIGN KEY (`primary_run_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_depreciation_employee_id` FOREIGN KEY (`depreciation_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_primary_run_employee_id` FOREIGN KEY (`primary_run_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_recurring_approved_by_user_employee_id` FOREIGN KEY (`recurring_approved_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_recurring_employee_id` FOREIGN KEY (`recurring_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_recurring_modified_by_user_employee_id` FOREIGN KEY (`recurring_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`finance`.`asset_book` ADD CONSTRAINT `fk_finance_asset_book_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= genomics --> laboratory (2 constraint(s)) =========
-- Requires: genomics schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ADD CONSTRAINT `fk_genomics_genetic_variant_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ADD CONSTRAINT `fk_genomics_biobank_specimen_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);

-- ========= genomics --> patient (3 constraint(s)) =========
-- Requires: genomics schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`genetic_variant` ADD CONSTRAINT `fk_genomics_genetic_variant_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`biobank_specimen` ADD CONSTRAINT `fk_genomics_biobank_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ADD CONSTRAINT `fk_genomics_pharmacogenomics_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= genomics --> pharmacy (1 constraint(s)) =========
-- Requires: genomics schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`genomics`.`pharmacogenomics_result` ADD CONSTRAINT `fk_genomics_pharmacogenomics_result_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= insurance --> claim (3 constraint(s)) =========
-- Requires: insurance schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= insurance --> compliance (4 constraint(s)) =========
-- Requires: insurance schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= insurance --> consent (5 constraint(s)) =========
-- Requires: insurance schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_plan_required_consent_form_template_id` FOREIGN KEY (`plan_required_consent_form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);

-- ========= insurance --> encounter (4 constraint(s)) =========
-- Requires: insurance schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= insurance --> facility (4 constraint(s)) =========
-- Requires: insurance schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= insurance --> finance (1 constraint(s)) =========
-- Requires: insurance schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= insurance --> patient (10 constraint(s)) =========
-- Requires: insurance schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_dependent_mpi_record_id` FOREIGN KEY (`dependent_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= insurance --> pharmacy (3 constraint(s)) =========
-- Requires: insurance schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= insurance --> provider (36 constraint(s)) =========
-- Requires: insurance schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_credentialing_application_id` FOREIGN KEY (`credentialing_application_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credentialing_application`(`credentialing_application_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_insurance_clinician_id` FOREIGN KEY (`insurance_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2` ADD CONSTRAINT `fk_insurance_insurance_network_participation2_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);

-- ========= insurance --> quality (2 constraint(s)) =========
-- Requires: insurance schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);

-- ========= insurance --> reference (11 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);

-- ========= insurance --> workforce (1 constraint(s)) =========
-- Requires: insurance schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= interoperability --> clinical (1 constraint(s)) =========
-- Requires: interoperability schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);

-- ========= interoperability --> compliance (2 constraint(s)) =========
-- Requires: interoperability schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);

-- ========= interoperability --> consent (1 constraint(s)) =========
-- Requires: interoperability schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);

-- ========= interoperability --> encounter (11 constraint(s)) =========
-- Requires: interoperability schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= interoperability --> facility (14 constraint(s)) =========
-- Requires: interoperability schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ADD CONSTRAINT `fk_interoperability_interface_engine_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_receiving_facility_care_site_id` FOREIGN KEY (`receiving_facility_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_sending_care_site_id` FOREIGN KEY (`sending_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= interoperability --> finance (2 constraint(s)) =========
-- Requires: interoperability schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ADD CONSTRAINT `fk_interoperability_hie_organization_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`financial_entity`(`financial_entity_id`);

-- ========= interoperability --> patient (14 constraint(s)) =========
-- Requires: interoperability schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_patient_mpi_record_id` FOREIGN KEY (`patient_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= interoperability --> provider (12 constraint(s)) =========
-- Requires: interoperability schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ADD CONSTRAINT `fk_interoperability_trading_partner_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= interoperability --> quality (1 constraint(s)) =========
-- Requires: interoperability schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);

-- ========= interoperability --> reference (9 constraint(s)) =========
-- Requires: interoperability schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_crosswalk_id` FOREIGN KEY (`crosswalk_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`crosswalk`(`crosswalk_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_target_code_set_version_id` FOREIGN KEY (`target_code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);

-- ========= interoperability --> research (1 constraint(s)) =========
-- Requires: interoperability schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= interoperability --> workforce (8 constraint(s)) =========
-- Requires: interoperability schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_tertiary_terminology_modified_by_user_employee_id` FOREIGN KEY (`tertiary_terminology_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> billing (3 constraint(s)) =========
-- Requires: laboratory schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);

-- ========= laboratory --> compliance (17 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_instrument_corrective_action_plan_id` FOREIGN KEY (`instrument_corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_policy_version_id` FOREIGN KEY (`policy_version_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`policy_version`(`policy_version_id`);

-- ========= laboratory --> consent (2 constraint(s)) =========
-- Requires: laboratory schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_genetic_testing_consent_id` FOREIGN KEY (`genetic_testing_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);

-- ========= laboratory --> encounter (9 constraint(s)) =========
-- Requires: laboratory schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= laboratory --> facility (7 constraint(s)) =========
-- Requires: laboratory schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= laboratory --> finance (15 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= laboratory --> insurance (13 constraint(s)) =========
-- Requires: laboratory schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= laboratory --> interoperability (4 constraint(s)) =========
-- Requires: laboratory schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);

-- ========= laboratory --> order (2 constraint(s)) =========
-- Requires: laboratory schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= laboratory --> patient (12 constraint(s)) =========
-- Requires: laboratory schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= laboratory --> provider (10 constraint(s)) =========
-- Requires: laboratory schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_tertiary_lab_cancelled_by_provider_clinician_id` FOREIGN KEY (`tertiary_lab_cancelled_by_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_test_ordering_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_test_resulting_clinician_id` FOREIGN KEY (`test_resulting_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`taxonomy`(`taxonomy_id`);

-- ========= laboratory --> quality (7 constraint(s)) =========
-- Requires: laboratory schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);

-- ========= laboratory --> reference (23 constraint(s)) =========
-- Requires: laboratory schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= laboratory --> research (7 constraint(s)) =========
-- Requires: laboratory schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);

-- ========= laboratory --> scheduling (3 constraint(s)) =========
-- Requires: laboratory schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= laboratory --> supply (10 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= laboratory --> workforce (15 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_specimen_employee_id` FOREIGN KEY (`specimen_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_tertiary_test_amending_user_employee_id` FOREIGN KEY (`tertiary_test_amending_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_transfusion_administering_employee_id` FOREIGN KEY (`transfusion_administering_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_point_performed_by_employee_id` FOREIGN KEY (`point_performed_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_qc_performed_by_employee_id` FOREIGN KEY (`qc_performed_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_instrument_assessor_employee_id` FOREIGN KEY (`instrument_assessor_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> compliance (9 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_hipaa_security_risk_id` FOREIGN KEY (`hipaa_security_risk_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`(`hipaa_security_risk_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= order --> consent (2 constraint(s)) =========
-- Requires: order schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= order --> encounter (9 constraint(s)) =========
-- Requires: order schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= order --> facility (9 constraint(s)) =========
-- Requires: order schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= order --> finance (4 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= order --> insurance (7 constraint(s)) =========
-- Requires: order schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= order --> interoperability (4 constraint(s)) =========
-- Requires: order schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_source_system_event_message_log_id` FOREIGN KEY (`source_system_event_message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);

-- ========= order --> laboratory (1 constraint(s)) =========
-- Requires: order schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);

-- ========= order --> patient (9 constraint(s)) =========
-- Requires: order schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= order --> provider (16 constraint(s)) =========
-- Requires: order schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_tertiary_clinical_authorizing_provider_clinician_id` FOREIGN KEY (`tertiary_clinical_authorizing_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_receiving_provider_clinician_id` FOREIGN KEY (`receiving_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_receiving_clinician_id` FOREIGN KEY (`receiving_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= order --> quality (4 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);

-- ========= order --> reference (13 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= order --> research (7 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= order --> scheduling (1 constraint(s)) =========
-- Requires: order schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= order --> supply (6 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= order --> workforce (21 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_routing_previous_destination_department_org_unit_id` FOREIGN KEY (`routing_previous_destination_department_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing` ADD CONSTRAINT `fk_order_routing_source_department_org_unit_id` FOREIGN KEY (`source_department_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_alert_employee_id` FOREIGN KEY (`alert_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_alert_last_modified_by_user_employee_id` FOREIGN KEY (`alert_last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`order`.`set` ADD CONSTRAINT `fk_order_set_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= patient --> clinical (4 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_team`(`care_team_id`);

-- ========= patient --> clinical_ai (1 constraint(s)) =========
-- Requires: patient schema, clinical_ai schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_care_gap_id` FOREIGN KEY (`care_gap_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`care_gap`(`care_gap_id`);

-- ========= patient --> compliance (1 constraint(s)) =========
-- Requires: patient schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= patient --> consent (1 constraint(s)) =========
-- Requires: patient schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= patient --> encounter (8 constraint(s)) =========
-- Requires: patient schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= patient --> facility (25 constraint(s)) =========
-- Requires: patient schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`contract`(`contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_facility_care_site_id` FOREIGN KEY (`facility_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= patient --> finance (3 constraint(s)) =========
-- Requires: patient schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);

-- ========= patient --> insurance (19 constraint(s)) =========
-- Requires: patient schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_accountable_care_organization_id` FOREIGN KEY (`accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_program_payer_id` FOREIGN KEY (`program_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_accountable_care_organization_id` FOREIGN KEY (`accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= patient --> interoperability (1 constraint(s)) =========
-- Requires: patient schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);

-- ========= patient --> order (1 constraint(s)) =========
-- Requires: patient schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= patient --> pharmacy (1 constraint(s)) =========
-- Requires: patient schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= patient --> provider (27 constraint(s)) =========
-- Requires: patient schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_tertiary_registration_pcp_provider_clinician_id` FOREIGN KEY (`tertiary_registration_pcp_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_tertiary_flag_reviewed_by_provider_clinician_id` FOREIGN KEY (`tertiary_flag_reviewed_by_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`attribution_panel` ADD CONSTRAINT `fk_patient_attribution_panel_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_sdoh_referring_clinician_id` FOREIGN KEY (`sdoh_referring_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_owning_clinician_id` FOREIGN KEY (`sdoh_owning_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_resolving_clinician_id` FOREIGN KEY (`sdoh_resolving_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_responsible_clinician_id` FOREIGN KEY (`sdoh_responsible_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= patient --> quality (9 constraint(s)) =========
-- Requires: patient schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_apm_enrollment_id` FOREIGN KEY (`apm_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`apm_enrollment`(`apm_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`pcp_attribution` ADD CONSTRAINT `fk_patient_pcp_attribution_raf_score_id` FOREIGN KEY (`raf_score_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`raf_score`(`raf_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_care_gap_closure_id` FOREIGN KEY (`care_gap_closure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`care_gap_closure`(`care_gap_closure_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_measure_attribution_id` FOREIGN KEY (`measure_attribution_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_attribution`(`measure_attribution_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_quality_measure_id` FOREIGN KEY (`quality_measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_raf_score_id` FOREIGN KEY (`raf_score_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`raf_score`(`raf_score_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_sdoh_screening_id` FOREIGN KEY (`sdoh_screening_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`sdoh_screening`(`sdoh_screening_id`);

-- ========= patient --> radiology (1 constraint(s)) =========
-- Requires: patient schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= patient --> reference (10 constraint(s)) =========
-- Requires: patient schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`community_resource` ADD CONSTRAINT `fk_patient_community_resource_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ADD CONSTRAINT `fk_patient_sdoh_zcode_mapping_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ADD CONSTRAINT `fk_patient_sdoh_zcode_mapping_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_zcode_mapping` ADD CONSTRAINT `fk_patient_sdoh_zcode_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= patient --> workforce (21 constraint(s)) =========
-- Requires: patient schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`population_segment` ADD CONSTRAINT `fk_patient_population_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_program_care_manager_employee_id` FOREIGN KEY (`program_care_manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_communication_modified_by_user_employee_id` FOREIGN KEY (`communication_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`patient`.`chw_intervention` ADD CONSTRAINT `fk_patient_chw_intervention_primary_chw_employee_id` FOREIGN KEY (`primary_chw_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= pharmacy --> billing (1 constraint(s)) =========
-- Requires: pharmacy schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_billing_network_participation_id` FOREIGN KEY (`billing_network_participation_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_network_participation`(`billing_network_participation_id`);

-- ========= pharmacy --> claim (7 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= pharmacy --> clinical (8 constraint(s)) =========
-- Requires: pharmacy schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= pharmacy --> compliance (20 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);

-- ========= pharmacy --> consent (3 constraint(s)) =========
-- Requires: pharmacy schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= pharmacy --> encounter (10 constraint(s)) =========
-- Requires: pharmacy schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= pharmacy --> facility (9 constraint(s)) =========
-- Requires: pharmacy schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`contract`(`contract_id`);

-- ========= pharmacy --> finance (6 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= pharmacy --> insurance (13 constraint(s)) =========
-- Requires: pharmacy schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_insurance_network_participation2_id` FOREIGN KEY (`insurance_network_participation2_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2`(`insurance_network_participation2_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_third_party_administrator_id` FOREIGN KEY (`third_party_administrator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`third_party_administrator`(`third_party_administrator_id`);

-- ========= pharmacy --> interoperability (22 constraint(s)) =========
-- Requires: pharmacy schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);

-- ========= pharmacy --> laboratory (6 constraint(s)) =========
-- Requires: pharmacy schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= pharmacy --> order (6 constraint(s)) =========
-- Requires: pharmacy schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= pharmacy --> patient (20 constraint(s)) =========
-- Requires: pharmacy schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_prescription_mpi_record_id` FOREIGN KEY (`primary_prescription_mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= pharmacy --> provider (23 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_prescription_clinician_id` FOREIGN KEY (`primary_prescription_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_pharmacy_pharmacist_in_charge_clinician_id` FOREIGN KEY (`pharmacy_pharmacist_in_charge_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_medication_prescriber_clinician_id` FOREIGN KEY (`medication_prescriber_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_medication_reviewing_pharmacist_clinician_id` FOREIGN KEY (`medication_reviewing_pharmacist_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_reviewer_clinician_id` FOREIGN KEY (`reviewer_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_provider_network_participation_id` FOREIGN KEY (`provider_network_participation_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`provider_network_participation`(`provider_network_participation_id`);

-- ========= pharmacy --> quality (6 constraint(s)) =========
-- Requires: pharmacy schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);

-- ========= pharmacy --> reference (17 constraint(s)) =========
-- Requires: pharmacy schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= pharmacy --> research (16 constraint(s)) =========
-- Requires: pharmacy schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_informed_consent_id` FOREIGN KEY (`informed_consent_id`) REFERENCES `vibe_healthcare_v1`.`research`.`informed_consent`(`informed_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_ip_dispensation_id` FOREIGN KEY (`ip_dispensation_id`) REFERENCES `vibe_healthcare_v1`.`research`.`ip_dispensation`(`ip_dispensation_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= pharmacy --> scheduling (1 constraint(s)) =========
-- Requires: pharmacy schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= pharmacy --> supply (8 constraint(s)) =========
-- Requires: pharmacy schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);

-- ========= pharmacy --> workforce (18 constraint(s)) =========
-- Requires: pharmacy schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mar_administering_provider_employee_id` FOREIGN KEY (`mar_administering_provider_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_pharmacy_pharmacist_in_charge_employee_id` FOREIGN KEY (`pharmacy_pharmacist_in_charge_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_medication_reviewing_pharmacist_employee_id` FOREIGN KEY (`medication_reviewing_pharmacist_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= population_health --> insurance (1 constraint(s)) =========
-- Requires: population_health schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_definition_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);

-- ========= population_health --> patient (2 constraint(s)) =========
-- Requires: population_health schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` ADD CONSTRAINT `fk_population_health_trial_match_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= population_health --> quality (1 constraint(s)) =========
-- Requires: population_health schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`measure`(`measure_id`);

-- ========= population_health --> research (1 constraint(s)) =========
-- Requires: population_health schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`trial_match_evaluation` ADD CONSTRAINT `fk_population_health_trial_match_evaluation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= population_health --> workforce (1 constraint(s)) =========
-- Requires: population_health schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`population_health`.`cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_definition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= post_acute --> encounter (1 constraint(s)) =========
-- Requires: post_acute schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ADD CONSTRAINT `fk_post_acute_snf_stay_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= post_acute --> facility (3 constraint(s)) =========
-- Requires: post_acute schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ADD CONSTRAINT `fk_post_acute_snf_stay_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ADD CONSTRAINT `fk_post_acute_home_health_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ADD CONSTRAINT `fk_post_acute_hospice_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= post_acute --> insurance (3 constraint(s)) =========
-- Requires: post_acute schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ADD CONSTRAINT `fk_post_acute_snf_stay_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ADD CONSTRAINT `fk_post_acute_home_health_episode_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ADD CONSTRAINT `fk_post_acute_hospice_episode_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= post_acute --> patient (3 constraint(s)) =========
-- Requires: post_acute schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`snf_stay` ADD CONSTRAINT `fk_post_acute_snf_stay_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`home_health_episode` ADD CONSTRAINT `fk_post_acute_home_health_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`post_acute`.`hospice_episode` ADD CONSTRAINT `fk_post_acute_hospice_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= provider --> compliance (8 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`investigation`(`investigation_id`);

-- ========= provider --> facility (14 constraint(s)) =========
-- Requires: provider schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`affiliation_history` ADD CONSTRAINT `fk_provider_affiliation_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`committee` ADD CONSTRAINT `fk_provider_committee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`location_specialty` ADD CONSTRAINT `fk_provider_location_specialty_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= provider --> finance (5 constraint(s)) =========
-- Requires: provider schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= provider --> insurance (9 constraint(s)) =========
-- Requires: provider schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_insurance_payer_enrollment_id` FOREIGN KEY (`insurance_payer_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment`(`insurance_payer_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_insurance_network_participation2_id` FOREIGN KEY (`insurance_network_participation2_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation2`(`insurance_network_participation2_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_network_participation` ADD CONSTRAINT `fk_provider_provider_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= provider --> pharmacy (1 constraint(s)) =========
-- Requires: provider schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= provider --> quality (2 constraint(s)) =========
-- Requires: provider schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`sanction` ADD CONSTRAINT `fk_provider_sanction_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);

-- ========= provider --> reference (7 constraint(s)) =========
-- Requires: provider schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`npi_registry`(`npi_registry_id`);

-- ========= provider --> research (1 constraint(s)) =========
-- Requires: provider schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`study_team_member` ADD CONSTRAINT `fk_provider_study_team_member_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= provider --> supply (1 constraint(s)) =========
-- Requires: provider schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= provider --> workforce (7 constraint(s)) =========
-- Requires: provider schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credential` ADD CONSTRAINT `fk_provider_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`assignment` ADD CONSTRAINT `fk_provider_assignment_assignment_employee_id` FOREIGN KEY (`assignment_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> billing (5 constraint(s)) =========
-- Requires: quality schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= quality --> claim (1 constraint(s)) =========
-- Requires: quality schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= quality --> clinical (1 constraint(s)) =========
-- Requires: quality schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_cdi_worksheet_id` FOREIGN KEY (`cdi_worksheet_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`cdi_worksheet`(`cdi_worksheet_id`);

-- ========= quality --> clinical_ai (1 constraint(s)) =========
-- Requires: quality schema, clinical_ai schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_care_gap_id` FOREIGN KEY (`care_gap_id`) REFERENCES `vibe_healthcare_v1`.`clinical_ai`.`care_gap`(`care_gap_id`);

-- ========= quality --> compliance (17 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= quality --> encounter (12 constraint(s)) =========
-- Requires: quality schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_bed_assignment_id` FOREIGN KEY (`bed_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`bed_assignment`(`bed_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_triage_assessment_id` FOREIGN KEY (`triage_assessment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`triage_assessment`(`triage_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_drg_assignment_id` FOREIGN KEY (`drg_assignment_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`drg_assignment`(`drg_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= quality --> facility (39 constraint(s)) =========
-- Requires: quality schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_environmental_service_request_id` FOREIGN KEY (`environmental_service_request_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`environmental_service_request`(`environmental_service_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_hazardous_material_id` FOREIGN KEY (`hazardous_material_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`hazardous_material`(`hazardous_material_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_network_contract_id` FOREIGN KEY (`network_contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`network_contract`(`network_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= quality --> finance (10 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> insurance (27 constraint(s)) =========
-- Requires: quality schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_program` ADD CONSTRAINT `fk_quality_accreditation_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_member_member_enrollment_id` FOREIGN KEY (`member_member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_accountable_care_organization_id` FOREIGN KEY (`accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= quality --> interoperability (4 constraint(s)) =========
-- Requires: quality schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`vbp_program` ADD CONSTRAINT `fk_quality_vbp_program_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_onboarding_project_id` FOREIGN KEY (`onboarding_project_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`onboarding_project`(`onboarding_project_id`);

-- ========= quality --> order (1 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= quality --> patient (21 constraint(s)) =========
-- Requires: quality schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_sdoh_risk_stratification_id` FOREIGN KEY (`sdoh_risk_stratification_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_risk_stratification`(`sdoh_risk_stratification_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_sdoh_need_closure_id` FOREIGN KEY (`sdoh_need_closure_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_need_closure`(`sdoh_need_closure_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_attribution_panel_id` FOREIGN KEY (`attribution_panel_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`attribution_panel`(`attribution_panel_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_sdoh_referral_id` FOREIGN KEY (`sdoh_referral_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`sdoh_referral`(`sdoh_referral_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= quality --> provider (40 constraint(s)) =========
-- Requires: quality schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_reviewer_provider_clinician_id` FOREIGN KEY (`reviewer_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_quality_reviewed_clinician_id` FOREIGN KEY (`quality_reviewed_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_reviewer_clinician_id` FOREIGN KEY (`reviewer_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_population_pcp_clinician_id` FOREIGN KEY (`population_pcp_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_measure_clinician_id` FOREIGN KEY (`measure_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_attribution` ADD CONSTRAINT `fk_quality_measure_attribution_measure_org_provider_id` FOREIGN KEY (`measure_org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_care_clinician_id` FOREIGN KEY (`care_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_care_closed_by_clinician_id` FOREIGN KEY (`care_closed_by_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_raf_clinician_id` FOREIGN KEY (`raf_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`raf_score` ADD CONSTRAINT `fk_quality_raf_score_raf_pcp_clinician_id` FOREIGN KEY (`raf_pcp_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mips_measure_reporting` ADD CONSTRAINT `fk_quality_mips_measure_reporting_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`apm_enrollment` ADD CONSTRAINT `fk_quality_apm_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`committee`(`committee_id`);

-- ========= quality --> radiology (3 constraint(s)) =========
-- Requires: quality schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_radiology_appointment_id` FOREIGN KEY (`radiology_appointment_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_appointment`(`radiology_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`report`(`report_id`);

-- ========= quality --> reference (11 constraint(s)) =========
-- Requires: quality schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_measure` ADD CONSTRAINT `fk_quality_hedis_measure_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure` ADD CONSTRAINT `fk_quality_measure_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`measure_result` ADD CONSTRAINT `fk_quality_measure_result_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);

-- ========= quality --> research (5 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);

-- ========= quality --> supply (3 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`udi_record`(`udi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= quality --> workforce (12 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`improvement_initiative` ADD CONSTRAINT `fk_quality_improvement_initiative_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= radiology --> billing (1 constraint(s)) =========
-- Requires: radiology schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);

-- ========= radiology --> claim (2 constraint(s)) =========
-- Requires: radiology schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);

-- ========= radiology --> clinical (4 constraint(s)) =========
-- Requires: radiology schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cdi_query_id` FOREIGN KEY (`cdi_query_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`cdi_query`(`cdi_query_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_clinical_finding_id` FOREIGN KEY (`clinical_finding_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`clinical_finding`(`clinical_finding_id`);

-- ========= radiology --> compliance (10 constraint(s)) =========
-- Requires: radiology schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);

-- ========= radiology --> consent (2 constraint(s)) =========
-- Requires: radiology schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= radiology --> encounter (16 constraint(s)) =========
-- Requires: radiology schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= radiology --> facility (22 constraint(s)) =========
-- Requires: radiology schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_radiology_room_id` FOREIGN KEY (`radiology_room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_report_recipient_care_site_id` FOREIGN KEY (`report_recipient_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`contract`(`contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_network_contract_id` FOREIGN KEY (`network_contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`network_contract`(`network_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= radiology --> finance (3 constraint(s)) =========
-- Requires: radiology schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= radiology --> insurance (8 constraint(s)) =========
-- Requires: radiology schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= radiology --> interoperability (16 constraint(s)) =========
-- Requires: radiology schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= radiology --> laboratory (2 constraint(s)) =========
-- Requires: radiology schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= radiology --> order (10 constraint(s)) =========
-- Requires: radiology schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_routing_rule_id` FOREIGN KEY (`routing_rule_id`) REFERENCES `vibe_healthcare_v1`.`order`.`routing_rule`(`routing_rule_id`);

-- ========= radiology --> patient (15 constraint(s)) =========
-- Requires: radiology schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= radiology --> pharmacy (4 constraint(s)) =========
-- Requires: radiology schema, pharmacy schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= radiology --> provider (33 constraint(s)) =========
-- Requires: radiology schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_tertiary_report_reading_radiologist_clinician_id` FOREIGN KEY (`tertiary_report_reading_radiologist_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_tertiary_report_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_report_ordering_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_radiology_clinician_id` FOREIGN KEY (`radiology_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_tertiary_radiology_referring_provider_clinician_id` FOREIGN KEY (`tertiary_radiology_referring_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_primary_critical_clinician_id` FOREIGN KEY (`primary_critical_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_tertiary_critical_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_critical_ordering_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_teleradiology_reading_clinician_id` FOREIGN KEY (`teleradiology_reading_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_primary_follow_clinician_id` FOREIGN KEY (`primary_follow_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_primary_interventional_clinician_id` FOREIGN KEY (`primary_interventional_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_primary_operator_clinician_id` FOREIGN KEY (`primary_operator_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_radiology_reading_clinician_id` FOREIGN KEY (`radiology_reading_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_radiology_original_reader_clinician_id` FOREIGN KEY (`radiology_original_reader_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_radiology_reviewed_clinician_id` FOREIGN KEY (`radiology_reviewed_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_radiology_reviewing_clinician_id` FOREIGN KEY (`radiology_reviewing_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_reviewer_clinician_id` FOREIGN KEY (`reviewer_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_radiology_reading_radiologist_clinician_id` FOREIGN KEY (`radiology_reading_radiologist_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= radiology --> quality (1 constraint(s)) =========
-- Requires: radiology schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);

-- ========= radiology --> reference (24 constraint(s)) =========
-- Requires: radiology schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_radiology_visit_reason_icd_code_id` FOREIGN KEY (`radiology_visit_reason_icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= radiology --> research (10 constraint(s)) =========
-- Requires: radiology schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= radiology --> scheduling (5 constraint(s)) =========
-- Requires: radiology schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_enterprise_appointment_id` FOREIGN KEY (`enterprise_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= radiology --> supply (6 constraint(s)) =========
-- Requires: radiology schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= radiology --> workforce (20 constraint(s)) =========
-- Requires: radiology schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_radiology_changed_by_employee_id` FOREIGN KEY (`radiology_changed_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= research --> billing (5 constraint(s)) =========
-- Requires: research schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`patient_account`(`patient_account_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`charge`(`charge_id`);

-- ========= research --> claim (2 constraint(s)) =========
-- Requires: research schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_line_id` FOREIGN KEY (`line_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`line`(`line_id`);

-- ========= research --> clinical (5 constraint(s)) =========
-- Requires: research schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= research --> compliance (22 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_exclusion_screening_id` FOREIGN KEY (`exclusion_screening_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`exclusion_screening`(`exclusion_screening_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ADD CONSTRAINT `fk_research_study_sponsor_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);

-- ========= research --> consent (5 constraint(s)) =========
-- Requires: research schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_genetic_testing_consent_id` FOREIGN KEY (`genetic_testing_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_form_template_id` FOREIGN KEY (`form_template_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`form_template`(`form_template_id`);

-- ========= research --> encounter (3 constraint(s)) =========
-- Requires: research schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= research --> facility (32 constraint(s)) =========
-- Requires: research schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= research --> finance (7 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_grant_grant_id` FOREIGN KEY (`grant_grant_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`grant`(`grant_id`);

-- ========= research --> insurance (3 constraint(s)) =========
-- Requires: research schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= research --> interoperability (5 constraint(s)) =========
-- Requires: research schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_data_use_agreement_id` FOREIGN KEY (`data_use_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_data_use_agreement_id` FOREIGN KEY (`data_use_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);

-- ========= research --> laboratory (4 constraint(s)) =========
-- Requires: research schema, laboratory schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_lab_charge_id` FOREIGN KEY (`lab_charge_id`) REFERENCES `vibe_healthcare_v1`.`laboratory`.`lab_charge`(`lab_charge_id`);

-- ========= research --> patient (6 constraint(s)) =========
-- Requires: research schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= research --> provider (9 constraint(s)) =========
-- Requires: research schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= research --> radiology (1 constraint(s)) =========
-- Requires: research schema, radiology schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `vibe_healthcare_v1`.`radiology`.`radiology_study`(`radiology_study_id`);

-- ========= research --> reference (8 constraint(s)) =========
-- Requires: research schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= research --> supply (9 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= research --> workforce (29 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_tertiary_irb_reviewed_by_user_employee_id` FOREIGN KEY (`tertiary_irb_reviewed_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_informed_last_modified_by_user_employee_id` FOREIGN KEY (`informed_last_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_primary_informed_employee_id` FOREIGN KEY (`primary_informed_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ADD CONSTRAINT `fk_research_deidentified_dataset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_data_requestor_employee_id` FOREIGN KEY (`data_requestor_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_trainee_employee_id` FOREIGN KEY (`investigational_trainee_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_trainer_employee_id` FOREIGN KEY (`investigational_trainer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_research_uploaded_by_employee_id` FOREIGN KEY (`research_uploaded_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= scheduling --> billing (2 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `vibe_healthcare_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= scheduling --> claim (4 constraint(s)) =========
-- Requires: scheduling schema, claim schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_healthcare_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= scheduling --> clinical (11 constraint(s)) =========
-- Requires: scheduling schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= scheduling --> compliance (5 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= scheduling --> consent (2 constraint(s)) =========
-- Requires: scheduling schema, consent schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_consent_id` FOREIGN KEY (`telehealth_consent_id`) REFERENCES `vibe_healthcare_v1`.`consent`.`telehealth_consent`(`telehealth_consent_id`);

-- ========= scheduling --> encounter (5 constraint(s)) =========
-- Requires: scheduling schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= scheduling --> facility (36 constraint(s)) =========
-- Requires: scheduling schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`contract`(`contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);

-- ========= scheduling --> finance (7 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= scheduling --> insurance (11 constraint(s)) =========
-- Requires: scheduling schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= scheduling --> interoperability (1 constraint(s)) =========
-- Requires: scheduling schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);

-- ========= scheduling --> order (4 constraint(s)) =========
-- Requires: scheduling schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`referral_order`(`referral_order_id`);

-- ========= scheduling --> patient (13 constraint(s)) =========
-- Requires: scheduling schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`message_template`(`message_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= scheduling --> provider (22 constraint(s)) =========
-- Requires: scheduling schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_board_certification_id` FOREIGN KEY (`board_certification_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`board_certification`(`board_certification_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_authorization_id` FOREIGN KEY (`telehealth_authorization_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`telehealth_authorization`(`telehealth_authorization_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`credential`(`credential_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_primary_booking_clinician_id` FOREIGN KEY (`primary_booking_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_scheduling_provider_clinician_id` FOREIGN KEY (`scheduling_provider_clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= scheduling --> quality (2 constraint(s)) =========
-- Requires: scheduling schema, quality schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `vibe_healthcare_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);

-- ========= scheduling --> reference (11 constraint(s)) =========
-- Requires: scheduling schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= scheduling --> research (5 constraint(s)) =========
-- Requires: scheduling schema, research schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= scheduling --> supply (5 constraint(s)) =========
-- Requires: scheduling schema, supply schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`udi_record`(`udi_record_id`);

-- ========= scheduling --> workforce (37 constraint(s)) =========
-- Requires: scheduling schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_tertiary_schedule_approved_by_user_employee_id` FOREIGN KEY (`tertiary_schedule_approved_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_tertiary_resource_requested_by_user_employee_id` FOREIGN KEY (`tertiary_resource_requested_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_tertiary_patient_modified_by_user_employee_id` FOREIGN KEY (`tertiary_patient_modified_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_provider_employee_id` FOREIGN KEY (`provider_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_tertiary_provider_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_provider_cancelled_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_surgical_employee_id` FOREIGN KEY (`surgical_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_tertiary_surgical_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_surgical_cancelled_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_primary_booking_requested_department_workforce_org_unit_id` FOREIGN KEY (`primary_booking_requested_department_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_tertiary_equipment_requested_by_user_employee_id` FOREIGN KEY (`tertiary_equipment_requested_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_reminder_workforce_org_unit_id` FOREIGN KEY (`reminder_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= supply --> clinical (1 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `vibe_healthcare_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= supply --> compliance (11 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_policy_version_id` FOREIGN KEY (`policy_version_id`) REFERENCES `vibe_healthcare_v1`.`compliance`.`policy_version`(`policy_version_id`);

-- ========= supply --> encounter (2 constraint(s)) =========
-- Requires: supply schema, encounter schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_healthcare_v1`.`encounter`.`visit`(`visit_id`);

-- ========= supply --> facility (22 constraint(s)) =========
-- Requires: supply schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_sterilizer_equipment_asset_id` FOREIGN KEY (`sterilizer_equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= supply --> finance (16 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_vendor_default_chart_of_accounts_id` FOREIGN KEY (`vendor_default_chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= supply --> insurance (1 constraint(s)) =========
-- Requires: supply schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= supply --> interoperability (4 constraint(s)) =========
-- Requires: supply schema, interoperability schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_terminology_mapping_id` FOREIGN KEY (`terminology_mapping_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);

-- ========= supply --> order (7 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_set_id` FOREIGN KEY (`set_id`) REFERENCES `vibe_healthcare_v1`.`order`.`set`(`set_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `vibe_healthcare_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= supply --> patient (1 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `vibe_healthcare_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= supply --> provider (4 constraint(s)) =========
-- Requires: supply schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_preference_card_id` FOREIGN KEY (`preference_card_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`preference_card`(`preference_card_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_committee_id` FOREIGN KEY (`committee_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`committee`(`committee_id`);

-- ========= supply --> reference (7 constraint(s)) =========
-- Requires: supply schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= supply --> scheduling (1 constraint(s)) =========
-- Requires: supply schema, scheduling schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= supply --> workforce (24 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_tertiary_surgical_supply_chain_owner_employee_id` FOREIGN KEY (`tertiary_surgical_supply_chain_owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_tertiary_case_delivered_by_employee_id` FOREIGN KEY (`tertiary_case_delivered_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_vendor_contract_manager_employee_id` FOREIGN KEY (`vendor_contract_manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_material_approved_by_employee_id` FOREIGN KEY (`material_approved_by_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> facility (11 constraint(s)) =========
-- Requires: workforce schema, facility schema
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= workforce --> finance (7 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_healthcare_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> insurance (2 constraint(s)) =========
-- Requires: workforce schema, insurance schema
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= workforce --> provider (3 constraint(s)) =========
-- Requires: workforce schema, provider schema
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `vibe_healthcare_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= workforce --> reference (1 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`cpt_code`(`cpt_code_id`);

