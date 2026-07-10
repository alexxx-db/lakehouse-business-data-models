-- Cross-Domain Foreign Keys for Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:29
-- Total cross-domain FK constraints: 379
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, distribution, metering, quality, service, treatment, wastewater

-- ========= asset --> billing (1 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= asset --> compliance (7 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> customer (5 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);

-- ========= asset --> quality (1 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);

-- ========= asset --> service (4 constraint(s)) =========
-- Requires: asset schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= asset --> treatment (6 constraint(s)) =========
-- Requires: asset schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);

-- ========= billing --> asset (4 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= billing --> compliance (5 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);

-- ========= billing --> customer (4 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= billing --> distribution (5 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= billing --> metering (2 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_interval_consumption_id` FOREIGN KEY (`interval_consumption_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`interval_consumption`(`interval_consumption_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);

-- ========= billing --> quality (3 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= billing --> service (20 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= billing --> treatment (1 constraint(s)) =========
-- Requires: billing schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= billing --> wastewater (6 constraint(s)) =========
-- Requires: billing schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_effluent_parameter_result_id` FOREIGN KEY (`effluent_parameter_result_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result`(`effluent_parameter_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_collection_system_blockage_id` FOREIGN KEY (`collection_system_blockage_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`(`collection_system_blockage_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sso_event`(`sso_event_id`);

-- ========= compliance --> asset (2 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= compliance --> metering (1 constraint(s)) =========
-- Requires: compliance schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);

-- ========= compliance --> service (6 constraint(s)) =========
-- Requires: compliance schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= compliance --> treatment (9 constraint(s)) =========
-- Requires: compliance schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_finished_water_production_id` FOREIGN KEY (`finished_water_production_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`finished_water_production`(`finished_water_production_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);

-- ========= compliance --> wastewater (4 constraint(s)) =========
-- Requires: compliance schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sso_event`(`sso_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= customer --> asset (4 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= customer --> billing (1 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (3 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);

-- ========= customer --> distribution (14 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= customer --> quality (2 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= customer --> service (17 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= customer --> treatment (3 constraint(s)) =========
-- Requires: customer schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= customer --> wastewater (4 constraint(s)) =========
-- Requires: customer schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_collection_system_blockage_id` FOREIGN KEY (`collection_system_blockage_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`(`collection_system_blockage_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sso_event`(`sso_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_collection_system_blockage_id` FOREIGN KEY (`collection_system_blockage_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage`(`collection_system_blockage_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sso_event`(`sso_event_id`);

-- ========= distribution --> asset (20 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);

-- ========= distribution --> compliance (7 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);

-- ========= distribution --> customer (1 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);

-- ========= distribution --> metering (4 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);

-- ========= distribution --> service (6 constraint(s)) =========
-- Requires: distribution schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= distribution --> treatment (2 constraint(s)) =========
-- Requires: distribution schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_finished_water_production_id` FOREIGN KEY (`finished_water_production_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`finished_water_production`(`finished_water_production_id`);

-- ========= metering --> asset (10 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (1 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`cycle`(`cycle_id`);

-- ========= metering --> compliance (4 constraint(s)) =========
-- Requires: metering schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);

-- ========= metering --> customer (5 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= metering --> distribution (4 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);

-- ========= metering --> service (9 constraint(s)) =========
-- Requires: metering schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= metering --> treatment (1 constraint(s)) =========
-- Requires: metering schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= quality --> asset (1 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= quality --> compliance (10 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);

-- ========= quality --> customer (2 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);

-- ========= quality --> distribution (3 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`main_break`(`main_break_id`);

-- ========= quality --> metering (5 constraint(s)) =========
-- Requires: quality schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);

-- ========= quality --> service (7 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`offering`(`offering_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_order_id` FOREIGN KEY (`order_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`order`(`order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);

-- ========= quality --> treatment (3 constraint(s)) =========
-- Requires: quality schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);

-- ========= service --> asset (3 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= service --> billing (2 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= service --> compliance (7 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= service --> customer (1 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= service --> distribution (11 constraint(s)) =========
-- Requires: service schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);

-- ========= service --> metering (6 constraint(s)) =========
-- Requires: service schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);

-- ========= service --> treatment (4 constraint(s)) =========
-- Requires: service schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`point` ADD CONSTRAINT `fk_service_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);

-- ========= service --> wastewater (1 constraint(s)) =========
-- Requires: service schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`service`.`order` ADD CONSTRAINT `fk_service_order_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);

-- ========= treatment --> asset (6 constraint(s)) =========
-- Requires: treatment schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= treatment --> compliance (8 constraint(s)) =========
-- Requires: treatment schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ADD CONSTRAINT `fk_treatment_water_source_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= treatment --> distribution (4 constraint(s)) =========
-- Requires: treatment schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= treatment --> metering (3 constraint(s)) =========
-- Requires: treatment schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);

-- ========= treatment --> quality (3 constraint(s)) =========
-- Requires: treatment schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= treatment --> service (3 constraint(s)) =========
-- Requires: treatment schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ADD CONSTRAINT `fk_treatment_water_source_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= wastewater --> asset (28 constraint(s)) =========
-- Requires: wastewater schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= wastewater --> compliance (13 constraint(s)) =========
-- Requires: wastewater schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);

-- ========= wastewater --> customer (5 constraint(s)) =========
-- Requires: wastewater schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= wastewater --> distribution (2 constraint(s)) =========
-- Requires: wastewater schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= wastewater --> metering (4 constraint(s)) =========
-- Requires: wastewater schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);

-- ========= wastewater --> quality (5 constraint(s)) =========
-- Requires: wastewater schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= wastewater --> service (7 constraint(s)) =========
-- Requires: wastewater schema, service schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_point_id` FOREIGN KEY (`point_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`point`(`point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_water_utilities_v1`.`service`.`territory`(`territory_id`);

-- ========= wastewater --> treatment (4 constraint(s)) =========
-- Requires: wastewater schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);

