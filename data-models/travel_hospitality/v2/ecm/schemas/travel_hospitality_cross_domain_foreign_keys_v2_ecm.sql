-- Cross-Domain Foreign Keys for Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:48
-- Total cross-domain FK constraints: 1359
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: channel, compliance, event, experience, finance, fnb, guest, housekeeping, inventory, loyalty, marketing, procurement, property, reservation, revenue, spa, workforce

-- ========= channel --> compliance (4 constraint(s)) =========
-- Requires: channel schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`ota_partner` ADD CONSTRAINT `fk_channel_ota_partner_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_sanction_screening_id` FOREIGN KEY (`sanction_screening_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`(`sanction_screening_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= channel --> finance (8 constraint(s)) =========
-- Requires: channel schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`connectivity_fee` ADD CONSTRAINT `fk_channel_connectivity_fee_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`metasearch_listing` ADD CONSTRAINT `fk_channel_metasearch_listing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= channel --> guest (4 constraint(s)) =========
-- Requires: channel schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_channel_tmc_corporate_account_id` FOREIGN KEY (`channel_tmc_corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= channel --> inventory (7 constraint(s)) =========
-- Requires: channel schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_inventory_allocation` ADD CONSTRAINT `fk_channel_channel_inventory_allocation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment` ADD CONSTRAINT `fk_channel_wholesale_allotment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_wholesale_inventory_allocation` ADD CONSTRAINT `fk_channel_channel_wholesale_inventory_allocation_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= channel --> loyalty (1 constraint(s)) =========
-- Requires: channel schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= channel --> marketing (7 constraint(s)) =========
-- Requires: channel schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`metasearch_listing` ADD CONSTRAINT `fk_channel_metasearch_listing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment` ADD CONSTRAINT `fk_channel_wholesale_allotment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`ota_campaign_participation` ADD CONSTRAINT `fk_channel_ota_campaign_participation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= channel --> procurement (3 constraint(s)) =========
-- Requires: channel schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`connectivity_fee` ADD CONSTRAINT `fk_channel_connectivity_fee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= channel --> property (15 constraint(s)) =========
-- Requires: channel schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`crs_channel_mapping` ADD CONSTRAINT `fk_channel_crs_channel_mapping_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_inventory_allocation` ADD CONSTRAINT `fk_channel_channel_inventory_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`rate_parity_audit` ADD CONSTRAINT `fk_channel_rate_parity_audit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_schedule` ADD CONSTRAINT `fk_channel_commission_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`connectivity_fee` ADD CONSTRAINT `fk_channel_connectivity_fee_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`stop_sell` ADD CONSTRAINT `fk_channel_stop_sell_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`metasearch_listing` ADD CONSTRAINT `fk_channel_metasearch_listing_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment` ADD CONSTRAINT `fk_channel_wholesale_allotment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_wholesale_inventory_allocation` ADD CONSTRAINT `fk_channel_channel_wholesale_inventory_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= channel --> reservation (2 constraint(s)) =========
-- Requires: channel schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`commission_accrual` ADD CONSTRAINT `fk_channel_commission_accrual_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= channel --> revenue (4 constraint(s)) =========
-- Requires: channel schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan` ADD CONSTRAINT `fk_channel_channel_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_booking` ADD CONSTRAINT `fk_channel_channel_booking_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_revenue_negotiated_rate_id` FOREIGN KEY (`revenue_negotiated_rate_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate`(`revenue_negotiated_rate_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= channel --> spa (1 constraint(s)) =========
-- Requires: channel schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`package_rate` ADD CONSTRAINT `fk_channel_package_rate_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);

-- ========= channel --> workforce (6 constraint(s)) =========
-- Requires: channel schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel` ADD CONSTRAINT `fk_channel_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`ota_partner` ADD CONSTRAINT `fk_channel_ota_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`gds_connection` ADD CONSTRAINT `fk_channel_gds_connection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_contract` ADD CONSTRAINT `fk_channel_channel_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`metasearch_listing` ADD CONSTRAINT `fk_channel_metasearch_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate` ADD CONSTRAINT `fk_channel_channel_negotiated_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> finance (5 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ADD CONSTRAINT `fk_compliance_permit_renewal_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ADD CONSTRAINT `fk_compliance_fire_safety_record_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= compliance --> fnb (1 constraint(s)) =========
-- Requires: compliance schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= compliance --> guest (9 constraint(s)) =========
-- Requires: compliance schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_note_id` FOREIGN KEY (`note_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`note`(`note_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_communication_consent_id` FOREIGN KEY (`communication_consent_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`communication_consent`(`communication_consent_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_identity_document_id` FOREIGN KEY (`identity_document_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`identity_document`(`identity_document_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= compliance --> loyalty (5 constraint(s)) =========
-- Requires: compliance schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= compliance --> marketing (1 constraint(s)) =========
-- Requires: compliance schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_marketing_calendar_id` FOREIGN KEY (`marketing_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar`(`marketing_calendar_id`);

-- ========= compliance --> procurement (2 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> property (23 constraint(s)) =========
-- Requires: compliance schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ADD CONSTRAINT `fk_compliance_permit_renewal_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ADD CONSTRAINT `fk_compliance_fire_safety_record_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ADD CONSTRAINT `fk_compliance_whistleblower_report_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= compliance --> reservation (4 constraint(s)) =========
-- Requires: compliance schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= compliance --> workforce (40 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_tertiary_obligation_updated_by_user_employee_id` FOREIGN KEY (`tertiary_obligation_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`permit_renewal` ADD CONSTRAINT `fk_compliance_permit_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident` ADD CONSTRAINT `fk_compliance_health_safety_incident_tertiary_health_updated_by_user_employee_id` FOREIGN KEY (`tertiary_health_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`incident_investigation` ADD CONSTRAINT `fk_compliance_incident_investigation_tertiary_incident_updated_by_user_employee_id` FOREIGN KEY (`tertiary_incident_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident` ADD CONSTRAINT `fk_compliance_privacy_incident_tertiary_privacy_updated_by_user_employee_id` FOREIGN KEY (`tertiary_privacy_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`dpia` ADD CONSTRAINT `fk_compliance_dpia_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert` ADD CONSTRAINT `fk_compliance_food_safety_cert_tertiary_food_updated_by_user_employee_id` FOREIGN KEY (`tertiary_food_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record` ADD CONSTRAINT `fk_compliance_fire_safety_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment` ADD CONSTRAINT `fk_compliance_ada_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_tertiary_compliance_updated_by_user_employee_id` FOREIGN KEY (`tertiary_compliance_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_workforce_training_completion_id` FOREIGN KEY (`workforce_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_training_completion`(`workforce_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_risk_employee_id` FOREIGN KEY (`risk_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_risk_updated_by_user_employee_id` FOREIGN KEY (`risk_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_tertiary_policy_updated_by_user_employee_id` FOREIGN KEY (`tertiary_policy_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_tertiary_policy_escalated_to_user_employee_id` FOREIGN KEY (`tertiary_policy_escalated_to_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment` ADD CONSTRAINT `fk_compliance_policy_acknowledgment_tertiary_quinary_policy_updated_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_policy_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance` ADD CONSTRAINT `fk_compliance_environmental_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ADD CONSTRAINT `fk_compliance_whistleblower_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report` ADD CONSTRAINT `fk_compliance_whistleblower_report_tertiary_whistleblower_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_whistleblower_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_sanction_employee_id` FOREIGN KEY (`sanction_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening` ADD CONSTRAINT `fk_compliance_sanction_screening_sanction_updated_by_user_employee_id` FOREIGN KEY (`sanction_updated_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_compliance_last_modified_by_user_employee_id` FOREIGN KEY (`compliance_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_primary_compliance_responsible_owner_employee_id` FOREIGN KEY (`primary_compliance_responsible_owner_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= event --> channel (4 constraint(s)) =========
-- Requires: event schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= event --> compliance (11 constraint(s)) =========
-- Requires: event schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_sanction_screening_id` FOREIGN KEY (`sanction_screening_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`(`sanction_screening_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_fire_safety_record_id` FOREIGN KEY (`fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_fire_safety_record_id` FOREIGN KEY (`fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_food_safety_cert_id` FOREIGN KEY (`food_safety_cert_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`(`food_safety_cert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_food_safety_cert_id` FOREIGN KEY (`food_safety_cert_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`(`food_safety_cert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= event --> experience (2 constraint(s)) =========
-- Requires: event schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`experience_enrollment` ADD CONSTRAINT `fk_event_experience_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);

-- ========= event --> finance (8 constraint(s)) =========
-- Requires: event schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= event --> fnb (3 constraint(s)) =========
-- Requires: event schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= event --> guest (3 constraint(s)) =========
-- Requires: event schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= event --> housekeeping (2 constraint(s)) =========
-- Requires: event schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_attendant_assignment` ADD CONSTRAINT `fk_event_beo_attendant_assignment_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`staffing_assignment` ADD CONSTRAINT `fk_event_staffing_assignment_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);

-- ========= event --> inventory (1 constraint(s)) =========
-- Requires: event schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= event --> loyalty (6 constraint(s)) =========
-- Requires: event schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= event --> marketing (7 constraint(s)) =========
-- Requires: event schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_offer_redemption_id` FOREIGN KEY (`offer_redemption_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption`(`offer_redemption_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_guest_communication_id` FOREIGN KEY (`guest_communication_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_communication`(`guest_communication_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`lost_business` ADD CONSTRAINT `fk_event_lost_business_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= event --> procurement (4 constraint(s)) =========
-- Requires: event schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_item` ADD CONSTRAINT `fk_event_beo_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_contract` ADD CONSTRAINT `fk_event_event_contract_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= event --> property (16 constraint(s)) =========
-- Requires: event schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`inquiry` ADD CONSTRAINT `fk_event_inquiry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`function_space` ADD CONSTRAINT `fk_event_function_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_property_space_allocation_id` FOREIGN KEY (`property_space_allocation_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_space_allocation`(`property_space_allocation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`catering_menu` ADD CONSTRAINT `fk_event_catering_menu_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`invoice` ADD CONSTRAINT `fk_event_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_revenue` ADD CONSTRAINT `fk_event_event_revenue_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`lost_business` ADD CONSTRAINT `fk_event_lost_business_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= event --> reservation (3 constraint(s)) =========
-- Requires: event schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_group_block` ADD CONSTRAINT `fk_event_event_group_block_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= event --> spa (7 constraint(s)) =========
-- Requires: event schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`attendee` ADD CONSTRAINT `fk_event_attendee_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_class_enrollment` ADD CONSTRAINT `fk_event_event_class_enrollment_fitness_class_session_id` FOREIGN KEY (`fitness_class_session_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`(`fitness_class_session_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_class_enrollment` ADD CONSTRAINT `fk_event_event_class_enrollment_spa_class_enrollment_id` FOREIGN KEY (`spa_class_enrollment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment`(`spa_class_enrollment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`treatment_allocation` ADD CONSTRAINT `fk_event_treatment_allocation_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= event --> workforce (10 constraint(s)) =========
-- Requires: event schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`account` ADD CONSTRAINT `fk_event_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`proposal` ADD CONSTRAINT `fk_event_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_booking` ADD CONSTRAINT `fk_event_event_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_space_allocation` ADD CONSTRAINT `fk_event_event_space_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo` ADD CONSTRAINT `fk_event_beo_tertiary_beo_modified_by_user_employee_id` FOREIGN KEY (`tertiary_beo_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`lost_business` ADD CONSTRAINT `fk_event_lost_business_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`event_class_enrollment` ADD CONSTRAINT `fk_event_event_class_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`beo_attendant_assignment` ADD CONSTRAINT `fk_event_beo_attendant_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`event`.`staffing_assignment` ADD CONSTRAINT `fk_event_staffing_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= experience --> channel (4 constraint(s)) =========
-- Requires: experience schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_channel_booking_id` FOREIGN KEY (`channel_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_booking`(`channel_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);

-- ========= experience --> compliance (7 constraint(s)) =========
-- Requires: experience schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_food_safety_cert_id` FOREIGN KEY (`food_safety_cert_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`(`food_safety_cert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);

-- ========= experience --> finance (5 constraint(s)) =========
-- Requires: experience schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= experience --> fnb (9 constraint(s)) =========
-- Requires: experience schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= experience --> guest (12 constraint(s)) =========
-- Requires: experience schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`review_topic_extraction` ADD CONSTRAINT `fk_experience_review_topic_extraction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`feedback_topic` ADD CONSTRAINT `fk_experience_feedback_topic_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= experience --> inventory (15 constraint(s)) =========
-- Requires: experience schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_room_amenity_id` FOREIGN KEY (`room_amenity_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= experience --> loyalty (7 constraint(s)) =========
-- Requires: experience schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);

-- ========= experience --> procurement (4 constraint(s)) =========
-- Requires: experience schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= experience --> property (25 constraint(s)) =========
-- Requires: experience schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program` ADD CONSTRAINT `fk_experience_program_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`quality_audit` ADD CONSTRAINT `fk_experience_quality_audit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`survey_template` ADD CONSTRAINT `fk_experience_survey_template_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= experience --> reservation (10 constraint(s)) =========
-- Requires: experience schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_reservation_special_request_id` FOREIGN KEY (`reservation_special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request`(`reservation_special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`online_review` ADD CONSTRAINT `fk_experience_online_review_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= experience --> revenue (1 constraint(s)) =========
-- Requires: experience schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`gss_score` ADD CONSTRAINT `fk_experience_gss_score_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= experience --> spa (2 constraint(s)) =========
-- Requires: experience schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_treatment_inclusion` ADD CONSTRAINT `fk_experience_program_treatment_inclusion_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`program_fitness_inclusion` ADD CONSTRAINT `fk_experience_program_fitness_inclusion_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`fitness_class`(`fitness_class_id`);

-- ========= experience --> workforce (13 constraint(s)) =========
-- Requires: experience schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_feedback` ADD CONSTRAINT `fk_experience_guest_feedback_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_case` ADD CONSTRAINT `fk_experience_service_case_tertiary_service_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_service_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`case_activity` ADD CONSTRAINT `fk_experience_case_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action` ADD CONSTRAINT `fk_experience_service_recovery_action_tertiary_service_created_by_employee_id` FOREIGN KEY (`tertiary_service_created_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`experience_special_request` ADD CONSTRAINT `fk_experience_experience_special_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment` ADD CONSTRAINT `fk_experience_amenity_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_interaction` ADD CONSTRAINT `fk_experience_guest_interaction_tertiary_guest_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_guest_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment` ADD CONSTRAINT `fk_experience_guest_experience_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`experience`.`reputation_alert` ADD CONSTRAINT `fk_experience_reputation_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> channel (1 constraint(s)) =========
-- Requires: finance schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);

-- ========= finance --> fnb (3 constraint(s)) =========
-- Requires: finance schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);

-- ========= finance --> guest (5 constraint(s)) =========
-- Requires: finance schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= finance --> inventory (1 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_control_id` FOREIGN KEY (`control_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`control`(`control_id`);

-- ========= finance --> marketing (1 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);

-- ========= finance --> procurement (11 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> property (33 constraint(s)) =========
-- Requires: finance schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ADD CONSTRAINT `fk_finance_owner_distribution_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ADD CONSTRAINT `fk_finance_owner_distribution_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`party`(`party_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`hma_contract` ADD CONSTRAINT `fk_finance_hma_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`gl_batch` ADD CONSTRAINT `fk_finance_gl_batch_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ADD CONSTRAINT `fk_finance_allocation_rule_set_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= finance --> reservation (2 constraint(s)) =========
-- Requires: finance schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= finance --> workforce (18 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tertiary_journal_posted_by_user_employee_id` FOREIGN KEY (`tertiary_journal_posted_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`ar_payment` ADD CONSTRAINT `fk_finance_ar_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`management_fee` ADD CONSTRAINT `fk_finance_management_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`owner_distribution` ADD CONSTRAINT `fk_finance_owner_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_payment_employee_id` FOREIGN KEY (`payment_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_capex_requestor_employee_id` FOREIGN KEY (`capex_requestor_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_allocation_employee_id` FOREIGN KEY (`allocation_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ADD CONSTRAINT `fk_finance_allocation_rule_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ADD CONSTRAINT `fk_finance_allocation_rule_set_allocation_employee_id` FOREIGN KEY (`allocation_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`finance`.`allocation_rule_set` ADD CONSTRAINT `fk_finance_allocation_rule_set_allocation_last_modified_by_user_employee_id` FOREIGN KEY (`allocation_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= fnb --> compliance (4 constraint(s)) =========
-- Requires: fnb schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ADD CONSTRAINT `fk_fnb_recipe_food_safety_cert_id` FOREIGN KEY (`food_safety_cert_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`(`food_safety_cert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_environmental_compliance_id` FOREIGN KEY (`environmental_compliance_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`(`environmental_compliance_id`);

-- ========= fnb --> event (2 constraint(s)) =========
-- Requires: fnb schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);

-- ========= fnb --> finance (9 constraint(s)) =========
-- Requires: fnb schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);

-- ========= fnb --> guest (7 constraint(s)) =========
-- Requires: fnb schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);

-- ========= fnb --> inventory (2 constraint(s)) =========
-- Requires: fnb schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= fnb --> loyalty (4 constraint(s)) =========
-- Requires: fnb schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= fnb --> marketing (6 constraint(s)) =========
-- Requires: fnb schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);

-- ========= fnb --> procurement (13 constraint(s)) =========
-- Requires: fnb schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ADD CONSTRAINT `fk_fnb_inventory_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ADD CONSTRAINT `fk_fnb_inventory_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ADD CONSTRAINT `fk_fnb_fnb_supply_agreement_procurement_supply_agreement_id` FOREIGN KEY (`procurement_supply_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement`(`procurement_supply_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ADD CONSTRAINT `fk_fnb_fnb_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= fnb --> property (14 constraint(s)) =========
-- Requires: fnb schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ADD CONSTRAINT `fk_fnb_revenue_center_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ADD CONSTRAINT `fk_fnb_wine_cellar_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ADD CONSTRAINT `fk_fnb_storage_location_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= fnb --> reservation (3 constraint(s)) =========
-- Requires: fnb schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= fnb --> spa (2 constraint(s)) =========
-- Requires: fnb schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);

-- ========= fnb --> workforce (16 constraint(s)) =========
-- Requires: fnb schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ADD CONSTRAINT `fk_fnb_fnb_outlet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_tertiary_pos_manager_employee_id` FOREIGN KEY (`tertiary_pos_manager_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ADD CONSTRAINT `fk_fnb_discount_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ADD CONSTRAINT `fk_fnb_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_physical_counter_employee_id` FOREIGN KEY (`physical_counter_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_physical_supervisor_employee_id` FOREIGN KEY (`physical_supervisor_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= guest --> event (2 constraint(s)) =========
-- Requires: guest schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= guest --> experience (1 constraint(s)) =========
-- Requires: guest schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);

-- ========= guest --> loyalty (2 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ADD CONSTRAINT `fk_guest_guest_enrollment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);

-- ========= guest --> marketing (4 constraint(s)) =========
-- Requires: guest schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ADD CONSTRAINT `fk_guest_segment_membership_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ADD CONSTRAINT `fk_guest_predictive_score_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);

-- ========= guest --> property (12 constraint(s)) =========
-- Requires: guest schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ADD CONSTRAINT `fk_guest_profile_merge_history_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ADD CONSTRAINT `fk_guest_corporate_property_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ADD CONSTRAINT `fk_guest_group_function_space_booking_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ADD CONSTRAINT `fk_guest_predictive_score_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= guest --> reservation (3 constraint(s)) =========
-- Requires: guest schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= guest --> workforce (11 constraint(s)) =========
-- Requires: guest schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_tertiary_vip_approved_by_employee_id` FOREIGN KEY (`tertiary_vip_approved_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_tertiary_note_resolved_by_staff_employee_id` FOREIGN KEY (`tertiary_note_resolved_by_staff_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ADD CONSTRAINT `fk_guest_profile_merge_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ADD CONSTRAINT `fk_guest_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ADD CONSTRAINT `fk_guest_relationship_tertiary_relationship_last_modified_by_staff_employee_id` FOREIGN KEY (`tertiary_relationship_last_modified_by_staff_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ADD CONSTRAINT `fk_guest_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= housekeeping --> compliance (13 constraint(s)) =========
-- Requires: housekeeping schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_environmental_compliance_id` FOREIGN KEY (`environmental_compliance_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`(`environmental_compliance_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ADD CONSTRAINT `fk_housekeeping_cleaning_standard_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_fire_safety_record_id` FOREIGN KEY (`fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_housekeeping_compliance_training_completion_id` FOREIGN KEY (`housekeeping_compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);

-- ========= housekeeping --> event (6 constraint(s)) =========
-- Requires: housekeeping schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_function_space_id` FOREIGN KEY (`function_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`function_space`(`function_space_id`);

-- ========= housekeeping --> experience (9 constraint(s)) =========
-- Requires: housekeeping schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_reputation_alert_id` FOREIGN KEY (`reputation_alert_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`reputation_alert`(`reputation_alert_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_experience_special_request_id` FOREIGN KEY (`experience_special_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`experience_special_request`(`experience_special_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);

-- ========= housekeeping --> finance (12 constraint(s)) =========
-- Requires: housekeeping schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= housekeeping --> fnb (5 constraint(s)) =========
-- Requires: housekeeping schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= housekeeping --> guest (6 constraint(s)) =========
-- Requires: housekeeping schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= housekeeping --> inventory (11 constraint(s)) =========
-- Requires: housekeeping schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ADD CONSTRAINT `fk_housekeeping_cleaning_standard_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= housekeeping --> procurement (6 constraint(s)) =========
-- Requires: housekeeping schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_procurement_work_order_id` FOREIGN KEY (`procurement_work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order`(`procurement_work_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= housekeeping --> property (16 constraint(s)) =========
-- Requires: housekeeping schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ADD CONSTRAINT `fk_housekeeping_team_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= housekeeping --> reservation (6 constraint(s)) =========
-- Requires: housekeeping schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_room_assignment_id` FOREIGN KEY (`room_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= housekeeping --> spa (6 constraint(s)) =========
-- Requires: housekeeping schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment_room`(`treatment_room_id`);

-- ========= housekeeping --> workforce (29 constraint(s)) =========
-- Requires: housekeeping schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_primary_inspection_employee_id` FOREIGN KEY (`primary_inspection_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ADD CONSTRAINT `fk_housekeeping_hk_schedule_tertiary_hk_modified_by_user_employee_id` FOREIGN KEY (`tertiary_hk_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ADD CONSTRAINT `fk_housekeeping_attendant_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_primary_deep_employee_id` FOREIGN KEY (`primary_deep_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ADD CONSTRAINT `fk_housekeeping_laundry_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_workforce_training_completion_id` FOREIGN KEY (`workforce_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_training_completion`(`workforce_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_work_inspected_by_employee_id` FOREIGN KEY (`work_inspected_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_work_requested_by_employee_id` FOREIGN KEY (`work_requested_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_maintenance_assigned_to_employee_id` FOREIGN KEY (`maintenance_assigned_to_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_maintenance_reported_by_employee_id` FOREIGN KEY (`maintenance_reported_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> channel (4 constraint(s)) =========
-- Requires: inventory schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ADD CONSTRAINT `fk_inventory_channel_inventory_map_channel_contract_id` FOREIGN KEY (`channel_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_contract`(`channel_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment` ADD CONSTRAINT `fk_inventory_rate_plan_room_type_assignment_channel_rate_plan_id` FOREIGN KEY (`channel_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`(`channel_rate_plan_id`);

-- ========= inventory --> compliance (6 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_fire_safety_record_id` FOREIGN KEY (`fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_fire_safety_record_id` FOREIGN KEY (`fire_safety_record_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`(`fire_safety_record_id`);

-- ========= inventory --> event (1 constraint(s)) =========
-- Requires: inventory schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= inventory --> finance (3 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= inventory --> guest (5 constraint(s)) =========
-- Requires: inventory schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= inventory --> housekeeping (1 constraint(s)) =========
-- Requires: inventory schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);

-- ========= inventory --> loyalty (4 constraint(s)) =========
-- Requires: inventory schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion` ADD CONSTRAINT `fk_inventory_room_type_promotion_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);

-- ========= inventory --> marketing (4 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> procurement (4 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply` ADD CONSTRAINT `fk_inventory_room_type_vendor_supply_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_material_installation` ADD CONSTRAINT `fk_inventory_room_material_installation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);

-- ========= inventory --> property (14 constraint(s)) =========
-- Requires: inventory schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type` ADD CONSTRAINT `fk_inventory_room_type_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ADD CONSTRAINT `fk_inventory_inventory_overbooking_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ADD CONSTRAINT `fk_inventory_channel_inventory_map_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ADD CONSTRAINT `fk_inventory_change_audit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= inventory --> reservation (1 constraint(s)) =========
-- Requires: inventory schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= inventory --> revenue (10 constraint(s)) =========
-- Requires: inventory schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_inventory_control_id` FOREIGN KEY (`inventory_control_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`inventory_control`(`inventory_control_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_group_evaluation_id` FOREIGN KEY (`group_evaluation_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation`(`group_evaluation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_group_evaluation_id` FOREIGN KEY (`group_evaluation_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation`(`group_evaluation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ADD CONSTRAINT `fk_inventory_inventory_overbooking_policy_revenue_overbooking_policy_id` FOREIGN KEY (`revenue_overbooking_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy`(`revenue_overbooking_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application` ADD CONSTRAINT `fk_inventory_block_wash_factor_application_wash_factor_id` FOREIGN KEY (`wash_factor_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`wash_factor`(`wash_factor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark` ADD CONSTRAINT `fk_inventory_room_type_competitive_benchmark_competitive_set_id` FOREIGN KEY (`competitive_set_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`competitive_set`(`competitive_set_id`);

-- ========= inventory --> workforce (12 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_block` ADD CONSTRAINT `fk_inventory_room_block_tertiary_room_modified_by_user_employee_id` FOREIGN KEY (`tertiary_room_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_tertiary_out_closed_by_user_employee_id` FOREIGN KEY (`tertiary_out_closed_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ADD CONSTRAINT `fk_inventory_inventory_overbooking_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy` ADD CONSTRAINT `fk_inventory_inventory_overbooking_policy_tertiary_inventory_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_inventory_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`los_restriction` ADD CONSTRAINT `fk_inventory_los_restriction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map` ADD CONSTRAINT `fk_inventory_channel_inventory_map_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`change_audit` ADD CONSTRAINT `fk_inventory_change_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= loyalty --> channel (5 constraint(s)) =========
-- Requires: loyalty schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment` ADD CONSTRAINT `fk_loyalty_loyalty_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion_distribution` ADD CONSTRAINT `fk_loyalty_promotion_distribution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= loyalty --> compliance (1 constraint(s)) =========
-- Requires: loyalty schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`fraud_alert` ADD CONSTRAINT `fk_loyalty_fraud_alert_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);

-- ========= loyalty --> finance (4 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= loyalty --> fnb (1 constraint(s)) =========
-- Requires: loyalty schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= loyalty --> guest (1 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= loyalty --> marketing (5 constraint(s)) =========
-- Requires: loyalty schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_segment` ADD CONSTRAINT `fk_loyalty_member_segment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);

-- ========= loyalty --> procurement (1 constraint(s)) =========
-- Requires: loyalty schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= loyalty --> property (11 constraint(s)) =========
-- Requires: loyalty schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment` ADD CONSTRAINT `fk_loyalty_loyalty_enrollment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`partner_program` ADD CONSTRAINT `fk_loyalty_partner_program_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_preference` ADD CONSTRAINT `fk_loyalty_member_preference_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`package_purchase` ADD CONSTRAINT `fk_loyalty_package_purchase_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= loyalty --> reservation (4 constraint(s)) =========
-- Requires: loyalty schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`certificate` ADD CONSTRAINT `fk_loyalty_certificate_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= loyalty --> revenue (1 constraint(s)) =========
-- Requires: loyalty schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= loyalty --> spa (5 constraint(s)) =========
-- Requires: loyalty schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog` ADD CONSTRAINT `fk_loyalty_reward_catalog_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`certificate` ADD CONSTRAINT `fk_loyalty_certificate_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`package_purchase` ADD CONSTRAINT `fk_loyalty_package_purchase_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion_treatment_rule` ADD CONSTRAINT `fk_loyalty_promotion_treatment_rule_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= loyalty --> workforce (12 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule` ADD CONSTRAINT `fk_loyalty_redemption_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment` ADD CONSTRAINT `fk_loyalty_loyalty_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement` ADD CONSTRAINT `fk_loyalty_benefit_entitlement_tertiary_benefit_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_benefit_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`benefit_redemption` ADD CONSTRAINT `fk_loyalty_benefit_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`promotion` ADD CONSTRAINT `fk_loyalty_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`program_config` ADD CONSTRAINT `fk_loyalty_program_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`member_segment` ADD CONSTRAINT `fk_loyalty_member_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`loyalty`.`certificate` ADD CONSTRAINT `fk_loyalty_certificate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> channel (1 constraint(s)) =========
-- Requires: marketing schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);

-- ========= marketing --> compliance (4 constraint(s)) =========
-- Requires: marketing schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar` ADD CONSTRAINT `fk_marketing_marketing_calendar_compliance_calendar_id` FOREIGN KEY (`compliance_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar`(`compliance_calendar_id`);

-- ========= marketing --> experience (7 constraint(s)) =========
-- Requires: marketing schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_segment` ADD CONSTRAINT `fk_marketing_guest_segment_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);

-- ========= marketing --> finance (6 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= marketing --> fnb (1 constraint(s)) =========
-- Requires: marketing schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);

-- ========= marketing --> guest (7 constraint(s)) =========
-- Requires: marketing schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= marketing --> loyalty (3 constraint(s)) =========
-- Requires: marketing schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`program_config`(`program_config_id`);

-- ========= marketing --> procurement (7 constraint(s)) =========
-- Requires: marketing schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= marketing --> property (10 constraint(s)) =========
-- Requires: marketing schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`content_asset` ADD CONSTRAINT `fk_marketing_content_asset_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`social_post` ADD CONSTRAINT `fk_marketing_social_post_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`communication_template` ADD CONSTRAINT `fk_marketing_communication_template_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= marketing --> reservation (8 constraint(s)) =========
-- Requires: marketing schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer` ADD CONSTRAINT `fk_marketing_campaign_offer_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_cancellation_id` FOREIGN KEY (`cancellation_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation`(`cancellation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_communication` ADD CONSTRAINT `fk_marketing_guest_communication_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`offer_redemption` ADD CONSTRAINT `fk_marketing_offer_redemption_travel_agent_id` FOREIGN KEY (`travel_agent_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`travel_agent`(`travel_agent_id`);

-- ========= marketing --> revenue (3 constraint(s)) =========
-- Requires: marketing schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`attribution_event` ADD CONSTRAINT `fk_marketing_attribution_event_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= marketing --> spa (1 constraint(s)) =========
-- Requires: marketing schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_treatment_promotion` ADD CONSTRAINT `fk_marketing_campaign_treatment_promotion_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= marketing --> workforce (10 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`guest_segment` ADD CONSTRAINT `fk_marketing_guest_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`survey_program` ADD CONSTRAINT `fk_marketing_survey_program_tertiary_survey_modified_by_user_employee_id` FOREIGN KEY (`tertiary_survey_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`brand` ADD CONSTRAINT `fk_marketing_brand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`consent` ADD CONSTRAINT `fk_marketing_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`experiment` ADD CONSTRAINT `fk_marketing_experiment_tertiary_experiment_modified_by_user_employee_id` FOREIGN KEY (`tertiary_experiment_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar` ADD CONSTRAINT `fk_marketing_marketing_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar` ADD CONSTRAINT `fk_marketing_marketing_calendar_tertiary_marketing_modified_by_user_employee_id` FOREIGN KEY (`tertiary_marketing_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> compliance (2 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);

-- ========= procurement --> experience (4 constraint(s)) =========
-- Requires: procurement schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ADD CONSTRAINT `fk_procurement_vendor_program_participation_vendor_experience_program_id` FOREIGN KEY (`vendor_experience_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_program_participation` ADD CONSTRAINT `fk_procurement_vendor_program_participation_vendor_program_id` FOREIGN KEY (`vendor_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_touchpoint_service` ADD CONSTRAINT `fk_procurement_vendor_touchpoint_service_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);

-- ========= procurement --> finance (5 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ADD CONSTRAINT `fk_procurement_procurement_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= procurement --> property (18 constraint(s)) =========
-- Requires: procurement schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_pip_plan_id` FOREIGN KEY (`pip_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`pip_plan`(`pip_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order` ADD CONSTRAINT `fk_procurement_procurement_work_order_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`delivery_address` ADD CONSTRAINT `fk_procurement_delivery_address_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= procurement --> spa (2 constraint(s)) =========
-- Requires: procurement schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ADD CONSTRAINT `fk_procurement_procurement_therapist_certification_spa_therapist_certification_id` FOREIGN KEY (`spa_therapist_certification_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification`(`spa_therapist_certification_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ADD CONSTRAINT `fk_procurement_procurement_therapist_certification_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`treatment`(`treatment_id`);

-- ========= procurement --> workforce (31 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_primary_procurement_approved_by_employee_id` FOREIGN KEY (`primary_procurement_approved_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_tertiary_procurement_last_modified_by_employee_id` FOREIGN KEY (`tertiary_procurement_last_modified_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_tertiary_purchase_final_approver_employee_id` FOREIGN KEY (`tertiary_purchase_final_approver_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_receiving_employee_id` FOREIGN KEY (`receiving_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_primary_request_employee_id` FOREIGN KEY (`primary_request_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_primary_purchase_employee_id` FOREIGN KEY (`primary_purchase_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_tertiary_vendor_last_modified_by_employee_id` FOREIGN KEY (`tertiary_vendor_last_modified_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`category_buyer_assignment` ADD CONSTRAINT `fk_procurement_category_buyer_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_therapist_certification` ADD CONSTRAINT `fk_procurement_procurement_therapist_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_program_assigned_by_employee_id` FOREIGN KEY (`program_assigned_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_program_employee_id` FOREIGN KEY (`program_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_requisition_employee_id` FOREIGN KEY (`requisition_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_project_manager_employee_id` FOREIGN KEY (`project_manager_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_project_sponsor_employee_id` FOREIGN KEY (`project_sponsor_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan` ADD CONSTRAINT `fk_procurement_procurement_benefit_plan_workforce_benefit_plan_id` FOREIGN KEY (`workforce_benefit_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan`(`workforce_benefit_plan_id`);

-- ========= property --> channel (1 constraint(s)) =========
-- Requires: property schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ADD CONSTRAINT `fk_property_channel_connection_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= property --> compliance (1 constraint(s)) =========
-- Requires: property schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);

-- ========= property --> event (2 constraint(s)) =========
-- Requires: property schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ADD CONSTRAINT `fk_property_property_space_allocation_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ADD CONSTRAINT `fk_property_property_space_allocation_event_space_allocation_id` FOREIGN KEY (`event_space_allocation_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_space_allocation`(`event_space_allocation_id`);

-- ========= property --> finance (2 constraint(s)) =========
-- Requires: property schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= property --> fnb (4 constraint(s)) =========
-- Requires: property schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ADD CONSTRAINT `fk_property_certification_food_safety_inspection_id` FOREIGN KEY (`food_safety_inspection_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`(`food_safety_inspection_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= property --> housekeeping (2 constraint(s)) =========
-- Requires: property schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);

-- ========= property --> procurement (5 constraint(s)) =========
-- Requires: property schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ADD CONSTRAINT `fk_property_vendor_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= property --> workforce (3 constraint(s)) =========
-- Requires: property schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= reservation --> channel (10 constraint(s)) =========
-- Requires: reservation schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_channel_rate_plan_id` FOREIGN KEY (`channel_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`(`channel_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_ota_partner_id` FOREIGN KEY (`ota_partner_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`ota_partner`(`ota_partner_id`);

-- ========= reservation --> event (1 constraint(s)) =========
-- Requires: reservation schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);

-- ========= reservation --> finance (5 constraint(s)) =========
-- Requires: reservation schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_ar_payment_id` FOREIGN KEY (`ar_payment_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_payment`(`ar_payment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ap_payment`(`ap_payment_id`);

-- ========= reservation --> guest (10 constraint(s)) =========
-- Requires: reservation schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= reservation --> inventory (3 constraint(s)) =========
-- Requires: reservation schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_reservation_room_type_id` FOREIGN KEY (`reservation_room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= reservation --> property (12 constraint(s)) =========
-- Requires: reservation schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy` ADD CONSTRAINT `fk_reservation_cancellation_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_primary_walk_property_id` FOREIGN KEY (`primary_walk_property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= reservation --> revenue (4 constraint(s)) =========
-- Requires: reservation schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);

-- ========= reservation --> spa (2 constraint(s)) =========
-- Requires: reservation schema, spa schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`program_enrollment` ADD CONSTRAINT `fk_reservation_program_enrollment_wellness_program_id` FOREIGN KEY (`wellness_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`group_spa_package_contract` ADD CONSTRAINT `fk_reservation_group_spa_package_contract_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_travel_hospitality_v1`.`spa`.`package`(`package_id`);

-- ========= reservation --> workforce (11 constraint(s)) =========
-- Requires: reservation schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger` ADD CONSTRAINT `fk_reservation_deposit_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`waitlist` ADD CONSTRAINT `fk_reservation_waitlist_tertiary_waitlist_modified_by_user_employee_id` FOREIGN KEY (`tertiary_waitlist_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_tertiary_room_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_room_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`reservation`.`walk_record` ADD CONSTRAINT `fk_reservation_walk_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= revenue --> channel (8 constraint(s)) =========
-- Requires: revenue schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= revenue --> compliance (5 constraint(s)) =========
-- Requires: revenue schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`competitor_rate` ADD CONSTRAINT `fk_revenue_competitor_rate_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy` ADD CONSTRAINT `fk_revenue_revenue_overbooking_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy` ADD CONSTRAINT `fk_revenue_revenue_overbooking_policy_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);

-- ========= revenue --> event (9 constraint(s)) =========
-- Requires: revenue schema, event schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_event_booking_id` FOREIGN KEY (`event_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`event_booking`(`event_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_travel_hospitality_v1`.`event`.`account`(`account_id`);

-- ========= revenue --> experience (3 constraint(s)) =========
-- Requires: revenue schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_touchpoint_id` FOREIGN KEY (`touchpoint_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`touchpoint`(`touchpoint_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_segment_program_id` FOREIGN KEY (`segment_program_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`program`(`program_id`);

-- ========= revenue --> finance (27 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);

-- ========= revenue --> fnb (12 constraint(s)) =========
-- Requires: revenue schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis` ADD CONSTRAINT `fk_revenue_displacement_analysis_banquet_event_order_id` FOREIGN KEY (`banquet_event_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`(`banquet_event_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);

-- ========= revenue --> guest (3 constraint(s)) =========
-- Requires: revenue schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis` ADD CONSTRAINT `fk_revenue_displacement_analysis_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);

-- ========= revenue --> inventory (9 constraint(s)) =========
-- Requires: revenue schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`wash_factor` ADD CONSTRAINT `fk_revenue_wash_factor_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room_type`(`room_type_id`);

-- ========= revenue --> loyalty (13 constraint(s)) =========
-- Requires: revenue schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`program_config`(`program_config_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_member_segment_id` FOREIGN KEY (`member_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member_segment`(`member_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`tier`(`tier_id`);

-- ========= revenue --> marketing (9 constraint(s)) =========
-- Requires: revenue schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis` ADD CONSTRAINT `fk_revenue_displacement_analysis_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);

-- ========= revenue --> property (22 constraint(s)) =========
-- Requires: revenue schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`market_segment` ADD CONSTRAINT `fk_revenue_market_segment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`competitive_set` ADD CONSTRAINT `fk_revenue_competitive_set_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`str_benchmark` ADD CONSTRAINT `fk_revenue_str_benchmark_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`group_evaluation` ADD CONSTRAINT `fk_revenue_group_evaluation_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy` ADD CONSTRAINT `fk_revenue_revenue_overbooking_policy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`channel_contribution` ADD CONSTRAINT `fk_revenue_channel_contribution_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`displacement_analysis` ADD CONSTRAINT `fk_revenue_displacement_analysis_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`strategy` ADD CONSTRAINT `fk_revenue_strategy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`wash_factor` ADD CONSTRAINT `fk_revenue_wash_factor_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= revenue --> reservation (4 constraint(s)) =========
-- Requires: revenue schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_restriction` ADD CONSTRAINT `fk_revenue_rate_restriction_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);

-- ========= revenue --> workforce (17 constraint(s)) =========
-- Requires: revenue schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan` ADD CONSTRAINT `fk_revenue_revenue_rate_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`dynamic_rate_rule` ADD CONSTRAINT `fk_revenue_dynamic_rate_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pricing_override` ADD CONSTRAINT `fk_revenue_pricing_override_primary_pricing_employee_id` FOREIGN KEY (`primary_pricing_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`rate_availability` ADD CONSTRAINT `fk_revenue_rate_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`demand_forecast` ADD CONSTRAINT `fk_revenue_demand_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`inventory_control` ADD CONSTRAINT `fk_revenue_inventory_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`performance_actuals` ADD CONSTRAINT `fk_revenue_performance_actuals_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`competitive_set` ADD CONSTRAINT `fk_revenue_competitive_set_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`str_benchmark` ADD CONSTRAINT `fk_revenue_str_benchmark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`competitor_rate` ADD CONSTRAINT `fk_revenue_competitor_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`pickup_report` ADD CONSTRAINT `fk_revenue_pickup_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_overbooking_policy` ADD CONSTRAINT `fk_revenue_revenue_overbooking_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_budget` ADD CONSTRAINT `fk_revenue_revenue_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`revenue_negotiated_rate` ADD CONSTRAINT `fk_revenue_revenue_negotiated_rate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`total_revenue_actuals` ADD CONSTRAINT `fk_revenue_total_revenue_actuals_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`revenue`.`segment_program_eligibility` ADD CONSTRAINT `fk_revenue_segment_program_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= spa --> channel (6 constraint(s)) =========
-- Requires: spa schema, channel schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_booking_source_id` FOREIGN KEY (`booking_source_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`booking_source`(`booking_source_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_travel_hospitality_v1`.`channel`.`channel`(`channel_id`);

-- ========= spa --> compliance (7 constraint(s)) =========
-- Requires: spa schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_ada_assessment_id` FOREIGN KEY (`ada_assessment_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`(`ada_assessment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_health_safety_incident_id` FOREIGN KEY (`health_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`(`health_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);

-- ========= spa --> experience (6 constraint(s)) =========
-- Requires: spa schema, experience schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_guest_feedback_id` FOREIGN KEY (`guest_feedback_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_feedback`(`guest_feedback_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_guest_interaction_id` FOREIGN KEY (`guest_interaction_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_interaction`(`guest_interaction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_guest_interaction_id` FOREIGN KEY (`guest_interaction_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`guest_interaction`(`guest_interaction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_service_recovery_action_id` FOREIGN KEY (`service_recovery_action_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`(`service_recovery_action_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `vibe_travel_hospitality_v1`.`experience`.`service_case`(`service_case_id`);

-- ========= spa --> finance (26 constraint(s)) =========
-- Requires: spa schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`ledger`(`ledger_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= spa --> fnb (4 constraint(s)) =========
-- Requires: spa schema, fnb schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);

-- ========= spa --> guest (14 constraint(s)) =========
-- Requires: spa schema, guest schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= spa --> housekeeping (1 constraint(s)) =========
-- Requires: spa schema, housekeeping schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);

-- ========= spa --> inventory (7 constraint(s)) =========
-- Requires: spa schema, inventory schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_travel_hospitality_v1`.`inventory`.`room`(`room_id`);

-- ========= spa --> loyalty (7 constraint(s)) =========
-- Requires: spa schema, loyalty schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ADD CONSTRAINT `fk_spa_group_booking_program_config_id` FOREIGN KEY (`program_config_id`) REFERENCES `vibe_travel_hospitality_v1`.`loyalty`.`program_config`(`program_config_id`);

-- ========= spa --> marketing (31 constraint(s)) =========
-- Requires: spa schema, marketing schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_attribution_event_id` FOREIGN KEY (`attribution_event_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`attribution_event`(`attribution_event_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_attribution_event_id` FOREIGN KEY (`attribution_event_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`attribution_event`(`attribution_event_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_survey_response_id` FOREIGN KEY (`survey_response_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`survey_response`(`survey_response_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_attribution_event_id` FOREIGN KEY (`attribution_event_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`attribution_event`(`attribution_event_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_campaign_offer_id` FOREIGN KEY (`campaign_offer_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`(`campaign_offer_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_guest_communication_id` FOREIGN KEY (`guest_communication_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_communication`(`guest_communication_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_survey_response_id` FOREIGN KEY (`survey_response_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`survey_response`(`survey_response_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`content_asset`(`content_asset_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ADD CONSTRAINT `fk_spa_product_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_travel_hospitality_v1`.`marketing`.`brand`(`brand_id`);

-- ========= spa --> procurement (9 constraint(s)) =========
-- Requires: spa schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ADD CONSTRAINT `fk_spa_retail_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ADD CONSTRAINT `fk_spa_product_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= spa --> property (36 constraint(s)) =========
-- Requires: spa schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification` ADD CONSTRAINT `fk_spa_spa_therapist_certification_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_inventory` ADD CONSTRAINT `fk_spa_retail_inventory_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_pip_item_id` FOREIGN KEY (`pip_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`pip_item`(`pip_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`equipment` ADD CONSTRAINT `fk_spa_equipment_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product` ADD CONSTRAINT `fk_spa_product_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ADD CONSTRAINT `fk_spa_group_booking_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_product` ADD CONSTRAINT `fk_spa_retail_product_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ADD CONSTRAINT `fk_spa_product_line_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);

-- ========= spa --> reservation (6 constraint(s)) =========
-- Requires: spa schema, reservation schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= spa --> revenue (5 constraint(s)) =========
-- Requires: spa schema, revenue schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_revenue_rate_plan_id` FOREIGN KEY (`revenue_rate_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`revenue_rate_plan`(`revenue_rate_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`day_pass` ADD CONSTRAINT `fk_spa_day_pass_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_market_segment_id` FOREIGN KEY (`market_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`revenue`.`market_segment`(`market_segment_id`);

-- ========= spa --> workforce (23 constraint(s)) =========
-- Requires: spa schema, workforce schema
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`retail_transaction` ADD CONSTRAINT `fk_spa_retail_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_fitness_modified_by_user_employee_id` FOREIGN KEY (`fitness_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`fitness_class_session` ADD CONSTRAINT `fk_spa_fitness_class_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment` ADD CONSTRAINT `fk_spa_spa_class_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`golf_tee_time` ADD CONSTRAINT `fk_spa_golf_tee_time_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`amenity_pricing` ADD CONSTRAINT `fk_spa_amenity_pricing_tertiary_amenity_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_amenity_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`cancellation_log` ADD CONSTRAINT `fk_spa_cancellation_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`wellness_program` ADD CONSTRAINT `fk_spa_wellness_program_tertiary_wellness_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_wellness_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`group_booking` ADD CONSTRAINT `fk_spa_group_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`spa`.`product_line` ADD CONSTRAINT `fk_spa_product_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `vibe_travel_hospitality_v1`.`compliance`.`policy`(`policy_id`);

-- ========= workforce --> finance (8 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ADD CONSTRAINT `fk_workforce_workforce_benefit_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ADD CONSTRAINT `fk_workforce_shift_template_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> procurement (4 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_category_id` FOREIGN KEY (`category_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`category`(`category_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_procurement_benefit_plan_id` FOREIGN KEY (`procurement_benefit_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan`(`procurement_benefit_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_procurement_work_order_id` FOREIGN KEY (`procurement_work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order`(`procurement_work_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_procurement_benefit_plan_id` FOREIGN KEY (`procurement_benefit_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`procurement`.`procurement_benefit_plan`(`procurement_benefit_plan_id`);

-- ========= workforce --> property (16 constraint(s)) =========
-- Requires: workforce schema, property schema
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ADD CONSTRAINT `fk_workforce_workforce_benefit_plan_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ADD CONSTRAINT `fk_workforce_workforce_benefit_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ADD CONSTRAINT `fk_workforce_workforce_safety_incident_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ADD CONSTRAINT `fk_workforce_shift_template_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);

