-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:28
-- Total cross-domain FK constraints: 1559
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, distribution, finance, laboratory, metering, project, quality, service, supply, treatment, wastewater, workforce

-- ========= asset --> billing (1 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= asset --> compliance (4 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ADD CONSTRAINT `fk_asset_compliance_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> customer (4 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);

-- ========= asset --> finance (9 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ADD CONSTRAINT `fk_asset_grant_funding_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);

-- ========= asset --> laboratory (6 constraint(s)) =========
-- Requires: asset schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);

-- ========= asset --> metering (2 constraint(s)) =========
-- Requires: asset schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_canonical_metering_meter_id` FOREIGN KEY (`canonical_metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= asset --> project (7 constraint(s)) =========
-- Requires: asset schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`design_contract`(`design_contract_id`);

-- ========= asset --> quality (6 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ADD CONSTRAINT `fk_asset_asset_sampling_point_canonical_quality_sampling_point_id` FOREIGN KEY (`canonical_quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ADD CONSTRAINT `fk_asset_asset_sampling_point_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= asset --> supply (13 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_default_vendor_id` FOREIGN KEY (`procurement_default_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_preferred_vendor_id` FOREIGN KEY (`procurement_preferred_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_vendor_id` FOREIGN KEY (`procurement_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= asset --> treatment (5 constraint(s)) =========
-- Requires: asset schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= asset --> workforce (19 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_condition_employee_id` FOREIGN KEY (`condition_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_condition_reviewed_by_employee_id` FOREIGN KEY (`condition_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_primary_condition_employee_id` FOREIGN KEY (`primary_condition_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_tertiary_condition_approved_by_employee_id` FOREIGN KEY (`tertiary_condition_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_job_work_center_org_unit_id` FOREIGN KEY (`job_work_center_org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_primary_inspection_approved_by_employee_id` FOREIGN KEY (`primary_inspection_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ADD CONSTRAINT `fk_asset_prediction_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ADD CONSTRAINT `fk_asset_prediction_event_prediction_reviewed_by_employee_id` FOREIGN KEY (`prediction_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> asset (4 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= billing --> customer (15 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_canonical_customer_account_id` FOREIGN KEY (`canonical_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_canonical_customer_assistance_enrollment_id` FOREIGN KEY (`canonical_customer_assistance_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment`(`customer_assistance_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_customer_assistance_enrollment_id` FOREIGN KEY (`customer_assistance_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment`(`customer_assistance_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_person_id` FOREIGN KEY (`person_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`person`(`person_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> distribution (7 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_network_isolation_event_id` FOREIGN KEY (`network_isolation_event_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_isolation_event`(`network_isolation_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= billing --> finance (13 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> laboratory (3 constraint(s)) =========
-- Requires: billing schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);

-- ========= billing --> metering (1 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_interval_consumption_id` FOREIGN KEY (`interval_consumption_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`interval_consumption`(`interval_consumption_id`);

-- ========= billing --> project (5 constraint(s)) =========
-- Requires: billing schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= billing --> quality (2 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= billing --> service (10 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);

-- ========= billing --> treatment (3 constraint(s)) =========
-- Requires: billing schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_violation`(`treatment_violation_id`);

-- ========= billing --> wastewater (1 constraint(s)) =========
-- Requires: billing schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);

-- ========= billing --> workforce (30 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_received_by_user_employee_id` FOREIGN KEY (`payment_received_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_employee_id` FOREIGN KEY (`payment_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_initiated_by_user_employee_id` FOREIGN KEY (`adjustment_initiated_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_primary_adjustment_employee_id` FOREIGN KEY (`primary_adjustment_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_payment_employee_id` FOREIGN KEY (`payment_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_collection_generated_by_employee_id` FOREIGN KEY (`collection_generated_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_collection_responsible_employee_id` FOREIGN KEY (`collection_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_billing_employee_id` FOREIGN KEY (`billing_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_assigned_to_user_employee_id` FOREIGN KEY (`dispute_assigned_to_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_dispute_employee_id` FOREIGN KEY (`dispute_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_write_approved_by_employee_id` FOREIGN KEY (`write_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_write_created_by_user_employee_id` FOREIGN KEY (`write_created_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_write_employee_id` FOREIGN KEY (`write_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_lien_released_by_user_employee_id` FOREIGN KEY (`lien_released_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_primary_lien_employee_id` FOREIGN KEY (`primary_lien_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_revenue_employee_id` FOREIGN KEY (`revenue_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> asset (7 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= compliance --> billing (2 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= compliance --> finance (15 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ADD CONSTRAINT `fk_compliance_permit_grant_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ADD CONSTRAINT `fk_compliance_permit_grant_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ADD CONSTRAINT `fk_compliance_permit_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);

-- ========= compliance --> laboratory (21 constraint(s)) =========
-- Requires: compliance schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_laboratory_corrective_action_id` FOREIGN KEY (`laboratory_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action`(`laboratory_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_lab_work_order_id` FOREIGN KEY (`lab_work_order_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_work_order`(`lab_work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= compliance --> project (9 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= compliance --> quality (8 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);

-- ========= compliance --> supply (13 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ADD CONSTRAINT `fk_compliance_permit_vendor_service_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ADD CONSTRAINT `fk_compliance_permit_vendor_service_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ADD CONSTRAINT `fk_compliance_permit_vendor_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ADD CONSTRAINT `fk_compliance_material_compliance_certification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ADD CONSTRAINT `fk_compliance_material_compliance_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= compliance --> treatment (20 constraint(s)) =========
-- Requires: compliance schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_finished_water_production_id` FOREIGN KEY (`finished_water_production_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`finished_water_production`(`finished_water_production_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_mor_wtp_facility_id` FOREIGN KEY (`mor_wtp_facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_compliance_treatment_violation_id` FOREIGN KEY (`compliance_treatment_violation_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= compliance --> wastewater (9 constraint(s)) =========
-- Requires: compliance schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_dmr_submission_id` FOREIGN KEY (`dmr_submission_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`dmr_submission`(`dmr_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_cso_event_id` FOREIGN KEY (`cso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`cso_event`(`cso_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_lift_station_id` FOREIGN KEY (`lift_station_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`lift_station`(`lift_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sso_event`(`sso_event_id`);

-- ========= compliance --> workforce (35 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_compliance_responsible_employee_id` FOREIGN KEY (`compliance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_compliance_responsible_operator_employee_id` FOREIGN KEY (`compliance_responsible_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_obligation_responsible_employee_id` FOREIGN KEY (`obligation_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_dmr_modified_by_user_employee_id` FOREIGN KEY (`dmr_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_compliance_discovered_by_employee_id` FOREIGN KEY (`compliance_discovered_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_compliance_responsible_employee_id` FOREIGN KEY (`compliance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_compliance_employee_id` FOREIGN KEY (`compliance_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_primary_compliance_employee_id` FOREIGN KEY (`primary_compliance_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_compliance_responsible_employee_id` FOREIGN KEY (`compliance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_overflow_reported_by_employee_id` FOREIGN KEY (`overflow_reported_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_overflow_responsible_employee_id` FOREIGN KEY (`overflow_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_regulatory_employee_id` FOREIGN KEY (`regulatory_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ADD CONSTRAINT `fk_compliance_material_compliance_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_crew_supervisor_employee_id` FOREIGN KEY (`crew_supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> asset (8 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_customer_verification_document_id` FOREIGN KEY (`customer_verification_document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_asset_responsibility` ADD CONSTRAINT `fk_customer_account_asset_responsibility_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= customer --> billing (11 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_account_payment_plan_id` FOREIGN KEY (`account_payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_billing_assistance_enrollment_id` FOREIGN KEY (`billing_assistance_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment`(`billing_assistance_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_customer_canonical_billing_assistance_enrollment_id` FOREIGN KEY (`customer_canonical_billing_assistance_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_assistance_enrollment`(`billing_assistance_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_deposit_refund_payment_id` FOREIGN KEY (`deposit_refund_payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (8 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_enforcement_impact` ADD CONSTRAINT `fk_customer_account_enforcement_impact_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`overflow_event`(`overflow_event_id`);

-- ========= customer --> distribution (8 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= customer --> finance (11 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);

-- ========= customer --> laboratory (1 constraint(s)) =========
-- Requires: customer schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_participation` ADD CONSTRAINT `fk_customer_sampling_participation_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= customer --> metering (4 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_metering_complaint_id` FOREIGN KEY (`metering_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_complaint`(`metering_complaint_id`);

-- ========= customer --> project (7 constraint(s)) =========
-- Requires: customer schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`project_stakeholder` ADD CONSTRAINT `fk_customer_project_stakeholder_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= customer --> quality (2 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`sampling_site` ADD CONSTRAINT `fk_customer_sampling_site_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= customer --> service (23 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_primary_service_rate_schedule_id` FOREIGN KEY (`primary_service_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_special_contract_id` FOREIGN KEY (`special_contract_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`special_contract`(`special_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_service_program_enrollment_id` FOREIGN KEY (`service_program_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_program_enrollment`(`service_program_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= customer --> treatment (1 constraint(s)) =========
-- Requires: customer schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= customer --> wastewater (1 constraint(s)) =========
-- Requires: customer schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_effluent_parameter_result_id` FOREIGN KEY (`effluent_parameter_result_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result`(`effluent_parameter_result_id`);

-- ========= customer --> workforce (42 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_responsible_employee_id` FOREIGN KEY (`service_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_assigned_to_user_employee_id` FOREIGN KEY (`service_assigned_to_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_employee_id` FOREIGN KEY (`service_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_account_employee_id` FOREIGN KEY (`account_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`assistance_program` ADD CONSTRAINT `fk_customer_assistance_program_assistance_responsible_employee_id` FOREIGN KEY (`assistance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_customer_created_by_employee_id` FOREIGN KEY (`customer_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_customer_enrolled_by_employee_id` FOREIGN KEY (`customer_enrolled_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_customer_responsible_employee_id` FOREIGN KEY (`customer_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_account_reviewed_by_user_employee_id` FOREIGN KEY (`account_reviewed_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_interaction_employee_id` FOREIGN KEY (`interaction_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_deposit_created_by_employee_id` FOREIGN KEY (`deposit_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_deposit_responsible_employee_id` FOREIGN KEY (`deposit_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`third_party_notification` ADD CONSTRAINT `fk_customer_third_party_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_account_employee_id` FOREIGN KEY (`account_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_account_last_modified_by_user_employee_id` FOREIGN KEY (`account_last_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_tertiary_account_created_by_user_employee_id` FOREIGN KEY (`tertiary_account_created_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_customer_enrolled_by_employee_id` FOREIGN KEY (`customer_enrolled_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_customer_verified_by_employee_id` FOREIGN KEY (`customer_verified_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_grant_case_manager_employee_id` FOREIGN KEY (`grant_case_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_grant_caseworker_employee_id` FOREIGN KEY (`grant_caseworker_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_grant_employee_id` FOREIGN KEY (`grant_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_primary_grant_administrator_employee_id` FOREIGN KEY (`primary_grant_administrator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_case_employee_id` FOREIGN KEY (`case_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= distribution --> asset (19 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_network_registry_id` FOREIGN KEY (`network_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= distribution --> compliance (9 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);

-- ========= distribution --> customer (3 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_complaint`(`customer_complaint_id`);

-- ========= distribution --> finance (19 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_revenue_requirement_id` FOREIGN KEY (`revenue_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`revenue_requirement`(`revenue_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ADD CONSTRAINT `fk_distribution_nrw_program_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= distribution --> laboratory (2 constraint(s)) =========
-- Requires: distribution schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);

-- ========= distribution --> metering (7 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_metering_nrw_water_balance_id` FOREIGN KEY (`metering_nrw_water_balance_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance`(`metering_nrw_water_balance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_leak_detection_event_id` FOREIGN KEY (`leak_detection_event_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`leak_detection_event`(`leak_detection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_consumption_profile_id` FOREIGN KEY (`consumption_profile_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`consumption_profile`(`consumption_profile_id`);

-- ========= distribution --> project (7 constraint(s)) =========
-- Requires: distribution schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= distribution --> quality (9 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_quality_public_notification_id` FOREIGN KEY (`quality_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_public_notification`(`quality_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= distribution --> service (2 constraint(s)) =========
-- Requires: distribution schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`nrw_program` ADD CONSTRAINT `fk_distribution_nrw_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= distribution --> supply (24 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_leak_vendor_id` FOREIGN KEY (`leak_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_network_vendor_id` FOREIGN KEY (`network_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_pipe_vendor_id` FOREIGN KEY (`pipe_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_procurement` ADD CONSTRAINT `fk_distribution_pipe_procurement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= distribution --> treatment (1 constraint(s)) =========
-- Requires: distribution schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);

-- ========= distribution --> workforce (22 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_dma_responsible_operator_employee_id` FOREIGN KEY (`dma_responsible_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_network_created_by_employee_id` FOREIGN KEY (`network_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_network_operator_employee_id` FOREIGN KEY (`network_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_network_validated_by_employee_id` FOREIGN KEY (`network_validated_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_valve_technician_employee_id` FOREIGN KEY (`valve_technician_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_network_employee_id` FOREIGN KEY (`network_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_pipe_technician_employee_id` FOREIGN KEY (`pipe_technician_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma_crew_coverage` ADD CONSTRAINT `fk_distribution_dma_crew_coverage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`zone_operator_assignment` ADD CONSTRAINT `fk_distribution_zone_operator_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (9 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= finance --> billing (5 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= finance --> compliance (2 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant` ADD CONSTRAINT `fk_finance_grant_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= finance --> customer (3 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_ar_customer_customer_account_id` FOREIGN KEY (`ar_customer_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ADD CONSTRAINT `fk_finance_grant_funded_segment_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`segment`(`segment_id`);

-- ========= finance --> project (15 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= finance --> service (3 constraint(s)) =========
-- Requires: finance schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ADD CONSTRAINT `fk_finance_finance_rate_case_canonical_service_rate_case_id` FOREIGN KEY (`canonical_service_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_case`(`service_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ADD CONSTRAINT `fk_finance_finance_rate_case_service_rate_case_id` FOREIGN KEY (`service_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_rate_case`(`service_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_rate_case` ADD CONSTRAINT `fk_finance_finance_rate_case_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= finance --> supply (10 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_vendor_id` FOREIGN KEY (`journal_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> wastewater (2 constraint(s)) =========
-- Requires: finance schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_lift_station_id` FOREIGN KEY (`lift_station_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`lift_station`(`lift_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_funded_segment` ADD CONSTRAINT `fk_finance_grant_funded_segment_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= finance --> workforce (34 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_created_by_employee_id` FOREIGN KEY (`journal_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_journal_posted_by_employee_id` FOREIGN KEY (`journal_posted_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_modified_by_user_employee_id` FOREIGN KEY (`journal_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_primary_approved_by_employee_id` FOREIGN KEY (`primary_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_primary_budget_manager_employee_id` FOREIGN KEY (`primary_budget_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_approved_by_user_employee_id` FOREIGN KEY (`bank_approved_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_employee_id` FOREIGN KEY (`bank_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_reconciled_by_employee_id` FOREIGN KEY (`bank_reconciled_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_bank_reviewed_by_user_employee_id` FOREIGN KEY (`bank_reviewed_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_bank_employee_id` FOREIGN KEY (`primary_bank_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_tertiary_bank_approved_by_user_employee_id` FOREIGN KEY (`tertiary_bank_approved_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_interfund_authorized_by_employee_id` FOREIGN KEY (`interfund_authorized_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_interfund_created_by_employee_id` FOREIGN KEY (`interfund_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_interfund_posted_by_employee_id` FOREIGN KEY (`interfund_posted_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_interfund_prepared_by_employee_id` FOREIGN KEY (`interfund_prepared_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_interfund_responsible_employee_id` FOREIGN KEY (`interfund_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_responsible_manager_employee_id` FOREIGN KEY (`tertiary_cost_responsible_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_created_by_employee_id` FOREIGN KEY (`payment_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_drawdown_employee_id` FOREIGN KEY (`drawdown_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> asset (5 constraint(s)) =========
-- Requires: laboratory schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_sampling_registry_id` FOREIGN KEY (`sampling_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_lab_registry_id` FOREIGN KEY (`lab_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);

-- ========= laboratory --> compliance (5 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_canonical_quality_corrective_action_id` FOREIGN KEY (`canonical_quality_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation_grant` ADD CONSTRAINT `fk_laboratory_lab_accreditation_grant_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= laboratory --> customer (6 constraint(s)) =========
-- Requires: laboratory schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= laboratory --> distribution (10 constraint(s)) =========
-- Requires: laboratory schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);

-- ========= laboratory --> finance (7 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_grant_allocation` ADD CONSTRAINT `fk_laboratory_analyst_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);

-- ========= laboratory --> project (6 constraint(s)) =========
-- Requires: laboratory schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= laboratory --> quality (4 constraint(s)) =========
-- Requires: laboratory schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_canonical_quality_instrument_calibration_id` FOREIGN KEY (`canonical_quality_instrument_calibration_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration`(`quality_instrument_calibration_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= laboratory --> service (5 constraint(s)) =========
-- Requires: laboratory schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);

-- ========= laboratory --> supply (8 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ADD CONSTRAINT `fk_laboratory_test_method_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ADD CONSTRAINT `fk_laboratory_reagent_standard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_material_usage` ADD CONSTRAINT `fk_laboratory_method_material_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= laboratory --> treatment (4 constraint(s)) =========
-- Requires: laboratory schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= laboratory --> workforce (39 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_lab_sampler_employee_id` FOREIGN KEY (`lab_sampler_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_sample_employee_id` FOREIGN KEY (`sample_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`test_method` ADD CONSTRAINT `fk_laboratory_test_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_laboratory_created_by_employee_id` FOREIGN KEY (`laboratory_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_laboratory_employee_id` FOREIGN KEY (`laboratory_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration` ADD CONSTRAINT `fk_laboratory_laboratory_instrument_calibration_laboratory_responsible_employee_id` FOREIGN KEY (`laboratory_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ADD CONSTRAINT `fk_laboratory_certified_analyst_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certified_analyst` ADD CONSTRAINT `fk_laboratory_certified_analyst_primary_certified_employee_id` FOREIGN KEY (`primary_certified_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_proficiency_reviewed_by_employee_id` FOREIGN KEY (`proficiency_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_result_employee_id` FOREIGN KEY (`result_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_reviewer_id` FOREIGN KEY (`reviewer_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`reagent_standard` ADD CONSTRAINT `fk_laboratory_reagent_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyte` ADD CONSTRAINT `fk_laboratory_analyte_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_assigned_employee_id` FOREIGN KEY (`laboratory_assigned_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_assigned_to_employee_id` FOREIGN KEY (`laboratory_assigned_to_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_created_by_employee_id` FOREIGN KEY (`laboratory_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_initiated_by_employee_id` FOREIGN KEY (`laboratory_initiated_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_responsible_employee_id` FOREIGN KEY (`laboratory_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action` ADD CONSTRAINT `fk_laboratory_laboratory_corrective_action_laboratory_verified_by_employee_id` FOREIGN KEY (`laboratory_verified_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_certificate_created_by_employee_id` FOREIGN KEY (`certificate_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_certificate_responsible_employee_id` FOREIGN KEY (`certificate_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_certificate_reviewed_by_employee_id` FOREIGN KEY (`certificate_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_method_qualification` ADD CONSTRAINT `fk_laboratory_analyst_method_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`laboratory`.`analyst_training_completion` ADD CONSTRAINT `fk_laboratory_analyst_training_completion_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`training_course`(`training_course_id`);

-- ========= metering --> asset (14 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_ami_registry_id` FOREIGN KEY (`ami_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (7 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_adjustment_id` FOREIGN KEY (`metering_adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);

-- ========= metering --> compliance (4 constraint(s)) =========
-- Requires: metering schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_regulatory_correspondence_id` FOREIGN KEY (`regulatory_correspondence_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence`(`regulatory_correspondence_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= metering --> customer (21 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_canonical_customer_complaint_id` FOREIGN KEY (`metering_canonical_customer_complaint_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_complaint`(`customer_complaint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);

-- ========= metering --> distribution (13 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_distribution_nrw_water_balance_id` FOREIGN KEY (`distribution_nrw_water_balance_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`(`distribution_nrw_water_balance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_canonical_distribution_nrw_water_balance_id` FOREIGN KEY (`metering_canonical_distribution_nrw_water_balance_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`(`distribution_nrw_water_balance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_distribution_nrw_water_balance_id` FOREIGN KEY (`metering_distribution_nrw_water_balance_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`distribution_nrw_water_balance`(`distribution_nrw_water_balance_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);

-- ========= metering --> finance (7 constraint(s)) =========
-- Requires: metering schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= metering --> laboratory (1 constraint(s)) =========
-- Requires: metering schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);

-- ========= metering --> project (5 constraint(s)) =========
-- Requires: metering schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= metering --> service (7 constraint(s)) =========
-- Requires: metering schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= metering --> supply (22 constraint(s)) =========
-- Requires: metering schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);

-- ========= metering --> workforce (50 constraint(s)) =========
-- Requires: metering schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_installation_employee_id` FOREIGN KEY (`installation_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_installation_installed_by_employee_id` FOREIGN KEY (`installation_installed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_installation_responsible_employee_id` FOREIGN KEY (`installation_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_consumption_validated_by_user_employee_id` FOREIGN KEY (`consumption_validated_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_leak_last_modified_by_user_employee_id` FOREIGN KEY (`leak_last_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_primary_leak_employee_id` FOREIGN KEY (`primary_leak_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_accuracy_responsible_employee_id` FOREIGN KEY (`accuracy_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_accuracy_technician_employee_id` FOREIGN KEY (`accuracy_technician_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_replacement_program_manager_employee_id` FOREIGN KEY (`replacement_program_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_replacement_responsible_employee_id` FOREIGN KEY (`replacement_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_created_by_employee_id` FOREIGN KEY (`replacement_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_crew_id` FOREIGN KEY (`replacement_crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_responsible_employee_id` FOREIGN KEY (`replacement_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_technician_employee_id` FOREIGN KEY (`replacement_technician_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_approved_by_employee_id` FOREIGN KEY (`metering_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_calculated_by_employee_id` FOREIGN KEY (`metering_calculated_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_created_by_employee_id` FOREIGN KEY (`metering_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_prepared_by_employee_id` FOREIGN KEY (`metering_prepared_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_responsible_employee_id` FOREIGN KEY (`metering_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_tamper_investigated_by_employee_id` FOREIGN KEY (`tamper_investigated_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_tamper_investigator_employee_id` FOREIGN KEY (`tamper_investigator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_tamper_responsible_employee_id` FOREIGN KEY (`tamper_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_read_assigned_employee_id` FOREIGN KEY (`read_assigned_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_read_created_by_employee_id` FOREIGN KEY (`read_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_read_responsible_employee_id` FOREIGN KEY (`read_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_assigned_to_employee_id` FOREIGN KEY (`metering_assigned_to_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_created_by_employee_id` FOREIGN KEY (`metering_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_received_by_employee_id` FOREIGN KEY (`metering_received_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_resolved_by_employee_id` FOREIGN KEY (`metering_resolved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_responsible_employee_id` FOREIGN KEY (`metering_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_endpoint_installation_employee_id` FOREIGN KEY (`endpoint_installation_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_meter_installation_employee_id` FOREIGN KEY (`meter_installation_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= project --> asset (8 constraint(s)) =========
-- Requires: project schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_commissioning_registry_id` FOREIGN KEY (`commissioning_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_primary_asset_registry_id` FOREIGN KEY (`primary_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);

-- ========= project --> compliance (9 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_project_canonical_compliance_permit_id` FOREIGN KEY (`project_canonical_compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_project_compliance_permit_id` FOREIGN KEY (`project_compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= project --> customer (1 constraint(s)) =========
-- Requires: project schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`parcel`(`parcel_id`);

-- ========= project --> distribution (16 constraint(s)) =========
-- Requires: project schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);

-- ========= project --> finance (32 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_project_canonical_finance_budget_id` FOREIGN KEY (`project_canonical_finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ADD CONSTRAINT `fk_project_funding_source_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ADD CONSTRAINT `fk_project_funding_source_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);

-- ========= project --> laboratory (7 constraint(s)) =========
-- Requires: project schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);

-- ========= project --> metering (4 constraint(s)) =========
-- Requires: project schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= project --> quality (4 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= project --> service (7 constraint(s)) =========
-- Requires: project schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= project --> supply (23 constraint(s)) =========
-- Requires: project schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_primary_design_vendor_id` FOREIGN KEY (`primary_design_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_construction_vendor_id` FOREIGN KEY (`construction_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_change_vendor_id` FOREIGN KEY (`change_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_pay_vendor_id` FOREIGN KEY (`pay_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_construction_vendor_id` FOREIGN KEY (`construction_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_submitted_by_vendor_id` FOREIGN KEY (`request_submitted_by_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_nonconformance_vendor_id` FOREIGN KEY (`nonconformance_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_asset_vendor_id` FOREIGN KEY (`asset_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_issue_vendor_id` FOREIGN KEY (`issue_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_assigned_to_vendor_id` FOREIGN KEY (`punch_assigned_to_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_contractor_vendor_id` FOREIGN KEY (`punch_contractor_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= project --> treatment (1 constraint(s)) =========
-- Requires: project schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);

-- ========= project --> workforce (43 constraint(s)) =========
-- Requires: project schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_cip_project_manager_employee_id` FOREIGN KEY (`cip_project_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_design_employee_id` FOREIGN KEY (`design_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_primary_design_employee_id` FOREIGN KEY (`primary_design_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_construction_project_manager_employee_id` FOREIGN KEY (`construction_project_manager_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_change_employee_id` FOREIGN KEY (`change_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_pay_engineer_employee_id` FOREIGN KEY (`pay_engineer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cost_employee_id` FOREIGN KEY (`cost_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_assigned_to_employee_id` FOREIGN KEY (`request_assigned_to_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_created_by_employee_id` FOREIGN KEY (`request_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_responded_by_employee_id` FOREIGN KEY (`request_responded_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_responsible_employee_id` FOREIGN KEY (`request_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_request_submitted_by_employee_id` FOREIGN KEY (`request_submitted_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ADD CONSTRAINT `fk_project_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ADD CONSTRAINT `fk_project_risk_primary_risk_owner_employee_id` FOREIGN KEY (`primary_risk_owner_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_issue_identified_by_employee_id` FOREIGN KEY (`issue_identified_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_created_by_employee_id` FOREIGN KEY (`punch_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_identified_by_employee_id` FOREIGN KEY (`punch_identified_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_responsible_employee_id` FOREIGN KEY (`punch_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_punch_verified_by_employee_id` FOREIGN KEY (`punch_verified_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_project_created_by_employee_id` FOREIGN KEY (`project_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_project_prepared_by_employee_id` FOREIGN KEY (`project_prepared_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_project_responsible_employee_id` FOREIGN KEY (`project_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_project_scheduler_employee_id` FOREIGN KEY (`project_scheduler_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> asset (6 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_asset_sampling_point_id` FOREIGN KEY (`asset_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_sampling_point`(`asset_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_online_registry_id` FOREIGN KEY (`online_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= quality --> compliance (23 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_dmr_id` FOREIGN KEY (`dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_quality_compliance_violation_id` FOREIGN KEY (`quality_compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= quality --> customer (9 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_site_id` FOREIGN KEY (`sampling_site_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`sampling_site`(`sampling_site_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`segment`(`segment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);

-- ========= quality --> finance (12 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> laboratory (32 constraint(s)) =========
-- Requires: quality schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_chain_of_custody_id` FOREIGN KEY (`chain_of_custody_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody`(`chain_of_custody_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_laboratory_corrective_action_id` FOREIGN KEY (`laboratory_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action`(`laboratory_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_laboratory_corrective_action_id` FOREIGN KEY (`laboratory_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_corrective_action`(`laboratory_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_chain_of_custody_id` FOREIGN KEY (`chain_of_custody_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`chain_of_custody`(`chain_of_custody_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_laboratory_instrument_calibration_id` FOREIGN KEY (`laboratory_instrument_calibration_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration`(`laboratory_instrument_calibration_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_quality_laboratory_instrument_calibration_id` FOREIGN KEY (`quality_laboratory_instrument_calibration_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory_instrument_calibration`(`laboratory_instrument_calibration_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_reagent_standard_id` FOREIGN KEY (`reagent_standard_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`reagent_standard`(`reagent_standard_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qaqc_reviewed_by_analyst_id` FOREIGN KEY (`qaqc_reviewed_by_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= quality --> metering (3 constraint(s)) =========
-- Requires: quality schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);

-- ========= quality --> project (3 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= quality --> service (9 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_bulk_water_agreement_id` FOREIGN KEY (`bulk_water_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`bulk_water_agreement`(`bulk_water_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_special_contract_id` FOREIGN KEY (`special_contract_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`special_contract`(`special_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= quality --> supply (8 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= quality --> treatment (17 constraint(s)) =========
-- Requires: quality schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_turbidity_wtp_facility_id` FOREIGN KEY (`turbidity_wtp_facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_ct_wtp_facility_id` FOREIGN KEY (`ct_wtp_facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_process_control_setpoint_id` FOREIGN KEY (`process_control_setpoint_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint`(`process_control_setpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_source_location_source_water_intake_id` FOREIGN KEY (`source_location_source_water_intake_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_source_water_intake_id` FOREIGN KEY (`source_water_intake_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= quality --> wastewater (5 constraint(s)) =========
-- Requires: quality schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_grease_interceptor_id` FOREIGN KEY (`grease_interceptor_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor`(`grease_interceptor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_fog_source_id` FOREIGN KEY (`fog_source_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`fog_source`(`fog_source_id`);

-- ========= quality --> workforce (47 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_water_employee_id` FOREIGN KEY (`water_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_water_modified_by_user_employee_id` FOREIGN KEY (`water_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_exceedance_responsible_employee_id` FOREIGN KEY (`exceedance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_pfas_employee_id` FOREIGN KEY (`pfas_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`pfas_monitoring` ADD CONSTRAINT `fk_quality_pfas_monitoring_pfas_responsible_employee_id` FOREIGN KEY (`pfas_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_turbidity_operator_employee_id` FOREIGN KEY (`turbidity_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_ct_operator_employee_id` FOREIGN KEY (`ct_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_residual_operator_employee_id` FOREIGN KEY (`residual_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_primary_bacteriological_employee_id` FOREIGN KEY (`primary_bacteriological_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_ccr_employee_id` FOREIGN KEY (`ccr_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_ccr_modified_by_user_employee_id` FOREIGN KEY (`ccr_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_primary_ccr_employee_id` FOREIGN KEY (`primary_ccr_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_tertiary_ccr_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ccr_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_quality_issued_by_employee_id` FOREIGN KEY (`quality_issued_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_quality_responsible_employee_id` FOREIGN KEY (`quality_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_quality_employee_id` FOREIGN KEY (`quality_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`quality_instrument_calibration` ADD CONSTRAINT `fk_quality_quality_instrument_calibration_quality_responsible_employee_id` FOREIGN KEY (`quality_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_compliance_determined_by_employee_id` FOREIGN KEY (`compliance_determined_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_compliance_responsible_employee_id` FOREIGN KEY (`compliance_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_compliance_reviewed_by_employee_id` FOREIGN KEY (`compliance_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qaqc_approved_by_employee_id` FOREIGN KEY (`qaqc_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qaqc_created_by_employee_id` FOREIGN KEY (`qaqc_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qaqc_responsible_employee_id` FOREIGN KEY (`qaqc_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qaqc_reviewed_by_employee_id` FOREIGN KEY (`qaqc_reviewed_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= service --> asset (9 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_service_asset_class_id` FOREIGN KEY (`service_asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_asset_meter_id` FOREIGN KEY (`asset_meter_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_meter`(`asset_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_document_id` FOREIGN KEY (`document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= service --> billing (8 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_billing_billing_rate_schedule_id` FOREIGN KEY (`billing_billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_service_account_billing_account_id` FOREIGN KEY (`service_account_billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= service --> compliance (9 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= service --> customer (11 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_connection_customer_customer_account_id` FOREIGN KEY (`connection_customer_customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_customer_program_enrollment_id` FOREIGN KEY (`customer_program_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment`(`customer_program_enrollment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_service_canonical_customer_program_enrollment_id` FOREIGN KEY (`service_canonical_customer_program_enrollment_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_program_enrollment`(`customer_program_enrollment_id`);

-- ========= service --> distribution (8 constraint(s)) =========
-- Requires: service schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= service --> finance (15 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_service_canonical_finance_rate_case_id` FOREIGN KEY (`service_canonical_finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);

-- ========= service --> metering (5 constraint(s)) =========
-- Requires: service schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= service --> project (4 constraint(s)) =========
-- Requires: service schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= service --> supply (4 constraint(s)) =========
-- Requires: service schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`program_material_eligibility` ADD CONSTRAINT `fk_service_program_material_eligibility_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= service --> treatment (4 constraint(s)) =========
-- Requires: service schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= service --> workforce (13 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_service_responsible_employee_id` FOREIGN KEY (`service_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_primary_order_created_by_user_employee_id` FOREIGN KEY (`primary_order_created_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_tertiary_order_modified_by_user_employee_id` FOREIGN KEY (`tertiary_order_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_service_lead_attorney_employee_id` FOREIGN KEY (`service_lead_attorney_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_case` ADD CONSTRAINT `fk_service_service_rate_case_service_responsible_employee_id` FOREIGN KEY (`service_responsible_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> asset (3 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_material_registry_id` FOREIGN KEY (`material_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= supply --> finance (25 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= supply --> project (5 constraint(s)) =========
-- Requires: supply schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ADD CONSTRAINT `fk_supply_project_vendor_engagement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= supply --> treatment (4 constraint(s)) =========
-- Requires: supply schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_inventory_wtp_facility_id` FOREIGN KEY (`inventory_wtp_facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= supply --> workforce (7 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_primary_purchase_requisitioner_employee_id` FOREIGN KEY (`primary_purchase_requisitioner_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_receiving_personnel_employee_id` FOREIGN KEY (`receiving_personnel_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= treatment --> asset (2 constraint(s)) =========
-- Requires: treatment schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ADD CONSTRAINT `fk_treatment_process_maintenance_plan_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);

-- ========= treatment --> compliance (3 constraint(s)) =========
-- Requires: treatment schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= treatment --> finance (2 constraint(s)) =========
-- Requires: treatment schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= treatment --> metering (1 constraint(s)) =========
-- Requires: treatment schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);

-- ========= treatment --> project (4 constraint(s)) =========
-- Requires: treatment schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ADD CONSTRAINT `fk_treatment_facility_project_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= treatment --> quality (1 constraint(s)) =========
-- Requires: treatment schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`online_instrument`(`online_instrument_id`);

-- ========= treatment --> service (3 constraint(s)) =========
-- Requires: treatment schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_facility_territory_id` FOREIGN KEY (`facility_territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= treatment --> supply (3 constraint(s)) =========
-- Requires: treatment schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ADD CONSTRAINT `fk_treatment_chemical_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= treatment --> workforce (14 constraint(s)) =========
-- Requires: treatment schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_facility_created_by_employee_id` FOREIGN KEY (`facility_created_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_facility_operator_in_charge_employee_id` FOREIGN KEY (`facility_operator_in_charge_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_process_operator_employee_id` FOREIGN KEY (`process_operator_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_operator_license_id` FOREIGN KEY (`operator_license_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`operator_license`(`operator_license_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ADD CONSTRAINT `fk_treatment_permit_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= wastewater --> asset (21 constraint(s)) =========
-- Requires: wastewater schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_wwtp_registry_id` FOREIGN KEY (`wwtp_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_sso_registry_id` FOREIGN KEY (`sso_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_primary_ii_registry_id` FOREIGN KEY (`primary_ii_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ADD CONSTRAINT `fk_wastewater_grease_interceptor_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ADD CONSTRAINT `fk_wastewater_grease_interceptor_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= wastewater --> billing (2 constraint(s)) =========
-- Requires: wastewater schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= wastewater --> compliance (17 constraint(s)) =========
-- Requires: wastewater schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`land_application_site` ADD CONSTRAINT `fk_wastewater_land_application_site_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= wastewater --> customer (7 constraint(s)) =========
-- Requires: wastewater schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);

-- ========= wastewater --> distribution (3 constraint(s)) =========
-- Requires: wastewater schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= wastewater --> finance (23 constraint(s)) =========
-- Requires: wastewater schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ADD CONSTRAINT `fk_wastewater_facility_grant_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ADD CONSTRAINT `fk_wastewater_facility_grant_allocation_grant_allocation_id` FOREIGN KEY (`grant_allocation_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant_allocation`(`grant_allocation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_grant_allocation` ADD CONSTRAINT `fk_wastewater_facility_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`grant`(`grant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ADD CONSTRAINT `fk_wastewater_facility_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ADD CONSTRAINT `fk_wastewater_sses_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= wastewater --> laboratory (10 constraint(s)) =========
-- Requires: wastewater schema, laboratory schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `vibe_water_utilities_v1`.`laboratory`.`lab_sample`(`lab_sample_id`);

-- ========= wastewater --> metering (2 constraint(s)) =========
-- Requires: wastewater schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= wastewater --> project (14 constraint(s)) =========
-- Requires: wastewater schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sses_study` ADD CONSTRAINT `fk_wastewater_sses_study_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= wastewater --> quality (6 constraint(s)) =========
-- Requires: wastewater schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= wastewater --> service (4 constraint(s)) =========
-- Requires: wastewater schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);

-- ========= wastewater --> supply (7 constraint(s)) =========
-- Requires: wastewater schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ADD CONSTRAINT `fk_wastewater_facility_vendor_contract_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`facility_vendor_contract` ADD CONSTRAINT `fk_wastewater_facility_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= wastewater --> treatment (2 constraint(s)) =========
-- Requires: wastewater schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);

-- ========= wastewater --> workforce (18 constraint(s)) =========
-- Requires: wastewater schema, workforce schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_primary_effluent_employee_id` FOREIGN KEY (`primary_effluent_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_ii_validated_by_user_employee_id` FOREIGN KEY (`ii_validated_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_iup_sampler_employee_id` FOREIGN KEY (`iup_sampler_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_dmr_submitted_by_employee_id` FOREIGN KEY (`dmr_submitted_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);

-- ========= workforce --> asset (11 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_field_registry_id` FOREIGN KEY (`field_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= workforce --> compliance (1 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`crew_assignment`(`crew_assignment_id`);

-- ========= workforce --> customer (1 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= workforce --> finance (7 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_water_utilities_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> metering (1 constraint(s)) =========
-- Requires: workforce schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);

-- ========= workforce --> project (1 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= workforce --> service (2 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_crew_territory_id` FOREIGN KEY (`crew_territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= workforce --> supply (4 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_training_vendor_id` FOREIGN KEY (`training_vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);

-- ========= workforce --> treatment (5 constraint(s)) =========
-- Requires: workforce schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ADD CONSTRAINT `fk_workforce_operator_license_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

