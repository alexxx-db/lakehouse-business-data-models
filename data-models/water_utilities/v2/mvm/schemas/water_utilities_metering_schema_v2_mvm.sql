-- Schema for Domain: metering | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each metering meter record in the metering domain.',
    `ami_compatible_flag` BOOLEAN COMMENT 'The ami compatible flag value recorded for each metering meter in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each metering meter record in the metering domain.',
    `cumulative_volume_gallons` DECIMAL(18,2) COMMENT 'The cumulative volume gallons value recorded for each metering meter in the metering domain.',
    `expected_useful_life_years` STRING COMMENT 'The expected useful life years value recorded for each metering meter in the metering domain.',
    `firmware_version` STRING COMMENT 'The firmware version value recorded for each metering meter in the metering domain.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the metering meter location.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the metering meter location.',
    `installation_date` DATE COMMENT 'The installation date associated with each metering meter record in the metering domain.',
    `last_test_accuracy_pct` DECIMAL(18,2) COMMENT 'The last test accuracy pct value recorded for each metering meter in the metering domain.',
    `last_test_date` DATE COMMENT 'The last test date associated with each metering meter record in the metering domain.',
    `lifecycle_status` STRING COMMENT 'The lifecycle status value recorded for each metering meter in the metering domain.',
    `location_description` STRING COMMENT 'The location description value recorded for each metering meter in the metering domain.',
    `manufacture_date` DATE COMMENT 'The manufacture date associated with each metering meter record in the metering domain.',
    `manufacturer` STRING COMMENT 'The manufacturer value recorded for each metering meter in the metering domain.',
    `max_flow_rate_gpm` DECIMAL(18,2) COMMENT 'The max flow rate gpm value recorded for each metering meter in the metering domain.',
    `meter_number` STRING COMMENT 'The meter number value recorded for each metering meter in the metering domain.',
    `meter_type` STRING COMMENT 'The meter type value recorded for each metering meter in the metering domain.',
    `model` STRING COMMENT 'The model value recorded for each metering meter in the metering domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each metering meter record in the metering domain.',
    `number_of_dials` STRING COMMENT 'The number of dials value recorded for each metering meter in the metering domain.',
    `pit_condition` STRING COMMENT 'The pit condition value recorded for each metering meter in the metering domain.',
    `purchase_date` DATE COMMENT 'The purchase date associated with each metering meter record in the metering domain.',
    `register_multiplier` DECIMAL(18,2) COMMENT 'The register multiplier value recorded for each metering meter in the metering domain.',
    `register_type` STRING COMMENT 'The register type value recorded for each metering meter in the metering domain.',
    `register_unit_of_measure` STRING COMMENT 'The register unit of measure value recorded for each metering meter in the metering domain.',
    `retirement_date` DATE COMMENT 'The retirement date associated with each metering meter record in the metering domain.',
    `serial_number` STRING COMMENT 'The serial number value recorded for each metering meter in the metering domain.',
    `size_inches` DECIMAL(18,2) COMMENT 'The meter size inches value recorded for each metering meter in the metering domain.',
    `tamper_seal_number` STRING COMMENT 'The tamper seal number value recorded for each metering meter in the metering domain.',
    `warranty_expiration_date` DATE COMMENT 'The warranty expiration date associated with each metering meter record in the metering domain.',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Physical water meter device installed at customer premises or system boundary points. Records consumption via mechanical or electronic register. Links to AMI endpoint for automated reading. Central to revenue metering, NRW analysis, and customer billing. References AWWA M6 Water Meters—Selection, Installation, Testing, and Maintenance. [SSOT: reference view of canonical asset.asset_meter] SSOT master for meter identity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'FK to the AMI communication endpoint attached. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'District Metered Area for this installation. Ref: Sensus AMI.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: A meter installation has a definitive physical location managed in the asset location registry. Installation carries denormalized latitude/longitude; linking to asset.location enables authoritative GI',
    `meter_id` BIGINT COMMENT 'Link to meter. Ref: Sensus AMI.',
    `pressure_zone_id` BIGINT COMMENT 'FK to the pressure zone. Ref: Sensus AMI.',
    `read_route_id` BIGINT COMMENT 'Read route assigned to this installation. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'FK to customer.service_address. Ref: Sensus AMI.',
    `service_agreement_id` BIGINT COMMENT 'FK to customer.service_agreement. Ref: Sensus AMI.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each installation in the metering domain.',
    `installation_category` STRING COMMENT 'The installation category value recorded for each installation in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each installation in the metering domain.',
    `installation_code` STRING COMMENT 'The installation code value recorded for each installation in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each installation in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each installation in the metering domain.',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Service connection size in inches. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each installation in the metering domain.',
    `installation_description` STRING COMMENT 'The installation description value recorded for each installation in the metering domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each installation record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each installation record in the metering domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each installation record in the metering domain.',
    `final_read_value` DECIMAL(18,2) COMMENT 'The final read value value recorded for each installation in the metering domain.',
    `flow_direction` STRING COMMENT 'Normal, reverse, bidirectional. Ref: Sensus AMI.',
    `initial_read_value` DECIMAL(18,2) COMMENT 'The initial read value value recorded for each installation in the metering domain.',
    `install_date` TIMESTAMP COMMENT 'Date meter was installed. Ref: Sensus AMI.',
    `install_read_value` DECIMAL(18,2) COMMENT 'Meter read value at time of installation. Ref: Sensus AMI.',
    `install_reason` STRING COMMENT 'New Service, Replacement, Upgrade, Repair. Ref: Sensus AMI.',
    `installation_date` TIMESTAMP COMMENT 'The installation date associated with each installation record in the metering domain.',
    `installation_number` STRING COMMENT 'Unique installation identifier. Ref: Sensus AMI.',
    `installation_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `installation_type` STRING COMMENT 'Type of installation (new, replacement, etc.). Ref: Sensus AMI.',
    `installed_date` TIMESTAMP COMMENT 'The installed date associated with each installation record in the metering domain.',
    `installer_notes` STRING COMMENT 'Free-text notes from the installing technician. Ref: Sensus AMI.',
    `is_accessible` BOOLEAN COMMENT 'Whether installation is accessible. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the installation record.',
    `is_locked` BOOLEAN COMMENT 'Whether meter is locked. Ref: Sensus AMI.',
    `location_description` STRING COMMENT 'Description of installation location. Ref: Sensus AMI.',
    `lock_reason` STRING COMMENT 'Reason meter is locked. Ref: Sensus AMI.',
    `meter_box_size` STRING COMMENT 'Size of the meter box or vault. Ref: Sensus AMI.',
    `meter_location_description` STRING COMMENT 'Physical location description (pit, curb box, inside). Ref: Sensus AMI.',
    `meter_orientation` STRING COMMENT 'Physical orientation (horizontal, vertical, angled). Ref: Sensus AMI.',
    `meter_pit_depth_in` DECIMAL(18,2) COMMENT 'Depth of meter pit in inches. Ref: Sensus AMI.',
    `meter_pit_depth_inches` DECIMAL(18,2) COMMENT 'Depth of the meter pit in inches. Ref: Sensus AMI.',
    `meter_position` STRING COMMENT 'The meter position value recorded for each installation in the metering domain.',
    `installation_name` STRING COMMENT 'The installation name used to identify each installation record in the metering domain.',
    `notes` STRING COMMENT 'Free-text notes from the installer about site conditions or issues. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each installation in the metering domain.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the service line at the meter in inches. Ref: Sensus AMI.',
    `pipe_material` STRING COMMENT 'Material of the service line at the meter connection. Ref: Sensus AMI.',
    `pit_type` STRING COMMENT 'Type of meter pit or vault. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each installation in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each installation in the metering domain.',
    `read_access_notes` STRING COMMENT 'Notes on meter access for reading. Ref: Sensus AMI.',
    `read_sequence_number` STRING COMMENT 'Sequence number in read route. Ref: Sensus AMI.',
    `reading_at_install` DECIMAL(18,2) COMMENT 'Meter reading at installation. Ref: Sensus AMI.',
    `reading_at_removal` DECIMAL(18,2) COMMENT 'Meter reading at removal. Ref: Sensus AMI.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each installation in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each installation in the metering domain.',
    `register_reading_at_install` DECIMAL(18,2) COMMENT 'Meter register reading at time of installation. Ref: Sensus AMI.',
    `register_reading_at_removal` DECIMAL(18,2) COMMENT 'Meter register reading at time of removal. Ref: Sensus AMI.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each installation in the metering domain.',
    `removal_date` TIMESTAMP COMMENT 'Date meter was removed. Ref: Sensus AMI.',
    `removal_read_value` DECIMAL(18,2) COMMENT 'Meter read value at time of removal. Ref: Sensus AMI.',
    `removal_reason` STRING COMMENT 'Replacement, Service Termination, Theft, Failure. Ref: Sensus AMI.',
    `removed_date` TIMESTAMP COMMENT 'The removed date associated with each installation record in the metering domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each installation record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each installation in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each installation in the metering domain.',
    `service_line_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the service line in inches. Ref: Sensus AMI.',
    `service_line_material` STRING COMMENT 'Material of service line. Ref: Sensus AMI.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each installation record in the metering domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each installation in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Physical installation of a meter at a specific location. Tracks install/removal dates, location, pit condition, and service line details. One meter may have multiple installations over its lifecycle. Critical for field service dispatch and meter history.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Link to district metered area. Ref: Sensus AMI.',
    `meter_id` BIGINT COMMENT 'Link to meter. Ref: Sensus AMI.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: AMI endpoints are physically located within pressure zones; pressure zone drives leak alert threshold calibration and AMI network topology planning. Utilities configure leak detection sensitivity by p',
    `battery_expected_life_years` DECIMAL(18,2) COMMENT 'Expected battery life in years. Ref: Sensus AMI.',
    `battery_install_date` TIMESTAMP COMMENT 'Date battery was installed. Ref: Sensus AMI.',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Current battery level percentage. Ref: Sensus AMI.',
    `commissioning_date` TIMESTAMP COMMENT 'Date endpoint was commissioned. Ref: Sensus AMI.',
    `communication_frequency_minutes` STRING COMMENT 'Communication frequency in minutes. Ref: Sensus AMI.',
    `communication_protocol` STRING COMMENT 'Communication protocol used. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_retention_days` STRING COMMENT 'Number of days data is retained. Ref: Sensus AMI.',
    `decommission_date` TIMESTAMP COMMENT 'Date endpoint was decommissioned. Ref: Sensus AMI.',
    `decommission_reason` STRING COMMENT 'Reason for decommissioning. Ref: Sensus AMI.',
    `encryption_algorithm` STRING COMMENT 'Encryption algorithm used. Ref: Sensus AMI.',
    `encryption_key_version` STRING COMMENT 'Version of encryption key. Ref: Sensus AMI.',
    `endpoint_serial_number` STRING COMMENT 'Serial number of endpoint. Ref: Sensus AMI.',
    `endpoint_type` STRING COMMENT 'Type of endpoint. Ref: Sensus AMI.',
    `firmware_version` STRING COMMENT 'Current firmware version. Ref: Sensus AMI.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'GPS latitude. Ref: Sensus AMI.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'GPS longitude. Ref: Sensus AMI.',
    `installation_date` TIMESTAMP COMMENT 'Date endpoint was installed. Ref: Sensus AMI.',
    `installation_technician` STRING COMMENT 'Technician who installed endpoint. Ref: Sensus AMI.',
    `ip_address` STRING COMMENT 'IP address of endpoint. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of last communication. Ref: Sensus AMI.',
    `last_firmware_update_date` TIMESTAMP COMMENT 'Date of last firmware update. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification. Ref: Sensus AMI.',
    `leak_alert_threshold_gpm` DECIMAL(18,2) COMMENT 'Leak alert threshold in GPM. Ref: Sensus AMI.',
    `leak_detection_enabled_flag` BOOLEAN COMMENT 'Whether leak detection is enabled. Ref: Sensus AMI.',
    `mac_address` STRING COMMENT 'MAC address of endpoint. Ref: Sensus AMI.',
    `network_node_code` STRING COMMENT 'Network node code. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Additional notes. Ref: Sensus AMI.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational status. Ref: Sensus AMI.',
    `read_interval_seconds` STRING COMMENT 'Read interval in seconds. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Whether reverse flow was detected. Ref: Sensus AMI.',
    `signal_quality_indicator` STRING COMMENT 'Signal quality indicator. Ref: Sensus AMI.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength in dBm. Ref: Sensus AMI.',
    `tamper_detected_timestamp` TIMESTAMP COMMENT 'Timestamp when tamper was detected. Ref: Sensus AMI.',
    `tamper_status` STRING COMMENT 'Current tamper status. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `warranty_expiration_date` DECIMAL(18,2) COMMENT 'Warranty expiration date. Ref: Sensus AMI.',
    CONSTRAINT pk_ami_endpoint PRIMARY KEY(`ami_endpoint_id`)
) COMMENT 'Advanced Metering Infrastructure (AMI) radio endpoint attached to a meter. Transmits interval consumption data, tamper alerts, and diagnostic information to network collectors. Tracks battery life, signal strength, firmware version, and communication status. References Sensus FlexNet, Itron OpenWay, or similar AMI systems.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read` (
    `read_id` BIGINT COMMENT 'Unique identifier for the read referenced by each read record in the metering domain.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the ami endpoint referenced by each read record in the metering domain.',
    `installation_id` BIGINT COMMENT 'Unique identifier for the meter installation referenced by each read record in the metering domain.',
    `read_route_id` BIGINT COMMENT 'Unique identifier for the read route referenced by each read record in the metering domain.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'The battery voltage value recorded for each read in the metering domain.',
    `billing_flag` BOOLEAN COMMENT 'The billing flag value recorded for each read in the metering domain.',
    `consumption_unit` STRING COMMENT 'The consumption unit value recorded for each read in the metering domain.',
    `consumption_value` DECIMAL(18,2) COMMENT 'The consumption value value recorded for each read in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each read record in the metering domain.',
    `days_since_previous_read` STRING COMMENT 'The days since previous read value recorded for each read in the metering domain.',
    `estimated_flag` BOOLEAN COMMENT 'The estimated flag value recorded for each read in the metering domain.',
    `estimation_method` STRING COMMENT 'The estimation method value recorded for each read in the metering domain.',
    `exception_code` STRING COMMENT 'The exception code value recorded for each read in the metering domain.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The flow rate gpm value recorded for each read in the metering domain.',
    `high_read_flag` BOOLEAN COMMENT 'The high read flag value recorded for each read in the metering domain.',
    `leak_flag` BOOLEAN COMMENT 'The leak flag value recorded for each read in the metering domain.',
    `low_read_flag` BOOLEAN COMMENT 'The low read flag value recorded for each read in the metering domain.',
    `method` STRING COMMENT 'The method value recorded for each read in the metering domain.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each read record in the metering domain.',
    `notes` STRING COMMENT 'The notes value recorded for each read in the metering domain.',
    `previous_register_reading` DECIMAL(18,2) COMMENT 'The previous register reading value recorded for each read in the metering domain.',
    `read_date` DATE COMMENT 'The read date associated with each read record in the metering domain.',
    `read_status` STRING COMMENT 'The read status value recorded for each read in the metering domain.',
    `read_timestamp` TIMESTAMP COMMENT 'The read timestamp associated with each read record in the metering domain.',
    `read_type` STRING COMMENT 'The read type value recorded for each read in the metering domain.',
    `register_reading` DECIMAL(18,2) COMMENT 'The register reading value recorded for each read in the metering domain.',
    `reverse_flow_flag` BOOLEAN COMMENT 'The reverse flow flag value recorded for each read in the metering domain.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'The signal strength dbm value recorded for each read in the metering domain.',
    `tamper_flag` BOOLEAN COMMENT 'The tamper flag value recorded for each read in the metering domain.',
    `validation_rule_applied` STRING COMMENT 'The validation rule applied value recorded for each read in the metering domain.',
    `validation_status` STRING COMMENT 'The validation status value recorded for each read in the metering domain.',
    `water_temperature_c` DECIMAL(18,2) COMMENT 'The water temperature c value recorded for each read in the metering domain.',
    `zero_consumption_flag` BOOLEAN COMMENT 'The zero consumption flag value recorded for each read in the metering domain.',
    CONSTRAINT pk_read PRIMARY KEY(`read_id`)
) COMMENT 'Individual meter reading event. Captures register value, consumption, read type (actual/estimated), validation status, and anomaly flags (high/low, leak, tamper, reverse flow). Source of billing consumption and NRW analysis. References Oracle CC&B meter read module.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` (
    `interval_consumption_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Link to AMI endpoint. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Link to district metered area. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Link to meter installation. Ref: Sensus AMI.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: NRW/UFW reporting by pressure zone is a standard regulatory KPI in water utilities. Interval consumption must be aggregated at pressure zone level alongside DMA level. dma_id already exists but pressu',
    `alarm_code` STRING COMMENT 'Alarm code if any. Ref: Sensus AMI.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Battery voltage at time of reading. Ref: Sensus AMI.',
    `consumption_volume_gallons` DECIMAL(18,2) COMMENT 'Consumption volume in gallons. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp. Ref: Sensus AMI.',
    `data_quality_indicator` STRING COMMENT 'Data quality indicator. Ref: Sensus AMI.',
    `estimated_method` STRING COMMENT 'Method used if estimated. Ref: Sensus AMI.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate in GPM. Ref: Sensus AMI.',
    `gap_flag` BOOLEAN COMMENT 'Whether there is a data gap. Ref: Sensus AMI.',
    `high_usage_flag` BOOLEAN COMMENT 'High usage flag. Ref: Sensus AMI.',
    `interval_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of interval in minutes. Ref: Sensus AMI.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'End timestamp of interval. Ref: Sensus AMI.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of interval. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `leak_detection_flag` BOOLEAN COMMENT 'Leak detection flag. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Additional notes. Ref: Sensus AMI.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Pressure in PSI. Ref: Sensus AMI.',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when processed. Ref: Sensus AMI.',
    `pulse_increment_gallons` DECIMAL(18,2) COMMENT 'Pulse increment in gallons. Ref: Sensus AMI.',
    `raw_pulse_count` BIGINT COMMENT 'Raw pulse count. Ref: Sensus AMI.',
    `received_timestamp` TIMESTAMP COMMENT 'Timestamp when received. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Reverse flow flag. Ref: Sensus AMI.',
    `signal_strength_dbm` STRING COMMENT 'Signal strength in dBm. Ref: Sensus AMI.',
    `tamper_event_code` STRING COMMENT 'Tamper event code if any. Ref: Sensus AMI.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature in Fahrenheit. Ref: Sensus AMI.',
    `transmission_retry_count` STRING COMMENT 'Number of transmission retries. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `validation_status` STRING COMMENT 'Validation status. Ref: Sensus AMI.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when validated. Ref: Sensus AMI.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Zero consumption flag. Ref: Sensus AMI.',
    CONSTRAINT pk_interval_consumption PRIMARY KEY(`interval_consumption_id`)
) COMMENT 'High-frequency (typically 15-minute or hourly) consumption data from AMI endpoints. Enables leak detection, demand forecasting, time-of-use billing, and DMA water balance. Stores raw pulse count, flow rate, pressure, temperature, and data quality indicators.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d. Ref: Sensus AMI.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Alert investigation requires direct access to the service agreement to review contracted demand, service type, billing thresholds, and rate class. high_usage_alert already has account/premise/address ',
    `actual_consumption_unit` STRING COMMENT 'Unit of measure for the actual consumption value. Gallons, cubic feet, and cubic meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate. Ref: Sensus AMI.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd`',
    `actual_consumption_value` DECIMAL(18,2) COMMENT 'The measured consumption value during the detection period that triggered the alert. Represents the actual usage that exceeded the threshold. Ref: Sensus AMI.',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was generated by the Advanced Metering Infrastructure (AMI) or analytics system. Represents the moment the threshold breach was detected. Ref: Sensus AMI.',
    `alert_number` STRING COMMENT 'Business-facing unique alert number used for tracking and customer communication. Format: HUA-XXXXXXXXXX. Ref: Sensus AMI.. Valid values are `^HUA-[0-9]{10}$`',
    `alert_severity` STRING COMMENT 'Severity classification of the alert based on variance magnitude and potential impact. Low indicates minor variance; medium indicates moderate concern; high indicates significant issue requiring prompt attention; critical indicates emergency condition requiring immediate response. Ref: Sensus AMI.. Valid values are `low|medium|high|critical`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the alert. Open indicates newly generated; notified means customer has been contacted; acknowledged means customer confirmed receipt; investigating indicates active review; resolved means issue addressed; dismissed means no action required; false positive indicates erroneous alert. [ENUM-REF-CANDIDATE: open|notified|acknowledged|investigating|resolved|dismissed|false_positive — 7 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `alert_type` STRING COMMENT 'Classification of the high usage alert based on consumption pattern analysis. High consumption indicates volume exceeds baseline; continuous flow suggests uninterrupted usage; backflow suspected indicates reverse flow detection; leak detected flags potential infrastructure failure; abnormal pattern identifies irregular usage; threshold exceeded indicates absolute limit breach. Ref: Sensus AMI.. Valid values are `high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded`',
    `baseline_consumption_value` DECIMAL(18,2) COMMENT 'Historical average or expected consumption value used as the comparison baseline for this alert. May be calculated from seasonal norms, customer history, or similar account profiles.',
    `baseline_period_days` STRING COMMENT 'Number of days used to calculate the baseline consumption value. Typical values include 30, 60, 90, or 365 days depending on seasonality and data availability. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the system. Used for audit trail and data lineage. Ref: Sensus AMI.',
    `customer_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the customer acknowledged receipt and awareness of this alert. Null if customer has not acknowledged. Ref: Sensus AMI.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about this high usage alert. True means notification sent; False means no notification sent yet. Ref: Sensus AMI.',
    `data_source` STRING COMMENT 'Source system or method that provided the consumption data used to generate this alert. AMI interval data represents 15-minute or hourly reads; AMI daily read represents once-per-day automated read; manual read represents field technician reading; estimated read represents calculated value; SCADA flow data represents distribution network monitoring; analytics engine represents derived calculation. Ref: Sensus AMI.. Valid values are `ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine`',
    `detection_period_end_timestamp` TIMESTAMP COMMENT 'End of the time window during which the high usage condition was detected. Used to define the consumption analysis interval. Ref: Sensus AMI.',
    `detection_period_start_timestamp` TIMESTAMP COMMENT 'Beginning of the time window during which the high usage condition was detected. Used to define the consumption analysis interval. Ref: Sensus AMI.',
    `estimated_revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the high usage condition, representing potential lost revenue or customer billing adjustment. Positive values indicate revenue at risk; negative values indicate customer credits issued. Null if not calculated. Ref: Sensus AMI.',
    `estimated_water_loss_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost or wasted due to the condition that triggered this alert, measured in gallons. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Null if not applicable or not calculated. Ref: Sensus AMI.',
    `first_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the first customer notification was sent for this alert. Null if customer has not been notified. Ref: Sensus AMI.',
    `investigation_started_timestamp` TIMESTAMP COMMENT 'Date and time when investigation of this alert began. Null if investigation has not started. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was most recently updated. Used for audit trail and change tracking. Ref: Sensus AMI.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this alert record. Used for audit trail and accountability. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Notes. Ref: Sensus AMI.',
    `notification_count` STRING COMMENT 'Total number of notification attempts made to the customer regarding this alert. Includes all channels and retries. Ref: Sensus AMI.',
    `notification_method` STRING COMMENT 'Primary communication channel used to notify the customer about this alert. Email, SMS, and mobile app represent digital channels; phone call represents voice contact; postal mail represents physical correspondence; customer portal represents self-service access; none indicates no notification sent. [ENUM-REF-CANDIDATE: email|sms|phone_call|postal_mail|mobile_app|customer_portal|none — 7 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `resolution_category` STRING COMMENT 'Classification of the root cause or resolution outcome for this alert. Customer leak repaired indicates customer-side plumbing issue fixed; utility leak repaired indicates utility infrastructure issue fixed; meter malfunction indicates faulty meter; seasonal usage indicates expected variance; customer behavior change indicates legitimate usage increase; irrigation system and pool filling indicate specific high-volume activities; construction activity indicates temporary usage spike; false alarm indicates erroneous alert; other indicates miscellaneous resolution. [ENUM-REF-CANDIDATE: customer_leak_repaired|utility_leak_repaired|meter_malfunction|seasonal_usage|customer_behavior_change|irrigation_system|pool_filling|construction_activity|false_alarm|other — 10 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `resolution_notes` STRING COMMENT 'Free-text narrative describing the investigation findings, actions taken, and resolution details for this alert. Provides context for future reference and audit trail. Ref: Sensus AMI.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when this alert was resolved or closed. Null if alert remains open or under investigation. Ref: Sensus AMI.',
    `service_order_created_flag` BOOLEAN COMMENT 'Indicates whether a field service order was created in response to this alert. True means service order generated; False means no service order created. Ref: Sensus AMI.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this alert was suppressed from customer notification due to business rules (e.g., customer opted out, account in dispute, recent similar alert). True means suppressed; False means not suppressed. Ref: Sensus AMI.',
    `suppression_reason` STRING COMMENT 'Explanation of why this alert was suppressed from customer notification. Null if alert was not suppressed. Ref: Sensus AMI.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value. Gallons and cubic feet/meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate; percent represents variance from baseline. Ref: Sensus AMI.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd|percent`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The defined limit or baseline value that was exceeded to trigger this alert. May represent absolute volume, flow rate, or percentage variance depending on alert configuration. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which actual consumption exceeded the threshold value. Calculated as ((actual - threshold) / threshold) * 100. Positive values indicate over-threshold conditions. Ref: Sensus AMI.',
    CONSTRAINT pk_high_usage_alert PRIMARY KEY(`high_usage_alert_id`)
) COMMENT 'Operational alert record generated when a meters consumption exceeds a defined threshold relative to historical baseline, seasonal norms, or absolute volume limits. Stores alert generation timestamp, meter installation reference, alert type (high consumption, continuous flow, backflow suspected), threshold value, actual consumption value, percentage over threshold, alert status (open, notified, resolved, dismissed), customer contact attempt log, and resolution notes. Feeds customer service workflows in Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` (
    `accuracy_test_id` BIGINT COMMENT 'Primary key for accuracy_test. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Customer account that requested the test. Ref: Sensus AMI.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Meter accuracy testing is formally scheduled and recorded as an asset inspection event in utility asset management systems (Maximo). Linking accuracy_test to inspection_event enables unified inspectio',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_. Ref: Sensus AMI.',
    `accuracy_pct` DECIMAL(18,2) COMMENT 'The accuracy pct value recorded for each accuracy test in the metering domain.',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'The accuracy percentage value recorded for each accuracy test in the metering domain.',
    `accuracy_test_number` STRING COMMENT 'The accuracy test number value recorded for each accuracy test in the metering domain.',
    `accuracy_test_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `accuracy_test_type` STRING COMMENT 'The accuracy test type value recorded for each accuracy test in the metering domain.',
    `accuracy_threshold_pct` DECIMAL(18,2) COMMENT 'Accuracy threshold used for pass/fail determination. Ref: Sensus AMI.',
    `accuracy_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable accuracy tolerance per AWWA standards',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each accuracy test in the metering domain.',
    `awwa_standard_reference` STRING COMMENT 'AWWA standard used (M6, C700, C702, C710).',
    `awwa_threshold_pct` DECIMAL(18,2) COMMENT 'AWWA accuracy threshold used (typically 98.5%)',
    `accuracy_test_category` STRING COMMENT 'The accuracy test category value recorded for each accuracy test in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each accuracy test in the metering domain.',
    `accuracy_test_code` STRING COMMENT 'The accuracy test code value recorded for each accuracy test in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each accuracy test in the metering domain.',
    `complaint_triggered` BOOLEAN COMMENT 'Whether test was triggered by customer complaint. Ref: Sensus AMI.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each accuracy test in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `cumulative_volume_at_test` DECIMAL(18,2) COMMENT 'Cumulative volume registered at test. Ref: Sensus AMI.',
    `customer_requested` BOOLEAN COMMENT 'Flag indicating the test was requested by the customer. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each accuracy test in the metering domain.',
    `accuracy_test_description` STRING COMMENT 'The accuracy test description value recorded for each accuracy test in the metering domain.',
    `disposition` STRING COMMENT 'Disposition after test (return_to_service, replace, repair, scrap). Ref: Sensus AMI.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each accuracy test record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each accuracy test record in the metering domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each accuracy test record in the metering domain.',
    `high_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at high flow rate (%). Ref: Sensus AMI.',
    `high_flow_rate_gpm` DECIMAL(18,2) COMMENT 'High flow test rate in GPM. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Sensus AMI.',
    `low_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at low flow rate (%). Ref: Sensus AMI.',
    `low_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Low flow test rate in GPM. Ref: Sensus AMI.',
    `medium_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'Accuracy at medium flow rate (%). Ref: Sensus AMI.',
    `meter_age_years` DECIMAL(18,2) COMMENT 'Age of meter at time of test. Ref: Sensus AMI.',
    `meter_volume` DECIMAL(18,2) COMMENT 'The meter volume value recorded for each accuracy test in the metering domain.',
    `mid_flow_accuracy_pct` DECIMAL(18,2) COMMENT 'The mid flow accuracy pct value recorded for each accuracy test in the metering domain.',
    `mid_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Mid flow test rate in GPM. Ref: Sensus AMI.',
    `accuracy_test_name` STRING COMMENT 'The accuracy test name used to identify each accuracy test record in the metering domain.',
    `notes` STRING COMMENT 'Test notes and observations. Ref: Sensus AMI.',
    `overall_accuracy_pct` DECIMAL(18,2) COMMENT 'Overall weighted accuracy percentage. Ref: Sensus AMI.',
    `pass_fail_flag` BOOLEAN COMMENT 'The pass fail flag value recorded for each accuracy test in the metering domain.',
    `pass_fail_status` STRING COMMENT 'Test result (pass, fail, marginal). Ref: Sensus AMI.',
    `pass_fail_threshold_pct` DECIMAL(18,2) COMMENT 'Pass/fail threshold percentage for the test. Ref: Sensus AMI.',
    `pass_flag` BOOLEAN COMMENT 'The pass flag value recorded for each accuracy test in the metering domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each accuracy test in the metering domain.',
    `post_test_read_value` DECIMAL(18,2) COMMENT 'Meter register reading after the test. Ref: Sensus AMI.',
    `pre_test_read_value` DECIMAL(18,2) COMMENT 'Meter register reading before the test. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each accuracy test in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each accuracy test in the metering domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each accuracy test in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each accuracy test in the metering domain.',
    `reference_volume` DECIMAL(18,2) COMMENT 'The reference volume value recorded for each accuracy test in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each accuracy test in the metering domain.',
    `replacement_reason` STRING COMMENT 'Reason replacement is recommended. Ref: Sensus AMI.',
    `replacement_recommended` BOOLEAN COMMENT 'Whether replacement is recommended based on test result. Ref: Sensus AMI.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each accuracy test record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each accuracy test in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each accuracy test in the metering domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each accuracy test record in the metering domain.',
    `test_bench_calibration_date` DECIMAL(18,2) COMMENT 'Last calibration date of the test bench. Ref: Sensus AMI.',
    `test_bench_code` BIGINT COMMENT 'Test bench/equipment identifier. Ref: Sensus AMI.',
    `test_date` DATE COMMENT 'Date test was performed. Ref: Sensus AMI.',
    `test_equipment_calibration_date` DECIMAL(18,2) COMMENT 'Calibration date of test equipment. Ref: Sensus AMI.',
    `test_flow_rate_gpm` DECIMAL(18,2) COMMENT 'The test flow rate gpm value recorded for each accuracy test in the metering domain.',
    `test_location` STRING COMMENT 'The test location value recorded for each accuracy test in the metering domain.',
    `test_method` STRING COMMENT 'AWWA M6, OIML R49',
    `test_notes` STRING COMMENT 'The test notes value recorded for each accuracy test in the metering domain.',
    `test_number` STRING COMMENT 'Unique test reference number. Ref: Sensus AMI.',
    `test_reason` STRING COMMENT 'Reason for test (scheduled, complaint, high_age, random). Ref: Sensus AMI.',
    `test_result` STRING COMMENT 'The test result value recorded for each accuracy test in the metering domain.',
    `test_status` STRING COMMENT 'Scheduled, In-progress, Completed, Failed, Cancelled. Ref: Sensus AMI.',
    `test_type` STRING COMMENT 'Type of test (bench, field, new_meter, complaint). Ref: Sensus AMI.',
    `test_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume used in test. Ref: Sensus AMI.',
    `tested_by` STRING COMMENT 'The tested by value recorded for each accuracy test in the metering domain.',
    `tester_name` STRING COMMENT 'The tester name used to identify each accuracy test record in the metering domain.',
    `tolerance_high` DECIMAL(18,2) COMMENT 'The tolerance high value recorded for each accuracy test in the metering domain.',
    `tolerance_low` DECIMAL(18,2) COMMENT 'The tolerance low value recorded for each accuracy test in the metering domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each accuracy test in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each accuracy test record in the metering domain.',
    `weighted_accuracy_pct` DECIMAL(18,2) COMMENT 'AWWA weighted accuracy percentage',
    CONSTRAINT pk_accuracy_test PRIMARY KEY(`accuracy_test_id`)
) COMMENT 'Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'FK to district metered area per VREQ-044. Ref: Sensus AMI.',
    `active_flag` BOOLEAN COMMENT 'The active flag value recorded for each read route in the metering domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each read route in the metering domain.',
    `read_route_category` STRING COMMENT 'The read route category value recorded for each read route in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each read route in the metering domain.',
    `read_route_code` STRING COMMENT 'The read route code value recorded for each read route in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each read route in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each read route in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `cycle_code` STRING COMMENT 'The cycle code value recorded for each read route in the metering domain.',
    `cycle_number` STRING COMMENT 'The cycle number value recorded for each read route in the metering domain.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each read route in the metering domain.',
    `read_route_description` STRING COMMENT 'The read route description value recorded for each read route in the metering domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each read route record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each read route record in the metering domain.',
    `estimated_duration_hours` STRING COMMENT 'Estimated time to complete route. Ref: Sensus AMI.',
    `estimated_read_hours` DECIMAL(18,2) COMMENT 'Estimated hours to complete a full route read. Ref: Sensus AMI.',
    `estimated_read_time_hours` DECIMAL(18,2) COMMENT 'Estimated time to complete route in hours. Ref: Sensus AMI.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each read route record in the metering domain.',
    `hazard_notes` STRING COMMENT 'Safety hazard notes for field personnel. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the read route record.',
    `is_ami_route` BOOLEAN COMMENT 'Boolean flag indicating whether the is ami route condition applies to the read route record.',
    `last_read_date` DATE COMMENT 'Date route was last read. Ref: Sensus AMI.',
    `meter_count` STRING COMMENT 'Number of meters on route. Ref: Sensus AMI.',
    `read_route_name` STRING COMMENT 'The read route name used to identify each read route record in the metering domain.',
    `next_scheduled_date` DATE COMMENT 'Next scheduled read date. Ref: Sensus AMI.',
    `next_scheduled_read_date` TIMESTAMP COMMENT 'Next scheduled read date. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each read route in the metering domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each read route in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each read route in the metering domain.',
    `read_cycle` STRING COMMENT 'The read cycle value recorded for each read route in the metering domain.',
    `read_cycle_days` STRING COMMENT 'Number of days between reads on this route. Ref: Sensus AMI.',
    `read_day_of_month` STRING COMMENT 'Scheduled day of month for reading. Ref: Sensus AMI.',
    `read_frequency` STRING COMMENT 'Read frequency (monthly, bi_monthly, quarterly). Ref: Sensus AMI.',
    `read_method` STRING COMMENT 'Walk-by AMR, Drive-by AMR, AMI, Manual. Ref: Sensus AMI.',
    `read_route_number` STRING COMMENT 'The read route number value recorded for each read route in the metering domain.',
    `read_route_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `read_route_type` STRING COMMENT 'The read route type value recorded for each read route in the metering domain.',
    `read_sequence` STRING COMMENT 'The read sequence value recorded for each read route in the metering domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each read route in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each read route in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each read route in the metering domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each read route record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each read route in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each read route in the metering domain.',
    `route_code` STRING COMMENT 'Unique route code identifier. Ref: Sensus AMI.',
    `route_distance_miles` DECIMAL(18,2) COMMENT 'Total route distance in miles. Ref: Sensus AMI.',
    `route_name` STRING COMMENT 'Descriptive route name. Ref: Sensus AMI.',
    `route_number` STRING COMMENT 'The route number value recorded for each read route in the metering domain.',
    `route_sequence` STRING COMMENT 'The route sequence value recorded for each read route in the metering domain.',
    `route_sequence_end` STRING COMMENT 'Ending sequence number. Ref: Sensus AMI.',
    `route_sequence_start` STRING COMMENT 'Starting sequence number. Ref: Sensus AMI.',
    `route_status` STRING COMMENT 'Status (active, inactive, seasonal). Ref: Sensus AMI.',
    `route_type` STRING COMMENT 'Type (manual_walk, drive_by, AMI_fixed_network). Ref: Sensus AMI.',
    `sequence_description` STRING COMMENT 'Description of route sequence/path. Ref: Sensus AMI.',
    `sequence_optimized` STRING COMMENT 'Whether route sequence is GPS-optimized. Ref: Sensus AMI.',
    `sequence_optimized_date` TIMESTAMP COMMENT 'Date the route sequence was last optimized for efficiency. Ref: Sensus AMI.',
    `sequence_optimized_flag` BOOLEAN COMMENT 'Whether the route sequence has been optimized for efficiency. Ref: Sensus AMI.',
    `sequence_order` STRING COMMENT 'The sequence order value recorded for each read route in the metering domain.',
    `service_area_description` STRING COMMENT 'The service area description value recorded for each read route in the metering domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each read route record in the metering domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each read route in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `install_date` SET TAGS ('dbx_business_glossary_term' = 'Install Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `install_reason` SET TAGS ('dbx_business_glossary_term' = 'Install Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_number` SET TAGS ('dbx_business_glossary_term' = 'Installation Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installer_notes` SET TAGS ('dbx_business_glossary_term' = 'Installer Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Is Accessible');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `lock_reason` SET TAGS ('dbx_business_glossary_term' = 'Lock Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_box_size` SET TAGS ('dbx_business_glossary_term' = 'Meter Box Size');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_orientation` SET TAGS ('dbx_business_glossary_term' = 'Meter Orientation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_pit_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Pit Depth');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pit_type` SET TAGS ('dbx_business_glossary_term' = 'Pit Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_access_notes` SET TAGS ('dbx_business_glossary_term' = 'Read Access Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Read Sequence Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `reading_at_install` SET TAGS ('dbx_business_glossary_term' = 'Reading at Install');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `reading_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Reading at Removal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `register_reading_at_install` SET TAGS ('dbx_business_glossary_term' = 'Reading at Install');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `register_reading_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Reading at Removal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_line_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Service Line Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_expected_life_years` SET TAGS ('dbx_business_glossary_term' = 'Battery Expected Life');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_install_date` SET TAGS ('dbx_business_glossary_term' = 'Battery Install Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_technician` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_alert_threshold_gpm` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `read_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Read Interval');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Signal Quality');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detected');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'consumption_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'consumption_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `consumption_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `high_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pulse_increment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Pulse Increment');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `raw_pulse_count` SET TAGS ('dbx_business_glossary_term' = 'Raw Pulse Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `tamper_event_code` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `transmission_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Retry Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'consumption_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `actual_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^HUA-[0-9]{10}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `baseline_period_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledged Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `detection_period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Period Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `estimated_water_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Water Loss Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `first_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Notification Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `investigation_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Started Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_order_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Order Created Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd|percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'consumption_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Tolerance Percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `awwa_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'AWWA Standard');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `cumulative_volume_at_test` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Volume At Test');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `customer_requested` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `meter_age_years` SET TAGS ('dbx_business_glossary_term' = 'Meter Age Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `pass_fail_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Threshold Percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `post_test_read_value` SET TAGS ('dbx_business_glossary_term' = 'Post Test Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `pre_test_read_value` SET TAGS ('dbx_business_glossary_term' = 'Pre Test Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Replacement Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_bench_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Bench Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `test_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Test Volume Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `estimated_read_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `hazard_notes` SET TAGS ('dbx_business_glossary_term' = 'Hazard Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `is_ami_route` SET TAGS ('dbx_boolean' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Route Distance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_sequence_end` SET TAGS ('dbx_business_glossary_term' = 'Route Sequence End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_sequence_start` SET TAGS ('dbx_business_glossary_term' = 'Route Sequence Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `sequence_optimized_date` SET TAGS ('dbx_business_glossary_term' = 'Sequence Optimized Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `sequence_optimized_flag` SET TAGS ('dbx_business_glossary_term' = 'Sequence Optimized');
