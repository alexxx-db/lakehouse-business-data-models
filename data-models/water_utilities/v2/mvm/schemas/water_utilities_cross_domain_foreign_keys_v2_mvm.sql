-- Cross-Domain Foreign Keys for Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:55
-- Total cross-domain FK constraints: 188
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, distribution, metering, quality, treatment, wastewater

-- ========= asset --> compliance (8 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= asset --> customer (3 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= asset --> quality (1 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);

-- ========= asset --> treatment (3 constraint(s)) =========
-- Requires: asset schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= asset --> wastewater (2 constraint(s)) =========
-- Requires: asset schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);

-- ========= billing --> compliance (3 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= billing --> customer (9 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`premise`(`premise_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= billing --> distribution (4 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= billing --> wastewater (2 constraint(s)) =========
-- Requires: billing schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);

-- ========= compliance --> distribution (2 constraint(s)) =========
-- Requires: compliance schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);

-- ========= compliance --> quality (5 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);

-- ========= compliance --> treatment (6 constraint(s)) =========
-- Requires: compliance schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= customer --> billing (3 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`payment`(`payment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (2 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= customer --> distribution (14 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= customer --> metering (4 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_high_usage_alert_id` FOREIGN KEY (`high_usage_alert_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`high_usage_alert`(`high_usage_alert_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_high_usage_alert_id` FOREIGN KEY (`high_usage_alert_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`high_usage_alert`(`high_usage_alert_id`);

-- ========= customer --> quality (2 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);

-- ========= customer --> treatment (2 constraint(s)) =========
-- Requires: customer schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= customer --> wastewater (2 constraint(s)) =========
-- Requires: customer schema, wastewater schema
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= distribution --> asset (11 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);

-- ========= distribution --> billing (1 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= distribution --> compliance (4 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= distribution --> metering (4 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);

-- ========= distribution --> treatment (3 constraint(s)) =========
-- Requires: distribution schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= metering --> asset (2 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);

-- ========= metering --> customer (6 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= metering --> distribution (7 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ADD CONSTRAINT `fk_metering_read_route_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);

-- ========= quality --> asset (1 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= quality --> compliance (15 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= quality --> customer (4 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`service_address`(`service_address_id`);

-- ========= quality --> distribution (10 constraint(s)) =========
-- Requires: quality schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= quality --> treatment (8 constraint(s)) =========
-- Requires: quality schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= treatment --> asset (3 constraint(s)) =========
-- Requires: treatment schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);

-- ========= treatment --> compliance (5 constraint(s)) =========
-- Requires: treatment schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= treatment --> distribution (1 constraint(s)) =========
-- Requires: treatment schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`pipe_main`(`pipe_main_id`);

-- ========= treatment --> metering (2 constraint(s)) =========
-- Requires: treatment schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);

-- ========= wastewater --> asset (9 constraint(s)) =========
-- Requires: wastewater schema, asset schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);

-- ========= wastewater --> billing (1 constraint(s)) =========
-- Requires: wastewater schema, billing schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_water_utilities_v1`.`billing`.`billing_account`(`billing_account_id`);

-- ========= wastewater --> compliance (6 constraint(s)) =========
-- Requires: wastewater schema, compliance schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= wastewater --> customer (1 constraint(s)) =========
-- Requires: wastewater schema, customer schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `vibe_water_utilities_v1`.`customer`.`customer_account`(`customer_account_id`);

-- ========= wastewater --> distribution (1 constraint(s)) =========
-- Requires: wastewater schema, distribution schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `vibe_water_utilities_v1`.`distribution`.`service_line`(`service_line_id`);

-- ========= wastewater --> metering (2 constraint(s)) =========
-- Requires: wastewater schema, metering schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);

-- ========= wastewater --> quality (3 constraint(s)) =========
-- Requires: wastewater schema, quality schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);

-- ========= wastewater --> treatment (1 constraint(s)) =========
-- Requires: wastewater schema, treatment schema
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);

