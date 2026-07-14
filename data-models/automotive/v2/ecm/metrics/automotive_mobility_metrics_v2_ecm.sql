-- Metric views for domain: mobility | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:49:52

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_adas_feature_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adas Feature Entitlement business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`adas_feature_entitlement`"
  dimensions:
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Adas Feature Entitlement Status"
      expr: adas_feature_entitlement_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Plan Type"
      expr: data_plan_type
    - name: "Adas Feature Entitlement Description"
      expr: adas_feature_entitlement_description
    - name: "Entitlement Number"
      expr: entitlement_number
    - name: "Entitlement Source"
      expr: entitlement_source
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Feature Code"
      expr: feature_code
    - name: "Feature Name"
      expr: feature_name
    - name: "Feature Version"
      expr: feature_version
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Is Trial"
      expr: is_trial
    - name: "Last Status Change Timestamp"
      expr: last_status_change_timestamp
    - name: "Mileage Limit"
      expr: mileage_limit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adas Feature Entitlement"
      expr: COUNT(DISTINCT adas_feature_entitlement_id)
    - name: "Total Entitlement Price"
      expr: SUM(entitlement_price)
    - name: "Average Entitlement Price"
      expr: AVG(entitlement_price)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_connected_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connected Vehicle business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`connected_vehicle`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Connectivity Tier"
      expr: connectivity_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Plan"
      expr: data_plan
    - name: "Data Usage Last Reset"
      expr: data_usage_last_reset
    - name: "Deactivation Timestamp"
      expr: deactivation_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Diagnostic Status"
      expr: diagnostic_status
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Last Diagnostic Timestamp"
      expr: last_diagnostic_timestamp
    - name: "Last Error Code"
      expr: last_error_code
    - name: "Last Ota Update Timestamp"
      expr: last_ota_update_timestamp
    - name: "Last Tpms Update Timestamp"
      expr: last_tpms_update_timestamp
    - name: "Last V2x Update Timestamp"
      expr: last_v2x_update_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Connected Vehicle"
      expr: COUNT(DISTINCT connected_vehicle_id)
    - name: "Total Battery Health Percent"
      expr: SUM(battery_health_percent)
    - name: "Average Battery Health Percent"
      expr: AVG(battery_health_percent)
    - name: "Total Battery State Of Charge Percent"
      expr: SUM(battery_state_of_charge_percent)
    - name: "Average Battery State Of Charge Percent"
      expr: AVG(battery_state_of_charge_percent)
    - name: "Total Data Usage Gb"
      expr: SUM(data_usage_gb)
    - name: "Average Data Usage Gb"
      expr: AVG(data_usage_gb)
    - name: "Total Mileage Km"
      expr: SUM(mileage_km)
    - name: "Average Mileage Km"
      expr: AVG(mileage_km)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ev_charger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ev Charger business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`ev_charger`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Asset Tag"
      expr: asset_tag
    - name: "City"
      expr: city
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Connector Type"
      expr: connector_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Amperage"
      expr: current_amperage
    - name: "Ev Charger Description"
      expr: ev_charger_description
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Public Access"
      expr: is_public_access
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Maintenance Interval Days"
      expr: maintenance_interval_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ev Charger"
      expr: COUNT(DISTINCT ev_charger_id)
    - name: "Total Average Session Duration Minutes"
      expr: SUM(average_session_duration_minutes)
    - name: "Average Average Session Duration Minutes"
      expr: AVG(average_session_duration_minutes)
    - name: "Total Carbon Emission Reduction Kg"
      expr: SUM(carbon_emission_reduction_kg)
    - name: "Average Carbon Emission Reduction Kg"
      expr: AVG(carbon_emission_reduction_kg)
    - name: "Total Installation Cost"
      expr: SUM(installation_cost)
    - name: "Average Installation Cost"
      expr: AVG(installation_cost)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Session Duration Minutes"
      expr: SUM(max_session_duration_minutes)
    - name: "Average Max Session Duration Minutes"
      expr: AVG(max_session_duration_minutes)
    - name: "Total Min Session Duration Minutes"
      expr: SUM(min_session_duration_minutes)
    - name: "Average Min Session Duration Minutes"
      expr: AVG(min_session_duration_minutes)
    - name: "Total Operational Cost"
      expr: SUM(operational_cost)
    - name: "Average Operational Cost"
      expr: AVG(operational_cost)
    - name: "Total Power Rating Kw"
      expr: SUM(power_rating_kw)
    - name: "Average Power Rating Kw"
      expr: AVG(power_rating_kw)
    - name: "Total Total Energy Delivered Kwh"
      expr: SUM(total_energy_delivered_kwh)
    - name: "Average Total Energy Delivered Kwh"
      expr: AVG(total_energy_delivered_kwh)
    - name: "Total Total Sessions"
      expr: SUM(total_sessions)
    - name: "Average Total Sessions"
      expr: AVG(total_sessions)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ev_charging_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ev Charging Session business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`ev_charging_session`"
  dimensions:
    - name: "Charger Type"
      expr: charger_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Soc Percent"
      expr: end_soc_percent
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Estimated Range Added Km"
      expr: estimated_range_added_km
    - name: "Ev Charging Session Status"
      expr: ev_charging_session_status
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Is Ota Update Performed"
      expr: is_ota_update_performed
    - name: "Location Type"
      expr: location_type
    - name: "Notes"
      expr: notes
    - name: "Odometer Km At End"
      expr: odometer_km_at_end
    - name: "Odometer Km At Start"
      expr: odometer_km_at_start
    - name: "Payment Method"
      expr: payment_method
    - name: "Session Number"
      expr: session_number
    - name: "Start Soc Percent"
      expr: start_soc_percent
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ev Charging Session"
      expr: COUNT(DISTINCT ev_charging_session_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Energy Delivered Kwh"
      expr: SUM(energy_delivered_kwh)
    - name: "Average Energy Delivered Kwh"
      expr: AVG(energy_delivered_kwh)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Peak Power Kw"
      expr: SUM(peak_power_kw)
    - name: "Average Peak Power Kw"
      expr: AVG(peak_power_kw)
    - name: "Total Session Duration Seconds"
      expr: SUM(session_duration_seconds)
    - name: "Average Session Duration Seconds"
      expr: AVG(session_duration_seconds)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_geofence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geofence business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`geofence`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Allowed Vehicle Type"
      expr: allowed_vehicle_type
    - name: "Associated Service"
      expr: associated_service
    - name: "Audit Status"
      expr: audit_status
    - name: "City"
      expr: city
    - name: "Geofence Code"
      expr: geofence_code
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Geofence Description"
      expr: geofence_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Geometry Coordinates"
      expr: geometry_coordinates
    - name: "Geometry Type"
      expr: geometry_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Geofence"
      expr: COUNT(DISTINCT geofence_id)
    - name: "Total Area Sq Meters"
      expr: SUM(area_sq_meters)
    - name: "Average Area Sq Meters"
      expr: AVG(area_sq_meters)
    - name: "Total Center Latitude"
      expr: SUM(center_latitude)
    - name: "Average Center Latitude"
      expr: AVG(center_latitude)
    - name: "Total Center Longitude"
      expr: SUM(center_longitude)
    - name: "Average Center Longitude"
      expr: AVG(center_longitude)
    - name: "Total Max Speed Limit Kph"
      expr: SUM(max_speed_limit_kph)
    - name: "Average Max Speed Limit Kph"
      expr: AVG(max_speed_limit_kph)
    - name: "Total Min Speed Limit Kph"
      expr: SUM(min_speed_limit_kph)
    - name: "Average Min Speed Limit Kph"
      expr: AVG(min_speed_limit_kph)
    - name: "Total Odometer Limit Km"
      expr: SUM(odometer_limit_km)
    - name: "Average Odometer Limit Km"
      expr: AVG(odometer_limit_km)
    - name: "Total Perimeter Meters"
      expr: SUM(perimeter_meters)
    - name: "Average Perimeter Meters"
      expr: AVG(perimeter_meters)
    - name: "Total Radius Meters"
      expr: SUM(radius_meters)
    - name: "Average Radius Meters"
      expr: AVG(radius_meters)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_geofence_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geofence Event business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`geofence_event`"
  dimensions:
    - name: "Battery Level Percent"
      expr: battery_level_percent
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Dwell Duration Seconds"
      expr: dwell_duration_seconds
    - name: "Event Source"
      expr: event_source
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Processing Status"
      expr: processing_status
    - name: "Signal Strength Dbm"
      expr: signal_strength_dbm
    - name: "Triggered Action"
      expr: triggered_action
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vehicle Vin"
      expr: vehicle_vin
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Event Timestamp Month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Geofence Event"
      expr: COUNT(DISTINCT geofence_event_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
    - name: "Total Speed Kph"
      expr: SUM(speed_kph)
    - name: "Average Speed Kph"
      expr: AVG(speed_kph)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Consent Record business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_consent_record`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Consent Record"
      expr: COUNT(DISTINCT mobility_consent_record_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_dtc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Dtc Event business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_dtc_event`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Dtc Event"
      expr: COUNT(DISTINCT mobility_dtc_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_fleet_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Fleet Account business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_fleet_account`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Fleet Account"
      expr: COUNT(DISTINCT mobility_fleet_account_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_fleet_vehicle_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Fleet Vehicle Assignment business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_fleet_vehicle_assignment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Fleet Vehicle Assignment"
      expr: COUNT(DISTINCT mobility_fleet_vehicle_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_ota_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Ota Deployment business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_ota_deployment`"
  dimensions:
    - name: "Connection Type"
      expr: connection_type
    - name: "Consent Given"
      expr: consent_given
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deployment Code"
      expr: deployment_code
    - name: "Deployment Initiated Timestamp"
      expr: deployment_initiated_timestamp
    - name: "Download Duration Seconds"
      expr: download_duration_seconds
    - name: "Download End Timestamp"
      expr: download_end_timestamp
    - name: "Download Start Timestamp"
      expr: download_start_timestamp
    - name: "Failure Reason Code"
      expr: failure_reason_code
    - name: "Install Duration Seconds"
      expr: install_duration_seconds
    - name: "Install End Timestamp"
      expr: install_end_timestamp
    - name: "Install Start Timestamp"
      expr: install_start_timestamp
    - name: "Mobility Ota Deployment Status"
      expr: mobility_ota_deployment_status
    - name: "Post Software Version"
      expr: post_software_version
    - name: "Pre Software Version"
      expr: pre_software_version
    - name: "Retry Count"
      expr: retry_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Ota Deployment"
      expr: COUNT(DISTINCT mobility_ota_deployment_id)
    - name: "Total Bandwidth Consumed Mb"
      expr: SUM(bandwidth_consumed_mb)
    - name: "Average Bandwidth Consumed Mb"
      expr: AVG(bandwidth_consumed_mb)
    - name: "Total Data Package Size Mb"
      expr: SUM(data_package_size_mb)
    - name: "Average Data Package Size Mb"
      expr: AVG(data_package_size_mb)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Route business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_route`"
  dimensions:
    - name: "Allowed Vehicle Type"
      expr: allowed_vehicle_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Mobility Route Description"
      expr: mobility_route_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "End Location"
      expr: end_location
    - name: "Estimated Time Min"
      expr: estimated_time_min
    - name: "Geometry Wkt"
      expr: geometry_wkt
    - name: "Gps Accuracy Meters"
      expr: gps_accuracy_meters
    - name: "Is Published"
      expr: is_published
    - name: "Is Toll Exempt"
      expr: is_toll_exempt
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Maintenance Interval Days"
      expr: maintenance_interval_days
    - name: "Priority Level"
      expr: priority_level
    - name: "Region"
      expr: region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Route"
      expr: COUNT(DISTINCT mobility_route_id)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Max Load Tons"
      expr: SUM(max_load_tons)
    - name: "Average Max Load Tons"
      expr: AVG(max_load_tons)
    - name: "Total Toll Amount"
      expr: SUM(toll_amount)
    - name: "Average Toll Amount"
      expr: AVG(toll_amount)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_mobility_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobility Service business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`mobility_service`"
  dimensions:
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Data Privacy Level"
      expr: data_privacy_level
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
    - name: "Device Compatibility"
      expr: device_compatibility
    - name: "Eligibility Rules"
      expr: eligibility_rules
    - name: "End Of Service Date"
      expr: end_of_service_date
    - name: "Is Premium"
      expr: is_premium
    - name: "Launch Date"
      expr: launch_date
    - name: "Max Simultaneous Devices"
      expr: max_simultaneous_devices
    - name: "Ota Update Capability"
      expr: ota_update_capability
    - name: "Predictive Maintenance Enabled"
      expr: predictive_maintenance_enabled
    - name: "Provider"
      expr: provider
    - name: "Regulatory Approval Date"
      expr: regulatory_approval_date
    - name: "Regulatory Approval Status"
      expr: regulatory_approval_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mobility Service"
      expr: COUNT(DISTINCT mobility_service_id)
    - name: "Total Price"
      expr: SUM(price)
    - name: "Average Price"
      expr: AVG(price)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Usage Limit"
      expr: SUM(usage_limit)
    - name: "Average Usage Limit"
      expr: AVG(usage_limit)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ota_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ota Campaign business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`ota_campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Audit Status"
      expr: audit_status
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Checksum"
      expr: checksum
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ota Campaign Description"
      expr: ota_campaign_description
    - name: "End Date"
      expr: end_date
    - name: "Max Concurrent Devices"
      expr: max_concurrent_devices
    - name: "Notes"
      expr: notes
    - name: "Regulatory Reference"
      expr: regulatory_reference
    - name: "Release Notes"
      expr: release_notes
    - name: "Rollback Enabled"
      expr: rollback_enabled
    - name: "Rollout Strategy"
      expr: rollout_strategy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ota Campaign"
      expr: COUNT(DISTINCT ota_campaign_id)
    - name: "Total Estimated Impact Percentage"
      expr: SUM(estimated_impact_percentage)
    - name: "Average Estimated Impact Percentage"
      expr: AVG(estimated_impact_percentage)
    - name: "Total Firmware Size Mb"
      expr: SUM(firmware_size_mb)
    - name: "Average Firmware Size Mb"
      expr: AVG(firmware_size_mb)
    - name: "Total Target Percentage"
      expr: SUM(target_percentage)
    - name: "Average Target Percentage"
      expr: AVG(target_percentage)
    - name: "Total Total Target Vehicles"
      expr: SUM(total_target_vehicles)
    - name: "Average Total Target Vehicles"
      expr: AVG(total_target_vehicles)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_predictive_maintenance_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive Maintenance Alert business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`predictive_maintenance_alert`"
  dimensions:
    - name: "Alert Category"
      expr: alert_category
    - name: "Alert Code"
      expr: alert_code
    - name: "Alert Status"
      expr: alert_status
    - name: "Component"
      expr: component
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Failure Mode"
      expr: failure_mode
    - name: "Generation Timestamp"
      expr: generation_timestamp
    - name: "Predicted Failure End"
      expr: predicted_failure_end
    - name: "Predicted Failure Start"
      expr: predicted_failure_start
    - name: "Recommended Service Action"
      expr: recommended_service_action
    - name: "Resolution Timestamp"
      expr: resolution_timestamp
    - name: "Severity"
      expr: severity
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Generation Timestamp Month"
      expr: DATE_TRUNC('MONTH', generation_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Predictive Maintenance Alert"
      expr: COUNT(DISTINCT predictive_maintenance_alert_id)
    - name: "Total Confidence Percentage"
      expr: SUM(confidence_percentage)
    - name: "Average Confidence Percentage"
      expr: AVG(confidence_percentage)
    - name: "Total Mileage At Alert"
      expr: SUM(mileage_at_alert)
    - name: "Average Mileage At Alert"
      expr: AVG(mileage_at_alert)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_pricing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing Plan business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`pricing_plan`"
  dimensions:
    - name: "Auto Renew"
      expr: auto_renew
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Pricing Plan Description"
      expr: pricing_plan_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "External System Code"
      expr: external_system_code
    - name: "Feature Set"
      expr: feature_set
    - name: "Is Trial"
      expr: is_trial
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Max Devices"
      expr: max_devices
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Plan"
      expr: COUNT(DISTINCT pricing_plan_id)
    - name: "Total Base Price"
      expr: SUM(base_price)
    - name: "Average Base Price"
      expr: AVG(base_price)
    - name: "Total Overage Rate"
      expr: SUM(overage_rate)
    - name: "Average Overage Rate"
      expr: AVG(overage_rate)
    - name: "Total Price Adjustment Amount"
      expr: SUM(price_adjustment_amount)
    - name: "Average Price Adjustment Amount"
      expr: AVG(price_adjustment_amount)
    - name: "Total Promotional Discount Percent"
      expr: SUM(promotional_discount_percent)
    - name: "Average Promotional Discount Percent"
      expr: AVG(promotional_discount_percent)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Termination Fee"
      expr: SUM(termination_fee)
    - name: "Average Termination Fee"
      expr: AVG(termination_fee)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_remote_command`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote Command business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`remote_command`"
  dimensions:
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Command Parameters"
      expr: command_parameters
    - name: "Command Reference"
      expr: command_reference
    - name: "Command Source"
      expr: command_source
    - name: "Command Type"
      expr: command_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Execution Status"
      expr: execution_status
    - name: "Expiration Timestamp"
      expr: expiration_timestamp
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Issuance Timestamp"
      expr: issuance_timestamp
    - name: "Priority"
      expr: priority
    - name: "Scheduled Timestamp"
      expr: scheduled_timestamp
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vehicle Vin"
      expr: vehicle_vin
    - name: "Acknowledgement Timestamp Month"
      expr: DATE_TRUNC('MONTH', acknowledgement_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Remote Command"
      expr: COUNT(DISTINCT remote_command_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_remote_diagnostic_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote Diagnostic Session business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`remote_diagnostic_session`"
  dimensions:
    - name: "Battery State Of Charge Percent"
      expr: battery_state_of_charge_percent
    - name: "Connectivity Status"
      expr: connectivity_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diagnostic Scope"
      expr: diagnostic_scope
    - name: "Error Codes"
      expr: error_codes
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Network Type"
      expr: network_type
    - name: "Notes"
      expr: notes
    - name: "Outcome"
      expr: outcome
    - name: "Recommended Action Codes"
      expr: recommended_action_codes
    - name: "Remote Diagnostic Session Status"
      expr: remote_diagnostic_session_status
    - name: "Session Code"
      expr: session_code
    - name: "Session Duration Seconds"
      expr: session_duration_seconds
    - name: "Session Timestamp"
      expr: session_timestamp
    - name: "Signal Strength Dbm"
      expr: signal_strength_dbm
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Remote Diagnostic Session"
      expr: COUNT(DISTINCT remote_diagnostic_session_id)
    - name: "Total Data Volume Mb"
      expr: SUM(data_volume_mb)
    - name: "Average Data Volume Mb"
      expr: AVG(data_volume_mb)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_service_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Incident business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`service_incident`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Incident"
      expr: COUNT(DISTINCT service_incident_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Subscription business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`service_subscription`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Compliance Gdpr Consent"
      expr: compliance_gdpr_consent
    - name: "Contract Terms"
      expr: contract_terms
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Sharing Opt In"
      expr: data_sharing_opt_in
    - name: "End Date"
      expr: end_date
    - name: "Entitlement Tier"
      expr: entitlement_tier
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Payment Date"
      expr: last_payment_date
    - name: "Next Payment Due"
      expr: next_payment_due
    - name: "Notes"
      expr: notes
    - name: "Overage Fee Applied"
      expr: overage_fee_applied
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Subscription"
      expr: COUNT(DISTINCT service_subscription_id)
    - name: "Total Billing Amount"
      expr: SUM(billing_amount)
    - name: "Average Billing Amount"
      expr: AVG(billing_amount)
    - name: "Total Overage Amount"
      expr: SUM(overage_amount)
    - name: "Average Overage Amount"
      expr: AVG(overage_amount)
    - name: "Total Promo Discount Amount"
      expr: SUM(promo_discount_amount)
    - name: "Average Promo Discount Amount"
      expr: AVG(promo_discount_amount)
    - name: "Total Usage Limit"
      expr: SUM(usage_limit)
    - name: "Average Usage Limit"
      expr: AVG(usage_limit)
    - name: "Total Usage Used"
      expr: SUM(usage_used)
    - name: "Average Usage Used"
      expr: AVG(usage_used)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_service_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Tier business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`service_tier`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Included Features"
      expr: included_features
    - name: "Max Vehicles"
      expr: max_vehicles
    - name: "Sla Response Time Hours"
      expr: sla_response_time_hours
    - name: "Tier Code"
      expr: tier_code
    - name: "Tier Description"
      expr: tier_description
    - name: "Tier Level"
      expr: tier_level
    - name: "Tier Name"
      expr: tier_name
    - name: "Tier Status"
      expr: tier_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Tier"
      expr: COUNT(DISTINCT service_tier_id)
    - name: "Total Monthly Fee"
      expr: SUM(monthly_fee)
    - name: "Average Monthly Fee"
      expr: AVG(monthly_fee)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_software_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software Version business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`software_version`"
  dimensions:
    - name: "Checksum"
      expr: checksum
    - name: "Checksum Algorithm"
      expr: checksum_algorithm
    - name: "Checksum Validated"
      expr: checksum_validated
    - name: "Compatible Vehicle Models"
      expr: compatible_vehicle_models
    - name: "Component Name"
      expr: component_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Software Version Description"
      expr: software_version_description
    - name: "Download Url"
      expr: download_url
    - name: "File Format"
      expr: file_format
    - name: "File Location Path"
      expr: file_location_path
    - name: "Hardware Dependency"
      expr: hardware_dependency
    - name: "Is Mandatory Update"
      expr: is_mandatory_update
    - name: "Is Security Update"
      expr: is_security_update
    - name: "Minimum Hardware Version"
      expr: minimum_hardware_version
    - name: "Regulatory Approval Date"
      expr: regulatory_approval_date
    - name: "Regulatory Approval Reference"
      expr: regulatory_approval_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Software Version"
      expr: COUNT(DISTINCT software_version_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_telematics_device`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telematics Device business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`telematics_device`"
  dimensions:
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Plan Expiration"
      expr: data_plan_expiration
    - name: "Data Plan Type"
      expr: data_plan_type
    - name: "Device Make"
      expr: device_make
    - name: "Device Model"
      expr: device_model
    - name: "Device Status"
      expr: device_status
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Hardware Generation"
      expr: hardware_generation
    - name: "Iccid"
      expr: iccid
    - name: "Imei"
      expr: imei
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Firmware Update"
      expr: last_firmware_update
    - name: "Last Heartbeat Timestamp"
      expr: last_heartbeat_timestamp
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Maintenance Cycle Months"
      expr: maintenance_cycle_months
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Telematics Device"
      expr: COUNT(DISTINCT telematics_device_id)
    - name: "Total Battery Level Percent"
      expr: SUM(battery_level_percent)
    - name: "Average Battery Level Percent"
      expr: AVG(battery_level_percent)
    - name: "Total Gps Latitude"
      expr: SUM(gps_latitude)
    - name: "Average Gps Latitude"
      expr: AVG(gps_latitude)
    - name: "Total Gps Longitude"
      expr: SUM(gps_longitude)
    - name: "Average Gps Longitude"
      expr: AVG(gps_longitude)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
    - name: "Total Temperature C"
      expr: SUM(temperature_c)
    - name: "Average Temperature C"
      expr: AVG(temperature_c)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_telemetry_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telemetry Event business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`telemetry_event`"
  dimensions:
    - name: "Charging Status"
      expr: charging_status
    - name: "Connectivity Status"
      expr: connectivity_status
    - name: "Engine Rpm"
      expr: engine_rpm
    - name: "Event Source"
      expr: event_source
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type Code"
      expr: event_type_code
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Ignition State"
      expr: ignition_state
    - name: "Location City"
      expr: location_city
    - name: "Location Country"
      expr: location_country
    - name: "Location State"
      expr: location_state
    - name: "Raw Payload"
      expr: raw_payload
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Signal Quality"
      expr: signal_quality
    - name: "Event Timestamp Month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Telemetry Event"
      expr: COUNT(DISTINCT telemetry_event_id)
    - name: "Total Altitude"
      expr: SUM(altitude)
    - name: "Average Altitude"
      expr: AVG(altitude)
    - name: "Total Battery Soc Percent"
      expr: SUM(battery_soc_percent)
    - name: "Average Battery Soc Percent"
      expr: AVG(battery_soc_percent)
    - name: "Total Battery Voltage Volt"
      expr: SUM(battery_voltage_volt)
    - name: "Average Battery Voltage Volt"
      expr: AVG(battery_voltage_volt)
    - name: "Total Engine Temperature C"
      expr: SUM(engine_temperature_c)
    - name: "Average Engine Temperature C"
      expr: AVG(engine_temperature_c)
    - name: "Total Event Sequence"
      expr: SUM(event_sequence)
    - name: "Average Event Sequence"
      expr: AVG(event_sequence)
    - name: "Total Fuel Level Percent"
      expr: SUM(fuel_level_percent)
    - name: "Average Fuel Level Percent"
      expr: AVG(fuel_level_percent)
    - name: "Total Gps Accuracy M"
      expr: SUM(gps_accuracy_m)
    - name: "Average Gps Accuracy M"
      expr: AVG(gps_accuracy_m)
    - name: "Total Heading Degrees"
      expr: SUM(heading_degrees)
    - name: "Average Heading Degrees"
      expr: AVG(heading_degrees)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Latitude Accuracy"
      expr: SUM(latitude_accuracy)
    - name: "Average Latitude Accuracy"
      expr: AVG(latitude_accuracy)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Longitude Accuracy"
      expr: SUM(longitude_accuracy)
    - name: "Average Longitude Accuracy"
      expr: AVG(longitude_accuracy)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_tpms_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tpms Reading business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`tpms_reading`"
  dimensions:
    - name: "Alert Flag"
      expr: alert_flag
    - name: "Battery Level Percent"
      expr: battery_level_percent
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
    - name: "Pressure Status"
      expr: pressure_status
    - name: "Pressure Unit"
      expr: pressure_unit
    - name: "Reading Timestamp"
      expr: reading_timestamp
    - name: "Record Status"
      expr: record_status
    - name: "Sensor Serial Number"
      expr: sensor_serial_number
    - name: "Sensor Type"
      expr: sensor_type
    - name: "Signal Strength"
      expr: signal_strength
    - name: "Temperature Unit"
      expr: temperature_unit
    - name: "Wheel Position"
      expr: wheel_position
    - name: "Ingestion Timestamp Month"
      expr: DATE_TRUNC('MONTH', ingestion_timestamp)
    - name: "Reading Timestamp Month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tpms Reading"
      expr: COUNT(DISTINCT tpms_reading_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
    - name: "Total Pressure Value"
      expr: SUM(pressure_value)
    - name: "Average Pressure Value"
      expr: AVG(pressure_value)
    - name: "Total Speed Kph"
      expr: SUM(speed_kph)
    - name: "Average Speed Kph"
      expr: AVG(speed_kph)
    - name: "Total Temperature Value"
      expr: SUM(temperature_value)
    - name: "Average Temperature Value"
      expr: AVG(temperature_value)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_trip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trip business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`trip`"
  dimensions:
    - name: "Charging Event Flag"
      expr: charging_event_flag
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Geo Fence Violation Count"
      expr: geo_fence_violation_count
    - name: "Harsh Acceleration Count"
      expr: harsh_acceleration_count
    - name: "Harsh Braking Count"
      expr: harsh_braking_count
    - name: "Maintenance Alert Flag"
      expr: maintenance_alert_flag
    - name: "Notes"
      expr: notes
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Road Type"
      expr: road_type
    - name: "Start Timestamp"
      expr: start_timestamp
    - name: "Toll Currency"
      expr: toll_currency
    - name: "Traffic Level"
      expr: traffic_level
    - name: "Trip Date"
      expr: trip_date
    - name: "Trip Number"
      expr: trip_number
    - name: "Trip Status"
      expr: trip_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trip"
      expr: COUNT(DISTINCT trip_id)
    - name: "Total Average Speed Kph"
      expr: SUM(average_speed_kph)
    - name: "Average Average Speed Kph"
      expr: AVG(average_speed_kph)
    - name: "Total Battery State Of Charge End Percent"
      expr: SUM(battery_state_of_charge_end_percent)
    - name: "Average Battery State Of Charge End Percent"
      expr: AVG(battery_state_of_charge_end_percent)
    - name: "Total Battery State Of Charge Start Percent"
      expr: SUM(battery_state_of_charge_start_percent)
    - name: "Average Battery State Of Charge Start Percent"
      expr: AVG(battery_state_of_charge_start_percent)
    - name: "Total Destination Latitude"
      expr: SUM(destination_latitude)
    - name: "Average Destination Latitude"
      expr: AVG(destination_latitude)
    - name: "Total Destination Longitude"
      expr: SUM(destination_longitude)
    - name: "Average Destination Longitude"
      expr: AVG(destination_longitude)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Driver Behavior Score"
      expr: SUM(driver_behavior_score)
    - name: "Average Driver Behavior Score"
      expr: AVG(driver_behavior_score)
    - name: "Total Duration Seconds"
      expr: SUM(duration_seconds)
    - name: "Average Duration Seconds"
      expr: AVG(duration_seconds)
    - name: "Total Emission Co2 Kg"
      expr: SUM(emission_co2_kg)
    - name: "Average Emission Co2 Kg"
      expr: AVG(emission_co2_kg)
    - name: "Total End Odometer Km"
      expr: SUM(end_odometer_km)
    - name: "Average End Odometer Km"
      expr: AVG(end_odometer_km)
    - name: "Total Energy Consumed Kwh"
      expr: SUM(energy_consumed_kwh)
    - name: "Average Energy Consumed Kwh"
      expr: AVG(energy_consumed_kwh)
    - name: "Total Fuel Consumed Liters"
      expr: SUM(fuel_consumed_liters)
    - name: "Average Fuel Consumed Liters"
      expr: AVG(fuel_consumed_liters)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_usage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage Record business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`usage_record`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Notes"
      expr: notes
    - name: "Rated Flag"
      expr: rated_flag
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Usage End Timestamp"
      expr: usage_end_timestamp
    - name: "Usage Metric Type"
      expr: usage_metric_type
    - name: "Usage Record Status"
      expr: usage_record_status
    - name: "Usage Start Timestamp"
      expr: usage_start_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Usage Record"
      expr: COUNT(DISTINCT usage_record_id)
    - name: "Total Rating Amount"
      expr: SUM(rating_amount)
    - name: "Average Rating Amount"
      expr: AVG(rating_amount)
    - name: "Total Usage Quantity"
      expr: SUM(usage_quantity)
    - name: "Average Usage Quantity"
      expr: AVG(usage_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_vehicle_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle Service Subscription business metrics"
  source: "`vibe_automotive_v1`.`mobility`.`vehicle_service_subscription`"
  dimensions:
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "End Date"
      expr: end_date
    - name: "Start Date"
      expr: start_date
    - name: "Subscription Number"
      expr: subscription_number
    - name: "Subscription Type"
      expr: subscription_type
    - name: "Vehicle Service Subscription Status"
      expr: vehicle_service_subscription_status
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
    - name: "Start Date Month"
      expr: DATE_TRUNC('MONTH', start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle Service Subscription"
      expr: COUNT(DISTINCT vehicle_service_subscription_id)
    - name: "Total Billing Amount"
      expr: SUM(billing_amount)
    - name: "Average Billing Amount"
      expr: AVG(billing_amount)
$$;