-- Schema for Domain: metering | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`metering` COMMENT 'Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Primary key for meter',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Water meters are capital assets requiring fixed asset accounting for depreciation, asset retirement obligations, and GASB compliance. Meter populations represent significant utility plant investment r',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Each installed meter corresponds to a material master record for procurement, inventory management, warranty tracking, and cost allocation. Procurement teams order meters by material number; warehouse',
    `location_id` BIGINT COMMENT '',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Meter size and type combinations are standardized configurations defined in the meter_size_type reference table. The metering_meter table currently stores meter_size_inches and meter_type as denormali',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Each meter has a governing PM schedule defining testing frequency, replacement intervals, and maintenance tasks (AWWA standards). A direct FK from metering_meter to pm_schedule supports meter maintena',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Master inventory record for every physical meter device deployed across the water and wastewater service territory. Captures meter make, model, size, type (AMI/AMR/manual), serial number, manufacturer, installation date, current status, register type, pulse output factor, maximum flow rate (GPM), meter generation, and communication module type. Includes bulk/compound meters, fire service meters, and all residential/commercial/industrial meter classes. Serves as the authoritative SSOT for meter device identity and specifications within the metering domain.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`installation` (
    `installation_id` BIGINT COMMENT 'Primary key for installation',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: A meter installation is the direct physical fulfillment of an approved connection application. New service fulfillment tracking and regulatory audit trails require a direct link from the resulting ins',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA-level meter installation inventory and NRW/water balance accounting require knowing which meter installations belong to each DMA. Water utilities reconcile meter counts per DMA for minimum night f',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Meter installations are physically located at specific asset locations (vaults, curb boxes, service connections). Field crews use this link for maintenance dispatch and GIS mapping. The asset.location',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: An installation represents the deployment of a physical meter device at a service location. The installation MUST reference which specific meter (from meter inventory) is installed. This is the core r',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: A meter installation physically realizes a service points metering setup. Service activation, field dispatch, and billing validation workflows require tracing which installation is active at a given ',
    `read_route_id` BIGINT COMMENT 'Foreign key linking to metering.read_route. Business justification: A read_route organizes meter installations for scheduled AMR drive-by, walk-by, or manual reading operations. While individual read records already capture read_route_id (the route used for a specific',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: A meter installation is activated under a service agreement — billing reads, consumption history, and account management all depend on knowing which service agreement governs a given installation. Wat',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Meter installations performed as part of CIP projects (main replacements, AMI deployments, system expansions) require project linkage for capital cost allocation, asset capitalization, project closeou',
    CONSTRAINT pk_installation PRIMARY KEY(`installation_id`)
) COMMENT 'Tracks the physical installation of a meter at a service location, linking a specific meter device to a service address and customer account. Records installation date, installer ID, work order reference, meter position (pit, vault, curb box), setter size, service line material, lock/seal number, initial register reading at installation, and removal date when replaced. Maintains the full history of which meter served which location over time, supporting NRW analysis and billing continuity.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier for the AMI/AMR communication endpoint device. Primary key for the endpoint registry.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area that this endpoint belongs to. Used for water loss analysis and pressure zone management.',
    `meter_id` BIGINT COMMENT 'Reference to the physical water meter that this AMI endpoint is attached to. An endpoint may be replaced independently of the meter.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: AMI endpoints are deployed at service points. service.point has ami_enabled flag but no FK to the actual endpoint record. AMI deployment tracking, remote monitoring operations, and endpoint replacemen',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: AMI endpoint deployments are capital projects requiring tracking for warranty management, project performance metrics, capital cost allocation, and grant reporting. Utilities must trace each endpoint',
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
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle during which this interval occurred. Used to aggregate interval data for billing purposes and time-of-use rate calculations.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area where this meter is located. Used for Non-Revenue Water (NRW) analysis, pressure zone management, and distribution network optimization.',
    `installation_id` BIGINT COMMENT 'Reference to the specific meter installation that generated this interval reading. Links to the meter installation registry in the metering domain.',
    `registry_id` BIGINT COMMENT 'Identifier for the AMI collector (gateway) that received this interval reading from the endpoint. Used for network topology analysis and troubleshooting.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` (
    `high_usage_alert_id` BIGINT COMMENT 'Unique identifier for the high usage alert record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: High usage alerts must be traced to the service agreement to determine applicable rates, conservation program eligibility, and billing adjustment authority. Customer service resolution and billing dis',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: High usage alerts notify account holders to prevent bill shock. Core customer service function requiring account contact information, notification preferences, and alert history tracking for customer',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: High usage alerts trigger field investigation work orders for meter inspection or leak detection. The existing order_id FK points to service.order (customer-facing); this role-prefixed FK captures the',
    `installation_id` BIGINT COMMENT 'Reference to the meter installation that triggered this high usage alert. Links to the specific meter deployment at a service location.',
    `order_id` BIGINT COMMENT 'Reference to the field service order created to investigate or resolve this alert. Links to work order management system. Null if no service order created.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: High usage alerts are anchored to service points — the canonical service delivery location. Field investigation dispatch, customer notification workflows, and leak detection reporting all operate at t',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: High usage alerts analyzed by premise type for pattern detection. Required for identifying systemic issues by building type, seasonal usage anomalies, and targeting conservation messaging to specific',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI endpoint device (Sensus FlexNet or similar) that generated the consumption data triggering this alert. Used for device diagnostics and data quality validation.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: High usage alerts tied to physical locations for field investigation. Essential for dispatching field crews, correlating alerts with address characteristics, and geographic pattern analysis for leak d',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: High usage alerts trigger billing adjustments, leak investigation service orders, and customer notifications — all governed by the service agreement. Existing FKs cover account/premise/address but not',
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
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Meter accuracy tests are a regulated inspection activity (state PUC and AWWA requirements). Linking to inspection_event enables formal inspection record-keeping, pass/fail outcomes, and next-due-date ',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Accuracy tests are performed on physical meter devices to assess measurement accuracy and compliance with standards. Each test record must reference which specific meter was tested. FK named metering_',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Accuracy tests can be performed in the field (in-situ testing) at a specific meter installation, or in a lab/bench setting. For field tests, this FK links the test to the installation location. This F',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspections (PUC, state agency) specifically mandate and review meter accuracy tests. Linking accuracy_test to the triggering regulatory_inspection supports the named process meter accurac',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Meter accuracy testing frequency and standards are mandated by specific regulatory requirements (AWWA M6, state PUC rules). Linking accuracy_test to the governing regulatory_requirement enables compli',
    CONSTRAINT pk_accuracy_test PRIMARY KEY(`accuracy_test_id`)
) COMMENT 'Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` (
    `replacement_order_id` BIGINT COMMENT 'Primary key for replacement_order',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: replacement_order captures old_meter_accuracy_test_result as a scalar value but lacks FK to the actual accuracy_test record that triggered the replacement. Meter replacements are often driven by faile',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement actions (e.g., LCR lead service line mandates, PUC accuracy orders) can directly mandate meter replacement programs. Linking replacement_order to enforcement_action enables tracking of enf',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: A replacement order is executed at a specific meter installation (service location). The replacement_order currently tracks old_metering_meter_id (the meter being replaced) and work_order_id, but has ',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.replacement_program. Business justification: Replacement orders are often executed as part of a structured replacement program or campaign (age-based, accuracy-based, technology upgrade). This FK links individual replacement work orders to their',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: A replacement order replaces an existing (old) meter with a new meter. This FK tracks which physical meter device was removed/replaced. This is the first of two FKs to metering_meter (old and new), re',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Meter replacements are frequently driven by PM schedules (end-of-life replacement cycles, testing-frequency-triggered replacements). Linking replacement_order to pm_schedule enables utilities to track',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Replacement orders trigger material requisitions to pull meter stock from warehouse for installation crews. Work order execution requires reservation/requisition of specific meter inventory, linking f',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Meter replacements are frequently mandated as corrective action for metering accuracy compliance violations (e.g., meters failing accuracy thresholds). Linking replacement_order to the triggering comp',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Each meter replacement is executed via work order that schedules crews, tracks labor/materials, manages old meter disposal, and closes out capital projects. Standard utility field service workflow lin',
    CONSTRAINT pk_replacement_order PRIMARY KEY(`replacement_order_id`)
) COMMENT 'Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`metering`.`read_route` (
    `read_route_id` BIGINT COMMENT 'Primary key for read_route',
    `dma_id` BIGINT COMMENT 'add column dma_id (BIGINT) with FK to distribution.dma.dma_id - read routes typically align with district metered areas for operational efficiency',
    `territory_id` BIGINT COMMENT 'add column territory_id (BIGINT) with FK to service.territory.territory_id - meter read routes are organized within service territories',
    `created_at` TIMESTAMP COMMENT '',
    `estimated_read_time_minutes` BIGINT COMMENT '',
    `geographic_area` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `meter_count` BIGINT COMMENT '',
    `route_code` STRING COMMENT '',
    `route_description` STRING COMMENT '',
    `route_name` STRING COMMENT '',
    `route_sequence` BIGINT COMMENT '',
    CONSTRAINT pk_read_route PRIMARY KEY(`read_route_id`)
) COMMENT 'Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery.';

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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`installation`(`installation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter`(`meter_id`);
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` ADD CONSTRAINT `fk_metering_meter_size_type_primary_replacement_meter_size_type_id` FOREIGN KEY (`primary_replacement_meter_size_type_id`) REFERENCES `vibe_water_utilities_v1`.`metering`.`meter_size_type`(`meter_size_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `location_id` SET TAGS ('dbx_ssot_owner' = 'asset.asset_meter');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`installation` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'device_inventory');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`ami_endpoint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_id` SET TAGS ('dbx_business_glossary_term' = 'Read Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `interval_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Consumption ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation ID');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`interval_consumption` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Collector ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `high_usage_alert_id` SET TAGS ('dbx_business_glossary_term' = 'High Usage Alert Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Investigation Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`high_usage_alert` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` SET TAGS ('dbx_subdomain' = 'meter_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`accuracy_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` SET TAGS ('dbx_subdomain' = 'meter_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Program Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`replacement_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` SET TAGS ('dbx_subdomain' = 'reading_operations');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `read_route_id` SET TAGS ('dbx_business_glossary_term' = 'Read Route Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`read_route` ALTER COLUMN `route_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`metering`.`meter_size_type` SET TAGS ('dbx_subdomain' = 'device_inventory');
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
