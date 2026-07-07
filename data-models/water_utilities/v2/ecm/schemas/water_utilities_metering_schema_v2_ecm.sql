-- Schema for Domain: metering | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` (
    `metering_meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each metering meter record in the metering domain.',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset referenced by each metering meter record in the metering domain.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master referenced by each metering meter record in the metering domain.',
    `meter_size_type_id` BIGINT COMMENT 'Unique identifier for the meter size type referenced by each metering meter record in the metering domain.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each metering meter record in the metering domain.',
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
    `meter_size_inches` DECIMAL(18,2) COMMENT 'The meter size inches value recorded for each metering meter in the metering domain.',
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
    `tamper_seal_number` STRING COMMENT 'The tamper seal number value recorded for each metering meter in the metering domain.',
    `warranty_expiration_date` DATE COMMENT 'The warranty expiration date associated with each metering meter record in the metering domain.',
    CONSTRAINT pk_metering_meter PRIMARY KEY(`metering_meter_id`)
) COMMENT 'Physical water meter device installed at customer premises or system boundary points. Records consumption via mechanical or electronic register. Links to AMI endpoint for automated reading. Central to revenue metering, NRW analysis, and customer billing. References AWWA M6 Water Meters—Selection, Installation, Testing, and Maintenance. [SSOT: reference view of canonical asset.asset_meter] SSOT master for meter identity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'FK to the AMI communication endpoint attached. Ref: Sensus AMI.',
    `cip_project_id` BIGINT COMMENT 'Link to CIP project if part of capital program. Ref: Sensus AMI.',
    `crew_id` BIGINT COMMENT 'Unique identifier for the crew referenced by each installation record in the metering domain.',
    `dma_id` BIGINT COMMENT 'District Metered Area for this installation. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the installation created by employee referenced by each installation record in the metering domain.',
    `installation_employee_id` BIGINT COMMENT 'Installing technician. Ref: Sensus AMI.',
    `installation_installed_by_employee_id` BIGINT COMMENT 'Unique identifier for the installation installed by employee referenced by each installation record in the metering domain.',
    `installation_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the installation responsible employee referenced by each installation record in the metering domain.',
    `metering_meter_id` BIGINT COMMENT 'Link to meter. Ref: Sensus AMI.',
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise referenced by each installation record in the metering domain.',
    `pressure_zone_id` BIGINT COMMENT 'FK to the pressure zone. Ref: Sensus AMI.',
    `read_route_id` BIGINT COMMENT 'Read route assigned to this installation. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'FK to customer.service_address. Ref: Sensus AMI.',
    `service_agreement_id` BIGINT COMMENT 'FK to customer.service_agreement. Ref: Sensus AMI.',
    `point_id` BIGINT COMMENT 'Unique identifier for the service point referenced by each installation record in the metering domain.',
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order referenced by each installation record in the metering domain.',
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
    `installation_notes` STRING COMMENT 'Free-text notes from the installer about site conditions or issues. Ref: Sensus AMI.',
    `installation_number` STRING COMMENT 'Unique installation identifier. Ref: Sensus AMI.',
    `installation_type` STRING COMMENT 'Type of installation (new, replacement, etc.). Ref: Sensus AMI.',
    `installed_date` TIMESTAMP COMMENT 'The installed date associated with each installation record in the metering domain.',
    `installer_notes` STRING COMMENT 'Free-text notes from the installing technician. Ref: Sensus AMI.',
    `is_accessible` BOOLEAN COMMENT 'Whether installation is accessible. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the installation record.',
    `is_locked` BOOLEAN COMMENT 'Whether meter is locked. Ref: Sensus AMI.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude. Ref: Sensus AMI.',
    `location_description` STRING COMMENT 'Description of installation location. Ref: Sensus AMI.',
    `lock_reason` STRING COMMENT 'Reason meter is locked. Ref: Sensus AMI.',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude. Ref: Sensus AMI.',
    `meter_box_size` STRING COMMENT 'Size of the meter box or vault. Ref: Sensus AMI.',
    `meter_location_description` STRING COMMENT 'Physical location description (pit, curb box, inside). Ref: Sensus AMI.',
    `meter_orientation` STRING COMMENT 'Physical orientation (horizontal, vertical, angled). Ref: Sensus AMI.',
    `meter_pit_depth_in` DECIMAL(18,2) COMMENT 'Depth of meter pit in inches. Ref: Sensus AMI.',
    `meter_pit_depth_inches` DECIMAL(18,2) COMMENT 'Depth of the meter pit in inches. Ref: Sensus AMI.',
    `meter_position` STRING COMMENT 'The meter position value recorded for each installation in the metering domain.',
    `installation_name` STRING COMMENT 'The installation name used to identify each installation record in the metering domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Sensus AMI.',
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
    `installation_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each installation in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Physical installation of a meter at a specific location. Tracks install/removal dates, location, pit condition, and service line details. One meter may have multiple installations over its lifecycle. Critical for field service dispatch and meter history.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `ami_network_collector_id` BIGINT COMMENT 'Link to network collector. Ref: Sensus AMI.',
    `cip_project_id` BIGINT COMMENT 'Link to CIP project. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Link to district metered area. Ref: Sensus AMI.',
    `material_master_id` BIGINT COMMENT 'Link to material master. Ref: Sensus AMI.',
    `metering_meter_id` BIGINT COMMENT 'Link to meter. Ref: Sensus AMI.',
    `registry_id` BIGINT COMMENT 'Link to asset registry. Ref: Sensus AMI.',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the reader employee referenced by each read record in the metering domain.',
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
    `ami_network_collector_id` BIGINT COMMENT 'Link to network collector. Ref: Sensus AMI.',
    `billing_cycle_id` BIGINT COMMENT 'Link to billing cycle. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Link to district metered area. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Link to meter installation. Ref: Sensus AMI.',
    `general_ledger_id` BIGINT COMMENT 'Link to revenue accrual GL account. Ref: Sensus AMI.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` (
    `consumption_profile_id` BIGINT COMMENT 'Primary key. Ref: Sensus AMI.',
    `agreement_id` BIGINT COMMENT 'Link to service agreement. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Employee who validated. Ref: Sensus AMI.',
    `consumption_validated_by_user_employee_id` BIGINT COMMENT 'User who validated. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Link to customer account. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Link to meter installation. Ref: Sensus AMI.',
    `premise_id` BIGINT COMMENT 'Link to premise. Ref: Sensus AMI.',
    `general_ledger_id` BIGINT COMMENT 'Link to revenue GL account. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Link to service address. Ref: Sensus AMI.',
    `adjustment_amount_gallons` DECIMAL(18,2) COMMENT 'Adjustment amount in gallons. Ref: Sensus AMI.',
    `adjustment_reason` STRING COMMENT 'Reason for adjustment. Ref: Sensus AMI.',
    `average_daily_usage_gpd` DECIMAL(18,2) COMMENT 'Average daily usage in GPD. Ref: Sensus AMI.',
    `billing_handoff_timestamp` TIMESTAMP COMMENT 'Timestamp when handed off to billing. Ref: Sensus AMI.',
    `billing_period_days` STRING COMMENT 'Number of days in billing period. Ref: Sensus AMI.',
    `billing_period_end_date` TIMESTAMP COMMENT 'End date of billing period. Ref: Sensus AMI.',
    `billing_period_start_date` TIMESTAMP COMMENT 'Start date of billing period. Ref: Sensus AMI.',
    `consumption_status` STRING COMMENT 'Status of consumption. Ref: Sensus AMI.',
    `consumption_tier` STRING COMMENT 'Consumption tier. Ref: Sensus AMI.',
    `consumption_variance_percent` DECIMAL(18,2) COMMENT 'Variance percentage. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `customer_class` STRING COMMENT 'Customer class. Ref: Sensus AMI.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score. Ref: Sensus AMI.',
    `estimated_read_reason` STRING COMMENT 'Reason for estimated read. Ref: Sensus AMI.',
    `high_usage_alert_flag` BOOLEAN COMMENT 'High usage alert flag. Ref: Sensus AMI.',
    `interval_data_available_flag` BOOLEAN COMMENT 'Whether interval data is available. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp. Ref: Sensus AMI.',
    `leak_detected_flag` BOOLEAN COMMENT 'Leak detected flag. Ref: Sensus AMI.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Meter size in inches. Ref: Sensus AMI.',
    `meter_technology` STRING COMMENT 'Meter technology. Ref: Sensus AMI.',
    `minimum_night_flow_gpm` DECIMAL(18,2) COMMENT 'Minimum night flow in GPM. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Additional notes. Ref: Sensus AMI.',
    `nrw_contribution_gallons` DECIMAL(18,2) COMMENT 'NRW contribution in gallons. Ref: Sensus AMI.',
    `peak_day_consumption_gallons` DECIMAL(18,2) COMMENT 'Peak day consumption in gallons. Ref: Sensus AMI.',
    `peak_day_date` TIMESTAMP COMMENT 'Date of peak consumption. Ref: Sensus AMI.',
    `prior_period_consumption_gallons` DECIMAL(18,2) COMMENT 'Prior period consumption. Ref: Sensus AMI.',
    `prior_year_consumption_gallons` DECIMAL(18,2) COMMENT 'Prior year consumption. Ref: Sensus AMI.',
    `read_method` STRING COMMENT 'Read method. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Reverse flow detected flag. Ref: Sensus AMI.',
    `seasonal_factor` DECIMAL(18,2) COMMENT 'Seasonal factor. Ref: Sensus AMI.',
    `service_type` STRING COMMENT 'Service type. Ref: Sensus AMI.',
    `total_consumption_ccf` DECIMAL(18,2) COMMENT 'Total consumption in CCF. Ref: Sensus AMI.',
    `total_consumption_gallons` DECIMAL(18,2) COMMENT 'Total consumption in gallons. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `validation_timestamp` TIMESTAMP COMMENT 'Validation timestamp. Ref: Sensus AMI.',
    `weather_normalized_consumption_gallons` DECIMAL(18,2) COMMENT 'Weather normalized consumption. Ref: Sensus AMI.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Zero consumption flag. Ref: Sensus AMI.',
    CONSTRAINT pk_consumption_profile PRIMARY KEY(`consumption_profile_id`)
) COMMENT 'Aggregated consumption profile for a billing period. Summarizes total consumption, average daily usage, variance from prior periods, data quality score, and flags for high usage, leaks, or reverse flow. Feeds billing system and customer portal.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` (
    `leak_detection_event_id` BIGINT COMMENT 'Unique identifier for the leak detection event record. Primary key. Ref: Sensus AMI.',
    `adjustment_id` BIGINT COMMENT 'Reference to the billing adjustment record created for this leak event, if applicable. Links to billing adjustment transaction. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Leak events require customer notification and may trigger billing adjustments. Essential for customer service outreach, high-bill investigations, assistance program eligibility, and tracking notificat. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the leak was detected. Used for geographic analysis and NRW reduction program targeting. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Reference to the AMI device (Sensus FlexNet endpoint or similar) that generated the interval data used for leak detection. Links to AMI device registry. Ref: Sensus AMI.',
    `leak_ami_endpoint_id` BIGINT COMMENT 'Reference to the AMI device (Sensus FlexNet endpoint or similar) that generated the interval data used for leak detection. Links to AMI device registry. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that created this leak detection event record. Used for audit and accountability. Ref: Sensus AMI.',
    `leak_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user who last modified this leak detection event record. Used for audit and accountability. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation where the leak was detected. Links to the meter installation registry. Ref: Sensus AMI.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Leaks occur at premises and may indicate infrastructure issues. Required for correlating leak frequency with premise characteristics, prioritizing premise-level infrastructure upgrades, and tracking p. Ref: Sensus AMI.',
    `primary_leak_employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that created this leak detection event record. Used for audit and accountability. Ref: Sensus AMI.',
    `regulatory_correspondence_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_correspondence. Business justification: Significant leak events trigger regulatory notification requirements under water loss control programs and infrastructure compliance mandates. Real process: notifying primacy agencies of major leak ev. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the leak was detected. Links to customer service location registry. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to investigate or repair the detected leak. Links to asset management work order system. Ref: Sensus AMI.',
    `alert_severity` STRING COMMENT 'Severity classification of the leak event based on estimated volume, duration, and potential impact. Used to prioritize response and customer outreach. Ref: Sensus AMI.. Valid values are `critical|high|medium|low|informational`',
    `billing_adjustment_eligible_flag` BOOLEAN COMMENT 'Boolean indicator whether this leak event qualifies for a customer billing adjustment under utility leak adjustment policy. True indicates eligibility for adjustment consideration. Ref: Sensus AMI.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0-100) indicating the likelihood that the detected anomaly represents a true leak. Higher scores indicate greater confidence in detection accuracy. Ref: Sensus AMI.',
    `continuous_flow_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through continuous flow analysis (flow detected 24 hours without interruption). True indicates continuous flow was the detection trigger. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was first created in the system. Used for audit trail and data lineage tracking. Ref: Sensus AMI.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified about the detected leak event. Used for tracking notification timeliness and customer service metrics. Ref: Sensus AMI.',
    `customer_notified_flag` BOOLEAN COMMENT 'Boolean indicator whether the customer has been notified of the detected leak event. True indicates notification has been sent. Ref: Sensus AMI.',
    `detection_algorithm_version` STRING COMMENT 'Version identifier of the leak detection algorithm or software that identified this event. Used for algorithm performance tracking and continuous improvement. Ref: Sensus AMI.',
    `detection_method` STRING COMMENT 'Method or technique used to identify the leak event. Indicates whether detection was automated (AMI interval analysis, continuous flow flag, minimum night flow anomaly) or manual (acoustic sensor, field inspection, customer report). Ref: Sensus AMI.. Valid values are `continuous_flow_threshold|minimum_night_flow_anomaly|ami_algorithm|acoustic_sensor|manual_inspection|customer_report`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the leak was first detected by the AMI system or monitoring algorithm. Principal business event timestamp for this event. Ref: Sensus AMI.',
    `estimated_leak_volume_gallons_per_day` DECIMAL(18,2) COMMENT 'Estimated daily water loss volume attributed to the detected leak, measured in gallons per day. Calculated from interval consumption data or continuous flow analysis. Ref: Sensus AMI.',
    `estimated_total_loss_gallons` DECIMAL(18,2) COMMENT 'Total estimated water loss volume from leak start to resolution, measured in gallons. Calculated as leak volume per day multiplied by duration. Contributes to Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) metrics. Ref: Sensus AMI.',
    `flow_threshold_value` DECIMAL(18,2) COMMENT 'The flow rate threshold value (in gallons per minute or GPM) that was exceeded to trigger the leak detection alert. Used for continuous flow and threshold-based detection methods. Ref: Sensus AMI.',
    `investigation_notes` STRING COMMENT 'Free-text field for field technician or customer service representative notes regarding leak investigation, customer interaction, or resolution details. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was last updated. Used for audit trail and change tracking. Ref: Sensus AMI.',
    `leak_duration_hours` DECIMAL(18,2) COMMENT 'Estimated or measured duration of the leak event from detection timestamp to resolution or current time if unresolved, measured in hours. Ref: Sensus AMI.',
    `leak_location_description` STRING COMMENT 'Textual description of the suspected or confirmed leak location (e.g., service line, toilet, irrigation system, water heater). Provides context for leak source and repair scope. Ref: Sensus AMI.',
    `leak_status` STRING COMMENT 'Current lifecycle status of the leak detection event. Tracks progression from initial detection through investigation, customer notification, and resolution. Ref: Sensus AMI.. Valid values are `detected|confirmed|under_investigation|resolved|false_positive|customer_notified`',
    `leak_type` STRING COMMENT 'Classification of the leak by type or source. Helps categorize leak patterns and target customer education programs. [ENUM-REF-CANDIDATE: service_line|meter|toilet|faucet|irrigation|water_heater|pool|unknown — 8 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `minimum_night_flow_anomaly_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through minimum night flow analysis showing abnormal consumption during low-usage hours (typically 2 AM - 4 AM). True indicates MNF anomaly detection. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Notes. Ref: Sensus AMI.',
    `notification_method` STRING COMMENT 'Communication channel used to notify the customer about the leak event. Tracks preferred and actual notification delivery method. Ref: Sensus AMI.. Valid values are `email|sms|phone_call|postal_mail|customer_portal|mobile_app`',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `resolution_date` DATE COMMENT 'Date when the leak event was resolved or closed. Used to calculate response time and track Non-Revenue Water (NRW) reduction program effectiveness. Ref: Sensus AMI.',
    `resolution_outcome` STRING COMMENT 'Final outcome or resolution status of the leak detection event. Indicates whether the leak was confirmed and repaired, determined to be a false positive, or remains pending. Ref: Sensus AMI.. Valid values are `customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action`',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_leak_detection_event PRIMARY KEY(`leak_detection_event_id`)
) COMMENT 'Records all detected consumption anomaly events including suspected leaks, high usage alerts, continuous flow conditions, backflow indicators, and threshold exceedance alerts identified through AMI interval data analysis or monitoring rules. Captures event type (leak, high usage, continuous flow, backflow, threshold exceedance), detection timestamp, meter installation reference, detection method, threshold and actual values, percentage over threshold, estimated volume impact, alert severity, alert status (open, notified, resolved, dismissed), notification history, customer contact log, and resolution outcome. Supports NRW reduction programs, customer notification workflows, proactive service management, and customer service case creation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key. Ref: Sensus AMI.',
    `alert_rule_id` BIGINT COMMENT 'Reference to the business rule or threshold configuration that triggered this alert. Links to alert rule definition for audit and tuning purposes. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation. Ref: Sensus AMI.',
    `high_ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: High usage alert investigation assignment to customer service or field technicians is core operational workflow. Enables workload tracking, SLA compliance monitoring, and employee performance metrics. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location. Ref: Sensus AMI.',
    `order_id` BIGINT COMMENT 'Reference to the field service order created to investigate or resolve this alert. Links to work order management system. Null if no service order created. Ref: Sensus AMI.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: High usage alerts analyzed by premise type for pattern detection. Required for identifying systemic issues by building type, seasonal usage anomalies, and targeting conservation messaging to specific. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d. Ref: Sensus AMI.',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the accuracy created by employee referenced by each accuracy test record in the metering domain.',
    `accuracy_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the accuracy responsible employee referenced by each accuracy test record in the metering domain.',
    `accuracy_technician_employee_id` BIGINT COMMENT 'Technician who performed the test. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Customer account that requested the test. Ref: Sensus AMI.',
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier for the lab instrument referenced by each accuracy test record in the metering domain.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Accuracy tests can be performed in the field (in-situ testing) at a specific meter installation, or in a lab/bench setting. For field tests, this FK links the test to the installation location. This F. Ref: Sensus AMI.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Work order associated with this accuracy test. Ref: Sensus AMI.',
    `accuracy_pct` DECIMAL(18,2) COMMENT 'The accuracy pct value recorded for each accuracy test in the metering domain.',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'The accuracy percentage value recorded for each accuracy test in the metering domain.',
    `accuracy_test_number` STRING COMMENT 'The accuracy test number value recorded for each accuracy test in the metering domain.',
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
    `accuracy_test_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` (
    `replacement_program_id` BIGINT COMMENT 'Primary key for replacement_program. Ref: Sensus AMI.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Replacement programs target specific asset classes (e.g., residential meters aged 15+ years). Program eligibility, prioritization, and budget forecasting depend on asset class characteristics like use. Ref: Sensus AMI.',
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the cip project referenced by each replacement program record in the metering domain.',
    `finance_budget_id` BIGINT COMMENT 'FK to finance.finance_budget. Ref: Sensus AMI.',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter replacement programs are often targeted at specific meter sizes or types (e.g., replace all 5/8-inch meters over 15 years old or replace all non-AMI 3/4-inch meters). This FK links the progr. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the replacement created by employee referenced by each replacement program record in the metering domain.',
    `replacement_program_manager_employee_id` BIGINT COMMENT 'Unique identifier for the replacement program manager employee referenced by each replacement program record in the metering domain.',
    `replacement_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the replacement responsible employee referenced by each replacement program record in the metering domain.',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory referenced by each replacement program record in the metering domain.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost value recorded for each replacement program in the metering domain.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Actual cost incurred to date. Ref: Sensus AMI.',
    `actual_end_date` TIMESTAMP COMMENT 'Actual end date of the replacement program. Ref: Sensus AMI.',
    `actual_start_date` TIMESTAMP COMMENT 'Actual start date of the replacement program. Ref: Sensus AMI.',
    `age_threshold_years` STRING COMMENT 'Meter age in years that triggers inclusion in the program. Ref: Sensus AMI.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each replacement program in the metering domain.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total program budget. Ref: Sensus AMI.',
    `budget_amount_usd` DECIMAL(18,2) COMMENT 'The budget amount usd value recorded for each replacement program in the metering domain.',
    `budget_spent` DECIMAL(18,2) COMMENT 'Budget spent to date. Ref: Sensus AMI.',
    `budget_usd` DECIMAL(18,2) COMMENT 'The budget usd value recorded for each replacement program in the metering domain.',
    `replacement_program_category` STRING COMMENT 'The replacement program category value recorded for each replacement program in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each replacement program in the metering domain.',
    `replacement_program_code` STRING COMMENT 'The replacement program code value recorded for each replacement program in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each replacement program in the metering domain.',
    `completed_count` STRING COMMENT 'Number of meters replaced to date. Ref: Sensus AMI.',
    `completed_meter_count` STRING COMMENT 'The completed meter count value recorded for each replacement program in the metering domain.',
    `completed_replacement_count` STRING COMMENT 'Number of replacements completed to date. Ref: Sensus AMI.',
    `completion_pct` DECIMAL(18,2) COMMENT 'The completion pct value recorded for each replacement program in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each replacement program in the metering domain.',
    `cost_per_replacement` DECIMAL(18,2) COMMENT 'Average cost per meter replacement. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each replacement program in the metering domain.',
    `replacement_program_description` STRING COMMENT 'The replacement program description value recorded for each replacement program in the metering domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each replacement program record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` DATE COMMENT 'Planned program end date. Ref: Sensus AMI.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each replacement program record in the metering domain.',
    `is_active` BOOLEAN COMMENT 'Whether program is currently active. Ref: Sensus AMI.',
    `max_meter_age_years` STRING COMMENT 'Maximum meter age threshold triggering replacement. Ref: Sensus AMI.',
    `meters_replaced_count` STRING COMMENT 'Meters replaced to date. Ref: Sensus AMI.',
    `min_accuracy_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum accuracy threshold below which replacement is triggered. Ref: Sensus AMI.',
    `replacement_program_name` STRING COMMENT 'The replacement program name used to identify each replacement program record in the metering domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Sensus AMI.',
    `nrw_reduction_target_pct` DECIMAL(18,2) COMMENT 'Target non-revenue water reduction percentage from this program. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each replacement program in the metering domain.',
    `planned_end_date` TIMESTAMP COMMENT 'Planned end date for the replacement program. Ref: Sensus AMI.',
    `planned_start_date` TIMESTAMP COMMENT 'Planned start date for the replacement program. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each replacement program in the metering domain.',
    `program_budget` DECIMAL(18,2) COMMENT 'Total budget allocated for the replacement program. Ref: Sensus AMI.',
    `program_code` STRING COMMENT 'The program code value recorded for each replacement program in the metering domain.',
    `program_end_date` TIMESTAMP COMMENT 'Program end date. Ref: Sensus AMI.',
    `program_name` STRING COMMENT 'Name of the meter replacement program. Ref: Sensus AMI.',
    `program_start_date` TIMESTAMP COMMENT 'Program start date. Ref: Sensus AMI.',
    `program_status` STRING COMMENT 'Status (planning, active, completed, suspended). Ref: Sensus AMI.',
    `program_type` STRING COMMENT 'Type (age_based, technology_upgrade, AMI_deployment, targeted). Ref: Sensus AMI.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each replacement program in the metering domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each replacement program in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each replacement program in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each replacement program in the metering domain.',
    `replaced_meter_count` STRING COMMENT 'The replaced meter count value recorded for each replacement program in the metering domain.',
    `replacement_criteria` STRING COMMENT 'Criteria for selecting meters (age, accuracy, technology, size). Ref: Sensus AMI.',
    `replacement_program_number` STRING COMMENT 'The replacement program number value recorded for each replacement program in the metering domain.',
    `replacement_program_type` STRING COMMENT 'The replacement program type value recorded for each replacement program in the metering domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each replacement program record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each replacement program in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each replacement program in the metering domain.',
    `spent_amount` DECIMAL(18,2) COMMENT 'Amount spent to date. Ref: Sensus AMI.',
    `spent_to_date` TIMESTAMP COMMENT 'Amount spent to date. Ref: Sensus AMI.',
    `spent_to_date_amount` DECIMAL(18,2) COMMENT 'Amount spent to date. Ref: Sensus AMI.',
    `start_date` DATE COMMENT 'Program start date. Ref: Sensus AMI.',
    `replacement_program_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `target_accuracy_threshold_pct` DECIMAL(18,2) COMMENT 'Accuracy threshold triggering replacement. Ref: Sensus AMI.',
    `target_age_years` STRING COMMENT 'Target age threshold for replacement. Ref: Sensus AMI.',
    `target_count` BIGINT COMMENT 'The target count value recorded for each replacement program in the metering domain.',
    `target_meter_age_years` STRING COMMENT 'Age threshold for replacement eligibility. Ref: Sensus AMI.',
    `target_meter_count` STRING COMMENT 'Total meters targeted for replacement. Ref: Sensus AMI.',
    `target_replacement_count` STRING COMMENT 'Total number of meters targeted for replacement. Ref: Sensus AMI.',
    `target_technology` STRING COMMENT 'Target replacement technology (AMI, ultrasonic). Ref: Sensus AMI.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total program budget in local currency. Ref: Sensus AMI.',
    `total_meters_replaced` STRING COMMENT 'Total number of meters replaced to date. Ref: Sensus AMI.',
    `total_meters_targeted` STRING COMMENT 'Total number of meters targeted for replacement. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each replacement program in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_replacement_program PRIMARY KEY(`replacement_program_id`)
) COMMENT 'Defines and tracks meter replacement programs and campaigns, including age-based replacement cycles, accuracy-based replacement triggers, and AMI retrofit programs. Stores program name, program type (age-based, accuracy-based, AMI upgrade, LCRR lead service line), target meter population criteria (age threshold, meter size, meter type, geographic zone), program start and end dates, target count, completion count, budget allocation, and program status. Links to individual replacement work orders executed through IBM Maximo.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` (
    `replacement_order_id` BIGINT COMMENT 'Primary key for replacement_order. Ref: Sensus AMI.',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: replacement_order captures old_meter_accuracy_test_result as a scalar value but lacks FK to the actual accuracy_test record that triggered the replacement. Meter replacements are often driven by faile. Ref: Sensus AMI.',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Replacement orders trigger material requisitions to pull meter stock from warehouse for installation crews. Work order execution requires reservation/requisition of specific meter inventory, linking f. Ref: Sensus AMI.',
    `metering_meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each replacement order record in the metering domain.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Meter replacement programs generate bulk purchase orders for new meter inventory. Replacement program execution triggers procurement of meters in planned quantities, linking program planning to procur. Ref: Sensus AMI.',
    `crew_id` BIGINT COMMENT 'FK to workforce.crew. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee. Ref: Sensus AMI.',
    `replacement_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the replacement created by employee referenced by each replacement order record in the metering domain.',
    `replacement_crew_id` BIGINT COMMENT 'Unique identifier for the replacement crew referenced by each replacement order record in the metering domain.',
    `installation_id` BIGINT COMMENT 'FK to metering.installation (new installation). Ref: Sensus AMI.',
    `replacement_new_meter_id` BIGINT COMMENT 'Unique identifier for the replacement new meter referenced by each replacement order record in the metering domain.',
    `replacement_new_meter_installation_id` BIGINT COMMENT 'Unique identifier for the replacement new meter installation referenced by each replacement order record in the metering domain.',
    `replacement_new_metering_meter_id` BIGINT COMMENT 'Unique identifier for the replacement new metering meter referenced by each replacement order record in the metering domain.',
    `replacement_old_metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: A replacement order replaces an existing (old) meter with a new meter. This FK tracks which physical meter device was removed/replaced. This is the first of two FKs to metering_meter (old and new), re. Ref: Sensus AMI.',
    `replacement_program_id` BIGINT COMMENT 'Foreign key linking to metering.replacement_program. Business justification: Replacement orders are often executed as part of a structured replacement program or campaign (age-based, accuracy-based, technology upgrade). This FK links individual replacement work orders to their. Ref: Sensus AMI.',
    `replacement_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the replacement responsible employee referenced by each replacement order record in the metering domain.',
    `replacement_technician_employee_id` BIGINT COMMENT 'Assigned technician. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Each meter replacement is executed via work order that schedules crews, tracks labor/materials, manages old meter disposal, and closes out capital projects. Standard utility field service workflow lin. Ref: Sensus AMI.',
    `access_issue_flag` BOOLEAN COMMENT 'Whether access issues were encountered. Ref: Sensus AMI.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each replacement order in the metering domain.',
    `replacement_order_category` STRING COMMENT 'The replacement order category value recorded for each replacement order in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each replacement order in the metering domain.',
    `replacement_order_code` STRING COMMENT 'The replacement order code value recorded for each replacement order in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each replacement order in the metering domain.',
    `completed_date` DATE COMMENT 'Actual completion date. Ref: Sensus AMI.',
    `completed_flag` BOOLEAN COMMENT 'The completed flag value recorded for each replacement order in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each replacement order in the metering domain.',
    `cost_usd` DECIMAL(18,2) COMMENT 'The cost usd value recorded for each replacement order in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `customer_notified` STRING COMMENT 'Whether customer was notified. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each replacement order in the metering domain.',
    `replacement_order_description` STRING COMMENT 'The replacement order description value recorded for each replacement order in the metering domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each replacement order record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each replacement order record in the metering domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each replacement order record in the metering domain.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Sensus AMI.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Labor cost for the replacement. Ref: Sensus AMI.',
    `labor_hours` STRING COMMENT 'Labor hours for replacement. Ref: Sensus AMI.',
    `material_cost` DECIMAL(18,2) COMMENT 'Material cost for replacement. Ref: Sensus AMI.',
    `replacement_order_name` STRING COMMENT 'The replacement order name used to identify each replacement order record in the metering domain.',
    `new_meter_initial_read` DECIMAL(18,2) COMMENT 'The new meter initial read value recorded for each replacement order in the metering domain.',
    `new_meter_read_at_install` DECIMAL(18,2) COMMENT 'New meter read value at time of installation. Ref: Sensus AMI.',
    `new_meter_reading` STRING COMMENT 'Initial reading on new meter. Ref: Sensus AMI.',
    `new_register_reading` DECIMAL(18,2) COMMENT 'Initial register reading on the new meter at installation. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Field notes. Ref: Sensus AMI.',
    `old_meter_final_read` DECIMAL(18,2) COMMENT 'The old meter final read value recorded for each replacement order in the metering domain.',
    `old_meter_read_at_removal` DECIMAL(18,2) COMMENT 'Old meter read value at time of removal. Ref: Sensus AMI.',
    `old_meter_reading` STRING COMMENT 'Final reading on old meter. Ref: Sensus AMI.',
    `old_register_reading` DECIMAL(18,2) COMMENT 'Final register reading on the old meter at removal. Ref: Sensus AMI.',
    `order_date` DATE COMMENT 'Date order was created. Ref: Sensus AMI.',
    `order_number` STRING COMMENT 'Unique replacement order number. Ref: Sensus AMI.',
    `order_status` STRING COMMENT 'Status (scheduled, assigned, in_progress, completed, cancelled). Ref: Sensus AMI.',
    `order_type` STRING COMMENT 'Planned, emergency, complaint-driven, accuracy-triggered. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each replacement order in the metering domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each replacement order in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each replacement order in the metering domain.',
    `reason_code` STRING COMMENT 'The reason code value recorded for each replacement order in the metering domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each replacement order in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each replacement order in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each replacement order in the metering domain.',
    `removal_reason` STRING COMMENT 'The removal reason value recorded for each replacement order in the metering domain.',
    `replacement_order_number` STRING COMMENT 'The replacement order number value recorded for each replacement order in the metering domain.',
    `replacement_order_type` STRING COMMENT 'The replacement order type value recorded for each replacement order in the metering domain.',
    `replacement_reason` STRING COMMENT 'Reason for replacement (age, failure, upgrade, accuracy). Ref: Sensus AMI.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each replacement order record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each replacement order in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each replacement order in the metering domain.',
    `scheduled_date` DATE COMMENT 'Scheduled replacement date. Ref: Sensus AMI.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each replacement order record in the metering domain.',
    `replacement_order_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the replacement order. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each replacement order in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each replacement order record in the metering domain.',
    CONSTRAINT pk_replacement_order PRIMARY KEY(`replacement_order_id`)
) COMMENT 'Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` (
    `metering_dma_zone_id` BIGINT COMMENT 'Unique identifier for the District Metered Area zone. Primary key for the DMA zone master record. Ref: Sensus AMI.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: DMA establishment and reconfiguration are capital projects involving valve installations, boundary meter installations, and hydraulic modeling. Required for NRW program capital investment tracking, re. Ref: Sensus AMI.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DMAs are operational cost centers for budget allocation, O&M expense tracking, and capital investment planning. Utilities manage DMA-level budgets, analyze cost per connection, and allocate labor/mate. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Foreign key reference to a secondary or backup zone meter installation for redundancy. Used when primary zone meter is offline or for validation of primary meter readings. Ref: Sensus AMI.',
    `metering_prv_installation_id` BIGINT COMMENT 'Foreign key reference to the primary Pressure Reducing Valve installation serving this DMA zone. PRVs control inlet pressure to reduce leakage and pipe stress. Ref: Sensus AMI.',
    `metering_zone_meter_installation_id` BIGINT COMMENT 'Foreign key reference to the primary zone meter installation that measures total inflow to the DMA. This meter is the authoritative source for DMA-level consumption and water balance calculations. Ref: Sensus AMI.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key reference to the pressure zone within which this DMA operates. Pressure zones define hydraulic boundaries based on elevation and pump station service areas. Ref: Sensus AMI.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: DMAs are established to meet regulatory requirements for pressure management, leak detection frequency, and water loss control programs. Real process: designing and operating DMAs per state water loss. Ref: Sensus AMI.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: DMAs are geographic subdivisions within service territories for NRW management and hydraulic modeling. Operations teams need territory link for franchise jurisdiction, regulatory reporting boundaries,. Ref: Sensus AMI.',
    `actual_nrw_percentage` DECIMAL(18,2) COMMENT 'Most recent calculated Non-Revenue Water percentage for this DMA zone based on water balance analysis. Updated monthly or quarterly from metering and billing data. Ref: Sensus AMI.',
    `average_age_of_mains_years` STRING COMMENT 'Average age in years of distribution mains within the DMA zone. Correlates with leak frequency and helps prioritize pipe replacement programs. Ref: Sensus AMI.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure within the DMA zone measured in pounds per square inch. Critical for pressure management and leak reduction programs. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DMA zone record was first created in the system. Used for audit trail and data lineage tracking. Ref: Sensus AMI.',
    `decommissioned_date` DATE COMMENT 'Date when the DMA zone was decommissioned or merged into another zone. Null for active zones. Used for historical record keeping and network reconfiguration tracking. Ref: Sensus AMI.',
    `metering_dma_zone_description` STRING COMMENT 'Detailed description of the DMA zone including boundaries, key landmarks, and operational notes. Used for field crew reference and planning. Ref: Sensus AMI.',
    `dma_code` STRING COMMENT 'Business identifier code for the DMA zone used in operational systems, SCADA displays, and reporting. Typically alphanumeric and unique across the distribution network. Ref: Sensus AMI.. Valid values are `^[A-Z0-9]{3,12}$`',
    `dma_name` STRING COMMENT 'Human-readable name of the DMA zone, often reflecting geographic location or neighborhood served (e.g., Downtown West DMA, Industrial Park Zone 3). Ref: Sensus AMI.',
    `dma_type` STRING COMMENT 'Classification of the DMA zone based on predominant customer type and land use. Drives consumption pattern analysis and NRW benchmarking. Ref: Sensus AMI.. Valid values are `residential|commercial|industrial|mixed_use|rural|institutional`',
    `established_date` DATE COMMENT 'Date when the DMA zone was officially established and zone metering began. Used for calculating age of DMA program and historical trend analysis. Ref: Sensus AMI.',
    `gis_boundary_reference` BOOLEAN COMMENT 'Reference identifier to the GIS polygon feature representing the geographic boundary of the DMA zone in the Esri ArcGIS system. Used for spatial analysis and mapping. Ref: Sensus AMI.',
    `hydraulic_model_reference` STRING COMMENT 'Reference identifier to the DMA zone representation in the Innovyze InfoWater hydraulic model. Used for pressure analysis, fire flow testing, and capital planning. Ref: Sensus AMI.',
    `infrastructure_leakage_index` DECIMAL(18,2) COMMENT 'Ratio of current annual real losses to unavoidable annual real losses. ILI values below 2.0 indicate good performance; above 4.0 indicates poor performance requiring intervention. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `isolation_valve_count` STRING COMMENT 'Number of isolation valves that define the hydraulic boundary of the DMA zone. Used for operational planning and boundary integrity verification.',
    `last_leak_detection_date` DATE COMMENT 'Date of the most recent active leak detection survey conducted in this DMA zone. Used to schedule next survey and track compliance with leak detection programs. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DMA zone record was last updated. Used for change tracking and data quality monitoring. Ref: Sensus AMI.',
    `leak_detection_frequency_days` STRING COMMENT 'Target frequency in days for conducting active leak detection surveys within this DMA zone. High-loss zones are surveyed more frequently. Ref: Sensus AMI.',
    `metering_dma_zone_status` STRING COMMENT 'Current operational status of the DMA zone. Active zones are monitored for NRW; inactive or planned zones are not yet operational. Ref: Sensus AMI.. Valid values are `active|inactive|planned|decommissioned|under_construction|maintenance`',
    `minimum_night_flow_gpm` DECIMAL(18,2) COMMENT 'Minimum flow rate measured during night hours (typically 2-4 AM) when legitimate consumption is lowest. Key indicator for leak detection and NRW analysis measured in gallons per minute. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, historical context, or other relevant information about the DMA zone not captured in structured fields. Ref: Sensus AMI.',
    `predominant_pipe_material` STRING COMMENT 'Most common pipe material type within the DMA zone. Influences leak rates, corrosion risk, and maintenance strategies. [ENUM-REF-CANDIDATE: cast_iron|ductile_iron|pvc|hdpe|steel|concrete|asbestos_cement|copper — 8 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `responsible_operations_team` STRING COMMENT 'Name or identifier of the operations team or district responsible for maintenance and leak response within this DMA zone. Used for work order routing and accountability. Ref: Sensus AMI.',
    `scada_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether the DMA zone meter is connected to the SCADA system for real-time flow and pressure monitoring. True enables automated alerts for abnormal conditions. Ref: Sensus AMI.',
    `scada_tag_reference` STRING COMMENT 'SCADA system tag identifier for the primary zone meter flow point in OSIsoft PI Historian. Used to retrieve real-time and historical flow data for water balance analysis.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections (meters) within the DMA zone. Used as denominator in per-connection NRW calculations and for sizing analysis. Ref: Sensus AMI.',
    `target_nrw_percentage` DECIMAL(18,2) COMMENT 'Target or goal for Non-Revenue Water as a percentage of total inflow for this DMA zone. Used for performance monitoring and loss reduction program planning. Ref: Sensus AMI.',
    `total_pipe_length_miles` DECIMAL(18,2) COMMENT 'Total length of distribution mains within the DMA zone measured in miles. Used for calculating NRW per mile of main and infrastructure density metrics. Ref: Sensus AMI.',
    `ufw_gallons_per_connection_per_day` DECIMAL(18,2) COMMENT 'Unaccounted-for Water volume normalized per service connection per day. Key performance indicator for leak detection prioritization and DMA performance benchmarking. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_metering_dma_zone PRIMARY KEY(`metering_dma_zone_id`)
) COMMENT 'Master record for each District Metered Area (DMA) — a hydraulically isolated zone of the distribution network bounded by closed valves and monitored by zone meters for water balance analysis. Stores DMA code, name, geographic boundary reference, zone meter installation IDs, service connection count, pipe length, pressure zone reference, and operational status. The authoritative reference for DMA topology used in NRW/UFW water balance calculations, pressure management, and leakage targeting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` (
    `metering_nrw_water_balance_id` BIGINT COMMENT 'Unique identifier for the metering_nrw_water_balance data product (auto-inserted pre-linking). Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee (auditor). Ref: Sensus AMI.',
    `metering_approved_by_employee_id` BIGINT COMMENT 'Employee who approved the balance. Ref: Sensus AMI.',
    `metering_calculated_by_employee_id` BIGINT COMMENT 'Unique identifier for the metering calculated by employee referenced by each metering nrw water balance record in the metering domain.',
    `metering_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the metering created by employee referenced by each metering nrw water balance record in the metering domain.',
    `metering_dma_zone_id` BIGINT COMMENT 'Foreign key linking to metering.metering_dma_zone. Business justification: Non-Revenue Water (NRW) water balance calculations are performed for specific District Metered Areas (DMAs) to quantify water losses within a hydraulically isolated zone. Each water balance record mus',
    `metering_prepared_by_employee_id` BIGINT COMMENT 'Employee who prepared the balance. Ref: Sensus AMI.',
    `metering_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the metering responsible employee referenced by each metering nrw water balance record in the metering domain.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Non-revenue water losses must be recorded in specific GL accounts for regulatory compliance, rate case justification, and financial transparency. NRW water balance calculations drive loss accounting e. Ref: Sensus AMI.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: NRW programs must comply with specific regulatory requirements for water loss control targets, infrastructure leakage index thresholds, and audit methodology standards. Real process: tracking complian. Ref: Sensus AMI.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Non-revenue water audits are mandatory regulatory submissions under AWWA M36 standards and state water loss control programs. Real process: annual water audit submission to state agencies per regulato',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: NRW water balance calculations (AWWA M36 methodology) are performed at service territory level for regulatory reporting to state primacy agencies and rate case cost-of-service studies. Territory link ',
    `distribution_nrw_water_balance_id` BIGINT COMMENT 'Reference to primary distribution.distribution_nrw_water_balance for SSOT alignment. Ref: Sensus AMI.',
    `metering_canonical_distribution_nrw_water_balance_id` BIGINT COMMENT 'Reference FK to canonical SSOT distribution.distribution_nrw_water_balance. Ref: Sensus AMI.',
    `metering_distribution_nrw_water_balance_id` BIGINT COMMENT 'Foreign key to the canonical single-source-of-truth entity distribution.distribution_nrw_water_balance to resolve cross-domain duplication. Ref: Sensus AMI.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each metering nrw water balance in the metering domain.',
    `apparent_loss_mg` DECIMAL(18,2) COMMENT 'The apparent loss mg value recorded for each metering nrw water balance in the metering domain.',
    `apparent_losses_mg` STRING COMMENT 'Apparent losses (meter inaccuracy, unauthorized use, data errors). Ref: Sensus AMI.',
    `apparent_losses_ml` DECIMAL(18,2) COMMENT 'Apparent losses (meter error + unauthorized use) in ML. Ref: Sensus AMI.',
    `audit_confidence_grade` STRING COMMENT 'IWA water audit confidence grade: A-E. Ref: Sensus AMI.',
    `authorized_consumption_mg` DECIMAL(18,2) COMMENT 'The authorized consumption mg value recorded for each metering nrw water balance in the metering domain.',
    `authorized_consumption_ml` DECIMAL(18,2) COMMENT 'Total authorized consumption in megalitres. Ref: Sensus AMI.',
    `average_pressure_m` DECIMAL(18,2) COMMENT 'Average system pressure in metres. Ref: Sensus AMI.',
    `awwa_m36_compliant` BOOLEAN COMMENT 'Whether balance follows AWWA M36 methodology',
    `balance_period_end` STRING COMMENT 'End of water balance period. Ref: Sensus AMI.',
    `balance_period_start` STRING COMMENT 'Start of water balance period. Ref: Sensus AMI.',
    `balance_type` DECIMAL(18,2) COMMENT 'Monthly, Quarterly, Annual. Ref: Sensus AMI.',
    `billed_authorized_consumption_mg` DECIMAL(18,2) COMMENT 'The billed authorized consumption mg value recorded for each metering nrw water balance in the metering domain.',
    `billed_authorized_consumption_ml` DECIMAL(18,2) COMMENT 'Billed authorized consumption in megalitres. Ref: Sensus AMI.',
    `billed_consumption_mg` DECIMAL(18,2) COMMENT 'The billed consumption mg value recorded for each metering nrw water balance in the metering domain.',
    `billed_metered_consumption_mg` STRING COMMENT 'Billed metered consumption. Ref: Sensus AMI.',
    `billed_unmetered_consumption_mg` STRING COMMENT 'Billed unmetered consumption. Ref: Sensus AMI.',
    `billed_volume_mg` DECIMAL(18,2) COMMENT 'Billed volume. Ref: Sensus AMI.',
    `calculation_date` TIMESTAMP COMMENT 'The calculation date associated with each metering nrw water balance record in the metering domain.',
    `calculation_method` STRING COMMENT 'IWA/AWWA water balance calculation method used',
    `carl_l_per_conn_per_day` DECIMAL(18,2) COMMENT 'Current Annual Real Losses in L/connection/day. Ref: Sensus AMI.',
    `metering_nrw_water_balance_category` STRING COMMENT 'The metering nrw water balance category value recorded for each metering nrw water balance in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each metering nrw water balance in the metering domain.',
    `metering_nrw_water_balance_code` STRING COMMENT 'The metering nrw water balance code value recorded for each metering nrw water balance in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each metering nrw water balance in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each metering nrw water balance in the metering domain.',
    `confidence_grade` STRING COMMENT 'Data confidence grade per AWWA methodology',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_handling_errors_ml` DECIMAL(18,2) COMMENT 'Estimated data handling errors. Ref: Sensus AMI.',
    `data_quality_flag` BOOLEAN COMMENT 'Flag indicating data quality issues in the water balance. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each metering nrw water balance in the metering domain.',
    `metering_nrw_water_balance_description` STRING COMMENT 'The metering nrw water balance description value recorded for each metering nrw water balance in the metering domain.',
    `economic_level_of_leakage_ml` DECIMAL(18,2) COMMENT 'Economic level of leakage in ML. Ref: Sensus AMI.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each metering nrw water balance record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each metering nrw water balance record in the metering domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each metering nrw water balance record in the metering domain.',
    `ili_index` DECIMAL(18,2) COMMENT 'Infrastructure Leakage Index (ILI). Ref: Sensus AMI.',
    `infrastructure_leakage_index` STRING COMMENT 'ILI ratio per AWWA M36',
    `input_volume_mg` DECIMAL(18,2) COMMENT 'System input volume. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Sensus AMI.',
    `iwwa_standard_reference` STRING COMMENT 'Reference to IWA/AWWA water audit methodology version',
    `leakage_at_storage_ml` DECIMAL(18,2) COMMENT 'Leakage at storage facilities in ML. Ref: Sensus AMI.',
    `leakage_on_mains_ml` DECIMAL(18,2) COMMENT 'Leakage on transmission/distribution mains in ML. Ref: Sensus AMI.',
    `leakage_on_service_connections_ml` DECIMAL(18,2) COMMENT 'Leakage on service connections in ML. Ref: Sensus AMI.',
    `meter_error_volume_ml` DECIMAL(18,2) COMMENT 'Volume attributed to meter under-registration. Ref: Sensus AMI.',
    `meter_under_registration_ml` DECIMAL(18,2) COMMENT 'Volume lost due to meter under-registration in megalitres. Ref: Sensus AMI.',
    `meter_under_registration_pct` DECIMAL(18,2) COMMENT 'Estimated meter under-registration percentage. Ref: Sensus AMI.',
    `metering_nrw_water_balance_number` STRING COMMENT 'The metering nrw water balance number value recorded for each metering nrw water balance in the metering domain.',
    `metering_nrw_water_balance_type` STRING COMMENT 'The metering nrw water balance type value recorded for each metering nrw water balance in the metering domain.',
    `metering_nrw_water_balance_name` STRING COMMENT 'The metering nrw water balance name used to identify each metering nrw water balance record in the metering domain.',
    `non_revenue_water_pct` DECIMAL(18,2) COMMENT 'Non-revenue water as percentage of system input. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Sensus AMI.',
    `nrw_cost_usd` DECIMAL(18,2) COMMENT 'The nrw cost usd value recorded for each metering nrw water balance in the metering domain.',
    `nrw_pct` DECIMAL(18,2) COMMENT 'The nrw pct value recorded for each metering nrw water balance in the metering domain.',
    `nrw_percent` DECIMAL(18,2) COMMENT 'Non-revenue water percent. Ref: Sensus AMI.',
    `nrw_percentage` DECIMAL(18,2) COMMENT 'The nrw percentage value recorded for each metering nrw water balance in the metering domain.',
    `nrw_volume_mg` DECIMAL(18,2) COMMENT 'The nrw volume mg value recorded for each metering nrw water balance in the metering domain.',
    `nrw_volume_ml` DECIMAL(18,2) COMMENT 'Non-revenue water volume in megalitres. Ref: Sensus AMI.',
    `number_of_service_connections` STRING COMMENT 'Number of service connections in zone. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each metering nrw water balance in the metering domain.',
    `period_end` TIMESTAMP COMMENT 'The period end value recorded for each metering nrw water balance in the metering domain.',
    `period_end_date` TIMESTAMP COMMENT 'The period end date associated with each metering nrw water balance record in the metering domain.',
    `period_start` TIMESTAMP COMMENT 'The period start value recorded for each metering nrw water balance in the metering domain.',
    `period_start_date` TIMESTAMP COMMENT 'The period start date associated with each metering nrw water balance record in the metering domain.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each metering nrw water balance in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each metering nrw water balance in the metering domain.',
    `real_loss_mg` DECIMAL(18,2) COMMENT 'The real loss mg value recorded for each metering nrw water balance in the metering domain.',
    `real_losses_mg` STRING COMMENT 'Real losses (leakage). Ref: Sensus AMI.',
    `real_losses_ml` DECIMAL(18,2) COMMENT 'Real losses (physical leakage) in megalitres. Ref: Sensus AMI.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each metering nrw water balance in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each metering nrw water balance in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each metering nrw water balance in the metering domain.',
    `reporting_frequency` STRING COMMENT 'Reporting frequency: Monthly, Quarterly, Annual. Ref: Sensus AMI.',
    `reporting_period_type` STRING COMMENT 'Monthly, quarterly, annual. Ref: Sensus AMI.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each metering nrw water balance record in the metering domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each metering nrw water balance in the metering domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each metering nrw water balance in the metering domain.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each metering nrw water balance in the metering domain.',
    `ssot_role` STRING COMMENT 'Ssot role. Ref: Sensus AMI.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each metering nrw water balance record in the metering domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each metering nrw water balance record in the metering domain.',
    `metering_nrw_water_balance_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `system_input_volume_mg` STRING COMMENT 'Total system input volume in million gallons. Ref: Sensus AMI.',
    `system_input_volume_ml` DECIMAL(18,2) COMMENT 'Total system input volume in megalitres. Ref: Sensus AMI.',
    `uarl_l_per_conn_per_day` DECIMAL(18,2) COMMENT 'Unavoidable Annual Real Losses in L/connection/day. Ref: Sensus AMI.',
    `unauthorized_consumption_ml` DECIMAL(18,2) COMMENT 'Volume attributed to unauthorized consumption. Ref: Sensus AMI.',
    `unavoidable_annual_real_losses_ml` DECIMAL(18,2) COMMENT 'Unavoidable Annual Real Losses (UARL) in megalitres. Ref: Sensus AMI.',
    `unbilled_authorized_consumption_mg` DECIMAL(18,2) COMMENT 'The unbilled authorized consumption mg value recorded for each metering nrw water balance in the metering domain.',
    `unbilled_authorized_consumption_ml` DECIMAL(18,2) COMMENT 'Unbilled authorized consumption in megalitres. Ref: Sensus AMI.',
    `unbilled_metered_consumption_mg` STRING COMMENT 'Unbilled metered consumption. Ref: Sensus AMI.',
    `unbilled_unmetered_consumption_mg` STRING COMMENT 'Unbilled unmetered consumption. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each metering nrw water balance in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each metering nrw water balance record in the metering domain.',
    `water_losses_mg` DECIMAL(18,2) COMMENT 'The water losses mg value recorded for each metering nrw water balance in the metering domain.',
    `water_losses_ml` DECIMAL(18,2) COMMENT 'Total water losses (apparent + real) in megalitres. Ref: Sensus AMI.',
    CONSTRAINT pk_metering_nrw_water_balance PRIMARY KEY(`metering_nrw_water_balance_id`)
) COMMENT 'Periodic (monthly/annual) water balance record for a DMA zone or system-wide, quantifying Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) per the IWA/AWWA water audit methodology (M36 manual). Stores period start and end dates, system input volume (MGD), authorized consumption (billed metered, billed unmetered, unbilled metered, unbilled unmetered), water losses (apparent losses from meter inaccuracy and unauthorized consumption; real losses from leakage), NRW volume, NRW percentage, Infrastructure Leakage Index (ILI), and audit confidence grade. Feeds regulatory reporting, capital planning, and performance benchmarking. [SSOT delegates to distribution.distribution_nrw_water_balance] [SSOT: reference view of canonical distribution.distribution_nrw_water_balance] Consolidated: distribution.distribution_nrw_water_balance is SSOT; metering version is redundant.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` (
    `tamper_event_id` BIGINT COMMENT 'Primary key for tamper_event. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Tamper events are often detected by AMI endpoints through tamper detection sensors and transmitted as alerts. This FK links the tamper event to the AMI endpoint that detected and reported the tamperin. Ref: Sensus AMI.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Tamper events trigger billing adjustments for estimated unbilled consumption during tamper period per revenue protection policies and regulatory requirements. Direct link supports tamper-to-cash workf. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Customer account associated with the tamper event. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Tamper events (meter tampering, unauthorized bypass, interference) occur at a specific meter installation location. This FK links the tamper event to the physical installation where tampering was dete. Ref: Sensus AMI.',
    `metering_meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each tamper event record in the metering domain.',
    `read_id` BIGINT COMMENT 'Unique identifier for the read referenced by each tamper event record in the metering domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the tamper created by employee referenced by each tamper event record in the metering domain.',
    `tamper_investigated_by_employee_id` BIGINT COMMENT 'FK to workforce.employee. Ref: Sensus AMI.',
    `tamper_investigator_employee_id` BIGINT COMMENT 'Unique identifier for the tamper investigator employee referenced by each tamper event record in the metering domain.',
    `tamper_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the tamper responsible employee referenced by each tamper event record in the metering domain.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Tamper events trigger field investigations and potential enforcement actions dispatched via work orders. Utilities track investigation findings, customer contact, and resolution through work order sys. Ref: Sensus AMI.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each tamper event in the metering domain.',
    `back_bill_amount` DECIMAL(18,2) COMMENT 'Back-billing amount assessed. Ref: Sensus AMI.',
    `back_bill_period_months` STRING COMMENT 'Number of months back-billed. Ref: Sensus AMI.',
    `case_number` STRING COMMENT 'Law enforcement case number. Ref: Sensus AMI.',
    `tamper_event_category` STRING COMMENT 'The tamper event category value recorded for each tamper event in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each tamper event in the metering domain.',
    `tamper_event_code` STRING COMMENT 'The tamper event code value recorded for each tamper event in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each tamper event in the metering domain.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each tamper event in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each tamper event in the metering domain.',
    `tamper_event_description` STRING COMMENT 'The tamper event description value recorded for each tamper event in the metering domain.',
    `detected_date` TIMESTAMP COMMENT 'Date the tamper event was detected. Ref: Sensus AMI.',
    `detected_timestamp` TIMESTAMP COMMENT 'The detected timestamp associated with each tamper event record in the metering domain.',
    `detection_date` TIMESTAMP COMMENT 'Date tamper was detected. Ref: Sensus AMI.',
    `detection_method` STRING COMMENT 'How tamper was detected (AMI_alert, field_inspection, billing_analysis). Ref: Sensus AMI.',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp tamper was detected. Ref: Sensus AMI.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each tamper event record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each tamper event record in the metering domain.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'The estimated loss amount value recorded for each tamper event in the metering domain.',
    `estimated_loss_gallons` STRING COMMENT 'Estimated water loss in gallons. Ref: Sensus AMI.',
    `estimated_loss_usd` DECIMAL(18,2) COMMENT 'The estimated loss usd value recorded for each tamper event in the metering domain.',
    `estimated_loss_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost due to tampering in gallons. Ref: Sensus AMI.',
    `estimated_revenue_loss` STRING COMMENT 'Estimated revenue loss. Ref: Sensus AMI.',
    `estimated_unbilled_consumption` DECIMAL(18,2) COMMENT 'Estimated unbilled consumption due to tamper. Ref: Sensus AMI.',
    `estimated_unbilled_volume_gal` DECIMAL(18,2) COMMENT 'Estimated unbilled volume due to tampering in gallons. Ref: Sensus AMI.',
    `estimated_volume_loss_gal` DECIMAL(18,2) COMMENT 'Estimated volume of unmetered water in gallons due to the tamper. Ref: Sensus AMI.',
    `event_date` TIMESTAMP COMMENT 'The event date associated with each tamper event record in the metering domain.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Estimated end of tamper event. Ref: Sensus AMI.',
    `event_number` STRING COMMENT 'The event number value recorded for each tamper event in the metering domain.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Estimated start of tamper event. Ref: Sensus AMI.',
    `event_status` STRING COMMENT 'Status (detected, investigating, confirmed, resolved, false_alarm). Ref: Sensus AMI.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp tamper was detected. Ref: Sensus AMI.',
    `event_type` STRING COMMENT 'Magnetic, tilt, removal, reverse flow. Ref: Sensus AMI.',
    `evidence_collected` BOOLEAN COMMENT 'Whether physical evidence was collected. Ref: Sensus AMI.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each tamper event record in the metering domain.',
    `field_visit_date` TIMESTAMP COMMENT 'Date of field visit. Ref: Sensus AMI.',
    `investigation_date` DATE COMMENT 'Date field investigation was conducted. Ref: Sensus AMI.',
    `investigation_end_date` TIMESTAMP COMMENT 'Date the investigation was concluded. Ref: Sensus AMI.',
    `investigation_flag` BOOLEAN COMMENT 'The investigation flag value recorded for each tamper event in the metering domain.',
    `investigation_notes` STRING COMMENT 'The investigation notes value recorded for each tamper event in the metering domain.',
    `investigation_start_date` TIMESTAMP COMMENT 'Date the investigation into the tamper event began. Ref: Sensus AMI.',
    `investigation_status` STRING COMMENT 'The investigation status value recorded for each tamper event in the metering domain.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Sensus AMI.',
    `is_confirmed` BOOLEAN COMMENT 'Boolean flag indicating whether the is confirmed condition applies to the tamper event record.',
    `is_confirmed_theft` BOOLEAN COMMENT 'Indicates whether the tamper was confirmed as water theft. Ref: Sensus AMI.',
    `is_criminal_referral` BOOLEAN COMMENT 'Flag indicating the case was referred for criminal prosecution. Ref: Sensus AMI.',
    `law_enforcement_case_number` STRING COMMENT 'Law enforcement case number if applicable. Ref: Sensus AMI.',
    `law_enforcement_notified` STRING COMMENT 'Whether law enforcement was notified. Ref: Sensus AMI.',
    `tamper_event_name` STRING COMMENT 'The tamper event name used to identify each tamper event record in the metering domain.',
    `notes` STRING COMMENT 'Investigation notes. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each tamper event in the metering domain.',
    `photos_taken` STRING COMMENT 'Whether photographic evidence was captured. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each tamper event in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each tamper event in the metering domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each tamper event in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each tamper event in the metering domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each tamper event in the metering domain.',
    `resolution_action` STRING COMMENT 'The resolution action value recorded for each tamper event in the metering domain.',
    `resolution_date` DATE COMMENT 'Date event was resolved. Ref: Sensus AMI.',
    `resolution_description` STRING COMMENT 'Description of resolution actions taken. Ref: Sensus AMI.',
    `resolution_notes` STRING COMMENT 'Resolution description. Ref: Sensus AMI.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each tamper event in the metering domain.',
    `resolved_date` TIMESTAMP COMMENT 'Date the tamper event was resolved. Ref: Sensus AMI.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each tamper event in the metering domain.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Timestamp when the tamper event was resolved. Ref: Sensus AMI.',
    `seal_number` STRING COMMENT 'The seal number value recorded for each tamper event in the metering domain.',
    `severity` STRING COMMENT 'Severity level (low, medium, high, critical). Ref: Sensus AMI.',
    `severity_level` STRING COMMENT 'The severity level value recorded for each tamper event in the metering domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each tamper event record in the metering domain.',
    `tamper_event_number` STRING COMMENT 'Unique reference number for the tamper event. Ref: Sensus AMI.',
    `tamper_event_status` STRING COMMENT 'Status: Open, Under Investigation, Resolved, Referred to Legal. Ref: Sensus AMI.',
    `tamper_event_type` STRING COMMENT 'Type: Meter Bypass, Seal Broken, Reverse Flow, Magnetic Interference, Physical Damage. Ref: Sensus AMI.',
    `tamper_status` STRING COMMENT 'Detected, Investigated, Confirmed, Unconfirmed, Resolved. Ref: Sensus AMI.',
    `tamper_type` STRING COMMENT 'Type of tamper (magnetic, tilt, reverse_flow, cut_wire, bypass). Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each tamper event in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each tamper event record in the metering domain.',
    CONSTRAINT pk_tamper_event PRIMARY KEY(`tamper_event_id`)
) COMMENT 'Records detected meter tampering, unauthorized bypass, or meter interference events identified through AMI tamper flags, field inspection, or billing anomaly investigation. Captures detection date, meter installation reference, tamper type (magnetic tamper, reverse flow, physical bypass, broken seal, unauthorized removal), detection source (AMI flag, field inspection, billing review), estimated unbilled consumption volume, investigation status, enforcement action taken, and revenue recovery amount. Supports revenue protection and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` (
    `read_exception_id` BIGINT COMMENT 'Unique identifier for the meter read exception record. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: For AMI read exceptions (communication failures, signal strength issues, battery failures), this FK links the exception to the specific AMI endpoint experiencing the issue. Should be nullable for manu. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Read exception investigation requires field technician assignment for resolution. Core operational workflow for meter reading quality control. Column assigned_to currently stores employee identifier. Ref: Sensus AMI.',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which the exception occurred. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Read exceptions affect billing accuracy and require customer notification. Essential for billing hold management, estimated bill communication, customer dispute resolution, and tracking exception impa. Ref: Sensus AMI.',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Read exceptions (communication failures, no-reads) may result from main breaks causing power outages or infrastructure damage. Root cause analysis for meter communication issues requires checking if d. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation where the exception occurred. Ref: Sensus AMI.',
    `read_id` BIGINT COMMENT 'Foreign key linking to metering.read. Business justification: Read exceptions are anomalies detected during meter read processing (communication failures, variance exceptions, validation failures). Each exception record should reference the specific read that tr. Ref: Sensus AMI.',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: read_exception tracks meter read anomalies that require investigation. Exceptions occur during route reading operations and should reference which route the exception occurred on. This enables route-l. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Read exceptions tied to locations for field resolution. Required for dispatching meter readers, identifying access issues, correlating exceptions with address characteristics like obstructions, and op. Ref: Sensus AMI.',
    `validation_rule_id` BIGINT COMMENT 'Identifier of the automated validation rule that triggered the exception when exception source is validation_rule. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created for field investigation or meter replacement when field visit is required. Ref: Sensus AMI.',
    `battery_status` STRING COMMENT 'Battery health status of the Advanced Metering Infrastructure (AMI) endpoint device at time of exception. Ref: Sensus AMI.. Valid values are `normal|low|critical|failed`',
    `billing_hold_flag` BOOLEAN COMMENT 'Indicator that billing has been placed on hold for this meter installation until the exception is resolved. Ref: Sensus AMI.',
    `communication_failure_reason` STRING COMMENT 'Detailed reason for Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR) communication failure when exception type is communication_failure. Ref: Sensus AMI.',
    `corrected_read_value` DECIMAL(18,2) COMMENT 'Corrected meter reading value after manual investigation or re-read, used for billing when resolution action is read_corrected. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system. Ref: Sensus AMI.',
    `current_read_value` DECIMAL(18,2) COMMENT 'Current meter register reading value that triggered the exception, measured in gallons or cubic feet depending on meter configuration. Ref: Sensus AMI.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicator that the customer was notified about the read exception and potential billing impact. Ref: Sensus AMI.',
    `estimated_read_value` DECIMAL(18,2) COMMENT 'Estimated consumption value used for billing when actual read cannot be obtained, calculated based on historical usage patterns. Ref: Sensus AMI.',
    `estimation_method` STRING COMMENT 'Method used to calculate estimated read value when actual read is unavailable (e.g., historical average, seasonal adjustment, similar customer profile). Ref: Sensus AMI.',
    `exception_code` STRING COMMENT 'System-generated code identifying the specific exception condition. Aligns with Oracle CC&B exception code catalog.',
    `exception_date` DATE COMMENT 'Date when the meter read exception was detected or occurred. Ref: Sensus AMI.',
    `exception_source` STRING COMMENT 'Source system or process that detected and reported the meter read exception. Ref: Sensus AMI.. Valid values are `ami_system|manual_read|validation_rule|customer_report|field_inspection`',
    `exception_status` STRING COMMENT 'Current workflow status of the exception investigation and resolution process. Ref: Sensus AMI.. Valid values are `open|in_progress|resolved|escalated|cancelled`',
    `exception_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was detected by the Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR) system. Ref: Sensus AMI.',
    `exception_type` STRING COMMENT 'Classification of the meter read exception condition requiring investigation or manual resolution before billing. Ref: Sensus AMI.. Valid values are `no_read|high_read|low_read|reverse_read|estimated_read|communication_failure`',
    `expected_consumption` DECIMAL(18,2) COMMENT 'Expected consumption value based on historical usage patterns, used for variance analysis and exception detection. Ref: Sensus AMI.',
    `field_visit_required` BOOLEAN COMMENT 'Indicator that a field technician visit is required to physically inspect the meter or resolve the exception. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was last updated. Ref: Sensus AMI.',
    `leak_detection_flag` BOOLEAN COMMENT 'Indicator that continuous flow or abnormal usage pattern suggesting a leak was detected during the read period. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Notes. Ref: Sensus AMI.',
    `notification_date` DATE COMMENT 'Date when customer notification was sent regarding the meter read exception. Ref: Sensus AMI.',
    `prior_read_value` DECIMAL(18,2) COMMENT 'Previous valid meter register reading value before the exception occurred, measured in gallons or cubic feet depending on meter configuration. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'Priority assigned to the exception for resolution workflow, based on exception type, customer class, and business impact. Ref: Sensus AMI.. Valid values are `low|medium|high|critical`',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `register_overflow_flag` BOOLEAN COMMENT 'Indicator that the meter register has exceeded its maximum capacity and rolled over to zero. Ref: Sensus AMI.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the meter read exception before billing can proceed. Ref: Sensus AMI.. Valid values are `re_read|estimate_accepted|read_corrected|meter_replaced|field_visit_scheduled|no_action`',
    `resolution_date` DATE COMMENT 'Date when the exception was resolved and the read was approved for billing. Ref: Sensus AMI.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation findings, actions taken, and rationale for the resolution decision. Ref: Sensus AMI.',
    `resolution_status` STRING COMMENT 'Resolution status. Ref: Sensus AMI.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was resolved and approved for billing. Ref: Sensus AMI.',
    `resolved_by` STRING COMMENT 'User ID of the person who resolved the exception and approved the read for billing. Ref: Sensus AMI.',
    `resolved_flag` BOOLEAN COMMENT 'Resolved flag. Ref: Sensus AMI.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Indicator that reverse water flow through the meter was detected, potentially indicating meter tampering or backflow condition. Ref: Sensus AMI.',
    `signal_strength` STRING COMMENT 'Radio signal strength indicator for Advanced Metering Infrastructure (AMI) communication at time of exception, measured in decibels (dBm). Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute difference between current and prior read values, measured in gallons or cubic feet. Ref: Sensus AMI.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between current and prior read values, used to identify high/low read anomalies. Ref: Sensus AMI.',
    CONSTRAINT pk_read_exception PRIMARY KEY(`read_exception_id`)
) COMMENT 'Tracks meter read exceptions and anomalies that require investigation or manual resolution before a read can be used for billing. Stores exception date, meter installation reference, exception type (no read, high read, low read, reverse read, estimated read, communication failure, register overflow), exception code, prior read value, current read value, variance percentage, resolution action (re-read, estimate accepted, read corrected, meter replaced), resolved by, and resolution date. Interfaces with Oracle CC&B exception management workflow.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route. Ref: Sensus AMI.',
    `billing_cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle referenced by each read route record in the metering domain.',
    `dma_id` BIGINT COMMENT 'FK to district metered area per VREQ-044. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary assigned reader employee referenced by each read route record in the metering domain.',
    `read_assigned_employee_id` BIGINT COMMENT 'Default assigned meter reader. Ref: Sensus AMI.',
    `read_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the read created by employee referenced by each read route record in the metering domain.',
    `read_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the read responsible employee referenced by each read route record in the metering domain.',
    `territory_id` BIGINT COMMENT 'FK to service territory per VREQ-043. Ref: Sensus AMI.',
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
    `read_route_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each read route in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` (
    `metering_complaint_id` BIGINT COMMENT 'Primary key for complaint. Ref: Sensus AMI.',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: metering_complaint tracks customer disputes about meter accuracy and captures meter_test_ordered_flag, meter_test_date, meter_test_result, meter_accuracy_percent but lacks FK to the actual accuracy_te. Ref: Sensus AMI.',
    `adjustment_id` BIGINT COMMENT 'Billing adjustment record associated with this complaint. Ref: Sensus AMI.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier for the customer account referenced by each metering complaint record in the metering domain.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Customer complaints about metering (high bill complaints, meter accuracy disputes, read disputes) are specific to a meter installation at a service address. This FK links the complaint to the installa. Ref: Sensus AMI.',
    `metering_adjustment_id` BIGINT COMMENT 'Unique identifier for the metering adjustment referenced by each metering complaint record in the metering domain.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the metering assigned employee referenced by each metering complaint record in the metering domain.',
    `metering_assigned_to_employee_id` BIGINT COMMENT 'Employee assigned to investigate the complaint. Ref: Sensus AMI.',
    `metering_created_by_employee_id` BIGINT COMMENT 'Unique identifier for the metering created by employee referenced by each metering complaint record in the metering domain.',
    `metering_meter_id` BIGINT COMMENT 'Unique identifier for the metering meter referenced by each metering complaint record in the metering domain.',
    `metering_received_by_employee_id` BIGINT COMMENT 'FK to workforce.employee (received by). Ref: Sensus AMI.',
    `metering_resolved_by_employee_id` BIGINT COMMENT 'FK to workforce.employee (resolved by). Ref: Sensus AMI.',
    `metering_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the metering responsible employee referenced by each metering complaint record in the metering domain.',
    `read_id` BIGINT COMMENT 'Foreign key linking to metering.read. Business justification: Many metering complaints reference a specific disputed meter read (e.g., the read on my January bill is wrong). This FK links the complaint to the specific read being disputed. Should be nullable fo. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Customer complaints about meters (high bills, suspected leaks, accuracy concerns) are investigated via work orders. Standard utility customer service workflow linking complaint intake to field resolut. Ref: Sensus AMI.',
    `customer_complaint_id` BIGINT COMMENT 'Reference to primary customer.customer_complaint for SSOT alignment. Ref: Sensus AMI.',
    `metering_canonical_customer_complaint_id` BIGINT COMMENT 'Reference FK to canonical SSOT customer.customer_complaint. Ref: Sensus AMI.',
    `accuracy_test_result` STRING COMMENT 'Pass, Fail, Inconclusive, Not Tested. Ref: Sensus AMI.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Bill adjustment amount if applicable. Ref: Sensus AMI.',
    `adjustment_amount_usd` DECIMAL(18,2) COMMENT 'The adjustment amount usd value recorded for each metering complaint in the metering domain.',
    `adjustment_applied` BOOLEAN COMMENT 'The adjustment applied value recorded for each metering complaint in the metering domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each metering complaint in the metering domain.',
    `bill_adjustment_amount` DECIMAL(18,2) COMMENT 'Bill adjustment amount if applicable. Ref: Sensus AMI.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Billing adjustment amount applied as part of resolution. Ref: Sensus AMI.',
    `billing_adjustment_issued` BOOLEAN COMMENT 'Whether a billing adjustment was issued. Ref: Sensus AMI.',
    `metering_complaint_category` STRING COMMENT 'The metering complaint category value recorded for each metering complaint in the metering domain.',
    `classification` STRING COMMENT 'The classification value recorded for each metering complaint in the metering domain.',
    `metering_complaint_code` STRING COMMENT 'The metering complaint code value recorded for each metering complaint in the metering domain.',
    `comments` STRING COMMENT 'The comments value recorded for each metering complaint in the metering domain.',
    `complaint_channel` STRING COMMENT 'The complaint channel value recorded for each metering complaint in the metering domain.',
    `complaint_date` TIMESTAMP COMMENT 'The complaint date associated with each metering complaint record in the metering domain.',
    `complaint_description` STRING COMMENT 'The complaint description value recorded for each metering complaint in the metering domain.',
    `complaint_number` STRING COMMENT 'Unique complaint reference number. Ref: Sensus AMI.',
    `complaint_reason` STRING COMMENT 'The complaint reason value recorded for each metering complaint in the metering domain.',
    `complaint_status` STRING COMMENT 'Status (open, investigating, resolved, closed, escalated). Ref: Sensus AMI.',
    `complaint_type` STRING COMMENT 'Type (high_bill, no_water, low_pressure, leak, meter_damage). Ref: Sensus AMI.',
    `compliance_status` STRING COMMENT 'The compliance status value recorded for each metering complaint in the metering domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction rating 1-5. Ref: Sensus AMI.',
    `customer_satisfied` BOOLEAN COMMENT 'Whether customer was satisfied with resolution. Ref: Sensus AMI.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each metering complaint in the metering domain.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each metering complaint in the metering domain.',
    `metering_complaint_description` STRING COMMENT 'Customer description of the issue. Ref: Sensus AMI.',
    `disputed_amount_usd` DECIMAL(18,2) COMMENT 'The disputed amount usd value recorded for each metering complaint in the metering domain.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each metering complaint record in the metering domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: Sensus AMI.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: Sensus AMI.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each metering complaint record in the metering domain.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each metering complaint record in the metering domain.',
    `field_visit_date` DATE COMMENT 'Date of field visit. Ref: Sensus AMI.',
    `field_visit_required` STRING COMMENT 'Whether field visit was required. Ref: Sensus AMI.',
    `investigation_complete_date` TIMESTAMP COMMENT 'Date investigation was completed. Ref: Sensus AMI.',
    `investigation_notes` STRING COMMENT 'The investigation notes value recorded for each metering complaint in the metering domain.',
    `investigation_start_date` TIMESTAMP COMMENT 'Date investigation started. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: Sensus AMI.',
    `is_escalated` BOOLEAN COMMENT 'Boolean flag indicating whether the is escalated condition applies to the metering complaint record.',
    `is_regulatory_complaint` BOOLEAN COMMENT 'Flag indicating the complaint was filed with a regulatory agency. Ref: Sensus AMI.',
    `is_resolved` BOOLEAN COMMENT 'Boolean flag indicating whether the is resolved condition applies to the metering complaint record.',
    `meter_tested` STRING COMMENT 'Whether meter accuracy test was performed. Ref: Sensus AMI.',
    `metering_complaint_number` STRING COMMENT 'The metering complaint number value recorded for each metering complaint in the metering domain.',
    `metering_complaint_type` STRING COMMENT 'The metering complaint type value recorded for each metering complaint in the metering domain.',
    `metering_customer_complaint_id` BIGINT COMMENT 'Foreign key to SSOT entity customer.customer_complaint. Ref: Sensus AMI.',
    `metering_complaint_name` STRING COMMENT 'The metering complaint name used to identify each metering complaint record in the metering domain.',
    `notes` STRING COMMENT 'Free-text notes. Ref: Sensus AMI.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each metering complaint in the metering domain.',
    `priority` STRING COMMENT 'Priority level (low, medium, high, urgent). Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each metering complaint in the metering domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each metering complaint in the metering domain.',
    `received_date` DATE COMMENT 'Date complaint was received. Ref: Sensus AMI.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'The record status value recorded for each metering complaint in the metering domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each metering complaint in the metering domain.',
    `regulatory_complaint_reference` STRING COMMENT 'Reference number from the regulatory agency complaint filing. Ref: Sensus AMI.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each metering complaint in the metering domain.',
    `reported_date` TIMESTAMP COMMENT 'The reported date associated with each metering complaint record in the metering domain.',
    `resolution` STRING COMMENT 'The resolution value recorded for each metering complaint in the metering domain.',
    `resolution_code` STRING COMMENT 'Resolution code (meter_replaced, no_issue_found, leak_repaired, adjusted). Ref: Sensus AMI.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each metering complaint record in the metering domain.',
    `resolution_description` STRING COMMENT 'Description of resolution. Ref: Sensus AMI.',
    `resolution_notes` STRING COMMENT 'The resolution notes value recorded for each metering complaint in the metering domain.',
    `resolution_status` STRING COMMENT 'Resolution status. Ref: Sensus AMI.',
    `resolution_type` STRING COMMENT 'Bill Adjusted, Meter Replaced, No Action, Leak Confirmed. Ref: Sensus AMI.',
    `resolved_date` DATE COMMENT 'Date complaint was resolved. Ref: Sensus AMI.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each metering complaint in the metering domain.',
    `root_cause` STRING COMMENT 'Root cause determination: meter fault, estimation error, leak, etc. Ref: Sensus AMI.',
    `ssot_entity_type` STRING COMMENT 'The ssot entity type value recorded for each metering complaint in the metering domain.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each metering complaint in the metering domain.',
    `ssot_role` STRING COMMENT 'Ssot role. Ref: Sensus AMI.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each metering complaint record in the metering domain.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each metering complaint record in the metering domain.',
    `metering_complaint_status` STRING COMMENT 'Lifecycle status of the record. Ref: Sensus AMI.',
    `test_requested` BOOLEAN COMMENT 'The test requested value recorded for each metering complaint in the metering domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each metering complaint in the metering domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each metering complaint record in the metering domain.',
    CONSTRAINT pk_metering_complaint PRIMARY KEY(`metering_complaint_id`)
) COMMENT 'Records customer-initiated complaints and disputes related to metering, including high bill complaints, meter accuracy disputes, estimated bill objections, and AMI data concerns. Captures complaint date, customer account reference, meter installation reference, complaint type, complaint description, consumption period in dispute, disputed amount, investigation assigned to, investigation findings, resolution type (meter test ordered, read corrected, bill adjusted, complaint dismissed), resolution date, and customer satisfaction outcome. Interfaces with Microsoft Dynamics 365 CRM case management. [SSOT: reference view of canonical customer.customer_complaint] Consolidated: customer.customer_complaint is SSOT; this table references it with category.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` (
    `meter_field_inspection_id` BIGINT COMMENT 'Unique identifier for the meter field inspection record. Primary key. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: meter_field_inspection records physical inspection of meter installations and captures AMI endpoint condition attributes (ami_endpoint_condition, ami_antenna_condition, ami_signal_strength_dbm, ami_ba. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Reference to the follow-up work order created in IBM Maximo based on the inspection findings and recommended actions.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the field inspection. Links to workforce employee record. Ref: Sensus AMI.',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Field inspections identify needed materials (repair parts, replacement registers, seals) and generate material requisitions. Inspector identifies failed component during inspection, creates requisitio. Ref: Sensus AMI.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation being inspected. Links to the meter installation record in the metering domain. Ref: Sensus AMI.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Inspections verify premise-level meter conditions and infrastructure. Required for correlating inspection findings with premise characteristics, prioritizing premise upgrades, and tracking compliance. Ref: Sensus AMI.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Field inspections occur at service addresses. Essential for inspection routing, GPS navigation, verifying physical location matches records, and coordinating customer access for vault/pit inspections. Ref: Sensus AMI.',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR compliance requires visual verification of service line material during meter field inspections. Inspectors document service line condition, material type, and leak evidence. Links inspection fin',
    `ami_antenna_condition` STRING COMMENT 'Condition of the AMI endpoint antenna: intact, damaged, missing, or corroded. Critical for radio frequency communication performance. Ref: Sensus AMI.. Valid values are `intact|damaged|missing|corroded`',
    `ami_battery_voltage` DECIMAL(18,2) COMMENT 'Battery voltage of the AMI endpoint measured during the field inspection, used to predict remaining battery life and schedule replacements. Ref: Sensus AMI.',
    `ami_endpoint_condition` STRING COMMENT 'Physical condition assessment of the AMI endpoint device: excellent, good, fair, poor, missing, or damaged. Evaluates antenna, housing, and mounting integrity. Ref: Sensus AMI.. Valid values are `excellent|good|fair|poor|missing|damaged`',
    `ami_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength of the AMI endpoint measured in decibels-milliwatts (dBm) during the field inspection, used to assess communication quality. Ref: Sensus AMI.',
    `condition_rating` STRING COMMENT 'Condition rating. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system. Ref: Sensus AMI.',
    `findings` STRING COMMENT 'Findings. Ref: Sensus AMI.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Follow up required flag. Ref: Sensus AMI.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'GPS coordinate accuracy measured in meters, indicating the precision of the location capture during the field inspection. Ref: Sensus AMI.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured during the field inspection, used to verify meter location and update GIS records. Ref: Sensus AMI.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured during the field inspection, used to verify meter location and update GIS records. Ref: Sensus AMI.',
    `inspection_date` DATE COMMENT 'Date when the field inspection was performed. Ref: Sensus AMI.',
    `inspection_duration_minutes` STRING COMMENT 'Duration of the field inspection in minutes, used for workforce productivity analysis and route optimization. Ref: Sensus AMI.',
    `inspection_notes` STRING COMMENT 'Free-text notes and observations recorded by the inspector during the field inspection, capturing additional details not covered by structured fields. Ref: Sensus AMI.',
    `inspection_number` STRING COMMENT 'Unique business identifier for the field inspection, typically generated by the CMMS or field service system. Ref: Sensus AMI.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: scheduled, in progress, completed, cancelled, failed, or pending review. Ref: Sensus AMI.. Valid values are `scheduled|in_progress|completed|cancelled|failed|pending_review`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the field inspection was performed, including time zone information. Ref: Sensus AMI.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose: routine scheduled inspection, complaint-driven investigation, post-repair verification, pre-replacement assessment, accuracy verification, leak investigation, tamper investigation, high usage investigation, AMI endpoint physical check, or regulatory compliance inspection. [ENUM-REF-CANDIDATE: routine|complaint_driven|post_repair|pre_replacement|accuracy_verification|leak_investigation|tamper_investigation|high_usage_investigation|ami_endpoint_check|regulatory_compliance — 10 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `inspector_name` STRING COMMENT 'Full name of the inspector who performed the field inspection. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was last modified in the system. Ref: Sensus AMI.',
    `leak_description` STRING COMMENT 'Detailed description of any leak detected during the inspection, including location, severity, and estimated flow rate if observable. Ref: Sensus AMI.',
    `leak_detected_flag` BOOLEAN COMMENT 'Indicates whether a leak was detected at the meter installation during the field inspection, including meter body leaks, connection leaks, or service line leaks. Ref: Sensus AMI.',
    `meter_condition_rating` STRING COMMENT 'Overall condition assessment of the meter based on visual inspection: excellent, good, fair, poor, or failed. Used for asset health scoring and replacement prioritization. Ref: Sensus AMI.. Valid values are `excellent|good|fair|poor|failed`',
    `notes` STRING COMMENT 'Notes. Ref: Sensus AMI.',
    `obstruction_description` STRING COMMENT 'Detailed description of any obstructions noted during the inspection that prevent or hinder meter access. Ref: Sensus AMI.',
    `obstruction_noted_flag` BOOLEAN COMMENT 'Indicates whether any obstructions were noted that prevent or hinder access to the meter installation, such as landscaping, vehicles, structures, or locked gates. Ref: Sensus AMI.',
    `photo_count` STRING COMMENT 'Number of photographs captured during the field inspection for documentation and evidence purposes. Ref: Sensus AMI.',
    `photo_evidence_reference` STRING COMMENT 'Reference identifier or file path to photographic evidence captured during the field inspection, stored in the document management system. Ref: Sensus AMI.',
    `pit_debris_present_flag` BOOLEAN COMMENT 'Indicates whether debris, sediment, or foreign objects are present in the meter pit or vault that may interfere with meter operation or access. Ref: Sensus AMI.',
    `pit_vault_condition` STRING COMMENT 'Condition assessment of the meter pit or vault: excellent, good, fair, poor, or hazardous. Includes evaluation of structural integrity, water intrusion, and safety hazards. Ref: Sensus AMI.. Valid values are `excellent|good|fair|poor|hazardous`',
    `pit_water_present_flag` BOOLEAN COMMENT 'Indicates whether standing water is present in the meter pit or vault, which may indicate drainage issues, leaks, or groundwater infiltration. Ref: Sensus AMI.',
    `priority_level` STRING COMMENT 'Priority level assigned to any follow-up action required based on inspection findings: critical, high, medium, or low. Ref: Sensus AMI.. Valid values are `critical|high|medium|low`',
    `recommended_action` STRING COMMENT 'Inspectors recommended action based on the field inspection findings: none, monitor, repair, replace, clean, recalibrate, investigate, upgrade AMI endpoint, or seal replacement. [ENUM-REF-CANDIDATE: none|monitor|repair|replace|clean|recalibrate|investigate|upgrade_ami|seal_replacement — 9 candidates stripped; promote to reference product]. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `register_readable_flag` BOOLEAN COMMENT 'Indicates whether the meter register is readable and visible during the inspection. False may indicate fogging, damage, or obstruction. Ref: Sensus AMI.',
    `register_reading` DECIMAL(18,2) COMMENT 'Current register reading captured during the field inspection, measured in gallons or cubic feet depending on meter configuration. Ref: Sensus AMI.',
    `register_unit_of_measure` STRING COMMENT 'Unit of measure for the register reading: gallons, cubic feet, or cubic meters. Ref: Sensus AMI.. Valid values are `gallons|cubic_feet|cubic_meters`',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the meter seal is intact and unbroken. False indicates potential tampering or unauthorized access requiring investigation. Ref: Sensus AMI.',
    `seal_number_verified` STRING COMMENT 'Seal number observed during the inspection, used to verify against the installation record and detect unauthorized seal replacement. Ref: Sensus AMI.',
    `tamper_description` STRING COMMENT 'Detailed description of any tampering evidence observed during the inspection, used for revenue protection investigations. Ref: Sensus AMI.',
    `tamper_evidence_flag` BOOLEAN COMMENT 'Indicates whether evidence of tampering was observed during the inspection, such as broken seals, unauthorized modifications, bypass piping, or meter reversal. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_meter_field_inspection PRIMARY KEY(`meter_field_inspection_id`)
) COMMENT 'Records field inspection visits to meter installations for condition assessment, seal verification, pit/vault inspection, and AMI endpoint physical check. Captures inspection date, meter installation reference, inspector employee ID, inspection type (routine, complaint-driven, post-repair, pre-replacement), meter condition rating, pit/vault condition, seal intact flag, AMI antenna condition, obstructions noted, photographic evidence reference, recommended action, and follow-up work order reference in IBM Maximo. Supports proactive asset management and revenue protection.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` (
    `ami_network_collector_id` BIGINT COMMENT 'Unique identifier for the AMI network collector device. Primary key for the collector registry. Ref: Sensus AMI.',
    `registry_id` BIGINT COMMENT 'Reference to the asset registry entry for this collector device in the CMMS (IBM Maximo). Links AMI network data to enterprise asset management for maintenance scheduling, depreciation, and lifecycle tracking.',
    `ami_registry_id` BIGINT COMMENT 'Reference to the asset registry entry for this collector device in the CMMS (IBM Maximo). Links AMI network data to enterprise asset management for maintenance scheduling, depreciation, and lifecycle tracking.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Network collectors installed as AMI infrastructure projects require project linkage for warranty management, project performance evaluation, capital cost allocation, and asset capitalization. Critical. Ref: Sensus AMI.',
    `dma_id` BIGINT COMMENT 'Identifier of the district metered area that this collector primarily serves. Used for aligning AMI network topology with hydraulic zones for non-revenue water analysis. Ref: Sensus AMI.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: AMI collectors are capitalized infrastructure assets requiring fixed asset register inclusion for depreciation, net book value tracking, and GASB capital asset reporting. Each collector has acquisitio. Ref: Sensus AMI.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and documented the installation of this collector device. Used for audit trail and cost tracking. Ref: Sensus AMI.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Network collectors are capital assets procured as materials, tracked for inventory, installation work orders, warranty, and spare parts management. Procurement orders collectors by material number; wa. Ref: Sensus AMI.',
    `backhaul_connection_type` STRING COMMENT 'Type of wide-area network connection used to transmit collected meter data from the collector to the central AMI head-end system. Cellular and fiber are most common for fixed base stations. Ref: Sensus AMI.. Valid values are `cellular|fiber|dsl|cable|satellite|microwave`',
    `backhaul_provider` STRING COMMENT 'Name of the telecommunications carrier or internet service provider supplying the backhaul connection for this collector. Used for vendor management and service level agreement tracking. Ref: Sensus AMI.',
    `battery_backup_flag` BOOLEAN COMMENT 'Indicates whether the collector device has battery backup power to maintain operation during AC power outages. True if battery backup is installed and functional. Ref: Sensus AMI.',
    `city` STRING COMMENT 'City or municipality where the collector device is installed. Ref: Sensus AMI.',
    `collector_identifier` STRING COMMENT 'Externally-known unique identifier or serial number assigned to the collector device by the manufacturer or utility. Used for field operations and inventory tracking. Ref: Sensus AMI.',
    `collector_serial_number` STRING COMMENT 'Collector serial number. Ref: Sensus AMI.',
    `collector_type` STRING COMMENT 'Classification of the collector device based on its deployment mode and function within the AMI network topology. Fixed base stations are permanently installed, mobile collectors are vehicle-mounted for drive-by reading, and repeaters extend network coverage. Ref: Sensus AMI.. Valid values are `fixed_base_station|mobile_collector|repeater|tower_mounted_receiver|gateway|hybrid`',
    `communication_protocol` STRING COMMENT 'Radio frequency communication protocol used by the collector to communicate with AMI endpoints. FlexNet is the Sensus proprietary protocol; other protocols may be used in hybrid deployments. Ref: Sensus AMI.. Valid values are `flexnet|mesh|point_to_multipoint|cellular|lora|zigbee`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the collector installation location.. Valid values are `USA|CAN|MEX`',
    `coverage_radius_miles` DECIMAL(18,2) COMMENT 'Estimated radio frequency coverage radius in miles for the collector device. Defines the geographic area within which AMI endpoints can communicate with this collector. Used for network planning and coverage gap analysis. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collector record was first created in the AMI system. Used for data lineage and audit purposes. Ref: Sensus AMI.',
    `decommission_date` DATE COMMENT 'Date when the collector device was removed from service or retired from the AMI network. Null for active collectors. Ref: Sensus AMI.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet where the collector device is installed. Critical for tower-mounted collectors and radio frequency propagation modeling. Ref: Sensus AMI.',
    `endpoint_capacity` STRING COMMENT 'Maximum number of AMI endpoints that this collector device can support based on manufacturer specifications and network design. Used for capacity planning and network expansion. Ref: Sensus AMI.',
    `endpoint_count` STRING COMMENT 'Current number of AMI endpoints (meters) actively registered and communicating through this collector. Used for load balancing and capacity planning. Ref: Sensus AMI.',
    `firmware_update_date` DATE COMMENT 'Date when the collector firmware was last updated. Used for tracking patch compliance and planning future updates. Ref: Sensus AMI.',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the collector device. Critical for security patch management, feature availability, and troubleshooting. Format varies by manufacturer. Ref: Sensus AMI.',
    `frequency_mhz` DECIMAL(18,2) COMMENT 'Radio frequency in megahertz on which the collector operates. Common frequencies include 900 MHz and 450 MHz bands. Critical for regulatory compliance and interference management. Ref: Sensus AMI.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the collector device location in decimal degrees. Used for GIS mapping, coverage analysis, and network topology visualization in ArcGIS. Ref: Sensus AMI.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the collector device location in decimal degrees. Used for GIS mapping, coverage analysis, and network topology visualization in ArcGIS. Ref: Sensus AMI.',
    `health_status` STRING COMMENT 'Overall health assessment of the collector device based on communication frequency, signal quality, error rates, and diagnostic metrics. Healthy indicates normal operation; degraded indicates performance issues; critical indicates imminent failure risk; offline indicates no communication. Ref: Sensus AMI.. Valid values are `healthy|degraded|critical|offline|unknown`',
    `installation_date` DATE COMMENT 'Date when the collector device was physically installed and commissioned in the field. Used for asset lifecycle tracking and warranty management. Ref: Sensus AMI.',
    `installation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the collector device was activated and began communicating with the AMI network. Provides exact commissioning time for audit and troubleshooting purposes. Ref: Sensus AMI.',
    `ip_address` STRING COMMENT 'IP address assigned to the collector device for network communication and remote management. May be static or dynamic depending on backhaul configuration. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful communication between the collector and the AMI head-end system. Used for health monitoring and outage detection. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collector record was most recently updated. Used for change tracking and data quality monitoring. Ref: Sensus AMI.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude. Ref: Sensus AMI.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude. Ref: Sensus AMI.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the collector device network interface. Used for device authentication and network management. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special instructions, site access details, or historical information about the collector device. Used by field technicians and network engineers. Ref: Sensus AMI.',
    `operational_status` STRING COMMENT 'Current operational state of the collector device in the AMI network. Active collectors are in service and communicating with endpoints; inactive collectors are installed but not operational; maintenance indicates scheduled or unscheduled service; decommissioned collectors are retired from service. Ref: Sensus AMI.. Valid values are `active|inactive|maintenance|decommissioned|testing|failed`',
    `physical_address_line1` STRING COMMENT 'Primary street address line where the collector device is physically installed. Used for field service dispatch and asset location management. Ref: Sensus AMI.',
    `physical_address_line2` STRING COMMENT 'Secondary address line for additional location details such as building, suite, or tower designation. Ref: Sensus AMI.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the collector installation location. Ref: Sensus AMI.',
    `power_source` STRING COMMENT 'Primary power source for the collector device. AC mains is typical for fixed base stations; solar and battery are used for remote or mobile installations. Ref: Sensus AMI.. Valid values are `ac_mains|solar|battery|hybrid`',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or operating region where the collector is deployed. Used for multi-jurisdiction utilities and regional reporting. Ref: Sensus AMI.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Most recent backhaul signal strength measurement in dBm. Used for diagnosing connectivity issues and optimizing network performance. Typical range is -50 dBm (excellent) to -110 dBm (poor). Ref: Sensus AMI.',
    `state_province` STRING COMMENT 'State or province code where the collector device is located. Typically two-letter abbreviation for US states. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    CONSTRAINT pk_ami_network_collector PRIMARY KEY(`ami_network_collector_id`)
) COMMENT 'Master record for each AMI fixed network collector (base station, tower-mounted receiver, or mobile collector) in the Sensus FlexNet infrastructure. Stores collector ID, collector type (fixed base station, mobile collector, repeater), physical location (address and GIS coordinates), coverage radius, number of endpoints served, communication protocol, backhaul connection type (cellular, fiber, DSL), installation date, firmware version, and operational status. Defines the AMI network topology that enables automated meter reading across the service territory.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` (
    `meter_size_type_id` BIGINT COMMENT 'Unique identifier for the meter size and type combination. Primary key for the reference table. Ref: Sensus AMI.',
    `primary_replacement_meter_size_type_id` BIGINT COMMENT 'Reference to the successor meter size and type that replaces this obsolete configuration. Null if no replacement defined. Ref: Sensus AMI.',
    `accuracy_class` STRING COMMENT 'AWWA or ISO accuracy classification for meters of this size (e.g., AWWA Class I, Class II; ISO R160, R250). Defines expected measurement precision and testing requirements.',
    `accuracy_percentage_low_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at the minimum detectable flow rate. Critical for NRW analysis. Ref: Sensus AMI.',
    `accuracy_percentage_normal_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at normal operating flow rate. Ref: Sensus AMI.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type is currently approved for new installations in the utility service territory. Ref: Sensus AMI.',
    `ami_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMI endpoints for remote reading and interval data collection. Ref: Sensus AMI.',
    `amr_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMR endpoints for drive-by or walk-by reading. Ref: Sensus AMI.',
    `average_unit_cost_usd` DECIMAL(18,2) COMMENT 'Average procurement cost in United States Dollars (USD) for a meter of this size including hardware but excluding installation labor. Used for budgeting and capital planning. Ref: Sensus AMI.',
    `awwa_standard_code` STRING COMMENT 'Applicable AWWA standard governing this meter size and type (e.g., C700, C701, C702, C706, C708, C710, C713).. Valid values are `^C[0-9]{3}$`',
    `connection_type` STRING COMMENT 'Standard connection method for meters of this size (threaded, flanged, compression, saddle, direct bury). Determines installation requirements and compatibility. Ref: Sensus AMI.. Valid values are `threaded|flanged|compression|saddle|direct_bury`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was first created in the system. Ref: Sensus AMI.',
    `meter_size_type_description` STRING COMMENT 'Detailed description of the meter size type including typical applications, customer classes, and usage characteristics (e.g., Standard residential meter for single-family homes). Ref: Sensus AMI.',
    `display_name` STRING COMMENT 'Human-readable display name for the meter size (e.g., 5/8 inch, 3/4 inch, 1 inch, 2 inch). Used in user interfaces, reports, and customer communications. Ref: Sensus AMI.',
    `effective_date` DATE COMMENT 'Date when this meter size and type was approved for use in the utility service territory. Ref: Sensus AMI.',
    `effective_end_date` DATE COMMENT 'Date when this meter size type was discontinued or superseded. Null for currently active meter size types. Used for phase-out planning and historical analysis. Ref: Sensus AMI.',
    `effective_start_date` DATE COMMENT 'Date when this meter size type became available for use in the utilitys meter inventory. Supports historical tracking and version control. Ref: Sensus AMI.',
    `expected_service_life_years` STRING COMMENT 'Typical operational lifespan in years before meter replacement is recommended due to accuracy degradation. Ref: Sensus AMI.',
    `flange_standard` STRING COMMENT 'Flange specification for flanged connections (e.g., ANSI Class 125, ANSI Class 250). Applicable to larger meter sizes requiring bolted connections. Ref: Sensus AMI.',
    `installation_labor_hours` DECIMAL(18,2) COMMENT 'Typical labor hours required to install or replace a meter of this size. Used for work order planning, crew scheduling, and cost estimation. Ref: Sensus AMI.',
    `installation_orientation` STRING COMMENT 'Required or recommended installation orientation for accurate measurement (horizontal, vertical, or any orientation). Ref: Sensus AMI.. Valid values are `horizontal|vertical|any`',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was last updated. Ref: Sensus AMI.',
    `lead_free_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type meets lead-free certification requirements under the Safe Drinking Water Act and LCRR.',
    `length_inches` DECIMAL(18,2) COMMENT 'Overall length of the meter body in inches. Critical for vault and pit sizing during installation. Ref: Sensus AMI.',
    `max_continuous_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum flow rate in gallons per minute that the meter can sustain continuously without damage or accuracy degradation. Ref: Sensus AMI.',
    `max_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Max flow rate gpm. Ref: Sensus AMI.',
    `max_registered_flow_gpm` DECIMAL(18,2) COMMENT 'Peak flow rate in gallons per minute that the meter can register accurately for short durations. Ref: Sensus AMI.',
    `maximum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum continuous flow rate in gallons per minute (GPM) for meters of this size. Defines the upper capacity limit for safe and accurate operation. Ref: Sensus AMI.',
    `maximum_intermittent_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum short-duration or peak flow rate in gallons per minute (GPM) that the meter can handle without damage. Used for surge and peak demand scenarios. Ref: Sensus AMI.',
    `measurement_class` STRING COMMENT 'AWWA accuracy classification (Class I through Class IV). Higher classes indicate greater accuracy at low flow rates.. Valid values are `class_i|class_ii|class_iii|class_iv`',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches. Standard sizes include 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12 inches per AWWA standards.',
    `meter_size_type_status` STRING COMMENT 'Current lifecycle status of this meter size type in the reference catalog (active, inactive, obsolete, pending approval). Controls availability for new installations. Ref: Sensus AMI.. Valid values are `active|inactive|obsolete|pending_approval`',
    `meter_technology` STRING COMMENT 'Meter technology. Ref: Sensus AMI.',
    `meter_type` STRING COMMENT 'Technology classification of the water meter. Defines the measurement principle used to register flow. Ref: Sensus AMI.. Valid values are `positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service`',
    `min_detectable_flow_gpm` DECIMAL(18,2) COMMENT 'Lowest flow rate in gallons per minute that the meter can detect and register. Critical for leak detection and low-flow accuracy. Ref: Sensus AMI.',
    `min_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Min flow rate gpm. Ref: Sensus AMI.',
    `minimum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum measurable flow rate in gallons per minute (GPM) for meters of this size. Defines the lower accuracy threshold for consumption measurement. Ref: Sensus AMI.',
    `nominal_size_inches` DECIMAL(18,2) COMMENT 'Nominal size inches. Ref: Sensus AMI.',
    `normal_operating_flow_gpm` DECIMAL(18,2) COMMENT 'Typical sustained flow rate in gallons per minute for which the meter is optimally designed. Used for meter sizing and selection. Ref: Sensus AMI.',
    `normal_operating_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Typical or recommended operating flow rate in gallons per minute (GPM) for optimal meter accuracy and longevity. Used for sizing and capacity planning. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Additional technical notes, installation guidance, or special considerations for this meter size and type. Ref: Sensus AMI.',
    `nsf_61_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter is certified to NSF/ANSI Standard 61 for drinking water system components. Ref: Sensus AMI.',
    `obsolete_date` DATE COMMENT 'Date when this meter size and type was discontinued or phased out for new installations. Null if still active. Ref: Sensus AMI.',
    `pressure_loss_at_max_flow_psi` DECIMAL(18,2) COMMENT 'Expected pressure loss in pounds per square inch (PSI) across the meter at maximum continuous flow rate. Critical for hydraulic modeling and system pressure management. Ref: Sensus AMI.',
    `pressure_rating_psi` STRING COMMENT 'Maximum working pressure in pounds per square inch that the meter can withstand without failure. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `register_capacity_gallons` BIGINT COMMENT 'Maximum cumulative volume in gallons that the meter register can display before rolling over. Important for billing cycle planning and register overflow detection. Ref: Sensus AMI.',
    `register_type` STRING COMMENT 'Type of register used to display consumption. Mechanical for analog dials, electronic for digital displays, encoder for AMI/AMR integration. Ref: Sensus AMI.. Valid values are `mechanical|electronic|encoder`',
    `service_connection_type` STRING COMMENT 'Standard connection method for installing this meter size (threaded, flanged, or compression fitting). Ref: Sensus AMI.. Valid values are `threaded|flanged|compression`',
    `size_code` STRING COMMENT 'Short alphanumeric code representing the meter size (e.g., 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12). Used as a lookup key in operational systems. Ref: Sensus AMI.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `size_description` STRING COMMENT 'Size description. Ref: Sensus AMI.',
    `size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches (e.g., 0.625 for 5/8 inch, 0.75 for 3/4 inch, 1.0, 1.5, 2.0, etc.). Primary measurement for meter sizing and capacity planning. Ref: Sensus AMI.',
    `size_millimeters` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in millimeters (e.g., 15mm, 20mm, 25mm, 40mm, 50mm, etc.). Used for international standards compliance and metric system reporting. Ref: Sensus AMI.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of meter sizes in user interfaces and reports (typically ordered from smallest to largest). Ref: Sensus AMI.',
    `straight_pipe_downstream_inches` STRING COMMENT 'Minimum length of straight pipe required downstream of the meter in inches to ensure accurate flow measurement. Ref: Sensus AMI.',
    `straight_pipe_upstream_inches` STRING COMMENT 'Minimum length of straight pipe required upstream of the meter in inches to ensure accurate flow measurement. Ref: Sensus AMI.',
    `temperature_rating_fahrenheit_max` STRING COMMENT 'Maximum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity. Ref: Sensus AMI.',
    `temperature_rating_fahrenheit_min` STRING COMMENT 'Minimum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity. Ref: Sensus AMI.',
    `testing_frequency_years` STRING COMMENT 'Recommended interval in years between accuracy testing and calibration per regulatory and utility standards. Ref: Sensus AMI.',
    `thread_standard` STRING COMMENT 'Thread specification for threaded connections (e.g., NPT, BSPT, AWWA). Ensures compatibility with service line fittings and meter setters.',
    `typical_application` STRING COMMENT 'Standard use case for this meter size and type (e.g., single-family residential, multi-family residential, commercial, industrial, fire service, irrigation). Ref: Sensus AMI.',
    `typical_customer_class` STRING COMMENT 'Primary customer class typically served by this meter size (residential, commercial, industrial, institutional, agricultural, municipal). Used for rate structure and billing configuration. Ref: Sensus AMI.. Valid values are `residential|commercial|industrial|institutional|agricultural|municipal`',
    `typical_service_life_years` STRING COMMENT 'Expected operational service life in years for meters of this size under normal operating conditions. Used for asset replacement planning and depreciation schedules. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp. Ref: Sensus AMI.',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Approximate weight of the meter in pounds. Used for logistics, installation planning, and safety assessments. Ref: Sensus AMI.',
    CONSTRAINT pk_meter_size_type PRIMARY KEY(`meter_size_type_id`)
) COMMENT 'Master reference table for meter_size_type. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` (
    `endpoint_procurement_id` BIGINT COMMENT 'Primary key for the endpoint_procurement association. Ref: Sensus AMI.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to the AMI endpoint device that was procured from this vendor. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'FK to employee who processed procurement. Ref: Sensus AMI.',
    `endpoint_installation_employee_id` BIGINT COMMENT 'Employee who installed the endpoint. Ref: Sensus AMI.',
    `material_master_id` BIGINT COMMENT 'Link to material master record. Ref: Sensus AMI.',
    `po_line_item_id` BIGINT COMMENT 'Link to the PO line item. Ref: Sensus AMI.',
    `procurement_category_id` BIGINT COMMENT 'Procurement category. Ref: Sensus AMI.',
    `purchase_order_id` BIGINT COMMENT 'Link to the purchase order. Ref: Sensus AMI.',
    `purchase_requisition_id` BIGINT COMMENT 'Link to purchase requisition. Ref: Sensus AMI.',
    `rfq_id` BIGINT COMMENT 'Request for quotation ID. Ref: Sensus AMI.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor who supplied this AMI endpoint. Ref: Sensus AMI.',
    `warehouse_location_id` BIGINT COMMENT 'FK to warehouse where endpoint is stored. Ref: Sensus AMI.',
    `acceptance_status` STRING COMMENT 'Acceptance status after quality inspection (e.g., accepted, rejected, partial). Ref: Sensus AMI.',
    `actual_delivery_date` TIMESTAMP COMMENT 'Actual date the endpoints were delivered. Ref: Sensus AMI.',
    `batch_serial_end` STRING COMMENT 'Ending serial number of the batch of endpoints procured. Ref: Sensus AMI.',
    `batch_serial_range_end` STRING COMMENT 'Ending serial number of the procured endpoint batch. Ref: Sensus AMI.',
    `batch_serial_range_start` STRING COMMENT 'Starting serial number of the procured endpoint batch. Ref: Sensus AMI.',
    `batch_serial_start` STRING COMMENT 'Starting serial number of the batch of endpoints procured. Ref: Sensus AMI.',
    `battery_type` STRING COMMENT 'Type of battery installed. Ref: Sensus AMI.',
    `bid_evaluation_score` DECIMAL(18,2) COMMENT 'Vendor bid evaluation score. Ref: Sensus AMI.',
    `bulk_discount_pct` DECIMAL(18,2) COMMENT 'Bulk discount percentage. Ref: Sensus AMI.',
    `bulk_discount_threshold` STRING COMMENT 'Quantity threshold for bulk discount. Ref: Sensus AMI.',
    `buy_america_compliant_flag` BOOLEAN COMMENT 'Whether procurement meets Buy America requirements. Ref: Sensus AMI.',
    `commissioning_date` TIMESTAMP COMMENT 'Date endpoint was commissioned. Ref: Sensus AMI.',
    `communication_protocol` STRING COMMENT 'Communication protocol (e.g., RF, cellular, LoRaWAN). Ref: Sensus AMI.',
    `cooperative_contract_number` STRING COMMENT 'Cooperative purchasing contract number if applicable. Ref: Sensus AMI.',
    `country_of_origin` STRING COMMENT 'Country of origin for endpoint. Ref: Sensus AMI.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this procurement record was created. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `cybersecurity_certification` STRING COMMENT 'Cybersecurity certification (e.g., UL 2900-2-2). Ref: Sensus AMI.',
    `defect_count` STRING COMMENT 'Number of defective units identified during inspection. Ref: Sensus AMI.',
    `delivery_date` TIMESTAMP COMMENT 'Delivery date. Ref: Sensus AMI.',
    `encryption_standard` STRING COMMENT 'Encryption standard used (e.g., AES-128). Ref: Sensus AMI.',
    `endpoint_manufacturer` STRING COMMENT 'Manufacturer of the endpoint. Ref: Sensus AMI.',
    `endpoint_model` STRING COMMENT 'Model number of the endpoint. Ref: Sensus AMI.',
    `endpoint_serial_number` STRING COMMENT 'Serial number of the endpoint. Ref: Sensus AMI.',
    `endpoint_technology_type` STRING COMMENT 'Communication technology type (e.g., cellular, RF_mesh, LoRaWAN, NB_IoT). Ref: Sensus AMI.',
    `endpoint_type` STRING COMMENT 'Type of endpoint (e.g., Fixed Network, Mobile, Hybrid). Ref: Sensus AMI.',
    `expected_battery_life_years` STRING COMMENT 'Expected battery life in years. Ref: Sensus AMI.',
    `expected_delivery_date` TIMESTAMP COMMENT 'Expected delivery date from the vendor. Ref: Sensus AMI.',
    `expected_lifespan_years` STRING COMMENT 'Expected operational lifespan of the endpoint in years. Ref: Sensus AMI.',
    `extra_attribute_1` STRING COMMENT 'The extra attribute 1 value recorded for each endpoint procurement in the metering domain.',
    `extra_attribute_2` STRING COMMENT 'The extra attribute 2 value recorded for each endpoint procurement in the metering domain.',
    `extra_attribute_3` STRING COMMENT 'The extra attribute 3 value recorded for each endpoint procurement in the metering domain.',
    `extra_attribute_4` STRING COMMENT 'The extra attribute 4 value recorded for each endpoint procurement in the metering domain.',
    `fcc_certification_number` STRING COMMENT 'FCC certification number. Ref: Sensus AMI.',
    `firmware_version` STRING COMMENT 'Firmware version installed on endpoint. Ref: Sensus AMI.',
    `frequency_band` STRING COMMENT 'Radio frequency band used. Ref: Sensus AMI.',
    `inspection_date` TIMESTAMP COMMENT 'Date of receiving inspection. Ref: Sensus AMI.',
    `inspection_passed_flag` BOOLEAN COMMENT 'Indicates whether the received endpoints passed incoming quality inspection. Ref: Sensus AMI.',
    `inspection_status` STRING COMMENT 'Status of incoming inspection (e.g., passed, failed, pending). Ref: Sensus AMI.',
    `installation_date` TIMESTAMP COMMENT 'Date endpoint was installed. Ref: Sensus AMI.',
    `interoperability_standard` STRING COMMENT 'Interoperability standard (e.g., ANSI C12.22). Ref: Sensus AMI.',
    `ip_rating` STRING COMMENT 'Ingress protection rating (e.g., IP68). Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `lead_time_days` STRING COMMENT 'Lead time from order to delivery in days. Ref: Sensus AMI.',
    `manufacturer` STRING COMMENT 'Manufacturer of the AMI endpoint (e.g., Sensus, Itron, Badger, Neptune). Ref: Sensus AMI.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity. Ref: Sensus AMI.',
    `model_number` STRING COMMENT 'Manufacturer model number of the AMI endpoint. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-text notes regarding the endpoint procurement. Ref: Sensus AMI.',
    `operating_temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum operating temperature in Fahrenheit. Ref: Sensus AMI.',
    `operating_temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum operating temperature in Fahrenheit. Ref: Sensus AMI.',
    `order_date` TIMESTAMP COMMENT 'Order date. Ref: Sensus AMI.',
    `procurement_date` DATE COMMENT 'Date when this endpoint was procured from this vendor. Used for tracking procurement history. Ref: Sensus AMI.',
    `procurement_method` STRING COMMENT 'Procurement method (competitive bid, sole source, cooperative purchase). Ref: Sensus AMI.',
    `procurement_order_number` STRING COMMENT 'Purchase order number associated with this procurement transaction. Ref: Sensus AMI.',
    `procurement_status` STRING COMMENT 'Current status of the procurement (e.g., ordered, shipped, received, inspected, deployed). Ref: Sensus AMI.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price paid to this vendor for this specific endpoint device. Explicitly identified in detection phase relationship data. Ref: Sensus AMI.',
    `quantity_ordered` STRING COMMENT 'Number of endpoints ordered in this procurement. Ref: Sensus AMI.',
    `quantity_received` STRING COMMENT 'Number of endpoints actually received. Ref: Sensus AMI.',
    `receipt_date` TIMESTAMP COMMENT 'Date endpoints were received into inventory. Ref: Sensus AMI.',
    `receiving_date` TIMESTAMP COMMENT 'Date the endpoint units were received at the warehouse. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `rejection_reason` STRING COMMENT 'Reason for rejection if endpoints failed acceptance inspection. Ref: Sensus AMI.',
    `serial_number` STRING COMMENT 'Manufacturer serial number. Ref: Sensus AMI.',
    `storage_location` STRING COMMENT 'Warehouse location where endpoints are stored. Ref: Sensus AMI.',
    `support_contract_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of support contract. Ref: Sensus AMI.',
    `support_contract_number` STRING COMMENT 'Vendor-assigned support contract identifier for technical support escalation. Explicitly identified in detection phase relationship data. Ref: Sensus AMI.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost including installation. Ref: Sensus AMI.',
    `transmission_range_feet` DECIMAL(18,2) COMMENT 'Transmission range in feet. Ref: Sensus AMI.',
    `ul_listing_number` STRING COMMENT 'UL listing number. Ref: Sensus AMI.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost of the endpoint. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    `vendor_part_number` STRING COMMENT 'Vendor-specific part number or SKU for this endpoint model. Used for reordering and warranty claims. Explicitly identified in detection phase relationship data. Ref: Sensus AMI.',
    `warranty_end_date` DATE COMMENT 'Date when the vendor warranty coverage expires for this endpoint. Explicitly identified in detection phase relationship data. Ref: Sensus AMI.',
    `warranty_start_date` DATE COMMENT 'Date when the vendor warranty coverage begins for this endpoint. Explicitly identified in detection phase relationship data. Ref: Sensus AMI.',
    `warranty_terms` STRING COMMENT 'Warranty terms and conditions. Ref: Sensus AMI.',
    CONSTRAINT pk_endpoint_procurement PRIMARY KEY(`endpoint_procurement_id`)
) COMMENT 'This association product represents the procurement relationship between AMI endpoints and vendors. It captures vendor-specific procurement details for each endpoint device, including warranty terms, purchase pricing, vendor part numbers, and support contract information. Each record links one AMI endpoint to one vendor with attributes that exist only in the context of this procurement relationship.. Existence Justification: In water utility operations, AMI endpoints can be procured from multiple vendors over their lifecycle (original manufacturer, replacement parts distributor, warranty service provider), and each vendor supplies multiple endpoint devices across the utilitys service territory. The utility actively manages vendor-specific procurement records for warranty claims, technical support escalation, and replacement part sourcing, with each vendor relationship carrying distinct warranty terms, pricing, part numbers, and support contracts.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` (
    `meter_procurement_id` BIGINT COMMENT 'Unique identifier for this meter-vendor procurement record. Primary key. Ref: Sensus AMI.',
    `material_master_id` BIGINT COMMENT 'Link to material master record. Ref: Sensus AMI.',
    `employee_id` BIGINT COMMENT 'FK to employee who processed procurement. Ref: Sensus AMI.',
    `meter_installation_employee_id` BIGINT COMMENT 'Employee who installed the meter. Ref: Sensus AMI.',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: meter_procurement represents the procurement relationship between physical meters and vendors. Each procurement is for a specific meter size/type (e.g., 5/8-inch residential, 2-inch commercial). Addin. Ref: Sensus AMI.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to the physical meter device in the metering domain. Ref: Sensus AMI.',
    `po_line_item_id` BIGINT COMMENT 'Link to the PO line item. Ref: Sensus AMI.',
    `procurement_category_id` BIGINT COMMENT 'Procurement category. Ref: Sensus AMI.',
    `purchase_order_id` BIGINT COMMENT 'Link to the purchase order. Ref: Sensus AMI.',
    `purchase_requisition_id` BIGINT COMMENT 'Link to purchase requisition. Ref: Sensus AMI.',
    `rfq_id` BIGINT COMMENT 'Request for quotation ID. Ref: Sensus AMI.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor/supplier in the supply domain. Ref: Sensus AMI.',
    `warehouse_location_id` BIGINT COMMENT 'FK to warehouse where meter is stored. Ref: Sensus AMI.',
    `acceptance_status` STRING COMMENT 'Acceptance status after quality inspection (e.g., accepted, rejected, partial). Ref: Sensus AMI.',
    `accuracy_at_high_flow_pct` DECIMAL(18,2) COMMENT 'Accuracy percentage at high flow. Ref: Sensus AMI.',
    `accuracy_at_low_flow_pct` DECIMAL(18,2) COMMENT 'Accuracy percentage at low flow. Ref: Sensus AMI.',
    `accuracy_at_normal_flow_pct` DECIMAL(18,2) COMMENT 'Accuracy percentage at normal flow. Ref: Sensus AMI.',
    `accuracy_class` STRING COMMENT 'AWWA accuracy class',
    `accuracy_test_pass_rate` DECIMAL(18,2) COMMENT 'Percentage of sampled meters passing accuracy test. Ref: Sensus AMI.',
    `accuracy_test_sample_size` STRING COMMENT 'Number of meters sampled for accuracy testing from this lot. Ref: Sensus AMI.',
    `actual_delivery_date` TIMESTAMP COMMENT 'Actual date the meters were delivered. Ref: Sensus AMI.',
    `awwa_accuracy_class` STRING COMMENT 'AWWA accuracy classification per C700/C710/C715 standards.',
    `awwa_class` STRING COMMENT 'AWWA accuracy class designation (e.g., Class I, Class II per AWWA C700/C710).',
    `awwa_standard` STRING COMMENT 'AWWA standard the meter meets (e.g., C700, C708)',
    `batch_serial_end` STRING COMMENT 'Ending serial number of the batch of meters procured. Ref: Sensus AMI.',
    `batch_serial_start` STRING COMMENT 'Starting serial number of the batch of meters procured. Ref: Sensus AMI.',
    `bench_test_date` TIMESTAMP COMMENT 'Date of bench test. Ref: Sensus AMI.',
    `bench_test_required_flag` BOOLEAN COMMENT 'Indicates if bench testing is required before deployment. Ref: Sensus AMI.',
    `bench_test_result` STRING COMMENT 'Result of bench test (Pass/Fail). Ref: Sensus AMI.',
    `bid_evaluation_score` DECIMAL(18,2) COMMENT 'Vendor bid evaluation score. Ref: Sensus AMI.',
    `bulk_discount_pct` DECIMAL(18,2) COMMENT 'Bulk discount percentage. Ref: Sensus AMI.',
    `bulk_discount_threshold` STRING COMMENT 'Quantity threshold for bulk discount. Ref: Sensus AMI.',
    `buy_america_compliant_flag` BOOLEAN COMMENT 'Whether procurement meets Buy America requirements. Ref: Sensus AMI.',
    `cooperative_contract_number` STRING COMMENT 'Cooperative purchasing contract number if applicable. Ref: Sensus AMI.',
    `country_of_origin` STRING COMMENT 'Country of origin for meter. Ref: Sensus AMI.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this procurement record was created. Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: Sensus AMI.',
    `delivery_date` TIMESTAMP COMMENT 'Date meters were delivered. Ref: Sensus AMI.',
    `expected_accuracy_pct` DECIMAL(18,2) COMMENT 'Expected measurement accuracy percentage of the procured meters per AWWA standards.',
    `expected_delivery_date` TIMESTAMP COMMENT 'Expected delivery date from the vendor. Ref: Sensus AMI.',
    `expected_lifespan_years` STRING COMMENT 'Expected operational lifespan of the meter in years per manufacturer specification. Ref: Sensus AMI.',
    `expected_service_life_years` STRING COMMENT 'Expected service life in years. Ref: Sensus AMI.',
    `extra_attribute_1` STRING COMMENT 'The extra attribute 1 value recorded for each meter procurement in the metering domain.',
    `extra_attribute_2` STRING COMMENT 'The extra attribute 2 value recorded for each meter procurement in the metering domain.',
    `extra_attribute_3` STRING COMMENT 'The extra attribute 3 value recorded for each meter procurement in the metering domain.',
    `extra_attribute_4` STRING COMMENT 'The extra attribute 4 value recorded for each meter procurement in the metering domain.',
    `flow_direction` STRING COMMENT 'Flow direction capability (unidirectional, bidirectional). Ref: Sensus AMI.',
    `flow_range_max_gpm` DECIMAL(18,2) COMMENT 'Maximum flow rate in GPM. Ref: Sensus AMI.',
    `flow_range_min_gpm` DECIMAL(18,2) COMMENT 'Minimum flow rate in GPM. Ref: Sensus AMI.',
    `inspection_date` TIMESTAMP COMMENT 'Date the incoming quality inspection was performed. Ref: Sensus AMI.',
    `inspection_passed_flag` BOOLEAN COMMENT 'Indicates whether the received meters passed incoming accuracy testing. Ref: Sensus AMI.',
    `inspection_status` STRING COMMENT 'Status of incoming inspection (e.g., passed, failed, pending). Ref: Sensus AMI.',
    `installation_date` TIMESTAMP COMMENT 'Date meter was installed. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `lead_free_certified_flag` BOOLEAN COMMENT 'Whether meter is lead-free certified. Ref: Sensus AMI.',
    `lead_time_days` BIGINT COMMENT 'Standard lead time in days for this vendor to deliver this meter model. Used for procurement planning and emergency replacement sourcing. Ref: Sensus AMI.',
    `lot_number` STRING COMMENT 'Manufacturer lot number for traceability. Ref: Sensus AMI.',
    `manufacturer` STRING COMMENT 'Meter manufacturer (e.g., Sensus, Badger Meter, Neptune, Kamstrup, Itron). Ref: Sensus AMI.',
    `material_body` STRING COMMENT 'Material of meter body (brass, bronze, composite). Ref: Sensus AMI.',
    `material_internal` STRING COMMENT 'Material of internal components. Ref: Sensus AMI.',
    `meter_manufacturer` STRING COMMENT 'Manufacturer of the meter. Ref: Sensus AMI.',
    `meter_model` STRING COMMENT 'Model number of the meter. Ref: Sensus AMI.',
    `meter_register_type` STRING COMMENT 'Type of meter register (analog, digital, encoder). Ref: Sensus AMI.',
    `meter_serial_number` STRING COMMENT 'Serial number of the meter. Ref: Sensus AMI.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Size of the meter in inches. Ref: Sensus AMI.',
    `meter_technology` STRING COMMENT 'Metering technology (e.g., positive displacement, ultrasonic, electromagnetic). Ref: Sensus AMI.',
    `meter_type` STRING COMMENT 'Type of meter (e.g., positive displacement, turbine, ultrasonic). Ref: Sensus AMI.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity. Ref: Sensus AMI.',
    `model_number` STRING COMMENT 'Manufacturer model number of the meter. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free-text notes regarding the meter procurement. Ref: Sensus AMI.',
    `nsf_61_certified_flag` BOOLEAN COMMENT 'Whether meter is NSF 61 certified. Ref: Sensus AMI.',
    `nsf_certification` STRING COMMENT 'NSF certification number. Ref: Sensus AMI.',
    `order_date` TIMESTAMP COMMENT 'Order date. Ref: Sensus AMI.',
    `pressure_loss_psi` DECIMAL(18,2) COMMENT 'Pressure loss across meter in PSI. Ref: Sensus AMI.',
    `pressure_rating_psi` STRING COMMENT 'Pressure rating in PSI. Ref: Sensus AMI.',
    `procurement_method` STRING COMMENT 'Procurement method (competitive bid, sole source, cooperative purchase). Ref: Sensus AMI.',
    `procurement_order_number` STRING COMMENT 'Internal procurement order reference number. Ref: Sensus AMI.',
    `procurement_status` STRING COMMENT 'Current status of this meter-vendor procurement relationship: Active (current source), Discontinued (no longer available), Preferred (primary supplier), Backup (secondary source), Under_Review (being evaluated). Ref: Sensus AMI.',
    `purchase_date` DATE COMMENT 'The date this specific meter was purchased from this vendor. Used for warranty period calculation and procurement history tracking. Ref: Sensus AMI.',
    `purchase_price` DECIMAL(18,2) COMMENT 'The unit price paid to this vendor for this meter at time of purchase. Enables cost analysis and vendor price comparison for competitive bidding.',
    `quantity_ordered` STRING COMMENT 'Quantity of meters ordered. Ref: Sensus AMI.',
    `quantity_received` STRING COMMENT 'Quantity of meters received. Ref: Sensus AMI.',
    `receipt_date` TIMESTAMP COMMENT 'Date meters were received into inventory. Ref: Sensus AMI.',
    `receiving_date` TIMESTAMP COMMENT 'Date the meters were received at the warehouse or staging area. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `serial_number` STRING COMMENT 'Manufacturer serial number. Ref: Sensus AMI.',
    `storage_location` STRING COMMENT 'Warehouse location where meters are stored. Ref: Sensus AMI.',
    `temperature_rating_f` STRING COMMENT 'Temperature rating in Fahrenheit. Ref: Sensus AMI.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost including installation. Ref: Sensus AMI.',
    `total_procurement_cost` DECIMAL(18,2) COMMENT 'Total cost of the meter procurement including all units. Ref: Sensus AMI.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost of the meter. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: Sensus AMI.',
    `vendor_part_number` STRING COMMENT 'The vendor-specific part number or SKU for this meter model as cataloged by this particular vendor. Critical for procurement orders and warranty claims. Ref: Sensus AMI.',
    `warranty_end_date` DATE COMMENT 'The date warranty coverage expires for this meter from this vendor. Critical for warranty claim eligibility and maintenance planning. Ref: Sensus AMI.',
    `warranty_start_date` DATE COMMENT 'The date warranty coverage begins for this meter from this vendor. May differ from purchase date based on installation or activation terms. Ref: Sensus AMI.',
    `warranty_terms` STRING COMMENT 'Warranty terms and conditions. Ref: Sensus AMI.',
    CONSTRAINT pk_meter_procurement PRIMARY KEY(`meter_procurement_id`)
) COMMENT 'This association product represents the procurement relationship between physical meter devices and their suppliers. It captures vendor-specific procurement terms, pricing, warranty coverage, and part numbers for each meter-vendor combination. Each record links one meter to one vendor with attributes that exist only in the context of this procurement relationship, enabling competitive bidding analysis, warranty claim processing, and multi-source supply chain management.. Existence Justification: Water utilities procure the same meter models from multiple approved vendors through competitive bidding, regional supplier networks, and backup sourcing strategies. Each meter-vendor combination has distinct procurement terms including vendor-specific part numbers, negotiated pricing, warranty coverage periods, and lead times. The utility actively manages these procurement relationships to optimize costs, ensure supply chain resilience, and process warranty claims.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` (
    `alert_rule_id` BIGINT COMMENT 'Primary key for alert_rule. Ref: Sensus AMI.',
    `escalation_alert_rule_id` BIGINT COMMENT 'Self-referencing FK on alert_rule (escalation_alert_rule_id). Ref: Sensus AMI.',
    `condition_operator` STRING COMMENT 'Comparison operator used in the rule condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert rule record was created. Ref: Sensus AMI.',
    `alert_rule_description` STRING COMMENT 'Detailed description of the purpose and logic of the alert rule. Ref: Sensus AMI.',
    `effective_from` DATE COMMENT 'Date from which the alert rule becomes effective. Ref: Sensus AMI.',
    `effective_until` DATE COMMENT 'Date after which the alert rule is no longer effective (nullable). Ref: Sensus AMI.',
    `enabled_flag` BOOLEAN COMMENT 'Indicates whether the alert rule is active. Ref: Sensus AMI.',
    `escalation_level` STRING COMMENT 'Numeric level indicating escalation hierarchy for the alert. Ref: Sensus AMI.',
    `evaluation_frequency_minutes` STRING COMMENT 'How often the rule is evaluated, in minutes. Ref: Sensus AMI.',
    `evaluation_window_hours` STRING COMMENT 'Evaluation window hours. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Is active. Ref: Sensus AMI.',
    `is_system_rule` BOOLEAN COMMENT 'Indicates if the rule is a built-in system rule. Ref: Sensus AMI.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of the rule. Ref: Sensus AMI.',
    `last_triggered_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule last generated an alert. Ref: Sensus AMI.',
    `metric_name` STRING COMMENT 'Name of the metric or measurement the rule evaluates (e.g., flow_rate, pressure). Ref: Sensus AMI.',
    `alert_rule_name` STRING COMMENT 'Descriptive name of the alert rule. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Notes. Ref: Sensus AMI.',
    `notification_channel` STRING COMMENT 'Channel(s) used to deliver alert notifications. Ref: Sensus AMI.',
    `owner` STRING COMMENT 'Identifier of the person or team responsible for the rule. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `rule_category` STRING COMMENT 'High-level category of the alert rule. Ref: Sensus AMI.',
    `rule_name` STRING COMMENT 'Rule name. Ref: Sensus AMI.',
    `rule_type` STRING COMMENT 'Specifies the type of logic the rule uses. Ref: Sensus AMI.',
    `severity` STRING COMMENT 'Severity level assigned to alerts generated by this rule. Ref: Sensus AMI.',
    `alert_rule_status` STRING COMMENT 'Current lifecycle status of the alert rule. Ref: Sensus AMI.',
    `tags` STRING COMMENT 'Optional free-form tags for categorization. Ref: Sensus AMI.',
    `threshold_unit` STRING COMMENT 'Threshold unit. Ref: Sensus AMI.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers the alert. Ref: Sensus AMI.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the threshold value. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert rule. Ref: Sensus AMI.',
    CONSTRAINT pk_alert_rule PRIMARY KEY(`alert_rule_id`)
) COMMENT 'Master reference table for alert_rule. Referenced by alert_rule_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` (
    `validation_rule_id` BIGINT COMMENT 'Primary key for validation_rule. Ref: Sensus AMI.',
    `parent_validation_rule_id` BIGINT COMMENT 'Self-referencing FK on validation_rule (parent_validation_rule_id). Ref: Sensus AMI.',
    `action_on_fail` STRING COMMENT 'Action on fail. Ref: Sensus AMI.',
    `applicable_entity` STRING COMMENT 'Entity or domain to which the rule applies. Ref: Sensus AMI.',
    `condition_expression` STRING COMMENT 'Logical expression evaluated to enforce the rule (e.g., SQL‑like or DSL). Ref: Sensus AMI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created. Ref: Sensus AMI.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective. Ref: Sensus AMI.',
    `effective_until` DATE COMMENT 'Date when the rule expires (null if indefinite). Ref: Sensus AMI.',
    `enabled_flag` BOOLEAN COMMENT 'Enabled flag. Ref: Sensus AMI.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the rule is currently active. Ref: Sensus AMI.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the rule. Ref: Sensus AMI.',
    `record_status` STRING COMMENT 'Record status. Ref: Sensus AMI.',
    `rule_category` STRING COMMENT 'Broad category indicating the type of rule. Ref: Sensus AMI.',
    `rule_description` STRING COMMENT 'Detailed description of the rule logic and purpose. Ref: Sensus AMI.',
    `rule_name` STRING COMMENT 'Human‑readable name of the validation rule. Ref: Sensus AMI.',
    `rule_type` STRING COMMENT 'Rule type. Ref: Sensus AMI.',
    `severity` STRING COMMENT 'Severity level indicating impact of rule violation. Ref: Sensus AMI.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value. Ref: Sensus AMI.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold used by the rule when applicable. Ref: Sensus AMI.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the rule. Ref: Sensus AMI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record. Ref: Sensus AMI.',
    `validation_logic` STRING COMMENT 'Validation logic. Ref: Sensus AMI.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the rule. Ref: Sensus AMI.',
    CONSTRAINT pk_validation_rule PRIMARY KEY(`validation_rule_id`)
) COMMENT 'Master reference table for validation_rule. Referenced by validation_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_ami_network_collector_id` FOREIGN KEY (`ami_network_collector_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_network_collector`(`ami_network_collector_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ADD CONSTRAINT `fk_metering_read_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_ami_network_collector_id` FOREIGN KEY (`ami_network_collector_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_network_collector`(`ami_network_collector_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_leak_ami_endpoint_id` FOREIGN KEY (`leak_ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_alert_rule_id` FOREIGN KEY (`alert_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`alert_rule`(`alert_rule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_high_ami_endpoint_id` FOREIGN KEY (`high_ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_new_meter_id` FOREIGN KEY (`replacement_new_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_new_meter_installation_id` FOREIGN KEY (`replacement_new_meter_installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_new_metering_meter_id` FOREIGN KEY (`replacement_new_metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_old_metering_meter_id` FOREIGN KEY (`replacement_old_metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_program_id` FOREIGN KEY (`replacement_program_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`replacement_program`(`replacement_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_metering_prv_installation_id` FOREIGN KEY (`metering_prv_installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_metering_zone_meter_installation_id` FOREIGN KEY (`metering_zone_meter_installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`validation_rule`(`validation_rule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ADD CONSTRAINT `fk_metering_meter_size_type_primary_replacement_meter_size_type_id` FOREIGN KEY (`primary_replacement_meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ADD CONSTRAINT `fk_metering_alert_rule_escalation_alert_rule_id` FOREIGN KEY (`escalation_alert_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`alert_rule`(`alert_rule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ADD CONSTRAINT `fk_metering_validation_rule_parent_validation_rule_id` FOREIGN KEY (`parent_validation_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`validation_rule`(`validation_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_pair' = 'asset.asset_meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_ssot_master_for' = 'asset.asset_meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_installed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_installed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `install_date` SET TAGS ('dbx_business_glossary_term' = 'Install Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `install_reason` SET TAGS ('dbx_business_glossary_term' = 'Install Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_number` SET TAGS ('dbx_business_glossary_term' = 'Installation Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installer_notes` SET TAGS ('dbx_business_glossary_term' = 'Installer Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Is Accessible');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `lock_reason` SET TAGS ('dbx_business_glossary_term' = 'Lock Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_box_size` SET TAGS ('dbx_business_glossary_term' = 'Meter Box Size');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_orientation` SET TAGS ('dbx_business_glossary_term' = 'Meter Orientation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_pit_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Pit Depth');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_network_collector_id` SET TAGS ('dbx_business_glossary_term' = 'Network Collector');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_network_collector_id` SET TAGS ('dbx_business_glossary_term' = 'Network Collector');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accrual GL');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_MVM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consumption Profile ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue GL');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `adjustment_amount_gallons` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `average_daily_usage_gpd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Handoff');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Consumption Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_tier` SET TAGS ('dbx_business_glossary_term' = 'Consumption Tier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Consumption Variance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `estimated_read_reason` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `high_usage_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `interval_data_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Interval Data Available');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `meter_technology` SET TAGS ('dbx_business_glossary_term' = 'Meter Technology');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `minimum_night_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `nrw_contribution_gallons` SET TAGS ('dbx_business_glossary_term' = 'NRW Contribution');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `peak_day_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Peak Day Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `peak_day_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Day Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `prior_period_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `prior_year_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `seasonal_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Factor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `total_consumption_ccf` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption CCF');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `total_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `weather_normalized_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Weather Normalized Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_detection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Event Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `primary_leak_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `primary_leak_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `primary_leak_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `regulatory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Severity Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `billing_adjustment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Eligibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Confidence Score');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `continuous_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Flow Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `detection_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Algorithm Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'continuous_flow_threshold|minimum_night_flow_anomaly|ami_algorithm|acoustic_sensor|manual_inspection|customer_report');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `estimated_leak_volume_gallons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Estimated Leak Volume in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `estimated_total_loss_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Water Loss in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `flow_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Flow Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Leak Investigation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Leak Duration in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_location_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_business_glossary_term' = 'Leak Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_value_regex' = 'detected|confirmed|under_investigation|resolved|false_positive|customer_notified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_type` SET TAGS ('dbx_business_glossary_term' = 'Leak Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `minimum_night_flow_anomaly_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (MNF) Anomaly Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone_call|postal_mail|customer_portal|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `alert_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Rule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `high_ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Device Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_cites' = 'ISO');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_program_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_program_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `age_threshold_years` SET TAGS ('dbx_business_glossary_term' = 'Age Threshold Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `budget_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `completed_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `completed_replacement_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `cost_per_replacement` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Replacement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `max_meter_age_years` SET TAGS ('dbx_business_glossary_term' = 'Max Meter Age');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `min_accuracy_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Min Accuracy Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `nrw_reduction_target_pct` SET TAGS ('dbx_business_glossary_term' = 'NRW Reduction Target');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `program_budget` SET TAGS ('dbx_business_glossary_term' = 'Program Budget');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_criteria` SET TAGS ('dbx_business_glossary_term' = 'Replacement Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `spent_to_date` SET TAGS ('dbx_business_glossary_term' = 'Spent To Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `spent_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent to Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `target_age_years` SET TAGS ('dbx_business_glossary_term' = 'Target Age Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `target_replacement_count` SET TAGS ('dbx_business_glossary_term' = 'Target Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `total_meters_replaced` SET TAGS ('dbx_business_glossary_term' = 'Total Meters Replaced');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_old_metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `cost_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `new_register_reading` SET TAGS ('dbx_business_glossary_term' = 'New Register Reading');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `old_register_reading` SET TAGS ('dbx_business_glossary_term' = 'Old Register Reading');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Zone Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_prv_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Reducing Valve (PRV) Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_zone_meter_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `actual_nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `average_age_of_mains_years` SET TAGS ('dbx_business_glossary_term' = 'Average Age of Mains (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `average_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'DMA Decommissioned Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_description` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_name` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_type` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|mixed_use|rural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'DMA Established Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `hydraulic_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `infrastructure_leakage_index` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Leakage Index (ILI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `isolation_valve_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Valve Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `last_leak_detection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leak Detection Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `leak_detection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_status` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction|maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `minimum_night_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DMA Zone Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `predominant_pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Predominant Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `responsible_operations_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operations Team');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `scada_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitoring Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `scada_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `service_connection_count` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `target_nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `total_pipe_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Pipe Length (Miles)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `ufw_gallons_per_connection_per_day` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted-for Water (UFW) Gallons per Connection per Day');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_duplicate' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_pair' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_canonical_ref' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_ssot_dependent' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_nrw_water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for metering_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_calculated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_calculated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_dma_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Dma Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_prepared_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_prepared_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_prepared_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Nrw Loss General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_canonical_distribution_nrw_water_balance_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_distribution_nrw_water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Link to canonical SSOT record in distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_distribution_nrw_water_balance_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_distribution_nrw_water_balance_id` SET TAGS ('dbx_ssot_link' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `average_pressure_m` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure M');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `awwa_m36_compliant` SET TAGS ('dbx_business_glossary_term' = 'Awwa M36 Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `carl_l_per_conn_per_day` SET TAGS ('dbx_business_glossary_term' = 'Carl L Per Conn Per Day');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `data_handling_errors_ml` SET TAGS ('dbx_business_glossary_term' = 'Data Handling Errors Ml');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ili_index` SET TAGS ('dbx_business_glossary_term' = 'Ili Index');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `meter_under_registration_ml` SET TAGS ('dbx_business_glossary_term' = 'Meter Under Registration ML');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `nrw_cost_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `number_of_service_connections` SET TAGS ('dbx_business_glossary_term' = 'Number Of Service Connections');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ssot_role` SET TAGS ('dbx_business_glossary_term' = 'Ssot Role');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'metering.metering_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `uarl_l_per_conn_per_day` SET TAGS ('dbx_business_glossary_term' = 'Uarl L Per Conn Per Day');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `unavoidable_annual_real_losses_ml` SET TAGS ('dbx_business_glossary_term' = 'UARL ML');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_investigated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_investigated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `estimated_loss_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `estimated_loss_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Volume Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `estimated_unbilled_consumption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unbilled Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `estimated_volume_loss_gal` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume Loss');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `field_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Field Visit Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `is_confirmed` SET TAGS ('dbx_boolean' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `is_confirmed_theft` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Theft');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `is_criminal_referral` SET TAGS ('dbx_business_glossary_term' = 'Is Criminal Referral');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_number` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_type` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `read_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Read Exception ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `validation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `battery_status` SET TAGS ('dbx_business_glossary_term' = 'Battery Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `battery_status` SET TAGS ('dbx_value_regex' = 'normal|low|critical|failed');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `billing_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Hold Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `communication_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Communication Failure Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `corrected_read_value` SET TAGS ('dbx_business_glossary_term' = 'Corrected Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `current_read_value` SET TAGS ('dbx_business_glossary_term' = 'Current Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `estimated_read_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_source` SET TAGS ('dbx_business_glossary_term' = 'Exception Source');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_source` SET TAGS ('dbx_value_regex' = 'ami_system|manual_read|validation_rule|customer_report|field_inspection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|escalated|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'no_read|high_read|low_read|reverse_read|estimated_read|communication_failure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `expected_consumption` SET TAGS ('dbx_business_glossary_term' = 'Expected Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `field_visit_required` SET TAGS ('dbx_business_glossary_term' = 'Field Visit Required');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `prior_read_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `register_overflow_flag` SET TAGS ('dbx_business_glossary_term' = 'Register Overflow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 're_read|estimate_accepted|read_corrected|meter_replaced|field_visit_scheduled|no_action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolved_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolved Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'consumption_reads');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'DMA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_assigned_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_assigned_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_assigned_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_canonical' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_duplicate_of' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_canonical_ref' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_ssot_dependent' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_received_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_received_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_resolved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_resolved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_canonical_customer_complaint_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `accuracy_test_result` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `bill_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Bill Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `customer_satisfied` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfied');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `investigation_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `is_escalated` SET TAGS ('dbx_boolean' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `is_regulatory_complaint` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_customer_complaint_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `regulatory_complaint_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Complaint Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_ssot_discriminator' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_entity_type` SET TAGS ('dbx_canonical' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_role` SET TAGS ('dbx_business_glossary_term' = 'Ssot Role');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'metering.metering_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `meter_field_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Field Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_antenna_condition` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Antenna Condition');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_antenna_condition` SET TAGS ('dbx_value_regex' = 'intact|damaged|missing|corroded');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Battery Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_endpoint_condition` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Condition');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_endpoint_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|missing|damaged');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `ami_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Signal Strength (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `findings` SET TAGS ('dbx_business_glossary_term' = 'Findings');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Accuracy (Meters)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `leak_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `meter_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Meter Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `meter_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `obstruction_description` SET TAGS ('dbx_business_glossary_term' = 'Obstruction Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `obstruction_noted_flag` SET TAGS ('dbx_business_glossary_term' = 'Obstruction Noted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_debris_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Pit Debris Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_vault_condition` SET TAGS ('dbx_business_glossary_term' = 'Pit Vault Condition');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_vault_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|hazardous');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_water_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Pit Water Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_readable_flag` SET TAGS ('dbx_business_glossary_term' = 'Register Readable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_reading` SET TAGS ('dbx_business_glossary_term' = 'Register Reading');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Register Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `seal_number_verified` SET TAGS ('dbx_business_glossary_term' = 'Seal Number Verified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `tamper_description` SET TAGS ('dbx_business_glossary_term' = 'Tamper Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `tamper_evidence_flag` SET TAGS ('dbx_business_glossary_term' = 'Tamper Evidence Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ami_network_collector_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Network Collector ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ami_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `backhaul_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Backhaul Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `backhaul_connection_type` SET TAGS ('dbx_value_regex' = 'cellular|fiber|dsl|cable|satellite|microwave');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `backhaul_provider` SET TAGS ('dbx_business_glossary_term' = 'Backhaul Provider');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `battery_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Battery Backup Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_identifier` SET TAGS ('dbx_business_glossary_term' = 'Collector Business Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Collector Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_type` SET TAGS ('dbx_business_glossary_term' = 'Collector Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_type` SET TAGS ('dbx_value_regex' = 'fixed_base_station|mobile_collector|repeater|tower_mounted_receiver|gateway|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'flexnet|mesh|point_to_multipoint|cellular|lora|zigbee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `coverage_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Coverage Radius in Miles');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `endpoint_capacity` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `endpoint_count` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Frequency in Megahertz (MHz)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Health Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'healthy|degraded|critical|offline|unknown');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|testing|failed');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `power_source` SET TAGS ('dbx_business_glossary_term' = 'Power Source');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `power_source` SET TAGS ('dbx_value_regex' = 'ac_mains|solar|battery|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels Milliwatt (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_subdomain' = 'meter_assets');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `primary_replacement_meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Meter Size Type ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_low_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Low Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `accuracy_percentage_normal_flow` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage at Normal Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `ami_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Compatible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `amr_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Meter Reading (AMR) Compatible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost in United States Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `average_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Standard Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `awwa_standard_code` SET TAGS ('dbx_value_regex' = '^C[0-9]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression|saddle|direct_bury');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Display Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `flange_standard` SET TAGS ('dbx_business_glossary_term' = 'Flange Standard Specification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Installation Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_business_glossary_term' = 'Installation Orientation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|any');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `lead_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_continuous_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Max Flow Rate Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_registered_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Registered Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_intermittent_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intermittent Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iv');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_technology` SET TAGS ('dbx_business_glossary_term' = 'Meter Technology');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `min_detectable_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `min_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Min Flow Rate Gpm');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `nominal_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Nominal Size Inches');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `nsf_61_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF 61 Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_loss_at_max_flow_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Loss at Maximum Flow in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Register Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Register Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|encoder');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_description` SET TAGS ('dbx_business_glossary_term' = 'Size Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Inches');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_millimeters` SET TAGS ('dbx_business_glossary_term' = 'Meter Size in Millimeters');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_downstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Downstream Requirement (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `straight_pipe_upstream_inches` SET TAGS ('dbx_business_glossary_term' = 'Straight Pipe Upstream Requirement (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Rating (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `temperature_rating_fahrenheit_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Rating (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `testing_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'Testing Frequency (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `thread_standard` SET TAGS ('dbx_business_glossary_term' = 'Thread Standard Specification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_application` SET TAGS ('dbx_business_glossary_term' = 'Typical Application');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Typical Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|municipal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `typical_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Typical Service Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_association_edges' = 'metering.ami_endpoint,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_data_depth' = 'expanded');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_review' = 'thin_product_expansion');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Endpoint Procurement Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Ami Endpoint Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_installation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installed By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_installation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_installation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line Item');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `batch_serial_end` SET TAGS ('dbx_business_glossary_term' = 'Batch Serial End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `batch_serial_range_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Range End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `batch_serial_range_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Range Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `batch_serial_start` SET TAGS ('dbx_business_glossary_term' = 'Batch Serial Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `battery_type` SET TAGS ('dbx_business_glossary_term' = 'Battery Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Technology Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `expected_battery_life_years` SET TAGS ('dbx_business_glossary_term' = 'Battery Life');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `expected_lifespan_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Lifespan Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `inspection_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `procurement_order_number` SET TAGS ('dbx_business_glossary_term' = 'Procurement Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `support_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Expiration');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `support_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_subdomain' = 'field_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_association_edges' = 'metering.metering_meter,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_data_depth' = 'expanded');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_review' = 'thin_product_expansion');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_installation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installed By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_installation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_installation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement - Metering Metering Meter Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line Item');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `accuracy_test_pass_rate` SET TAGS ('dbx_business_glossary_term' = 'Test Pass Rate');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `accuracy_test_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Size');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `awwa_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'AWWA Accuracy Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `awwa_class` SET TAGS ('dbx_business_glossary_term' = 'AWWA Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `awwa_standard` SET TAGS ('dbx_business_glossary_term' = 'AWWA Standard');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `batch_serial_end` SET TAGS ('dbx_business_glossary_term' = 'Batch Serial End');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `batch_serial_start` SET TAGS ('dbx_business_glossary_term' = 'Batch Serial Start');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `bench_test_date` SET TAGS ('dbx_business_glossary_term' = 'Bench Test Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `bench_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bench Test Required');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `bench_test_result` SET TAGS ('dbx_business_glossary_term' = 'Bench Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `expected_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Accuracy Percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `expected_lifespan_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Lifespan Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Service Life');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `inspection_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_technology` SET TAGS ('dbx_business_glossary_term' = 'Meter Technology');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `nsf_certification` SET TAGS ('dbx_business_glossary_term' = 'NSF Certification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `procurement_order_number` SET TAGS ('dbx_business_glossary_term' = 'Procurement Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `total_procurement_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Procurement Cost');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Rule Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `escalation_alert_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Alert Rule Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `escalation_alert_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `condition_operator` SET TAGS ('dbx_business_glossary_term' = 'Condition Operator');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `evaluation_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Frequency Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `evaluation_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Window Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `is_system_rule` SET TAGS ('dbx_business_glossary_term' = 'Is System Rule');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `last_triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Triggered Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_system_of_record' = 'Sensus_AMI');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_metering_domain_managed' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `validation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `parent_validation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Validation Rule Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `parent_validation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `action_on_fail` SET TAGS ('dbx_business_glossary_term' = 'Action On Fail');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `applicable_entity` SET TAGS ('dbx_business_glossary_term' = 'Applicable Entity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `validation_logic` SET TAGS ('dbx_business_glossary_term' = 'Validation Logic');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
