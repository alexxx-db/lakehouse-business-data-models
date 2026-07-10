-- Schema for Domain: metering | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` (
    `metering_meter_id` BIGINT COMMENT 'Primary key for meter',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Water meters are capital assets requiring fixed asset accounting for depreciation, asset retirement obligations, and GASB compliance. Meter populations represent significant utility plant investment r',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each installed meter corresponds to a material master record for procurement, inventory management, warranty tracking, and cost allocation. Procurement teams order meters by material number; warehouse',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter size and type combinations are standardized configurations defined in the meter_size_type reference table. The metering_meter table currently stores meter_size_inches and meter_type as denormali',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Meters are capital assets requiring lifecycle management, depreciation tracking, condition assessment, and regulatory compliance (GASB 34). Water utilities track meters in asset registries for replace',
    `asset_meter_id` BIGINT COMMENT '',
    CONSTRAINT pk_metering_meter PRIMARY KEY(`metering_meter_id`)
) COMMENT 'Master inventory record for every physical meter device deployed across the water and wastewater service territory. Captures meter make, model, size, type (AMI/AMR/manual), serial number, manufacturer, installation date, current status, register type, pulse output factor, maximum flow rate (GPM), meter generation, and communication module type. Includes bulk/compound meters, fire service meters, and all residential/commercial/industrial meter classes. Serves as the authoritative SSOT for meter device identity and specifications within the metering domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key for installation',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Meter installations performed as part of CIP projects (main replacements, AMI deployments, system expansions) require project linkage for capital cost allocation, asset capitalization, project closeou',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: An installation represents the deployment of a physical meter device at a service location. The installation MUST reference which specific meter (from meter inventory) is installed. This is the core r',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Tracks the physical installation of a meter at a service location, linking a specific meter device to a service address and customer account. Records installation date, installer ID, work order reference, meter position (pit, vault, curb box), setter size, service line material, lock/seal number, initial register reading at installation, and removal date when replaced. Maintains the full history of which meter served which location over time, supporting NRW analysis and billing continuity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI/AMR communication endpoint device. Primary key for the endpoint registry.',
    `ami_network_collector_id` BIGINT COMMENT 'Reference to the FlexNet collector or gateway device that receives transmissions from this endpoint. Part of the AMI network infrastructure.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: AMI endpoint deployments are capital projects requiring tracking for warranty management, project performance metrics, capital cost allocation, and grant reporting. Utilities must trace each endpoint',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area that this endpoint belongs to. Used for water loss analysis and pressure zone management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: AMI endpoints are procured materials with manufacturer part numbers, tracked in inventory for deployment, warranty management, and spare parts planning. Procurement orders endpoints by material number',
    `metering_meter_id` BIGINT COMMENT 'Reference to the physical water meter that this AMI endpoint is attached to. An endpoint may be replaced independently of the meter.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: AMI endpoints are capital assets with acquisition cost, useful life, warranty, and cybersecurity compliance requirements. Utilities track these separately from meters for technology refresh cycles, FC',
    `battery_expected_life_years` DECIMAL(18,2) COMMENT 'Manufacturer-specified expected battery life in years under normal operating conditions. Typically 15-20 years for AMI endpoints.',
    `battery_install_date` DATE COMMENT 'Date when the battery was installed or last replaced in the endpoint device. Used to calculate expected battery life remaining.',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Current battery charge level as a percentage. Critical for battery-powered endpoints to schedule replacement before failure.',
    `commissioning_date` DATE COMMENT 'Date when the endpoint was successfully commissioned and began transmitting data to the AMI system. May differ from installation date.',
    `communication_frequency_minutes` STRING COMMENT 'Configured interval in minutes between endpoint transmissions. Typical values: 15, 30, 60 minutes for hourly reads; 1440 for daily reads.',
    `communication_protocol` STRING COMMENT 'Network communication protocol used by the endpoint. RF (Radio Frequency) for FlexNet, Cellular for 4G/5G, LoRaWAN for low-power wide-area, NB-IoT for narrowband cellular.. Valid values are `RF|Cellular|LoRaWAN|NB-IoT|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was first created in the system. Used for audit trail and data lineage.',
    `data_retention_days` STRING COMMENT 'Number of days of interval consumption data stored locally on the endpoint device before being overwritten. Typically 35-45 days.',
    `decommission_date` DATE COMMENT 'Date when the endpoint was removed from service or deactivated. Null for active endpoints.',
    `decommission_reason` STRING COMMENT 'Reason for endpoint decommissioning (e.g., meter replacement, device failure, service disconnection, upgrade to new technology).',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used to secure communications between endpoint and collector. AES-128 or AES-256 for encrypted devices.. Valid values are `AES-128|AES-256|None`',
    `encryption_key_version` STRING COMMENT 'Version identifier for the encryption key currently provisioned on the endpoint. Used for secure communication and key rotation management.',
    `endpoint_serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the AMI/AMR endpoint device. Used for warranty tracking and device identification.',
    `endpoint_type` STRING COMMENT 'Type of AMI/AMR communication device. ERT (Encoder Receiver Transmitter) for drive-by reading, MXU (Meter Transmit Unit) for fixed network, iPerl for integrated smart meter, Orion for cellular endpoint, Ally for water meter module.. Valid values are `ERT|MXU|iPerl|Orion|Ally|Other`',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the endpoint device. Critical for security patches and feature updates.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the endpoint installation location in decimal degrees. Used for GIS mapping and network planning.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the endpoint installation location in decimal degrees. Used for GIS mapping and network planning.',
    `installation_date` DATE COMMENT 'Date when the AMI endpoint was installed and activated in the field. Used for warranty tracking and lifecycle management.',
    `installation_technician` STRING COMMENT 'Name or identifier of the technician who installed the endpoint device. Used for quality tracking and accountability.',
    `ip_address` STRING COMMENT 'IP address assigned to the endpoint device for cellular or IP-based communication protocols. Null for RF-only devices.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful communication received from this endpoint. Used to identify non-communicating devices.',
    `last_firmware_update_date` DATE COMMENT 'Date when the endpoint firmware was last updated. Critical for security patch tracking and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was last updated. Used for change tracking and audit trail.',
    `leak_alert_threshold_gpm` DECIMAL(18,2) COMMENT 'Continuous flow threshold in gallons per minute that triggers a leak alert. Typically 0.01 to 0.5 GPM for residential meters.',
    `leak_detection_enabled_flag` BOOLEAN COMMENT 'Indicates whether continuous leak detection monitoring is enabled on this endpoint. True if enabled, False if disabled.',
    `mac_address` STRING COMMENT 'Unique hardware address assigned to the endpoint network interface. Used for device authentication and network routing.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `network_node_code` STRING COMMENT 'Identifier for the network node or collector that this endpoint communicates with in the AMI network topology.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical information about the endpoint device.',
    `operational_status` STRING COMMENT 'Current operational status of the endpoint device. Active indicates normal operation, Failed indicates communication or device failure.. Valid values are `Active|Inactive|Suspended|Failed|Maintenance|Decommissioned`',
    `read_interval_seconds` STRING COMMENT 'Interval in seconds at which the endpoint records consumption data internally. Typical values: 900 (15 min), 3600 (hourly), 86400 (daily).',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Indicates whether reverse flow has been detected by the endpoint. True if reverse flow detected, False otherwise. May indicate backflow or meter installation error.',
    `signal_quality_indicator` STRING COMMENT 'Qualitative assessment of communication signal quality. Derived from signal strength and packet success rate.. Valid values are `Excellent|Good|Fair|Poor|No Signal`',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Most recent radio signal strength measurement in dBm. Indicates communication quality between endpoint and collector. Typical range -110 to -50 dBm.',
    `tamper_detected_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent tamper event was detected by the endpoint. Null if no tamper has been detected.',
    `tamper_status` STRING COMMENT 'Current tamper detection status reported by the endpoint. Alerts to potential theft, fraud, or unauthorized access.. Valid values are `Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the endpoint device expires. Used for replacement planning and cost recovery.',
    CONSTRAINT pk_ami_endpoint PRIMARY KEY(`ami_endpoint_id`)
) COMMENT 'Master record for each AMI/AMR communication endpoint device (encoder/receiver/transmitter unit) associated with a meter, and the fixed-network collector infrastructure (base stations, repeaters, mobile collectors) that enables automated reading across the service territory. Captures endpoint serial number, device type, firmware version, network node assignment, signal strength, battery level, last communication timestamp, encryption key version, tamper status, collector assignment, collector location, coverage area, and backhaul connection type. Distinct from the meter itself — one meter may have its endpoint replaced independently.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read` (
    `read_id` BIGINT COMMENT 'Primary key for read',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: For AMI/AMR reads, the read is captured by a specific AMI endpoint device. This links the read event to the communication endpoint that transmitted the data. Manual reads would have NULL ami_endpoint_',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A meter read is captured for a specific meter installation (a meter deployed at a location), not just an abstract meter device. Reads are tied to the installation context (location, service point). Th',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: Meter reads are collected along defined read routes (for manual, walk-by, or drive-by reading operations). Each read should reference which route it was collected on for operational tracking and route',
    CONSTRAINT pk_read PRIMARY KEY(`read_id`)
) COMMENT 'Individual meter reading record capturing the register value at a specific point in time for a given meter installation. Stores read date and time, read value (gallons or CCF), read type (AMI automated, AMR drive-by, manual field read, estimated), read source system, reader employee ID (for manual reads), read quality flag, exception code, and whether the read was used for billing. The authoritative transactional record for all meter reads feeding the Oracle CC&B billing cycle.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` (
    `interval_consumption_id` BIGINT COMMENT 'Unique identifier for each interval consumption record. Primary key for the interval consumption data product.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI endpoint device that transmitted this interval data. Corresponds to the Sensus FlexNet endpoint serial number or device identifier.',
    `ami_network_collector_id` BIGINT COMMENT 'Identifier for the AMI collector (gateway) that received this interval reading from the endpoint. Used for network topology analysis and troubleshooting.',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which this interval occurred. Used to aggregate interval data for billing purposes and time-of-use rate calculations.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where this meter is located. Used for Non-Revenue Water (NRW) analysis, pressure zone management, and distribution network optimization.',
    `installation_id` BIGINT COMMENT 'Reference to the specific meter installation that generated this interval reading. Links to the meter installation registry in the metering domain.',
    `alarm_code` STRING COMMENT 'Code indicating any alarm condition detected during this interval. Examples include leak alarm, burst alarm, backflow alarm, low battery alarm, or communication failure alarm. Empty if no alarm condition exists.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'The battery voltage of the AMI endpoint device at the time of this reading, measured in volts. Used to monitor endpoint health and predict battery replacement needs.',
    `consumption_volume_gallons` DECIMAL(18,2) COMMENT 'The total volume of water consumed during this interval, measured in gallons. This is the primary consumption metric used for billing, leak detection, and demand analysis.',
    `data_quality_indicator` STRING COMMENT 'Indicates the quality and reliability of this interval reading. Valid readings are directly measured; estimated readings are interpolated due to communication gaps; suspect readings show anomalies; missing indicates no data received; tampered indicates potential meter tampering; overflow indicates meter register overflow.. Valid values are `valid|estimated|suspect|missing|tampered|overflow`',
    `estimated_method` STRING COMMENT 'The method used to estimate this interval reading if data was missing or invalid. None indicates actual measured data. Other values indicate the estimation algorithm applied.. Valid values are `none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward`',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The average flow rate during the interval, measured in gallons per minute. Calculated as consumption volume divided by interval duration. Used for leak detection and high-flow alerting.',
    `gap_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval represents a data gap that was filled by estimation or interpolation. True indicates the reading is estimated due to missing data transmission.',
    `high_usage_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval exceeded the high-usage threshold for this meter installation. True indicates consumption significantly above normal patterns, potentially indicating irrigation, filling pools, or abnormal usage.',
    `interval_duration_minutes` STRING COMMENT 'The length of the consumption interval in minutes. Typically 15, 30, or 60 minutes for AMI systems. Used to normalize consumption rates and identify irregular interval lengths.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumption interval ended. Represents the end of the measurement period for this interval reading.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumption interval began. Represents the beginning of the measurement period for this interval reading.',
    `leak_detection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interval triggered a potential leak alert based on continuous low-flow patterns. True indicates sustained consumption suggesting a possible leak.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this interval reading. Used to document anomalies, manual adjustments, or special circumstances affecting this reading.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'The water pressure at the meter location during this interval, measured in pounds per square inch. Available from advanced AMI endpoints with integrated pressure sensors. Used for distribution network monitoring and pressure zone analysis.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was processed and loaded into the data warehouse. Used for data pipeline monitoring and audit trails.',
    `pulse_increment_gallons` DECIMAL(18,2) COMMENT 'The volume of water represented by each pulse from the meter encoder, measured in gallons. Varies by meter size and type. Used to convert pulse counts to consumption volumes.',
    `raw_pulse_count` BIGINT COMMENT 'The raw cumulative pulse count from the meter encoder at the end of this interval. Each pulse represents a fixed volume increment. Used for data validation and troubleshooting.',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was received by the AMI head-end system. Used to calculate transmission latency and identify delayed readings.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Boolean flag indicating whether reverse flow was detected during this interval. True indicates water flowing backward through the meter, which may indicate backflow, meter installation issues, or tampering.',
    `signal_strength_dbm` STRING COMMENT 'The radio signal strength of the AMI endpoint transmission, measured in dBm. Used to assess communication quality and identify endpoints with poor connectivity.',
    `tamper_event_code` STRING COMMENT 'Code indicating the type of tamper event detected during this interval, if any. Examples include magnetic interference, tilt detection, removal detection, or reverse flow. Empty if no tamper event detected.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'The ambient temperature at the meter location during this interval, measured in degrees Fahrenheit. Some AMI endpoints include temperature sensors for freeze detection and consumption correlation analysis.',
    `transmission_retry_count` STRING COMMENT 'The number of transmission attempts required to successfully deliver this interval reading to the AMI collector. Higher retry counts indicate communication challenges.',
    `validation_status` STRING COMMENT 'The current validation status of this interval reading. Pending indicates awaiting validation; validated indicates passed all quality checks; rejected indicates failed validation; under review indicates manual review required.. Valid values are `pending|validated|rejected|under_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when this interval reading was validated or rejected. Used for audit trails and data quality reporting.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether zero consumption was recorded during this interval. True indicates no water usage, which may be normal for vacant properties or may indicate meter malfunction.',
    CONSTRAINT pk_interval_consumption PRIMARY KEY(`interval_consumption_id`)
) COMMENT 'High-frequency interval consumption data collected from AMI endpoints, typically at 15-minute or hourly intervals. Stores meter installation reference, interval start and end timestamps, consumption volume (gallons), flow rate (GPM), data quality indicator, gap flag, and raw pulse count. Sourced from the AMI head-end system and time-series data historian. Enables leak detection, high-usage alerting, time-of-use analysis, and demand forecasting at sub-daily granularity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` (
    `consumption_profile_id` BIGINT COMMENT 'Unique identifier for the consumption profile record. Primary key for this billing-grade consumption summary.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Consumption profiles drive billing calculations and must link to service agreement to apply correct rate schedule, customer class, tier structure, and contract terms. Essential for revenue cycle opera',
    `employee_id` BIGINT COMMENT 'User identifier of the system or person who validated this consumption profile. Used for audit trail and quality assurance.',
    `consumption_validated_by_user_employee_id` BIGINT COMMENT 'User identifier of the system or person who validated this consumption profile. Used for audit trail and quality assurance.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Consumption profiles drive customer billing. Essential for revenue calculation, rate application, tier determination, and customer portal display. Links metered usage to the account responsible for pa',
    `installation_id` BIGINT COMMENT 'Reference to the specific meter installation point for which this consumption profile is calculated. Links to the physical meter deployment at a service address.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Consumption tied to premises for demand forecasting and capacity planning. Essential for infrastructure investment decisions, peak demand analysis by building type, and water use efficiency benchmarki',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Water consumption billing requires GL account mapping for revenue recognition and financial statement preparation. Consumption profiles drive revenue postings to specific GL accounts (water sales reve',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Consumption occurs at specific service addresses. Required for geographic usage analysis, conservation program targeting, leak correlation with location characteristics, and regulatory reporting by se',
    `adjustment_amount_gallons` DECIMAL(18,2) COMMENT 'Volume adjustment in gallons applied to the raw consumption data. May reflect leak adjustments, meter accuracy corrections, or billing dispute resolutions. Zero if no adjustment applied.',
    `adjustment_reason` STRING COMMENT 'Free-text explanation of why a consumption adjustment was applied. Null if no adjustment. Used for audit trail and customer communication.',
    `average_daily_usage_gpd` DECIMAL(18,2) COMMENT 'Average daily water consumption in gallons per day (GPD) calculated by dividing total consumption by billing period days. Used for trend analysis and customer benchmarking.',
    `billing_handoff_timestamp` TIMESTAMP COMMENT 'Date and time when this consumption profile was transmitted to Oracle CC&B for invoice generation. Null if not yet handed off to billing.',
    `billing_period_days` STRING COMMENT 'Total number of calendar days in the billing period. Used to normalize consumption for comparison across periods of different lengths.',
    `billing_period_end_date` DATE COMMENT 'The last date of the billing period covered by this consumption profile. Defines the end of the consumption measurement window.',
    `billing_period_start_date` DATE COMMENT 'The first date of the billing period covered by this consumption profile. Defines the beginning of the consumption measurement window.',
    `consumption_status` STRING COMMENT 'Current validation status of the consumption data. Indicates whether the consumption is based on actual reads, estimates, or has been adjusted. Only validated or final records are used for billing.. Valid values are `validated|estimated|prorated|adjusted|disputed|final`',
    `consumption_tier` STRING COMMENT 'Classification of consumption volume into rate tiers for tiered pricing structures. Determines applicable rate schedule and conservation incentives.. Valid values are `tier_1_base|tier_2_standard|tier_3_high|tier_4_excessive|tier_5_penalty`',
    `consumption_variance_percent` DECIMAL(18,2) COMMENT 'Percentage change in consumption compared to prior period. Positive values indicate increased usage; negative values indicate decreased usage. Used to trigger high-usage alerts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consumption profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_class` STRING COMMENT 'Classification of the customer account for rate structure and consumption analysis purposes. Determines applicable rate schedules and regulatory reporting categories.. Valid values are `residential|commercial|industrial|municipal|agricultural|wholesale`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) representing the quality and reliability of the consumption data. Based on read method, completeness of interval data, validation checks passed, and absence of anomalies. Higher scores indicate higher confidence.',
    `estimated_read_reason` STRING COMMENT 'Reason code explaining why consumption was estimated rather than based on actual meter read. Null if consumption is based on actual read.. Valid values are `meter_inaccessible|meter_malfunction|communication_failure|weather_event|customer_refusal|other`',
    `high_usage_alert_flag` BOOLEAN COMMENT 'Indicates whether consumption exceeded predefined thresholds triggering a high-usage alert. Used for proactive customer outreach and potential billing dispute prevention.',
    `interval_data_available_flag` BOOLEAN COMMENT 'Indicates whether granular interval consumption data (typically hourly) is available from AMI system for this billing period. True if AMI data exists; false if only aggregated reads are available.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consumption profile record was last updated. Used for change tracking and audit trail.',
    `leak_detected_flag` BOOLEAN COMMENT 'Indicates whether a potential leak was detected during the billing period based on continuous flow patterns or minimum night flow analysis. Triggers customer notification and field investigation.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Physical diameter of the meter in inches. Determines flow capacity and accuracy range. Common sizes include 0.625, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches.',
    `meter_technology` STRING COMMENT 'Technology type of the meter used for this consumption measurement. Determines data granularity, accuracy, and communication capabilities.. Valid values are `ami_fixed_network|amr_mobile|mechanical_register|smart_meter|ultrasonic|electromagnetic`',
    `minimum_night_flow_gpm` DECIMAL(18,2) COMMENT 'Minimum flow rate in gallons per minute (GPM) observed during overnight hours (typically 2 AM - 4 AM). Used for leak detection and continuous-use identification in AMI systems.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special circumstances, or operational notes related to this consumption profile. Used for exception documentation and customer service reference.',
    `nrw_contribution_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of consumption that contributes to Non-Revenue Water (NRW) or Unaccounted-for Water (UFW) calculations. Includes unbilled authorized consumption and apparent losses.',
    `peak_day_consumption_gallons` DECIMAL(18,2) COMMENT 'Maximum single-day water consumption in gallons during the billing period. Identifies peak demand events and potential high-usage anomalies.',
    `peak_day_date` DATE COMMENT 'The date on which the peak day consumption occurred. Used for correlation with weather events, holidays, or operational anomalies.',
    `prior_period_consumption_gallons` DECIMAL(18,2) COMMENT 'Total consumption in gallons from the immediately preceding billing period. Used for period-over-period variance analysis and trend detection.',
    `prior_year_consumption_gallons` DECIMAL(18,2) COMMENT 'Total consumption in gallons from the same billing period in the prior year. Used for year-over-year comparison and seasonal trend analysis.',
    `read_method` STRING COMMENT 'Method by which the meter reading was obtained. AMI (Advanced Metering Infrastructure) provides interval data; AMR (Automatic Meter Reading) provides periodic reads; manual and self-reads are less frequent.. Valid values are `ami_interval|amr_drive_by|manual_field|customer_self_read|estimated`',
    `reverse_flow_detected_flag` BOOLEAN COMMENT 'Indicates whether reverse flow was detected by the meter during the billing period. May indicate backflow condition, meter installation error, or tampering requiring immediate investigation.',
    `seasonal_factor` DECIMAL(18,2) COMMENT 'Multiplier representing expected seasonal variation in consumption for this customer class and service type. Used for forecasting and anomaly detection. 1.0 = average; >1.0 = high season; <1.0 = low season.',
    `service_type` STRING COMMENT 'Type of water service provided at this meter installation. Determines applicable quality standards, pricing, and regulatory requirements.. Valid values are `potable_water|reclaimed_water|raw_water|fire_service|irrigation`',
    `total_consumption_ccf` DECIMAL(18,2) COMMENT 'Total water consumption for the billing period measured in CCF (hundred cubic feet). Standard billing unit for many water utilities. 1 CCF = 748 gallons.',
    `total_consumption_gallons` DECIMAL(18,2) COMMENT 'Total water consumption for the billing period measured in gallons. Aggregated from validated interval reads or manual meter reads.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the consumption profile was validated and approved for billing handoff to Oracle CC&B. Represents the point at which the record became billing-grade.',
    `weather_normalized_consumption_gallons` DECIMAL(18,2) COMMENT 'Consumption adjusted for weather variations using heating/cooling degree days or precipitation data. Used for fair year-over-year comparisons and conservation program evaluation.',
    `zero_consumption_flag` BOOLEAN COMMENT 'Indicates whether zero consumption was recorded for the billing period. May indicate vacant property, meter malfunction, or frozen meter requiring investigation.',
    CONSTRAINT pk_consumption_profile PRIMARY KEY(`consumption_profile_id`)
) COMMENT 'Aggregated daily and monthly consumption summary per meter installation, derived from interval data and validated meter reads. Stores billing period consumption (CCF or gallons), average daily usage (GPD), peak day demand, minimum night flow, consumption tier classification, and comparison to prior period and prior year. Serves as the authoritative consumption record for billing handoff and NRW/UFW analysis. Distinct from raw interval_consumption — this is the validated, billing-grade record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` (
    `leak_detection_event_id` BIGINT COMMENT 'Unique identifier for the leak detection event record. Primary key.',
    `adjustment_id` BIGINT COMMENT 'Reference to the billing adjustment record created for this leak event, if applicable. Links to billing adjustment transaction.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Leak events require customer notification and may trigger billing adjustments. Essential for customer service outreach, high-bill investigations, assistance program eligibility, and tracking notificat',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where the leak was detected. Used for geographic analysis and NRW reduction program targeting.',
    `ami_endpoint_id` BIGINT COMMENT 'Reference to the AMI device (Sensus FlexNet endpoint or similar) that generated the interval data used for leak detection. Links to AMI device registry.',
    `leak_ami_endpoint_id` BIGINT COMMENT 'Reference to the AMI device (Sensus FlexNet endpoint or similar) that generated the interval data used for leak detection. Links to AMI device registry.',
    `employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that created this leak detection event record. Used for audit and accountability.',
    `leak_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user who last modified this leak detection event record. Used for audit and accountability.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation where the leak was detected. Links to the meter installation registry.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Leaks occur at premises and may indicate infrastructure issues. Required for correlating leak frequency with premise characteristics, prioritizing premise-level infrastructure upgrades, and tracking p',
    `primary_leak_employee_id` BIGINT COMMENT 'User identifier of the system user or automated process that created this leak detection event record. Used for audit and accountability.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the leak was detected. Links to customer service location registry.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to investigate or repair the detected leak. Links to asset management work order system.',
    `alert_severity` STRING COMMENT 'Severity classification of the leak event based on estimated volume, duration, and potential impact. Used to prioritize response and customer outreach.. Valid values are `critical|high|medium|low|informational`',
    `billing_adjustment_eligible_flag` BOOLEAN COMMENT 'Boolean indicator whether this leak event qualifies for a customer billing adjustment under utility leak adjustment policy. True indicates eligibility for adjustment consideration.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0-100) indicating the likelihood that the detected anomaly represents a true leak. Higher scores indicate greater confidence in detection accuracy.',
    `continuous_flow_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through continuous flow analysis (flow detected 24 hours without interruption). True indicates continuous flow was the detection trigger.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified about the detected leak event. Used for tracking notification timeliness and customer service metrics.',
    `customer_notified_flag` BOOLEAN COMMENT 'Boolean indicator whether the customer has been notified of the detected leak event. True indicates notification has been sent.',
    `detection_algorithm_version` STRING COMMENT 'Version identifier of the leak detection algorithm or software that identified this event. Used for algorithm performance tracking and continuous improvement.',
    `detection_method` STRING COMMENT 'Method or technique used to identify the leak event. Indicates whether detection was automated (AMI interval analysis, continuous flow flag, minimum night flow anomaly) or manual (acoustic sensor, field inspection, customer report).. Valid values are `continuous_flow_threshold|minimum_night_flow_anomaly|ami_algorithm|acoustic_sensor|manual_inspection|customer_report`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the leak was first detected by the AMI system or monitoring algorithm. Principal business event timestamp for this event.',
    `estimated_leak_volume_gallons_per_day` DECIMAL(18,2) COMMENT 'Estimated daily water loss volume attributed to the detected leak, measured in gallons per day. Calculated from interval consumption data or continuous flow analysis.',
    `estimated_total_loss_gallons` DECIMAL(18,2) COMMENT 'Total estimated water loss volume from leak start to resolution, measured in gallons. Calculated as leak volume per day multiplied by duration. Contributes to Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) metrics.',
    `flow_threshold_value` DECIMAL(18,2) COMMENT 'The flow rate threshold value (in gallons per minute or GPM) that was exceeded to trigger the leak detection alert. Used for continuous flow and threshold-based detection methods.',
    `investigation_notes` STRING COMMENT 'Free-text field for field technician or customer service representative notes regarding leak investigation, customer interaction, or resolution details.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leak detection event record was last updated. Used for audit trail and change tracking.',
    `leak_duration_hours` DECIMAL(18,2) COMMENT 'Estimated or measured duration of the leak event from detection timestamp to resolution or current time if unresolved, measured in hours.',
    `leak_location_description` STRING COMMENT 'Textual description of the suspected or confirmed leak location (e.g., service line, toilet, irrigation system, water heater). Provides context for leak source and repair scope.',
    `leak_status` STRING COMMENT 'Current lifecycle status of the leak detection event. Tracks progression from initial detection through investigation, customer notification, and resolution.. Valid values are `detected|confirmed|under_investigation|resolved|false_positive|customer_notified`',
    `leak_type` STRING COMMENT 'Classification of the leak by type or source. Helps categorize leak patterns and target customer education programs. [ENUM-REF-CANDIDATE: service_line|meter|toilet|faucet|irrigation|water_heater|pool|unknown — 8 candidates stripped; promote to reference product]',
    `minimum_night_flow_anomaly_flag` BOOLEAN COMMENT 'Boolean indicator that the leak was detected through minimum night flow analysis showing abnormal consumption during low-usage hours (typically 2 AM - 4 AM). True indicates MNF anomaly detection.',
    `notification_method` STRING COMMENT 'Communication channel used to notify the customer about the leak event. Tracks preferred and actual notification delivery method.. Valid values are `email|sms|phone_call|postal_mail|customer_portal|mobile_app`',
    `resolution_date` DATE COMMENT 'Date when the leak event was resolved or closed. Used to calculate response time and track Non-Revenue Water (NRW) reduction program effectiveness.',
    `resolution_outcome` STRING COMMENT 'Final outcome or resolution status of the leak detection event. Indicates whether the leak was confirmed and repaired, determined to be a false positive, or remains pending.. Valid values are `customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action`',
    CONSTRAINT pk_leak_detection_event PRIMARY KEY(`leak_detection_event_id`)
) COMMENT 'Records all detected consumption anomaly events including suspected leaks, high usage alerts, continuous flow conditions, backflow indicators, and threshold exceedance alerts identified through AMI interval data analysis or monitoring rules. Captures event type (leak, high usage, continuous flow, backflow, threshold exceedance), detection timestamp, meter installation reference, detection method, threshold and actual values, percentage over threshold, estimated volume impact, alert severity, alert status (open, notified, resolved, dismissed), notification history, customer contact log, and resolution outcome. Supports NRW reduction programs, customer notification workflows, proactive service management, and customer service case creation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key.',
    `alert_rule_id` BIGINT COMMENT 'Reference to the business rule or threshold configuration that triggered this alert. Links to alert rule definition for audit and tuning purposes.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation.',
    `high_ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: High usage alert investigation assignment to customer service or field technicians is core operational workflow. Enables workload tracking, SLA compliance monitoring, and employee performance metrics.',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location.',
    `order_id` BIGINT COMMENT 'Reference to the field service order created to investigate or resolve this alert. Links to work order management system. Null if no service order created.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: High usage alerts analyzed by premise type for pattern detection. Required for identifying systemic issues by building type, seasonal usage anomalies, and targeting conservation messaging to specific',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d',
    `actual_consumption_unit` STRING COMMENT 'Unit of measure for the actual consumption value. Gallons, cubic feet, and cubic meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd`',
    `actual_consumption_value` DECIMAL(18,2) COMMENT 'The measured consumption value during the detection period that triggered the alert. Represents the actual usage that exceeded the threshold.',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the alert was generated by the Advanced Metering Infrastructure (AMI) or analytics system. Represents the moment the threshold breach was detected.',
    `alert_number` STRING COMMENT 'Business-facing unique alert number used for tracking and customer communication. Format: HUA-XXXXXXXXXX.. Valid values are `^HUA-[0-9]{10}$`',
    `alert_severity` STRING COMMENT 'Severity classification of the alert based on variance magnitude and potential impact. Low indicates minor variance; medium indicates moderate concern; high indicates significant issue requiring prompt attention; critical indicates emergency condition requiring immediate response.. Valid values are `low|medium|high|critical`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the alert. Open indicates newly generated; notified means customer has been contacted; acknowledged means customer confirmed receipt; investigating indicates active review; resolved means issue addressed; dismissed means no action required; false positive indicates erroneous alert. [ENUM-REF-CANDIDATE: open|notified|acknowledged|investigating|resolved|dismissed|false_positive — 7 candidates stripped; promote to reference product]',
    `alert_type` STRING COMMENT 'Classification of the high usage alert based on consumption pattern analysis. High consumption indicates volume exceeds baseline; continuous flow suggests uninterrupted usage; backflow suspected indicates reverse flow detection; leak detected flags potential infrastructure failure; abnormal pattern identifies irregular usage; threshold exceeded indicates absolute limit breach.. Valid values are `high_consumption|continuous_flow|backflow_suspected|leak_detected|abnormal_pattern|threshold_exceeded`',
    `baseline_consumption_value` DECIMAL(18,2) COMMENT 'Historical average or expected consumption value used as the comparison baseline for this alert. May be calculated from seasonal norms, customer history, or similar account profiles.',
    `baseline_period_days` STRING COMMENT 'Number of days used to calculate the baseline consumption value. Typical values include 30, 60, 90, or 365 days depending on seasonality and data availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was first created in the system. Used for audit trail and data lineage.',
    `customer_acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the customer acknowledged receipt and awareness of this alert. Null if customer has not acknowledged.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about this high usage alert. True means notification sent; False means no notification sent yet.',
    `data_source` STRING COMMENT 'Source system or method that provided the consumption data used to generate this alert. AMI interval data represents 15-minute or hourly reads; AMI daily read represents once-per-day automated read; manual read represents field technician reading; estimated read represents calculated value; SCADA flow data represents distribution network monitoring; analytics engine represents derived calculation.. Valid values are `ami_interval_data|ami_daily_read|manual_read|estimated_read|scada_flow_data|analytics_engine`',
    `detection_period_end_timestamp` TIMESTAMP COMMENT 'End of the time window during which the high usage condition was detected. Used to define the consumption analysis interval.',
    `detection_period_start_timestamp` TIMESTAMP COMMENT 'Beginning of the time window during which the high usage condition was detected. Used to define the consumption analysis interval.',
    `estimated_revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the high usage condition, representing potential lost revenue or customer billing adjustment. Positive values indicate revenue at risk; negative values indicate customer credits issued. Null if not calculated.',
    `estimated_water_loss_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of water lost or wasted due to the condition that triggered this alert, measured in gallons. Used for Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) analysis. Null if not applicable or not calculated.',
    `first_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the first customer notification was sent for this alert. Null if customer has not been notified.',
    `investigation_started_timestamp` TIMESTAMP COMMENT 'Date and time when investigation of this alert began. Null if investigation has not started.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this alert record was most recently updated. Used for audit trail and change tracking.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this alert record. Used for audit trail and accountability.',
    `notification_count` STRING COMMENT 'Total number of notification attempts made to the customer regarding this alert. Includes all channels and retries.',
    `notification_method` STRING COMMENT 'Primary communication channel used to notify the customer about this alert. Email, SMS, and mobile app represent digital channels; phone call represents voice contact; postal mail represents physical correspondence; customer portal represents self-service access; none indicates no notification sent. [ENUM-REF-CANDIDATE: email|sms|phone_call|postal_mail|mobile_app|customer_portal|none — 7 candidates stripped; promote to reference product]',
    `resolution_category` STRING COMMENT 'Classification of the root cause or resolution outcome for this alert. Customer leak repaired indicates customer-side plumbing issue fixed; utility leak repaired indicates utility infrastructure issue fixed; meter malfunction indicates faulty meter; seasonal usage indicates expected variance; customer behavior change indicates legitimate usage increase; irrigation system and pool filling indicate specific high-volume activities; construction activity indicates temporary usage spike; false alarm indicates erroneous alert; other indicates miscellaneous resolution. [ENUM-REF-CANDIDATE: customer_leak_repaired|utility_leak_repaired|meter_malfunction|seasonal_usage|customer_behavior_change|irrigation_system|pool_filling|construction_activity|false_alarm|other — 10 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text narrative describing the investigation findings, actions taken, and resolution details for this alert. Provides context for future reference and audit trail.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when this alert was resolved or closed. Null if alert remains open or under investigation.',
    `service_order_created_flag` BOOLEAN COMMENT 'Indicates whether a field service order was created in response to this alert. True means service order generated; False means no service order created.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this alert was suppressed from customer notification due to business rules (e.g., customer opted out, account in dispute, recent similar alert). True means suppressed; False means not suppressed.',
    `suppression_reason` STRING COMMENT 'Explanation of why this alert was suppressed from customer notification. Null if alert was not suppressed.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value. Gallons and cubic feet/meters represent volume; GPM (Gallons per Minute) and MGD (Million Gallons per Day) represent flow rate; percent represents variance from baseline.. Valid values are `gallons|cubic_feet|cubic_meters|gpm|mgd|percent`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The defined limit or baseline value that was exceeded to trigger this alert. May represent absolute volume, flow rate, or percentage variance depending on alert configuration.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which actual consumption exceeded the threshold value. Calculated as ((actual - threshold) / threshold) * 100. Positive values indicate over-threshold conditions.',
    CONSTRAINT pk_high_usage_alert PRIMARY KEY(`high_usage_alert_id`)
) COMMENT 'Operational alert record generated when a meters consumption exceeds a defined threshold relative to historical baseline, seasonal norms, or absolute volume limits. Stores alert generation timestamp, meter installation reference, alert type (high consumption, continuous flow, backflow suspected), threshold value, actual consumption value, percentage over threshold, alert status (open, notified, resolved, dismissed), customer contact attempt log, and resolution notes. Feeds customer service workflows in Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` (
    `accuracy_test_id` BIGINT COMMENT 'Primary key for accuracy_test',
    `cost_center_id` BIGINT COMMENT 'add column cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - meter testing costs must be allocated to cost centers',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - accuracy tests are performed by certified meter technicians who must be recorded',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Accuracy tests can be performed in the field (in-situ testing) at a specific meter installation, or in a lab/bench setting. For field tests, this FK links the test to the installation location. This F',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_',
    CONSTRAINT pk_accuracy_test PRIMARY KEY(`accuracy_test_id`)
) COMMENT 'Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` (
    `replacement_program_id` BIGINT COMMENT 'Primary key for replacement_program',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Replacement programs target specific asset classes (e.g., residential meters aged 15+ years). Program eligibility, prioritization, and budget forecasting depend on asset class characteristics like use',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter replacement programs are often targeted at specific meter sizes or types (e.g., replace all 5/8-inch meters over 15 years old or replace all non-AMI 3/4-inch meters). This FK links the progr',
    CONSTRAINT pk_replacement_program PRIMARY KEY(`replacement_program_id`)
) COMMENT 'Defines and tracks meter replacement programs and campaigns, including age-based replacement cycles, accuracy-based replacement triggers, and AMI retrofit programs. Stores program name, program type (age-based, accuracy-based, AMI upgrade, LCRR lead service line), target meter population criteria (age threshold, meter size, meter type, geographic zone), program start and end dates, target count, completion count, budget allocation, and program status. Links to individual replacement work orders executed through IBM Maximo.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` (
    `replacement_order_id` BIGINT COMMENT 'Primary key for replacement_order',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: replacement_order captures old_meter_accuracy_test_result as a scalar value but lacks FK to the actual accuracy_test record that triggered the replacement. Meter replacements are often driven by faile',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Replacement orders trigger material requisitions to pull meter stock from warehouse for installation crews. Work order execution requires reservation/requisition of specific meter inventory, linking f',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: A replacement order replaces an existing (old) meter with a new meter. This FK tracks which physical meter device was removed/replaced. This is the first of two FKs to metering_meter (old and new), re',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Meter replacement programs generate bulk purchase orders for new meter inventory. Replacement program execution triggers procurement of meters in planned quantities, linking program planning to procur',
    `replacement_program_id` BIGINT COMMENT 'Foreign key linking to metering.replacement_program. Business justification: Replacement orders are often executed as part of a structured replacement program or campaign (age-based, accuracy-based, technology upgrade). This FK links individual replacement work orders to their',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Each meter replacement is executed via work order that schedules crews, tracks labor/materials, manages old meter disposal, and closes out capital projects. Standard utility field service workflow lin',
    CONSTRAINT pk_replacement_order PRIMARY KEY(`replacement_order_id`)
) COMMENT 'Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` (
    `metering_dma_zone_id` BIGINT COMMENT 'Unique identifier for the District Metered Area zone. Primary key for the DMA zone master record.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: DMA establishment and reconfiguration are capital projects involving valve installations, boundary meter installations, and hydraulic modeling. Required for NRW program capital investment tracking, re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DMAs are operational cost centers for budget allocation, O&M expense tracking, and capital investment planning. Utilities manage DMA-level budgets, analyze cost per connection, and allocate labor/mate',
    `installation_id` BIGINT COMMENT 'Foreign key reference to a secondary or backup zone meter installation for redundancy. Used when primary zone meter is offline or for validation of primary meter readings.',
    `metering_prv_installation_id` BIGINT COMMENT 'Foreign key reference to the primary Pressure Reducing Valve installation serving this DMA zone. PRVs control inlet pressure to reduce leakage and pipe stress.',
    `metering_zone_meter_installation_id` BIGINT COMMENT 'Foreign key reference to the primary zone meter installation that measures total inflow to the DMA. This meter is the authoritative source for DMA-level consumption and water balance calculations.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key reference to the pressure zone within which this DMA operates. Pressure zones define hydraulic boundaries based on elevation and pump station service areas.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: DMAs are established to meet regulatory requirements for pressure management, leak detection frequency, and water loss control programs. Real process: designing and operating DMAs per state water loss',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: DMAs are geographic subdivisions within service territories for NRW management and hydraulic modeling. Operations teams need territory link for franchise jurisdiction, regulatory reporting boundaries',
    `actual_nrw_percentage` DECIMAL(18,2) COMMENT 'Most recent calculated Non-Revenue Water percentage for this DMA zone based on water balance analysis. Updated monthly or quarterly from metering and billing data.',
    `average_age_of_mains_years` STRING COMMENT 'Average age in years of distribution mains within the DMA zone. Correlates with leak frequency and helps prioritize pipe replacement programs.',
    `average_pressure_psi` DECIMAL(18,2) COMMENT 'Average operating pressure within the DMA zone measured in pounds per square inch. Critical for pressure management and leak reduction programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DMA zone record was first created in the system. Used for audit trail and data lineage tracking.',
    `decommissioned_date` DATE COMMENT 'Date when the DMA zone was decommissioned or merged into another zone. Null for active zones. Used for historical record keeping and network reconfiguration tracking.',
    `metering_dma_zone_description` STRING COMMENT 'Detailed description of the DMA zone including boundaries, key landmarks, and operational notes. Used for field crew reference and planning.',
    `dma_code` STRING COMMENT 'Business identifier code for the DMA zone used in operational systems, SCADA displays, and reporting. Typically alphanumeric and unique across the distribution network.. Valid values are `^[A-Z0-9]{3,12}$`',
    `dma_name` STRING COMMENT 'Human-readable name of the DMA zone, often reflecting geographic location or neighborhood served (e.g., Downtown West DMA, Industrial Park Zone 3).',
    `dma_type` STRING COMMENT 'Classification of the DMA zone based on predominant customer type and land use. Drives consumption pattern analysis and NRW benchmarking.. Valid values are `residential|commercial|industrial|mixed_use|rural|institutional`',
    `established_date` DATE COMMENT 'Date when the DMA zone was officially established and zone metering began. Used for calculating age of DMA program and historical trend analysis.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier to the GIS polygon feature representing the geographic boundary of the DMA zone in the Esri ArcGIS system. Used for spatial analysis and mapping.',
    `hydraulic_model_reference` STRING COMMENT 'Reference identifier to the DMA zone representation in the Innovyze InfoWater hydraulic model. Used for pressure analysis, fire flow testing, and capital planning.',
    `infrastructure_leakage_index` DECIMAL(18,2) COMMENT 'Ratio of current annual real losses to unavoidable annual real losses. ILI values below 2.0 indicate good performance; above 4.0 indicates poor performance requiring intervention.',
    `isolation_valve_count` STRING COMMENT 'Number of isolation valves that define the hydraulic boundary of the DMA zone. Used for operational planning and boundary integrity verification.',
    `last_leak_detection_date` DATE COMMENT 'Date of the most recent active leak detection survey conducted in this DMA zone. Used to schedule next survey and track compliance with leak detection programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DMA zone record was last updated. Used for change tracking and data quality monitoring.',
    `leak_detection_frequency_days` STRING COMMENT 'Target frequency in days for conducting active leak detection surveys within this DMA zone. High-loss zones are surveyed more frequently.',
    `metering_dma_zone_status` STRING COMMENT 'Current operational status of the DMA zone. Active zones are monitored for NRW; inactive or planned zones are not yet operational.. Valid values are `active|inactive|planned|decommissioned|under_construction|maintenance`',
    `minimum_night_flow_gpm` DECIMAL(18,2) COMMENT 'Minimum flow rate measured during night hours (typically 2-4 AM) when legitimate consumption is lowest. Key indicator for leak detection and NRW analysis measured in gallons per minute.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, historical context, or other relevant information about the DMA zone not captured in structured fields.',
    `predominant_pipe_material` STRING COMMENT 'Most common pipe material type within the DMA zone. Influences leak rates, corrosion risk, and maintenance strategies. [ENUM-REF-CANDIDATE: cast_iron|ductile_iron|pvc|hdpe|steel|concrete|asbestos_cement|copper — 8 candidates stripped; promote to reference product]',
    `responsible_operations_team` STRING COMMENT 'Name or identifier of the operations team or district responsible for maintenance and leak response within this DMA zone. Used for work order routing and accountability.',
    `scada_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether the DMA zone meter is connected to the SCADA system for real-time flow and pressure monitoring. True enables automated alerts for abnormal conditions.',
    `scada_tag_reference` STRING COMMENT 'SCADA system tag identifier for the primary zone meter flow point in OSIsoft PI Historian. Used to retrieve real-time and historical flow data for water balance analysis.',
    `service_connection_count` STRING COMMENT 'Total number of active service connections (meters) within the DMA zone. Used as denominator in per-connection NRW calculations and for sizing analysis.',
    `target_nrw_percentage` DECIMAL(18,2) COMMENT 'Target or goal for Non-Revenue Water as a percentage of total inflow for this DMA zone. Used for performance monitoring and loss reduction program planning.',
    `total_pipe_length_miles` DECIMAL(18,2) COMMENT 'Total length of distribution mains within the DMA zone measured in miles. Used for calculating NRW per mile of main and infrastructure density metrics.',
    `ufw_gallons_per_connection_per_day` DECIMAL(18,2) COMMENT 'Unaccounted-for Water volume normalized per service connection per day. Key performance indicator for leak detection prioritization and DMA performance benchmarking.',
    CONSTRAINT pk_metering_dma_zone PRIMARY KEY(`metering_dma_zone_id`)
) COMMENT 'Master record for each District Metered Area (DMA) — a hydraulically isolated zone of the distribution network bounded by closed valves and monitored by zone meters for water balance analysis. Stores DMA code, name, geographic boundary reference, zone meter installation IDs, service connection count, pipe length, pressure zone reference, and operational status. The authoritative reference for DMA topology used in NRW/UFW water balance calculations, pressure management, and leakage targeting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` (
    `metering_nrw_water_balance_id` BIGINT COMMENT 'Unique identifier for the metering_nrw_water_balance data product (auto-inserted pre-linking).',
    `metering_dma_zone_id` BIGINT COMMENT 'Foreign key linking to metering.metering_dma_zone. Business justification: Non-Revenue Water (NRW) water balance calculations are performed for specific District Metered Areas (DMAs) to quantify water losses within a hydraulically isolated zone. Each water balance record mus',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Non-revenue water losses must be recorded in specific GL accounts for regulatory compliance, rate case justification, and financial transparency. NRW water balance calculations drive loss accounting e',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: NRW programs must comply with specific regulatory requirements for water loss control targets, infrastructure leakage index thresholds, and audit methodology standards. Real process: tracking complian',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Non-revenue water audits are mandatory regulatory submissions under AWWA M36 standards and state water loss control programs. Real process: annual water audit submission to state agencies per regulato',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: NRW water balance calculations (AWWA M36 methodology) are performed at service territory level for regulatory reporting to state primacy agencies and rate case cost-of-service studies. Territory link',
    `distribution_nrw_water_balance_id` BIGINT COMMENT '',
    CONSTRAINT pk_metering_nrw_water_balance PRIMARY KEY(`metering_nrw_water_balance_id`)
) COMMENT 'Periodic (monthly/annual) water balance record for a DMA zone or system-wide, quantifying Non-Revenue Water (NRW) and Unaccounted-for Water (UFW) per the IWA/AWWA water audit methodology (M36 manual). Stores period start and end dates, system input volume (MGD), authorized consumption (billed metered, billed unmetered, unbilled metered, unbilled unmetered), water losses (apparent losses from meter inaccuracy and unauthorized consumption; real losses from leakage), NRW volume, NRW percentage, Infrastructure Leakage Index (ILI), and audit confidence grade. Feeds regulatory reporting, capital planning, and performance benchmarking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` (
    `tamper_event_id` BIGINT COMMENT 'Primary key for tamper_event',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Tamper events are often detected by AMI endpoints through tamper detection sensors and transmitted as alerts. This FK links the tamper event to the AMI endpoint that detected and reported the tamperin',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Tamper events trigger billing adjustments for estimated unbilled consumption during tamper period per revenue protection policies and regulatory requirements. Direct link supports tamper-to-cash workf',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Tamper events (meter tampering, unauthorized bypass, interference) occur at a specific meter installation location. This FK links the tamper event to the physical installation where tampering was dete',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Tamper events trigger field investigations and potential enforcement actions dispatched via work orders. Utilities track investigation findings, customer contact, and resolution through work order sys',
    CONSTRAINT pk_tamper_event PRIMARY KEY(`tamper_event_id`)
) COMMENT 'Records detected meter tampering, unauthorized bypass, or meter interference events identified through AMI tamper flags, field inspection, or billing anomaly investigation. Captures detection date, meter installation reference, tamper type (magnetic tamper, reverse flow, physical bypass, broken seal, unauthorized removal), detection source (AMI flag, field inspection, billing review), estimated unbilled consumption volume, investigation status, enforcement action taken, and revenue recovery amount. Supports revenue protection and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` (
    `read_exception_id` BIGINT COMMENT 'Unique identifier for the meter read exception record.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: For AMI read exceptions (communication failures, signal strength issues, battery failures), this FK links the exception to the specific AMI endpoint experiencing the issue. Should be nullable for manu',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Read exception investigation requires field technician assignment for resolution. Core operational workflow for meter reading quality control. Column assigned_to currently stores employee identifier',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which the exception occurred.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Read exceptions affect billing accuracy and require customer notification. Essential for billing hold management, estimated bill communication, customer dispute resolution, and tracking exception impa',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Read exceptions (communication failures, no-reads) may result from main breaks causing power outages or infrastructure damage. Root cause analysis for meter communication issues requires checking if d',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation where the exception occurred.',
    `read_id` BIGINT COMMENT 'Foreign key linking to metering.read. Business justification: Read exceptions are anomalies detected during meter read processing (communication failures, variance exceptions, validation failures). Each exception record should reference the specific read that tr',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: read_exception tracks meter read anomalies that require investigation. Exceptions occur during route reading operations and should reference which route the exception occurred on. This enables route-l',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Read exceptions tied to locations for field resolution. Required for dispatching meter readers, identifying access issues, correlating exceptions with address characteristics like obstructions, and op',
    `validation_rule_id` BIGINT COMMENT 'Identifier of the automated validation rule that triggered the exception when exception source is validation_rule.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created for field investigation or meter replacement when field visit is required.',
    `battery_status` STRING COMMENT 'Battery health status of the Advanced Metering Infrastructure (AMI) endpoint device at time of exception.. Valid values are `normal|low|critical|failed`',
    `billing_hold_flag` BOOLEAN COMMENT 'Indicator that billing has been placed on hold for this meter installation until the exception is resolved.',
    `communication_failure_reason` STRING COMMENT 'Detailed reason for Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR) communication failure when exception type is communication_failure.',
    `corrected_read_value` DECIMAL(18,2) COMMENT 'Corrected meter reading value after manual investigation or re-read, used for billing when resolution action is read_corrected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system.',
    `current_read_value` DECIMAL(18,2) COMMENT 'Current meter register reading value that triggered the exception, measured in gallons or cubic feet depending on meter configuration.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicator that the customer was notified about the read exception and potential billing impact.',
    `estimated_read_value` DECIMAL(18,2) COMMENT 'Estimated consumption value used for billing when actual read cannot be obtained, calculated based on historical usage patterns.',
    `estimation_method` STRING COMMENT 'Method used to calculate estimated read value when actual read is unavailable (e.g., historical average, seasonal adjustment, similar customer profile).',
    `exception_code` STRING COMMENT 'System-generated code identifying the specific exception condition. Aligns with Oracle CC&B exception code catalog.',
    `exception_date` DATE COMMENT 'Date when the meter read exception was detected or occurred.',
    `exception_source` STRING COMMENT 'Source system or process that detected and reported the meter read exception.. Valid values are `ami_system|manual_read|validation_rule|customer_report|field_inspection`',
    `exception_status` STRING COMMENT 'Current workflow status of the exception investigation and resolution process.. Valid values are `open|in_progress|resolved|escalated|cancelled`',
    `exception_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was detected by the Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR) system.',
    `exception_type` STRING COMMENT 'Classification of the meter read exception condition requiring investigation or manual resolution before billing.. Valid values are `no_read|high_read|low_read|reverse_read|estimated_read|communication_failure`',
    `expected_consumption` DECIMAL(18,2) COMMENT 'Expected consumption value based on historical usage patterns, used for variance analysis and exception detection.',
    `field_visit_required` BOOLEAN COMMENT 'Indicator that a field technician visit is required to physically inspect the meter or resolve the exception.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was last updated.',
    `leak_detection_flag` BOOLEAN COMMENT 'Indicator that continuous flow or abnormal usage pattern suggesting a leak was detected during the read period.',
    `notification_date` DATE COMMENT 'Date when customer notification was sent regarding the meter read exception.',
    `prior_read_value` DECIMAL(18,2) COMMENT 'Previous valid meter register reading value before the exception occurred, measured in gallons or cubic feet depending on meter configuration.',
    `priority_level` STRING COMMENT 'Priority assigned to the exception for resolution workflow, based on exception type, customer class, and business impact.. Valid values are `low|medium|high|critical`',
    `register_overflow_flag` BOOLEAN COMMENT 'Indicator that the meter register has exceeded its maximum capacity and rolled over to zero.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the meter read exception before billing can proceed.. Valid values are `re_read|estimate_accepted|read_corrected|meter_replaced|field_visit_scheduled|no_action`',
    `resolution_date` DATE COMMENT 'Date when the exception was resolved and the read was approved for billing.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation findings, actions taken, and rationale for the resolution decision.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exception was resolved and approved for billing.',
    `resolved_by` STRING COMMENT 'User ID of the person who resolved the exception and approved the read for billing.',
    `reverse_flow_flag` BOOLEAN COMMENT 'Indicator that reverse water flow through the meter was detected, potentially indicating meter tampering or backflow condition.',
    `signal_strength` STRING COMMENT 'Radio signal strength indicator for Advanced Metering Infrastructure (AMI) communication at time of exception, measured in decibels (dBm).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute difference between current and prior read values, measured in gallons or cubic feet.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between current and prior read values, used to identify high/low read anomalies.',
    CONSTRAINT pk_read_exception PRIMARY KEY(`read_exception_id`)
) COMMENT 'Tracks meter read exceptions and anomalies that require investigation or manual resolution before a read can be used for billing. Stores exception date, meter installation reference, exception type (no read, high read, low read, reverse read, estimated read, communication failure, register overflow), exception code, prior read value, current read value, variance percentage, resolution action (re-read, estimate accepted, read corrected, meter replaced), resolved by, and resolution date. Interfaces with Oracle CC&B exception management workflow.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route',
    `dma_id` BIGINT COMMENT 'add column dma_id (BIGINT) with FK to distribution.dma.dma_id - read routes typically align with district metered areas for operational efficiency',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - meter read routes are organized within service territories',
    `route_name` STRING COMMENT '',
    `route_code` STRING COMMENT '',
    `route_description` STRING COMMENT '',
    `assigned_reader_id` BIGINT COMMENT '',
    `route_sequence` BIGINT COMMENT '',
    `estimated_read_time_minutes` BIGINT COMMENT '',
    `meter_count` BIGINT COMMENT '',
    `geographic_area` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` (
    `metering_complaint_id` BIGINT COMMENT 'Primary key for complaint',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: metering_complaint tracks customer disputes about meter accuracy and captures meter_test_ordered_flag, meter_test_date, meter_test_result, meter_accuracy_percent but lacks FK to the actual accuracy_te',
    `customer_account_id` BIGINT COMMENT 'add column customer_account_id (BIGINT) with FK to customer.customer_account.customer_account_id - metering complaints are filed by customers and need account linkage',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Customer complaints about metering (high bill complaints, meter accuracy disputes, read disputes) are specific to a meter installation at a service address. This FK links the complaint to the installa',
    `read_id` BIGINT COMMENT 'Foreign key linking to metering.read. Business justification: Many metering complaints reference a specific disputed meter read (e.g., the read on my January bill is wrong). This FK links the complaint to the specific read being disputed. Should be nullable fo',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Customer complaints about meters (high bills, suspected leaks, accuracy concerns) are investigated via work orders. Standard utility customer service workflow linking complaint intake to field resolut',
    `customer_complaint_id` BIGINT COMMENT '',
    CONSTRAINT pk_metering_complaint PRIMARY KEY(`metering_complaint_id`)
) COMMENT 'Records customer-initiated complaints and disputes related to metering, including high bill complaints, meter accuracy disputes, estimated bill objections, and AMI data concerns. Captures complaint date, customer account reference, meter installation reference, complaint type, complaint description, consumption period in dispute, disputed amount, investigation assigned to, investigation findings, resolution type (meter test ordered, read corrected, bill adjusted, complaint dismissed), resolution date, and customer satisfaction outcome. Interfaces with Microsoft Dynamics 365 CRM case management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` (
    `meter_field_inspection_id` BIGINT COMMENT 'Unique identifier for the meter field inspection record. Primary key.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: meter_field_inspection records physical inspection of meter installations and captures AMI endpoint condition attributes (ami_endpoint_condition, ami_antenna_condition, ami_signal_strength_dbm, ami_ba',
    `work_order_id` BIGINT COMMENT 'Reference to the follow-up work order created in IBM Maximo based on the inspection findings and recommended actions.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the field inspection. Links to workforce employee record.',
    `material_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.material_requisition. Business justification: Field inspections identify needed materials (repair parts, replacement registers, seals) and generate material requisitions. Inspector identifies failed component during inspection, creates requisitio',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation being inspected. Links to the meter installation record in the metering domain.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Inspections verify premise-level meter conditions and infrastructure. Required for correlating inspection findings with premise characteristics, prioritizing premise upgrades, and tracking compliance',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Field inspections occur at service addresses. Essential for inspection routing, GPS navigation, verifying physical location matches records, and coordinating customer access for vault/pit inspections',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: LCRR compliance requires visual verification of service line material during meter field inspections. Inspectors document service line condition, material type, and leak evidence. Links inspection fin',
    `ami_antenna_condition` STRING COMMENT 'Condition of the AMI endpoint antenna: intact, damaged, missing, or corroded. Critical for radio frequency communication performance.. Valid values are `intact|damaged|missing|corroded`',
    `ami_battery_voltage` DECIMAL(18,2) COMMENT 'Battery voltage of the AMI endpoint measured during the field inspection, used to predict remaining battery life and schedule replacements.',
    `ami_endpoint_condition` STRING COMMENT 'Physical condition assessment of the AMI endpoint device: excellent, good, fair, poor, missing, or damaged. Evaluates antenna, housing, and mounting integrity.. Valid values are `excellent|good|fair|poor|missing|damaged`',
    `ami_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength of the AMI endpoint measured in decibels-milliwatts (dBm) during the field inspection, used to assess communication quality.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'GPS coordinate accuracy measured in meters, indicating the precision of the location capture during the field inspection.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured during the field inspection, used to verify meter location and update GIS records.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured during the field inspection, used to verify meter location and update GIS records.',
    `inspection_date` DATE COMMENT 'Date when the field inspection was performed.',
    `inspection_duration_minutes` STRING COMMENT 'Duration of the field inspection in minutes, used for workforce productivity analysis and route optimization.',
    `inspection_notes` STRING COMMENT 'Free-text notes and observations recorded by the inspector during the field inspection, capturing additional details not covered by structured fields.',
    `inspection_number` STRING COMMENT 'Unique business identifier for the field inspection, typically generated by the CMMS or field service system.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: scheduled, in progress, completed, cancelled, failed, or pending review.. Valid values are `scheduled|in_progress|completed|cancelled|failed|pending_review`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the field inspection was performed, including time zone information.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose: routine scheduled inspection, complaint-driven investigation, post-repair verification, pre-replacement assessment, accuracy verification, leak investigation, tamper investigation, high usage investigation, AMI endpoint physical check, or regulatory compliance inspection. [ENUM-REF-CANDIDATE: routine|complaint_driven|post_repair|pre_replacement|accuracy_verification|leak_investigation|tamper_investigation|high_usage_investigation|ami_endpoint_check|regulatory_compliance — 10 candidates stripped; promote to reference product]',
    `inspector_name` STRING COMMENT 'Full name of the inspector who performed the field inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was last modified in the system.',
    `leak_description` STRING COMMENT 'Detailed description of any leak detected during the inspection, including location, severity, and estimated flow rate if observable.',
    `leak_detected_flag` BOOLEAN COMMENT 'Indicates whether a leak was detected at the meter installation during the field inspection, including meter body leaks, connection leaks, or service line leaks.',
    `meter_condition_rating` STRING COMMENT 'Overall condition assessment of the meter based on visual inspection: excellent, good, fair, poor, or failed. Used for asset health scoring and replacement prioritization.. Valid values are `excellent|good|fair|poor|failed`',
    `obstruction_description` STRING COMMENT 'Detailed description of any obstructions noted during the inspection that prevent or hinder meter access.',
    `obstruction_noted_flag` BOOLEAN COMMENT 'Indicates whether any obstructions were noted that prevent or hinder access to the meter installation, such as landscaping, vehicles, structures, or locked gates.',
    `photo_count` STRING COMMENT 'Number of photographs captured during the field inspection for documentation and evidence purposes.',
    `photo_evidence_reference` STRING COMMENT 'Reference identifier or file path to photographic evidence captured during the field inspection, stored in the document management system.',
    `pit_debris_present_flag` BOOLEAN COMMENT 'Indicates whether debris, sediment, or foreign objects are present in the meter pit or vault that may interfere with meter operation or access.',
    `pit_vault_condition` STRING COMMENT 'Condition assessment of the meter pit or vault: excellent, good, fair, poor, or hazardous. Includes evaluation of structural integrity, water intrusion, and safety hazards.. Valid values are `excellent|good|fair|poor|hazardous`',
    `pit_water_present_flag` BOOLEAN COMMENT 'Indicates whether standing water is present in the meter pit or vault, which may indicate drainage issues, leaks, or groundwater infiltration.',
    `priority_level` STRING COMMENT 'Priority level assigned to any follow-up action required based on inspection findings: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `recommended_action` STRING COMMENT 'Inspectors recommended action based on the field inspection findings: none, monitor, repair, replace, clean, recalibrate, investigate, upgrade AMI endpoint, or seal replacement. [ENUM-REF-CANDIDATE: none|monitor|repair|replace|clean|recalibrate|investigate|upgrade_ami|seal_replacement — 9 candidates stripped; promote to reference product]',
    `register_readable_flag` BOOLEAN COMMENT 'Indicates whether the meter register is readable and visible during the inspection. False may indicate fogging, damage, or obstruction.',
    `register_reading` DECIMAL(18,2) COMMENT 'Current register reading captured during the field inspection, measured in gallons or cubic feet depending on meter configuration.',
    `register_unit_of_measure` STRING COMMENT 'Unit of measure for the register reading: gallons, cubic feet, or cubic meters.. Valid values are `gallons|cubic_feet|cubic_meters`',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the meter seal is intact and unbroken. False indicates potential tampering or unauthorized access requiring investigation.',
    `seal_number_verified` STRING COMMENT 'Seal number observed during the inspection, used to verify against the installation record and detect unauthorized seal replacement.',
    `tamper_description` STRING COMMENT 'Detailed description of any tampering evidence observed during the inspection, used for revenue protection investigations.',
    `tamper_evidence_flag` BOOLEAN COMMENT 'Indicates whether evidence of tampering was observed during the inspection, such as broken seals, unauthorized modifications, bypass piping, or meter reversal.',
    CONSTRAINT pk_meter_field_inspection PRIMARY KEY(`meter_field_inspection_id`)
) COMMENT 'Records field inspection visits to meter installations for condition assessment, seal verification, pit/vault inspection, and AMI endpoint physical check. Captures inspection date, meter installation reference, inspector employee ID, inspection type (routine, complaint-driven, post-repair, pre-replacement), meter condition rating, pit/vault condition, seal intact flag, AMI antenna condition, obstructions noted, photographic evidence reference, recommended action, and follow-up work order reference in IBM Maximo. Supports proactive asset management and revenue protection.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` (
    `ami_network_collector_id` BIGINT COMMENT 'Unique identifier for the AMI network collector device. Primary key for the collector registry.',
    `registry_id` BIGINT COMMENT 'Reference to the asset registry entry for this collector device in the CMMS (IBM Maximo). Links AMI network data to enterprise asset management for maintenance scheduling, depreciation, and lifecycle tracking.',
    `ami_registry_id` BIGINT COMMENT 'Reference to the asset registry entry for this collector device in the CMMS (IBM Maximo). Links AMI network data to enterprise asset management for maintenance scheduling, depreciation, and lifecycle tracking.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Network collectors installed as AMI infrastructure projects require project linkage for warranty management, project performance evaluation, capital cost allocation, and asset capitalization. Critical',
    `dma_id` BIGINT COMMENT 'Identifier of the district metered area that this collector primarily serves. Used for aligning AMI network topology with hydraulic zones for non-revenue water analysis.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: AMI collectors are capitalized infrastructure assets requiring fixed asset register inclusion for depreciation, net book value tracking, and GASB capital asset reporting. Each collector has acquisitio',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and documented the installation of this collector device. Used for audit trail and cost tracking.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Network collectors are capital assets procured as materials, tracked for inventory, installation work orders, warranty, and spare parts management. Procurement orders collectors by material number; wa',
    `backhaul_connection_type` STRING COMMENT 'Type of wide-area network connection used to transmit collected meter data from the collector to the central AMI head-end system. Cellular and fiber are most common for fixed base stations.. Valid values are `cellular|fiber|dsl|cable|satellite|microwave`',
    `backhaul_provider` STRING COMMENT 'Name of the telecommunications carrier or internet service provider supplying the backhaul connection for this collector. Used for vendor management and service level agreement tracking.',
    `battery_backup_flag` BOOLEAN COMMENT 'Indicates whether the collector device has battery backup power to maintain operation during AC power outages. True if battery backup is installed and functional.',
    `city` STRING COMMENT 'City or municipality where the collector device is installed.',
    `collector_identifier` STRING COMMENT 'Externally-known unique identifier or serial number assigned to the collector device by the manufacturer or utility. Used for field operations and inventory tracking.',
    `collector_type` STRING COMMENT 'Classification of the collector device based on its deployment mode and function within the AMI network topology. Fixed base stations are permanently installed, mobile collectors are vehicle-mounted for drive-by reading, and repeaters extend network coverage.. Valid values are `fixed_base_station|mobile_collector|repeater|tower_mounted_receiver|gateway|hybrid`',
    `communication_protocol` STRING COMMENT 'Radio frequency communication protocol used by the collector to communicate with AMI endpoints. FlexNet is the Sensus proprietary protocol; other protocols may be used in hybrid deployments.. Valid values are `flexnet|mesh|point_to_multipoint|cellular|lora|zigbee`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the collector installation location.. Valid values are `USA|CAN|MEX`',
    `coverage_radius_miles` DECIMAL(18,2) COMMENT 'Estimated radio frequency coverage radius in miles for the collector device. Defines the geographic area within which AMI endpoints can communicate with this collector. Used for network planning and coverage gap analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collector record was first created in the AMI system. Used for data lineage and audit purposes.',
    `decommission_date` DATE COMMENT 'Date when the collector device was removed from service or retired from the AMI network. Null for active collectors.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet where the collector device is installed. Critical for tower-mounted collectors and radio frequency propagation modeling.',
    `endpoint_capacity` STRING COMMENT 'Maximum number of AMI endpoints that this collector device can support based on manufacturer specifications and network design. Used for capacity planning and network expansion.',
    `endpoint_count` STRING COMMENT 'Current number of AMI endpoints (meters) actively registered and communicating through this collector. Used for load balancing and capacity planning.',
    `firmware_update_date` DATE COMMENT 'Date when the collector firmware was last updated. Used for tracking patch compliance and planning future updates.',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the collector device. Critical for security patch management, feature availability, and troubleshooting. Format varies by manufacturer.',
    `frequency_mhz` DECIMAL(18,2) COMMENT 'Radio frequency in megahertz on which the collector operates. Common frequencies include 900 MHz and 450 MHz bands. Critical for regulatory compliance and interference management.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the collector device location in decimal degrees. Used for GIS mapping, coverage analysis, and network topology visualization in ArcGIS.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the collector device location in decimal degrees. Used for GIS mapping, coverage analysis, and network topology visualization in ArcGIS.',
    `health_status` STRING COMMENT 'Overall health assessment of the collector device based on communication frequency, signal quality, error rates, and diagnostic metrics. Healthy indicates normal operation; degraded indicates performance issues; critical indicates imminent failure risk; offline indicates no communication.. Valid values are `healthy|degraded|critical|offline|unknown`',
    `installation_date` DATE COMMENT 'Date when the collector device was physically installed and commissioned in the field. Used for asset lifecycle tracking and warranty management.',
    `installation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the collector device was activated and began communicating with the AMI network. Provides exact commissioning time for audit and troubleshooting purposes.',
    `ip_address` STRING COMMENT 'IP address assigned to the collector device for network communication and remote management. May be static or dynamic depending on backhaul configuration.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful communication between the collector and the AMI head-end system. Used for health monitoring and outage detection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collector record was most recently updated. Used for change tracking and data quality monitoring.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the collector device network interface. Used for device authentication and network management.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special instructions, site access details, or historical information about the collector device. Used by field technicians and network engineers.',
    `operational_status` STRING COMMENT 'Current operational state of the collector device in the AMI network. Active collectors are in service and communicating with endpoints; inactive collectors are installed but not operational; maintenance indicates scheduled or unscheduled service; decommissioned collectors are retired from service.. Valid values are `active|inactive|maintenance|decommissioned|testing|failed`',
    `physical_address_line1` STRING COMMENT 'Primary street address line where the collector device is physically installed. Used for field service dispatch and asset location management.',
    `physical_address_line2` STRING COMMENT 'Secondary address line for additional location details such as building, suite, or tower designation.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the collector installation location.',
    `power_source` STRING COMMENT 'Primary power source for the collector device. AC mains is typical for fixed base stations; solar and battery are used for remote or mobile installations.. Valid values are `ac_mains|solar|battery|hybrid`',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or operating region where the collector is deployed. Used for multi-jurisdiction utilities and regional reporting.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Most recent backhaul signal strength measurement in dBm. Used for diagnosing connectivity issues and optimizing network performance. Typical range is -50 dBm (excellent) to -110 dBm (poor).',
    `state_province` STRING COMMENT 'State or province code where the collector device is located. Typically two-letter abbreviation for US states.',
    CONSTRAINT pk_ami_network_collector PRIMARY KEY(`ami_network_collector_id`)
) COMMENT 'Master record for each AMI fixed network collector (base station, tower-mounted receiver, or mobile collector) in the Sensus FlexNet infrastructure. Stores collector ID, collector type (fixed base station, mobile collector, repeater), physical location (address and GIS coordinates), coverage radius, number of endpoints served, communication protocol, backhaul connection type (cellular, fiber, DSL), installation date, firmware version, and operational status. Defines the AMI network topology that enables automated meter reading across the service territory.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` (
    `meter_size_type_id` BIGINT COMMENT 'Unique identifier for the meter size and type combination. Primary key for the reference table.',
    `primary_replacement_meter_size_type_id` BIGINT COMMENT 'Reference to the successor meter size and type that replaces this obsolete configuration. Null if no replacement defined.',
    `accuracy_class` STRING COMMENT 'AWWA or ISO accuracy classification for meters of this size (e.g., AWWA Class I, Class II; ISO R160, R250). Defines expected measurement precision and testing requirements.',
    `accuracy_percentage_low_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at the minimum detectable flow rate. Critical for NRW analysis.',
    `accuracy_percentage_normal_flow` DECIMAL(18,2) COMMENT 'Expected measurement accuracy as a percentage at normal operating flow rate.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type is currently approved for new installations in the utility service territory.',
    `ami_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMI endpoints for remote reading and interval data collection.',
    `amr_compatible_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type can be equipped with AMR endpoints for drive-by or walk-by reading.',
    `average_unit_cost_usd` DECIMAL(18,2) COMMENT 'Average procurement cost in United States Dollars (USD) for a meter of this size including hardware but excluding installation labor. Used for budgeting and capital planning.',
    `awwa_standard_code` STRING COMMENT 'Applicable AWWA standard governing this meter size and type (e.g., C700, C701, C702, C706, C708, C710, C713).. Valid values are `^C[0-9]{3}$`',
    `connection_type` STRING COMMENT 'Standard connection method for meters of this size (threaded, flanged, compression, saddle, direct bury). Determines installation requirements and compatibility.. Valid values are `threaded|flanged|compression|saddle|direct_bury`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was first created in the system.',
    `meter_size_type_description` STRING COMMENT 'Detailed description of the meter size type including typical applications, customer classes, and usage characteristics (e.g., Standard residential meter for single-family homes).',
    `display_name` STRING COMMENT 'Human-readable display name for the meter size (e.g., 5/8 inch, 3/4 inch, 1 inch, 2 inch). Used in user interfaces, reports, and customer communications.',
    `effective_date` DATE COMMENT 'Date when this meter size and type was approved for use in the utility service territory.',
    `effective_end_date` DATE COMMENT 'Date when this meter size type was discontinued or superseded. Null for currently active meter size types. Used for phase-out planning and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this meter size type became available for use in the utilitys meter inventory. Supports historical tracking and version control.',
    `expected_service_life_years` STRING COMMENT 'Typical operational lifespan in years before meter replacement is recommended due to accuracy degradation.',
    `flange_standard` STRING COMMENT 'Flange specification for flanged connections (e.g., ANSI Class 125, ANSI Class 250). Applicable to larger meter sizes requiring bolted connections.',
    `installation_labor_hours` DECIMAL(18,2) COMMENT 'Typical labor hours required to install or replace a meter of this size. Used for work order planning, crew scheduling, and cost estimation.',
    `installation_orientation` STRING COMMENT 'Required or recommended installation orientation for accurate measurement (horizontal, vertical, or any orientation).. Valid values are `horizontal|vertical|any`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter size and type record was last updated.',
    `lead_free_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter size and type meets lead-free certification requirements under the Safe Drinking Water Act and LCRR.',
    `length_inches` DECIMAL(18,2) COMMENT 'Overall length of the meter body in inches. Critical for vault and pit sizing during installation.',
    `max_continuous_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum flow rate in gallons per minute that the meter can sustain continuously without damage or accuracy degradation.',
    `max_registered_flow_gpm` DECIMAL(18,2) COMMENT 'Peak flow rate in gallons per minute that the meter can register accurately for short durations.',
    `maximum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum continuous flow rate in gallons per minute (GPM) for meters of this size. Defines the upper capacity limit for safe and accurate operation.',
    `maximum_intermittent_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum short-duration or peak flow rate in gallons per minute (GPM) that the meter can handle without damage. Used for surge and peak demand scenarios.',
    `measurement_class` STRING COMMENT 'AWWA accuracy classification (Class I through Class IV). Higher classes indicate greater accuracy at low flow rates.. Valid values are `class_i|class_ii|class_iii|class_iv`',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches. Standard sizes include 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12 inches per AWWA standards.',
    `meter_size_type_status` STRING COMMENT 'Current lifecycle status of this meter size type in the reference catalog (active, inactive, obsolete, pending approval). Controls availability for new installations.. Valid values are `active|inactive|obsolete|pending_approval`',
    `meter_type` STRING COMMENT 'Technology classification of the water meter. Defines the measurement principle used to register flow.. Valid values are `positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service`',
    `min_detectable_flow_gpm` DECIMAL(18,2) COMMENT 'Lowest flow rate in gallons per minute that the meter can detect and register. Critical for leak detection and low-flow accuracy.',
    `minimum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum measurable flow rate in gallons per minute (GPM) for meters of this size. Defines the lower accuracy threshold for consumption measurement.',
    `normal_operating_flow_gpm` DECIMAL(18,2) COMMENT 'Typical sustained flow rate in gallons per minute for which the meter is optimally designed. Used for meter sizing and selection.',
    `normal_operating_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Typical or recommended operating flow rate in gallons per minute (GPM) for optimal meter accuracy and longevity. Used for sizing and capacity planning.',
    `notes` STRING COMMENT 'Additional technical notes, installation guidance, or special considerations for this meter size and type.',
    `nsf_61_certified_flag` BOOLEAN COMMENT 'Indicates whether this meter is certified to NSF/ANSI Standard 61 for drinking water system components.',
    `obsolete_date` DATE COMMENT 'Date when this meter size and type was discontinued or phased out for new installations. Null if still active.',
    `pressure_loss_at_max_flow_psi` DECIMAL(18,2) COMMENT 'Expected pressure loss in pounds per square inch (PSI) across the meter at maximum continuous flow rate. Critical for hydraulic modeling and system pressure management.',
    `pressure_rating_psi` STRING COMMENT 'Maximum working pressure in pounds per square inch that the meter can withstand without failure.',
    `register_capacity_gallons` BIGINT COMMENT 'Maximum cumulative volume in gallons that the meter register can display before rolling over. Important for billing cycle planning and register overflow detection.',
    `register_type` STRING COMMENT 'Type of register used to display consumption. Mechanical for analog dials, electronic for digital displays, encoder for AMI/AMR integration.. Valid values are `mechanical|electronic|encoder`',
    `service_connection_type` STRING COMMENT 'Standard connection method for installing this meter size (threaded, flanged, or compression fitting).. Valid values are `threaded|flanged|compression`',
    `size_code` STRING COMMENT 'Short alphanumeric code representing the meter size (e.g., 5/8, 3/4, 1, 1.5, 2, 3, 4, 6, 8, 10, 12). Used as a lookup key in operational systems.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches (e.g., 0.625 for 5/8 inch, 0.75 for 3/4 inch, 1.0, 1.5, 2.0, etc.). Primary measurement for meter sizing and capacity planning.',
    `size_millimeters` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in millimeters (e.g., 15mm, 20mm, 25mm, 40mm, 50mm, etc.). Used for international standards compliance and metric system reporting.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of meter sizes in user interfaces and reports (typically ordered from smallest to largest).',
    `straight_pipe_downstream_inches` STRING COMMENT 'Minimum length of straight pipe required downstream of the meter in inches to ensure accurate flow measurement.',
    `straight_pipe_upstream_inches` STRING COMMENT 'Minimum length of straight pipe required upstream of the meter in inches to ensure accurate flow measurement.',
    `temperature_rating_fahrenheit_max` STRING COMMENT 'Maximum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity.',
    `temperature_rating_fahrenheit_min` STRING COMMENT 'Minimum water temperature in Fahrenheit at which the meter maintains accuracy and structural integrity.',
    `testing_frequency_years` STRING COMMENT 'Recommended interval in years between accuracy testing and calibration per regulatory and utility standards.',
    `thread_standard` STRING COMMENT 'Thread specification for threaded connections (e.g., NPT, BSPT, AWWA). Ensures compatibility with service line fittings and meter setters.',
    `typical_application` STRING COMMENT 'Standard use case for this meter size and type (e.g., single-family residential, multi-family residential, commercial, industrial, fire service, irrigation).',
    `typical_customer_class` STRING COMMENT 'Primary customer class typically served by this meter size (residential, commercial, industrial, institutional, agricultural, municipal). Used for rate structure and billing configuration.. Valid values are `residential|commercial|industrial|institutional|agricultural|municipal`',
    `typical_service_life_years` STRING COMMENT 'Expected operational service life in years for meters of this size under normal operating conditions. Used for asset replacement planning and depreciation schedules.',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Approximate weight of the meter in pounds. Used for logistics, installation planning, and safety assessments.',
    CONSTRAINT pk_meter_size_type PRIMARY KEY(`meter_size_type_id`)
) COMMENT 'Master reference table for meter_size_type. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` (
    `endpoint_procurement_id` BIGINT COMMENT 'Primary key for the endpoint_procurement association',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to the AMI endpoint device that was procured from this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor who supplied this AMI endpoint',
    `procurement_date` DATE COMMENT 'Date when this endpoint was procured from this vendor. Used for tracking procurement history.',
    `procurement_order_number` STRING COMMENT 'Purchase order number associated with this procurement transaction.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Price paid to this vendor for this specific endpoint device. Explicitly identified in detection phase relationship data.',
    `support_contract_number` STRING COMMENT 'Vendor-assigned support contract identifier for technical support escalation. Explicitly identified in detection phase relationship data.',
    `vendor_part_number` STRING COMMENT 'Vendor-specific part number or SKU for this endpoint model. Used for reordering and warranty claims. Explicitly identified in detection phase relationship data.',
    `warranty_end_date` DATE COMMENT 'Date when the vendor warranty coverage expires for this endpoint. Explicitly identified in detection phase relationship data.',
    `warranty_start_date` DATE COMMENT 'Date when the vendor warranty coverage begins for this endpoint. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_endpoint_procurement PRIMARY KEY(`endpoint_procurement_id`)
) COMMENT 'This association product represents the procurement relationship between AMI endpoints and vendors. It captures vendor-specific procurement details for each endpoint device, including warranty terms, purchase pricing, vendor part numbers, and support contract information. Each record links one AMI endpoint to one vendor with attributes that exist only in the context of this procurement relationship.. Existence Justification: In water utility operations, AMI endpoints can be procured from multiple vendors over their lifecycle (original manufacturer, replacement parts distributor, warranty service provider), and each vendor supplies multiple endpoint devices across the utilitys service territory. The utility actively manages vendor-specific procurement records for warranty claims, technical support escalation, and replacement part sourcing, with each vendor relationship carrying distinct warranty terms, pricing, part numbers, and support contracts.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` (
    `meter_procurement_id` BIGINT COMMENT 'Unique identifier for this meter-vendor procurement record. Primary key.',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: meter_procurement represents the procurement relationship between physical meters and vendors. Each procurement is for a specific meter size/type (e.g., 5/8-inch residential, 2-inch commercial). Addin',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to the physical meter device in the metering domain',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor/supplier in the supply domain',
    `lead_time_days` BIGINT COMMENT 'Standard lead time in days for this vendor to deliver this meter model. Used for procurement planning and emergency replacement sourcing.',
    `procurement_status` STRING COMMENT 'Current status of this meter-vendor procurement relationship: Active (current source), Discontinued (no longer available), Preferred (primary supplier), Backup (secondary source), Under_Review (being evaluated).',
    `purchase_date` DATE COMMENT 'The date this specific meter was purchased from this vendor. Used for warranty period calculation and procurement history tracking.',
    `purchase_price` DECIMAL(18,2) COMMENT 'The unit price paid to this vendor for this meter at time of purchase. Enables cost analysis and vendor price comparison for competitive bidding.',
    `vendor_part_number` STRING COMMENT 'The vendor-specific part number or SKU for this meter model as cataloged by this particular vendor. Critical for procurement orders and warranty claims.',
    `warranty_end_date` DATE COMMENT 'The date warranty coverage expires for this meter from this vendor. Critical for warranty claim eligibility and maintenance planning.',
    `warranty_start_date` DATE COMMENT 'The date warranty coverage begins for this meter from this vendor. May differ from purchase date based on installation or activation terms.',
    CONSTRAINT pk_meter_procurement PRIMARY KEY(`meter_procurement_id`)
) COMMENT 'This association product represents the procurement relationship between physical meter devices and their suppliers. It captures vendor-specific procurement terms, pricing, warranty coverage, and part numbers for each meter-vendor combination. Each record links one meter to one vendor with attributes that exist only in the context of this procurement relationship, enabling competitive bidding analysis, warranty claim processing, and multi-source supply chain management.. Existence Justification: Water utilities procure the same meter models from multiple approved vendors through competitive bidding, regional supplier networks, and backup sourcing strategies. Each meter-vendor combination has distinct procurement terms including vendor-specific part numbers, negotiated pricing, warranty coverage periods, and lead times. The utility actively manages these procurement relationships to optimize costs, ensure supply chain resilience, and process warranty claims.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` (
    `alert_rule_id` BIGINT COMMENT 'Primary key for alert_rule',
    `escalation_alert_rule_id` BIGINT COMMENT 'Self-referencing FK on alert_rule (escalation_alert_rule_id)',
    `condition_operator` STRING COMMENT 'Comparison operator used in the rule condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert rule record was created.',
    `alert_rule_description` STRING COMMENT 'Detailed description of the purpose and logic of the alert rule.',
    `effective_from` DATE COMMENT 'Date from which the alert rule becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the alert rule is no longer effective (nullable).',
    `enabled_flag` BOOLEAN COMMENT 'Indicates whether the alert rule is active.',
    `escalation_level` STRING COMMENT 'Numeric level indicating escalation hierarchy for the alert.',
    `evaluation_frequency_minutes` STRING COMMENT 'How often the rule is evaluated, in minutes.',
    `is_system_rule` BOOLEAN COMMENT 'Indicates if the rule is a built-in system rule.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of the rule.',
    `last_triggered_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule last generated an alert.',
    `metric_name` STRING COMMENT 'Name of the metric or measurement the rule evaluates (e.g., flow_rate, pressure).',
    `alert_rule_name` STRING COMMENT 'Descriptive name of the alert rule.',
    `notification_channel` STRING COMMENT 'Channel(s) used to deliver alert notifications.',
    `owner` STRING COMMENT 'Identifier of the person or team responsible for the rule.',
    `rule_category` STRING COMMENT 'High-level category of the alert rule.',
    `rule_type` STRING COMMENT 'Specifies the type of logic the rule uses.',
    `severity` STRING COMMENT 'Severity level assigned to alerts generated by this rule.',
    `alert_rule_status` STRING COMMENT 'Current lifecycle status of the alert rule.',
    `tags` STRING COMMENT 'Optional free-form tags for categorization.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers the alert.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the threshold value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert rule.',
    CONSTRAINT pk_alert_rule PRIMARY KEY(`alert_rule_id`)
) COMMENT 'Master reference table for alert_rule. Referenced by alert_rule_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` (
    `validation_rule_id` BIGINT COMMENT 'Primary key for validation_rule',
    `meter_size_type_id` BIGINT COMMENT 'add column meter_size_type_id (BIGINT) with FK to metering.meter_size_type.meter_size_type_id - validation rules for reads vary by meter size/type',
    `parent_validation_rule_id` BIGINT COMMENT 'Self-referencing FK on validation_rule (parent_validation_rule_id)',
    `applicable_entity` STRING COMMENT 'Entity or domain to which the rule applies.',
    `condition_expression` STRING COMMENT 'Logical expression evaluated to enforce the rule (e.g., SQL‑like or DSL).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the rule expires (null if indefinite).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the rule is currently active.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the rule.',
    `rule_category` STRING COMMENT 'Broad category indicating the type of rule.',
    `rule_description` STRING COMMENT 'Detailed description of the rule logic and purpose.',
    `rule_name` STRING COMMENT 'Human‑readable name of the validation rule.',
    `severity` STRING COMMENT 'Severity level indicating impact of rule violation.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold used by the rule when applicable.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the rule.',
    CONSTRAINT pk_validation_rule PRIMARY KEY(`validation_rule_id`)
) COMMENT 'Master reference table for validation_rule. Referenced by validation_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_replacement_program_id` FOREIGN KEY (`replacement_program_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`replacement_program`(`replacement_program_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_metering_prv_installation_id` FOREIGN KEY (`metering_prv_installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_metering_zone_meter_installation_id` FOREIGN KEY (`metering_zone_meter_installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_read_route_id` FOREIGN KEY (`read_route_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read_route`(`read_route_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`validation_rule`(`validation_rule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_read_id` FOREIGN KEY (`read_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`read`(`read_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ADD CONSTRAINT `fk_metering_meter_size_type_primary_replacement_meter_size_type_id` FOREIGN KEY (`primary_replacement_meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ADD CONSTRAINT `fk_metering_alert_rule_escalation_alert_rule_id` FOREIGN KEY (`escalation_alert_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`alert_rule`(`alert_rule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ADD CONSTRAINT `fk_metering_validation_rule_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ADD CONSTRAINT `fk_metering_validation_rule_parent_validation_rule_id` FOREIGN KEY (`parent_validation_rule_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`validation_rule`(`validation_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_meter` ALTER COLUMN `asset_meter_id` SET TAGS ('dbx_ssot_owner' = 'asset.asset_meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_network_collector_id` SET TAGS ('dbx_business_glossary_term' = 'FlexNet Collector Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_expected_life_years` SET TAGS ('dbx_business_glossary_term' = 'Battery Expected Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_install_date` SET TAGS ('dbx_business_glossary_term' = 'Battery Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'RF|Cellular|LoRaWAN|NB-IoT|Other');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention in Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'AES-128|AES-256|None');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_key_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Device Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'ERT|MXU|iPerl|Orion|Ally|Other');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `installation_technician` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_firmware_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_alert_threshold_gpm` SET TAGS ('dbx_business_glossary_term' = 'Leak Alert Threshold in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `leak_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Enabled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Failed|Maintenance|Decommissioned');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `read_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Read Interval in Seconds');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Signal Quality Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_quality_indicator` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|No Signal');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detected Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_business_glossary_term' = 'Tamper Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_status` SET TAGS ('dbx_value_regex' = 'Normal|Tamper Detected|Magnetic Interference|Physical Removal|Reverse Flow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_network_collector_id` SET TAGS ('dbx_business_glossary_term' = 'Collector ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `consumption_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Consumption Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|missing|tampered|overflow');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `estimated_method` SET TAGS ('dbx_value_regex' = 'none|linear_interpolation|historical_average|same_day_prior_week|zero_fill|carry_forward');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `high_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `pulse_increment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Pulse Increment in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `raw_pulse_count` SET TAGS ('dbx_business_glossary_term' = 'Raw Pulse Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `tamper_event_code` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `transmission_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Retry Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consumption Profile ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_validated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `adjustment_amount_gallons` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `average_daily_usage_gpd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Handoff Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Consumption Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_status` SET TAGS ('dbx_value_regex' = 'validated|estimated|prorated|adjusted|disputed|final');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_tier` SET TAGS ('dbx_business_glossary_term' = 'Consumption Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_tier` SET TAGS ('dbx_value_regex' = 'tier_1_base|tier_2_standard|tier_3_high|tier_4_excessive|tier_5_penalty');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `consumption_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Consumption Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|wholesale');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `estimated_read_reason` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `estimated_read_reason` SET TAGS ('dbx_value_regex' = 'meter_inaccessible|meter_malfunction|communication_failure|weather_event|customer_refusal|other');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `high_usage_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `interval_data_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Interval Data Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Inches');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `meter_technology` SET TAGS ('dbx_business_glossary_term' = 'Meter Technology');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `meter_technology` SET TAGS ('dbx_value_regex' = 'ami_fixed_network|amr_mobile|mechanical_register|smart_meter|ultrasonic|electromagnetic');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `minimum_night_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `nrw_contribution_gallons` SET TAGS ('dbx_business_glossary_term' = 'Non-Revenue Water (NRW) Contribution Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `peak_day_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Peak Day Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `peak_day_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Day Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `prior_period_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `prior_year_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `read_method` SET TAGS ('dbx_value_regex' = 'ami_interval|amr_drive_by|manual_field|customer_self_read|estimated');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `reverse_flow_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `seasonal_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Factor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|reclaimed_water|raw_water|fire_service|irrigation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `total_consumption_ccf` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption Hundred Cubic Feet (CCF)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `total_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `weather_normalized_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Weather Normalized Consumption Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`consumption_profile` ALTER COLUMN `zero_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Consumption Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Leak Duration in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_location_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_business_glossary_term' = 'Leak Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_status` SET TAGS ('dbx_value_regex' = 'detected|confirmed|under_investigation|resolved|false_positive|customer_notified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `leak_type` SET TAGS ('dbx_business_glossary_term' = 'Leak Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `minimum_night_flow_anomaly_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (MNF) Anomaly Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone_call|postal_mail|customer_portal|mobile_app');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Leak Resolution Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`leak_detection_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'customer_repaired|utility_repaired|false_positive|no_action_required|under_investigation|pending_customer_action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `service_order_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Order Created Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters|gpm|mgd|percent');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_program` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_program_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` SET TAGS ('dbx_subdomain' = 'field_operations');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_type` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `dma_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|mixed_use|rural|institutional');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'DMA Established Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `hydraulic_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Model Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `infrastructure_leakage_index` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Leakage Index (ILI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `isolation_valve_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Valve Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `last_leak_detection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leak Detection Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `leak_detection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_status` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `metering_dma_zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction|maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `minimum_night_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Night Flow (GPM - Gallons per Minute)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DMA Zone Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `predominant_pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Predominant Pipe Material');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `responsible_operations_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operations Team');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `scada_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitoring Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `scada_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `service_connection_count` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `target_nrw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Non-Revenue Water (NRW) Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `total_pipe_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Pipe Length (Miles)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_dma_zone` ALTER COLUMN `ufw_gallons_per_connection_per_day` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted-for Water (UFW) Gallons per Connection per Day');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_nrw_water_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for metering_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `metering_dma_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Dma Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Nrw Loss General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance` ALTER COLUMN `distribution_nrw_water_balance_id` SET TAGS ('dbx_ssot_owner' = 'distribution.distribution_nrw_water_balance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `tamper_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tamper Event Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`tamper_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `leak_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `prior_read_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Read Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `register_overflow_flag` SET TAGS ('dbx_business_glossary_term' = 'Register Overflow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 're_read|estimate_accepted|read_corrected|meter_replaced|field_visit_scheduled|no_action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_exception` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` SET TAGS ('dbx_subdomain' = 'anomaly_detection');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `metering_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`metering_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_ssot_owner' = 'customer.customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` SET TAGS ('dbx_subdomain' = 'field_operations');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `leak_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `meter_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Meter Condition Rating');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `meter_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `obstruction_description` SET TAGS ('dbx_business_glossary_term' = 'Obstruction Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `obstruction_noted_flag` SET TAGS ('dbx_business_glossary_term' = 'Obstruction Noted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Reference');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `photo_evidence_reference` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_debris_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Pit Debris Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_vault_condition` SET TAGS ('dbx_business_glossary_term' = 'Pit Vault Condition');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_vault_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|hazardous');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `pit_water_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Pit Water Present Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_readable_flag` SET TAGS ('dbx_business_glossary_term' = 'Register Readable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_reading` SET TAGS ('dbx_business_glossary_term' = 'Register Reading');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Register Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|cubic_feet|cubic_meters');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `seal_number_verified` SET TAGS ('dbx_business_glossary_term' = 'Seal Number Verified');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `tamper_description` SET TAGS ('dbx_business_glossary_term' = 'Tamper Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_field_inspection` ALTER COLUMN `tamper_evidence_flag` SET TAGS ('dbx_business_glossary_term' = 'Tamper Evidence Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` SET TAGS ('dbx_subdomain' = 'device_registry');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_type` SET TAGS ('dbx_business_glossary_term' = 'Collector Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `collector_type` SET TAGS ('dbx_value_regex' = 'fixed_base_station|mobile_collector|repeater|tower_mounted_receiver|gateway|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'flexnet|mesh|point_to_multipoint|cellular|lora|zigbee');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `health_status` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|testing|failed');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `power_source` SET TAGS ('dbx_business_glossary_term' = 'Power Source');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `power_source` SET TAGS ('dbx_value_regex' = 'ac_mains|solar|battery|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength in Decibels Milliwatt (dBm)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_network_collector` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_subdomain' = 'device_registry');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `flange_standard` SET TAGS ('dbx_business_glossary_term' = 'Flange Standard Specification');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Installation Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_business_glossary_term' = 'Installation Orientation');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `installation_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|any');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `lead_free_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `length_inches` SET TAGS ('dbx_business_glossary_term' = 'Length (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_continuous_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `max_registered_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Registered Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `maximum_intermittent_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Intermittent Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Class');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `measurement_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iv');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_size_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'positive_displacement|turbine|compound|electromagnetic|ultrasonic|fire_service');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `min_detectable_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `normal_operating_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `nsf_61_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF 61 Certified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_loss_at_max_flow_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Loss at Maximum Flow in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Register Capacity in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Register Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|encoder');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `service_connection_type` SET TAGS ('dbx_value_regex' = 'threaded|flanged|compression');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Code');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `size_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` SET TAGS ('dbx_association_edges' = 'metering.ami_endpoint,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `endpoint_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Endpoint Procurement Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Ami Endpoint Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Procurement - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `procurement_order_number` SET TAGS ('dbx_business_glossary_term' = 'Procurement Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `support_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`endpoint_procurement` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_subdomain' = 'device_registry');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` SET TAGS ('dbx_association_edges' = 'metering.metering_meter,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement - Metering Metering Meter Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Procurement - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_procurement` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `is_system_rule` SET TAGS ('dbx_business_glossary_term' = 'Is System Rule');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `last_triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Triggered Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `metric_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `alert_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`alert_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` SET TAGS ('dbx_subdomain' = 'consumption_measurement');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `validation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `parent_validation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Validation Rule Id');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `parent_validation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `applicable_entity` SET TAGS ('dbx_business_glossary_term' = 'Applicable Entity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`validation_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
