-- Schema for Domain: automation | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`automation` COMMENT 'Industrial IoT, SCADA, PLC programming, and automation systems domain managing device registries, control system configurations, OPC-UA tag definitions, edge gateway data, and real-time process control parameters for smart manufacturing';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` (
    `device_registry_id` BIGINT COMMENT 'System-generated unique identifier for the device registry record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Site‑level device inventory needed for maintenance scheduling and site‑specific service contracts.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Maintenance BOM links physical components to devices for spare‑part tracking; required in Asset Maintenance Bill of Materials report.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPEX tracking: each device is assigned to a cost center for depreciation and maintenance budgeting, required for the Asset Capitalization Report.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Asset inventory report requires linking each device to its owning customer for warranty, support, and billing.',
    `equipment_register_id` BIGINT COMMENT 'FK to asset.equipment_register.equipment_register_id — Automation devices (PLCs, sensors) are physically installed on equipment assets. This link enables asset-to-device correlation for maintenance planning and OT/IT convergence queries.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Maintenance Management System requires tracking which technician is responsible for each device for compliance and OEE reporting.',
    `network_segment_id` BIGINT COMMENT '',
    `parent_device_registry_id` BIGINT COMMENT 'Self-referencing FK on device_registry (parent_device_registry_id)',
    `asset_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant hosting the device.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or cell where the device operates.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Procurement tracks which supplier provided each device for warranty, maintenance, and cost allocation; required for Asset Management reports.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or station associated with the device.',
    `commissioning_date` DATE COMMENT 'Date the device was first placed into service.',
    `communication_protocol` STRING COMMENT 'Primary industrial communication protocol used by the device.. Valid values are `OPC-UA|Modbus|PROFINET|EtherNet/IP|BACnet|MQTT`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device registry record was first created.',
    `current_rating_a` DECIMAL(18,2) COMMENT 'Maximum continuous current draw of the device in amperes.',
    `decommission_date` DATE COMMENT 'Date the device was retired or removed from service.',
    `device_registry_description` STRING COMMENT 'Free‑form textual description of the device and its purpose.',
    `device_code` STRING COMMENT 'Business identifier or asset tag used to reference the device in operational systems.',
    `device_registry_status` STRING COMMENT 'Current operational condition of the device.. Valid values are `active|inactive|maintenance|faulted|decommissioned`',
    `device_type` STRING COMMENT 'Classification of the device (e.g., PLC, HMI, RTU, DCS, Edge Gateway, Sensor).. Valid values are `PLC|HMI|RTU|DCS|EdgeGateway|Sensor`',
    `firmware_version` STRING COMMENT 'Version identifier of the device firmware currently installed.',
    `hardware_version` STRING COMMENT 'Version identifier of the device hardware revision.',
    `ip_address` STRING COMMENT 'IPv4 address assigned to the device for network communication.. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the device within asset management.. Valid values are `in_service|retired|pending|decommissioned|suspended`',
    `mac_address` STRING COMMENT 'Media Access Control address of the devices network interface.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `maintenance_status` STRING COMMENT 'Current maintenance compliance status of the device.. Valid values are `up_to_date|overdue|scheduled|not_applicable`',
    `manufacturer` STRING COMMENT '',
    `model_number` STRING COMMENT 'Vendor‑assigned model number of the device.',
    `device_registry_name` STRING COMMENT 'Human‑readable name of the automation device.',
    `network_address` STRING COMMENT 'Hostname or DNS name used to reach the device on the network.',
    `notes` STRING COMMENT 'Any supplemental remarks, installation notes, or special handling instructions.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Approved ambient temperature range for device operation in degrees Celsius.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power rating of the device in kilowatts.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the device registry record.',
    `voltage_rating_v` DECIMAL(18,2) COMMENT 'Nominal operating voltage of the device in volts.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty for the device expires.',
    CONSTRAINT pk_device_registry PRIMARY KEY(`device_registry_id`)
) COMMENT 'Master record for all industrial automation devices including PLCs, HMIs, SCADA servers, edge gateways, sensors, actuators, drives, and IIoT endpoints deployed across manufacturing facilities. Serves as the SSOT for device identity, firmware version, hardware model, communication protocol, network address, installation location, operational status, and lifecycle state. Each device is uniquely identified and linked to a plant, production line, or work center. Captures device type classification (PLC, HMI, RTU, DCS, edge node), vendor, model number, serial number, firmware version, IP address, MAC address, communication protocol (OPC-UA, Modbus, PROFINET, EtherNet/IP), commissioning date, decommission date, and current operational status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`control_system` (
    `control_system_id` BIGINT COMMENT 'Unique surrogate key for the control system record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OPEX allocation: control systems incur operational expenses charged to a cost center, needed for the Monthly Operations Cost Report.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Control system ownership drives SLA terms, billing, and compliance reporting per customer.',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to automation.network_segment. Business justification: Control system records a network segment; using FK to network_segment enables network topology management and removes the free‑text segment field.',
    `parent_control_system_id` BIGINT COMMENT 'Self-referencing FK on control_system (parent_control_system_id)',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Control system configuration is managed per product family; maintenance plans and safety standards reference the family.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Control system contracts are managed per supplier; linking enables support contract tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Control system ownership and maintenance responsibility are recorded per system for safety audits and change management.',
    `alarm_capacity` STRING COMMENT 'Maximum number of concurrent alarms the system can handle.',
    `commissioning_date` DATE COMMENT 'Date when the control system was commissioned and first put into service.',
    `communication_protocol` STRING COMMENT 'Primary industrial communication protocol used by the system.. Valid values are `OPC-UA|Modbus|PROFIBUS|EtherNet/IP`',
    `control_program_version` STRING COMMENT 'Version identifier of the main control logic program deployed on the system.',
    `control_system_status` STRING COMMENT '',
    `control_system_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the control system record was first created in the data lake.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long configuration and log data are retained.',
    `decommission_date` DATE COMMENT 'Date when the control system was retired or removed from service (nullable).',
    `control_system_description` STRING COMMENT 'Free‑form description of the control system purpose and scope.',
    `device_count` STRING COMMENT 'Number of individual devices (e.g., PLCs, I/O modules) that belong to the control system.',
    `engineering_workstation` STRING COMMENT 'Identifier of the primary engineering workstation used for configuration.',
    `installation_date` DATE COMMENT 'Calendar date when the control system was physically installed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the control system is classified as critical to plant operation.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent compliance audit of the control system.',
    `last_config_backup_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent configuration backup of the control system.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the control system.. Valid values are `design|installed|operational|maintenance|decommissioned|retired`',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average elapsed time between successive failures, expressed in hours.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the system after a failure.',
    `control_system_name` STRING COMMENT 'Human‑readable name of the control system as used by engineering and operations.',
    `notes` STRING COMMENT 'Additional remarks, special instructions, or historical notes.',
    `operational_status` DECIMAL(18,2) COMMENT 'Real‑time operational state of the control system.',
    `plant_area` STRING COMMENT 'Physical area or production line where the control system is deployed.',
    `redundancy_configuration` DECIMAL(18,2) COMMENT 'Describes the redundancy scheme applied to the control system.',
    `redundancy_level` STRING COMMENT '',
    `safety_integrity_level` STRING COMMENT 'Safety certification level of the system as defined by IEC 61508.. Valid values are `SIL0|SIL1|SIL2|SIL3|SIL4`',
    `security_classification` STRING COMMENT 'Data security classification of the control system record.. Valid values are `Confidential|Restricted|Public`',
    `software_version` STRING COMMENT 'Version string of the control system runtime software.',
    `system_code` STRING COMMENT 'Business identifier or tag used to reference the control system in plant documentation and ERP.',
    `system_type` STRING COMMENT 'Categorizes the control system by its functional architecture.. Valid values are `DCS|SCADA|PLC|SIS|ESD`',
    `tag_count` STRING COMMENT 'Total number of OPC‑UA or PLC tags defined in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the control system record.',
    `uptime_hours` BIGINT COMMENT 'Cumulative number of hours the system has been in an online state.',
    `vendor` STRING COMMENT '',
    CONSTRAINT pk_control_system PRIMARY KEY(`control_system_id`)
) COMMENT 'Master record representing a discrete industrial control system instance — a named, configured automation system such as a DCS (Distributed Control System), SCADA system, PLC-based control panel, or safety instrumented system (SIS). Captures control system name, type (DCS, SCADA, PLC, SIS, ESD), vendor platform (Siemens S7, Allen-Bradley ControlLogix, ABB 800xA, Honeywell Experion), software version, redundancy configuration, safety integrity level (SIL), associated plant area, network segment, engineering workstation reference, last configuration backup date, and lifecycle status. Acts as the parent grouping entity for all devices, tag definitions, and control programs within a logical control boundary.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` (
    `plc_program_id` BIGINT COMMENT 'System-generated unique identifier for the PLC program record.',
    `control_system_id` BIGINT COMMENT '',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Traceability of PLC program releases to component revisions; needed for Change Management Release Report.',
    `parent_plc_program_id` BIGINT COMMENT 'Self-referencing FK on plc_program (parent_plc_program_id)',
    `device_registry_id` BIGINT COMMENT '',
    `primary_plc_device_registry_id` BIGINT COMMENT 'Identifier of the PLC or controller hardware that this program is intended for.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: Configuration management links each PLC program version to the product configuration it implements, ensuring correct program deployment.',
    `target_device_device_registry_id` BIGINT COMMENT 'FK to automation.device_registry',
    `author` STRING COMMENT 'Name of the engineer or developer who authored the current version of the program.',
    `change_reason` STRING COMMENT 'Brief description of why the program was revised or updated.',
    `checksum` STRING COMMENT 'Hash value used to verify program file integrity (e.g., SHA‑256).',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum (MD5, SHA‑1, or SHA‑256).. Valid values are `MD5|SHA1|SHA256`',
    `compatible_hardware_model` STRING COMMENT 'Model number of hardware that can run this program.',
    `compiled_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the program record was first created in the system.',
    `plc_program_description` STRING COMMENT 'Free‑form description of the programs purpose, functionality, and scope.',
    `language` STRING COMMENT 'IEC 61131‑3 language used for the program: Ladder Diagram (LD), Function Block Diagram (FBD), Structured Text (ST), Sequential Function Chart (SFC), or Instruction List (IL).. Valid values are `LD|FBD|ST|SFC|IL`',
    `last_download_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `plc_program_name` STRING COMMENT 'Human‑readable name of the PLC program as used by engineers and operators.',
    `plc_program_status` STRING COMMENT 'Current lifecycle state of the program: draft, tested, released, or archived.. Valid values are `draft|tested|released|archived`',
    `program_code` STRING COMMENT 'Unique alphanumeric code assigned to the PLC program for cataloguing and lookup.',
    `program_name` STRING COMMENT '',
    `program_size_bytes` BIGINT COMMENT 'Size of the compiled program binary in bytes.',
    `program_status` STRING COMMENT '',
    `program_version` STRING COMMENT '',
    `programming_language` STRING COMMENT '',
    `release_notes` STRING COMMENT 'Narrative of changes, fixes, and new features included in the release.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the program was officially released for production use.',
    `revision_number` STRING COMMENT 'Sequential integer incremented each time the program is revised.',
    `safety_critical` BOOLEAN COMMENT 'True if the program controls safety‑related functions and must meet safety certification requirements.',
    `source_control_branch` STRING COMMENT 'Version‑control branch name where the program source resides.',
    `source_control_commit_hash` STRING COMMENT 'Commit hash identifying the exact source snapshot used for this program version.',
    `supported_firmware_version` STRING COMMENT 'Firmware version of the target device required for this program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the program record.',
    `validation_passed` BOOLEAN COMMENT 'Indicates whether the program passed all automated and manual validation tests.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent validation was performed.',
    `version` STRING COMMENT 'Semantic version string (e.g., 1.0.3) indicating the released version of the program.',
    CONSTRAINT pk_plc_program PRIMARY KEY(`plc_program_id`)
) COMMENT 'Master record for PLC and controller programs (ladder logic, function block diagrams, structured text, sequential function charts) managed within the automation domain. Captures program name, controller target (device_registry reference), programming language (IEC 61131-3: LD, FBD, ST, SFC, IL), program version, revision number, author, last modified timestamp, checksum/hash for integrity verification, release status (draft, tested, released, archived), associated control system, and program description. Tracks the lifecycle of control logic from development through release and archival. Supports change management and version control for safety-critical control programs.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` (
    `tag_definition_id` BIGINT COMMENT 'Unique surrogate key for the tag definition record.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Tag definitions map to physical sensor components; needed for Configuration Management and Safety Audits.',
    `control_system_id` BIGINT COMMENT 'FK to automation.control_system',
    `device_registry_id` BIGINT COMMENT '',
    `parent_tag_definition_id` BIGINT COMMENT 'Self-referencing FK on tag_definition (parent_tag_definition_id)',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Tag definitions are used to monitor compliance with product specifications (e.g., voltage, temperature).',
    `access_level` STRING COMMENT 'Permission level for reading and/or writing the tag.. Valid values are `Read|Write|ReadWrite`',
    `alarm_enabled` BOOLEAN COMMENT 'Indicates whether the tag is configured to generate alarms.',
    `alarm_priority` STRING COMMENT 'Severity level for alarms generated by this tag.. Valid values are `Low|Medium|High|Critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tag definition was created in the system.',
    `data_type` STRING COMMENT 'Data type of the tag value.. Valid values are `Boolean|Int|Float|String|Double|Byte`',
    `deadband` DECIMAL(18,2) COMMENT 'Minimum change in value required to trigger an update.',
    `tag_definition_description` STRING COMMENT 'Detailed description of the tag purpose and usage.',
    `device_name` STRING COMMENT 'Name of the physical device or controller hosting the tag.',
    `engineering_unit` STRING COMMENT 'Physical unit of measurement for the tag (e.g., °C, %, psi, kW).',
    `eu_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the engineering unit range.',
    `eu_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the engineering unit range.',
    `is_historian_enabled` BOOLEAN COMMENT 'Flag indicating if the tag value is captured in the historian.',
    `max_value` DECIMAL(18,2) COMMENT '',
    `min_value` DECIMAL(18,2) COMMENT '',
    `process_area` STRING COMMENT 'Logical area of the plant or process where the tag is located.',
    `quality_code` STRING COMMENT 'Quality indicator for the tag value (e.g., Good, Bad, Uncertain).',
    `raw_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the raw sensor value range.',
    `raw_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the raw sensor value range.',
    `retention_period_days` STRING COMMENT 'Number of days the tags historical data is retained.',
    `scaling_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to raw value to obtain engineering value.',
    `scan_rate_ms` DECIMAL(18,2) COMMENT 'Polling interval in milliseconds for the tag.',
    `tag_address` STRING COMMENT '',
    `tag_definition_status` STRING COMMENT 'Current lifecycle status of the tag definition.. Valid values are `active|inactive|deprecated|planned`',
    `tag_name` STRING COMMENT 'Human‑readable name of the tag as used in engineering documentation.',
    `tag_path` STRING COMMENT 'Fully qualified OPC‑UA node identifier locating the tag in the address space.',
    `tag_status` STRING COMMENT '',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tag definition.',
    `created_by` STRING COMMENT 'User or system that created the tag definition.',
    CONSTRAINT pk_tag_definition PRIMARY KEY(`tag_definition_id`)
) COMMENT 'Master record for OPC-UA, SCADA, and DCS process tag definitions — the authoritative catalog of all named data points (tags) within the automation infrastructure. Each tag represents a named variable mapped to a physical I/O point, calculated value, or communication register. Captures tag name, tag path (OPC-UA node ID), data type (Boolean, INT, FLOAT, STRING), engineering unit (EU), EU range (low/high), raw range (low/high), scan rate (ms), deadband, access level (read/write/read-write), associated device, associated control system, process area, tag description, alarm enabled flag, and tag status. Serves as the SSOT for all process variable definitions consumed by SCADA historians, MES, and IIoT platforms.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` (
    `edge_gateway_id` BIGINT COMMENT 'System-generated unique identifier for the edge gateway device.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Edge gateway placement is tracked per site for network topology and maintenance planning.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Remote‑monitoring service subscription is billed per customer; linking gateway to account enables usage reporting.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Edge gateways are physical devices; linking to device_registry consolidates device master data and removes duplicate attributes.',
    `network_segment_id` BIGINT COMMENT '',
    `upstream_edge_gateway_id` BIGINT COMMENT 'Self-referencing FK on edge_gateway (upstream_edge_gateway_id)',
    `connected_device_count` STRING COMMENT 'Number of field devices currently registered to the gateway.',
    `connectivity_status` STRING COMMENT '',
    `cpu_utilization_percent` DECIMAL(18,2) COMMENT 'Average CPU utilization percentage over the last monitoring interval.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_throughput_mbps` DECIMAL(18,2) COMMENT 'Maximum data throughput capacity of the gateway expressed in megabits per second.',
    `decommission_date` DATE COMMENT 'Planned or actual date when the gateway is retired from service.',
    `edge_gateway_status` STRING COMMENT 'Current lifecycle status of the gateway indicating whether it is actively processing data, under maintenance, or retired.. Valid values are `active|inactive|decommissioned|maintenance`',
    `edge_group` STRING COMMENT 'Logical grouping of gateways for management or reporting purposes.',
    `edge_last_config_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent configuration change applied to the gateway.',
    `edge_location_latitude` DOUBLE COMMENT 'Geographic latitude of the gateway installation point.',
    `edge_location_longitude` DOUBLE COMMENT 'Geographic longitude of the gateway installation point.',
    `edge_os_license_key` STRING COMMENT 'License key required for the gateways operating system.',
    `edge_os_vendor` STRING COMMENT 'Vendor of the operating system installed on the gateway.',
    `edge_os_version` STRING COMMENT 'Version of the operating system running on the gateway.',
    `edge_processing_capabilities` STRING COMMENT 'Enumerated list of processing functions the gateway can perform locally.. Valid values are `local_ml|protocol_translation|data_buffering|edge_storage`',
    `edge_role` STRING COMMENT 'Primary functional role of the gateway within the IIoT architecture.. Valid values are `data_aggregator|protocol_translator|edge_compute`',
    `edge_security_status` STRING COMMENT 'Current security posture of the gateway.. Valid values are `secure|vulnerable|compromised|unknown`',
    `edge_status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., cause of maintenance mode.',
    `edge_zone` STRING COMMENT 'Logical zone within the plant where the gateway resides.',
    `firmware_version` STRING COMMENT 'Version identifier of the firmware currently installed on the gateway.',
    `gateway_name` STRING COMMENT '',
    `gateway_type` STRING COMMENT 'Classification of the gateway based on its functional role within the IIoT architecture.. Valid values are `edge|gateway|aggregator`',
    `hardware_model` STRING COMMENT 'Model designation of the gateway hardware as defined by the vendor.',
    `installation_date` DATE COMMENT 'Date on which the gateway was installed at the deployment location.',
    `ip_address` STRING COMMENT 'IPv4 address assigned to the gateway on the IT network.',
    `it_protocol` STRING COMMENT 'Protocol used on the information‑technology side for cloud or enterprise integration.. Valid values are `MQTT|HTTPS|REST|AMQP`',
    `last_firmware_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent firmware update applied to the gateway.',
    `last_heartbeat_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent heartbeat signal received from the gateway.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `mac_address` STRING COMMENT 'Media Access Control address of the gateways network interface.',
    `maintenance_window` STRING COMMENT 'Scheduled time window for routine maintenance activities.',
    `memory_usage_mb` BIGINT COMMENT 'Amount of RAM currently in use by the gateway, expressed in megabytes.',
    `network_bandwidth_limit_mbps` DECIMAL(18,2) COMMENT 'Maximum network bandwidth allocated to the gateway.',
    `ot_protocol` STRING COMMENT 'Industrial protocol used on the operational‑technology side to communicate with field devices.. Valid values are `OPC-UA|Modbus|PROFINET|EtherNetIP`',
    `power_supply_type` STRING COMMENT 'Type of power supply used by the gateway.. Valid values are `AC|DC|PoE`',
    `processing_capacity_ops` BIGINT COMMENT 'Number of processing operations the gateway can perform per second.',
    `rack_position` STRING COMMENT 'Physical rack location identifier within the data center or plant.',
    `security_certification` STRING COMMENT 'Security certifications held by the gateway hardware/software.. Valid values are `ISO27001|IEC62443|NIST800-53`',
    `software_modules` STRING COMMENT 'Comma‑separated list of software modules installed on the gateway.',
    `storage_capacity_gb` DECIMAL(18,2) COMMENT 'Total onboard storage capacity of the gateway in gigabytes.',
    `supports_local_ml` BOOLEAN COMMENT 'Indicates whether the gateway can execute local machine‑learning inference.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Current ambient temperature measured at the gateway enclosure in degrees Celsius.',
    `uptime_seconds` BIGINT COMMENT 'Total number of seconds the gateway has been continuously operational since last restart.',
    CONSTRAINT pk_edge_gateway PRIMARY KEY(`edge_gateway_id`)
) COMMENT 'Master record for industrial edge gateway devices that aggregate, pre-process, and forward IIoT data from field devices to cloud or on-premise platforms. Captures gateway name, hardware model, vendor, firmware version, deployment location (plant, line, zone), network interfaces (OT-side protocol, IT-side protocol), connected device count, data throughput capacity, edge processing capabilities (local ML inference, protocol translation, data buffering), VPN/security configuration reference, last heartbeat timestamp, operational status, and associated control system. Distinct from device_registry in that edge gateways are data aggregation and protocol translation nodes rather than direct control devices.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Unique surrogate identifier for the process parameter record.',
    `derived_from_process_parameter_id` BIGINT COMMENT 'Self-referencing FK on process_parameter (derived_from_process_parameter_id)',
    `tag_definition_id` BIGINT COMMENT '',
    `address` STRING COMMENT 'Network address or node identifier of the device exposing the tag (e.g., IP address or PLC slot).',
    `alarm_high` DECIMAL(18,2) COMMENT 'Value at which a high‑level alarm is raised.',
    `alarm_high_high` DECIMAL(18,2) COMMENT 'Value at which a critical high alarm is raised.',
    `alarm_low` DECIMAL(18,2) COMMENT 'Value at which a low‑level alarm is raised.',
    `alarm_low_low` DECIMAL(18,2) COMMENT 'Value at which a critical low alarm is raised.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the parameter was approved.',
    `approved_by` STRING COMMENT 'Identifier of the engineer or manager who approved the parameter configuration.',
    `change_reason` STRING COMMENT 'Free‑text reason for the most recent change to the parameter configuration.',
    `process_parameter_code` STRING COMMENT 'Business identifier or code for the parameter, often used in engineering drawings and PLC programs.',
    `control_system` STRING COMMENT 'Automation system that hosts the parameter (e.g., PLC, SCADA, DCS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parameter record was first created in the system.',
    `data_type` STRING COMMENT 'Underlying data type of the parameter value in the control system.. Valid values are `float|int|bool|string`',
    `process_parameter_description` STRING COMMENT 'Detailed free‑text description of the parameter purpose, usage, and any special notes.',
    `effective_end_date` DATE COMMENT 'Date on which the parameter configuration is retired (null if still active).',
    `effective_start_date` DATE COMMENT 'Date on which the parameter configuration becomes effective.',
    `engineering_unit` STRING COMMENT 'Unit of measure for the parameter (e.g., °C, bar, psi, %).',
    `high_limit` DECIMAL(18,2) COMMENT '',
    `low_limit` DECIMAL(18,2) COMMENT '',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Statistical lower control limit used for process monitoring.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value defined by product or process specifications.',
    `process_parameter_name` STRING COMMENT 'Human‑readable name of the control parameter as used by engineers and operators.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target or default value for the parameter under normal operating conditions.',
    `offset` DECIMAL(18,2) COMMENT 'Additive offset applied after scaling to align raw data with engineering units.',
    `parameter_name` STRING COMMENT '',
    `parameter_status` STRING COMMENT '',
    `parameter_type` STRING COMMENT 'Category of the parameter indicating its purpose (e.g., set‑point, limit, alarm threshold, PID tuning constant).. Valid values are `set_point|limit|alarm_threshold|pid_constant`',
    `process_area` STRING COMMENT 'Logical area of the plant or production line where the parameter is applied (e.g., furnace, mixing, packaging).',
    `process_parameter_status` STRING COMMENT 'Current lifecycle status of the parameter record.. Valid values are `active|inactive|deprecated|pending`',
    `scaling_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to raw sensor data to obtain engineering units.',
    `setpoint_value` DECIMAL(18,2) COMMENT '',
    `tag_definition` STRING COMMENT 'Standardized OPC‑UA tag name that maps to the physical sensor or control point.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the parameter record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Statistical upper control limit used for process monitoring.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value defined by product or process specifications.',
    `version` STRING COMMENT 'Incremental version of the parameter record for change management.',
    CONSTRAINT pk_process_parameter PRIMARY KEY(`process_parameter_id`)
) COMMENT 'Master record defining the set-point and control parameter configurations for manufacturing processes managed by automation systems. Captures parameter name, parameter type (set-point, limit, alarm threshold, PID tuning constant), associated tag definition, associated control system, process area, nominal value, upper control limit (UCL), lower control limit (LCL), upper specification limit (USL), lower specification limit (LSL), alarm high, alarm high-high, alarm low, alarm low-low, engineering unit, last modified timestamp, approved-by reference, and effective date range. Represents the authoritative configuration of how a process should be controlled — distinct from real-time tag readings which are captured in process_data_point.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` (
    `alarm_definition_id` BIGINT COMMENT 'Unique identifier for the alarm definition record.',
    `parent_alarm_definition_id` BIGINT COMMENT 'Self-referencing FK on alarm_definition (parent_alarm_definition_id)',
    `tag_definition_id` BIGINT COMMENT '',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether operator acknowledgment is required to clear the alarm.',
    `alarm_category` STRING COMMENT 'Higher‑level grouping of the alarm (e.g., process, equipment, environmental).',
    `alarm_name` STRING COMMENT '',
    `alarm_priority` STRING COMMENT '',
    `alarm_type` STRING COMMENT 'Classification of the alarm based on its origin.. Valid values are `process|equipment|safety|system`',
    `auto_reset` BOOLEAN COMMENT 'Indicates whether the alarm automatically resets after the condition clears.',
    `class` STRING COMMENT 'ISA‑18.2 classification of the alarm (A‑D).. Valid values are `A|B|C|D`',
    `alarm_definition_code` STRING COMMENT 'Unique business code used to reference the alarm definition.',
    `compliance_standard` STRING COMMENT 'Reference to the compliance standard governing the alarm definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alarm definition record was created.',
    `deadband` DECIMAL(18,2) COMMENT 'Deadband applied around the setpoint to prevent chatter.',
    `deadband_unit` STRING COMMENT 'Unit of measure for the deadband value.',
    `alarm_definition_description` STRING COMMENT 'Detailed description of the alarm purpose and behavior.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation or SOP for the alarm.',
    `effective_from` DATE COMMENT 'Date from which the alarm definition is valid.',
    `effective_until` DATE COMMENT 'Date after which the alarm definition is no longer valid (null if open‑ended).',
    `enabled_flag` BOOLEAN COMMENT '',
    `escalation_policy` STRING COMMENT 'Textual description of escalation steps if the alarm is not addressed.',
    `last_reviewed_date` DATE COMMENT 'Date when the alarm definition was last reviewed for relevance.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the alarm definition.. Valid values are `active|inactive|deprecated|retired`',
    `alarm_definition_name` STRING COMMENT 'Human‑readable name of the alarm.',
    `notification_method` STRING COMMENT 'Preferred method for notifying operators about the alarm.. Valid values are `email|sms|popup|none`',
    `off_delay_seconds` STRING COMMENT 'Time the condition must clear before the alarm is cleared.',
    `on_delay_seconds` STRING COMMENT 'Time the condition must persist before the alarm becomes active.',
    `operator_group` STRING COMMENT 'Operator group responsible for acknowledging and handling the alarm.',
    `priority` STRING COMMENT 'Business priority indicating the impact of the alarm.. Valid values are `critical|high|medium|low`',
    `process_area` STRING COMMENT 'Logical area of the plant or process to which the alarm belongs.',
    `rationalization_status` DECIMAL(18,2) COMMENT 'Current status of the alarm rationalization process.',
    `related_equipment_tag` STRING COMMENT 'Tag identifier of equipment associated with the alarm.',
    `reset_delay_seconds` STRING COMMENT 'Delay before the alarm automatically resets when auto_reset is true.',
    `setpoint_unit` STRING COMMENT 'Unit of measure for the setpoint value (e.g., psi, °C, %).',
    `setpoint_value` DECIMAL(18,2) COMMENT 'Numeric setpoint that defines the alarm threshold.',
    `shelving_allowed` BOOLEAN COMMENT 'Indicates whether the alarm can be temporarily shelved by operators.',
    `suppression_rules` STRING COMMENT 'Textual description of any suppression logic applied to the alarm.',
    `threshold_value` DECIMAL(18,2) COMMENT '',
    `trigger_condition` STRING COMMENT 'Condition that causes the alarm to fire.. Valid values are `high|low|deviation|rate_of_change`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alarm definition.',
    `version` STRING COMMENT 'Version identifier for the alarm definition.',
    CONSTRAINT pk_alarm_definition PRIMARY KEY(`alarm_definition_id`)
) COMMENT 'Master record for the alarm and event management catalog defining all configured alarms within SCADA, DCS, and PLC systems. Captures alarm tag reference, alarm name, alarm type (process alarm, equipment alarm, safety alarm, system alarm), priority (critical, high, medium, low), alarm class (ISA-18.2 classification), trigger condition (high, low, deviation, rate-of-change), setpoint value, deadband, delay time (on-delay, off-delay), suppression rules, shelving allowed flag, associated process area, responsible operator group, alarm rationalization status, and last reviewed date. Supports ISA-18.2 alarm management lifecycle including rationalization, documentation, and performance monitoring.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` (
    `network_segment_id` BIGINT COMMENT 'Unique system-generated identifier for the OT network segment.',
    `parent_network_segment_id` BIGINT COMMENT 'Self-referencing FK on network_segment (parent_network_segment_id)',
    `asset_plant_id` BIGINT COMMENT 'Identifier of the plant or facility where the segment resides.',
    `addressing_scheme` STRING COMMENT 'Indicates whether the segment uses static, DHCP, or other IP allocation methods.',
    `allowed_protocols` STRING COMMENT 'Comma‑separated list of network protocols permitted on the segment (e.g., OPC-UA, MQTT, TCP).',
    `backup_connectivity` STRING COMMENT 'Description of any backup link or secondary path for the segment.',
    `change_control_reference` STRING COMMENT 'Reference to the change control or engineering change order governing modifications to the segment.',
    `compliance_standard` STRING COMMENT 'Applicable compliance framework(s) (e.g., IEC 62443, NIST) for the segment.',
    `connected_device_count` STRING COMMENT 'Number of OT devices currently attached to the segment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the network segment record was created.',
    `network_segment_description` STRING COMMENT 'Free‑form description of the segment purpose and characteristics.',
    `effective_from` DATE COMMENT 'Date when the segment became operational.',
    `effective_until` DATE COMMENT 'Date when the segment is scheduled for decommissioning (null if indefinite).',
    `firewall_reference` STRING COMMENT 'Reference or name of the firewall protecting the segment.',
    `ip_subnet` STRING COMMENT 'IP subnet in CIDR notation that defines the address space of the segment.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent security audit performed on the segment.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window description (e.g., Sun 02:00‑04:00).',
    `monitoring_tool` STRING COMMENT 'Name of the SCADA/monitoring system that collects telemetry from the segment.',
    `network_segment_name` STRING COMMENT 'Human‑readable name of the network segment or zone.',
    `network_segment_status` STRING COMMENT 'Current operational status of the segment.. Valid values are `active|inactive|planned|decommissioned`',
    `owner_contact` STRING COMMENT 'Name or identifier of the person responsible for the segment.',
    `redundancy_configuration` DECIMAL(18,2) COMMENT 'Description of redundancy (e.g., dual‑homing, hot‑standby).',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the segment based on security assessments.. Valid values are `low|medium|high|critical`',
    `security_level` STRING COMMENT 'Security level assigned to the segment per IEC 62443.. Valid values are `SL-1|SL-2|SL-3|SL-4`',
    `security_zone` STRING COMMENT '',
    `segment_code` STRING COMMENT 'Enterprise‑wide code used to reference the segment in documentation and systems.',
    `segment_name` STRING COMMENT '',
    `segment_status` STRING COMMENT '',
    `subnet_cidr` STRING COMMENT '',
    `topology` STRING COMMENT 'Physical or logical topology of the segment.. Valid values are `ring|star|linear|mesh|bus`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    `vlan_number` STRING COMMENT 'Virtual LAN identifier assigned to the segment.',
    `vlan_tag` STRING COMMENT '',
    `zone_type` STRING COMMENT 'ISA/IEC 62443 security zone classification for the segment.. Valid values are `level_0_field|level_1_control|level_2_supervisory|level_3_operations|dmz`',
    CONSTRAINT pk_network_segment PRIMARY KEY(`network_segment_id`)
) COMMENT 'Master record for OT (Operational Technology) network segments and zones within the industrial automation network architecture. Captures segment name, zone type (ISA/IEC 62443 security zone: Level 0 field, Level 1 control, Level 2 supervisory, Level 3 operations, DMZ), VLAN ID, IP subnet, associated plant/facility, firewall/conduit reference, allowed protocols, connected device count, network topology (ring, star, linear), redundancy configuration, and security level (SL-1 through SL-4 per IEC 62443). Provides the network topology context for device placement and cybersecurity zone management. Distinct from IT network infrastructure managed by corporate IT.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` (
    `alarm_event_id` BIGINT COMMENT 'Unique identifier for each alarm event record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory incident logs require linking each alarm acknowledgment to the employee who performed it for traceability.',
    `alarm_definition_id` BIGINT COMMENT 'Identifier of the alarm definition that describes the condition, severity, and setpoint.',
    `device_registry_id` BIGINT COMMENT 'Unique identifier of the PLC, sensor, or equipment that generated the alarm.',
    `location_id` BIGINT COMMENT 'Identifier of the plant, zone, or area where the alarm originated.',
    `preceding_alarm_event_id` BIGINT COMMENT 'Self-referencing FK on alarm_event (preceding_alarm_event_id)',
    `work_center_id` BIGINT COMMENT 'FK to production.work_center.work_center_id — Production operators need to correlate automation alarms to specific work centers for root cause analysis during production stoppages. Without this link, alarm events are disconnected from production ',
    `acknowledged_by` STRING COMMENT 'Name of the operator who acknowledged the alarm.',
    `acknowledged_flag` BOOLEAN COMMENT '',
    `acknowledged_timestamp` TIMESTAMP COMMENT '',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the operator acknowledged the alarm.',
    `alarm_category` STRING COMMENT 'Broad category of the alarm (process, equipment, environment, safety, quality).. Valid values are `process|equipment|environment|safety|quality`',
    `alarm_duration_seconds` DECIMAL(18,2) COMMENT 'Total time in seconds that the alarm stayed in the active state before being cleared or returned to normal.',
    `alarm_message` STRING COMMENT 'Text message describing the alarm condition as presented to the operator.',
    `alarm_priority` STRING COMMENT 'Numeric priority (lower number = higher priority) used for alarm sorting and display.',
    `alarm_severity` STRING COMMENT 'Severity classification of the alarm according to ISA‑18.2 (critical, high, medium, low, info).. Valid values are `critical|high|medium|low|info`',
    `alarm_source_system` STRING COMMENT 'Control system type that originated the alarm (e.g., SCADA, DCS, PLC, HMI).. Valid values are `SCADA|DCS|PLC|HMI`',
    `alarm_state` STRING COMMENT 'Lifecycle state of the alarm (e.g., active, acknowledged, shelved, suppressed, returned to normal, cleared).. Valid values are `active|acknowledged|shelved|suppressed|returned_to_normal|cleared`',
    `alarm_value` DECIMAL(18,2) COMMENT '',
    `cleared_timestamp` TIMESTAMP COMMENT '',
    `event_status` STRING COMMENT '',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm was generated by the control system.',
    `is_nuisance` BOOLEAN COMMENT 'True if the alarm is classified as a nuisance/alarm flood, otherwise false.',
    `operator_comment` STRING COMMENT 'Free‑form text entered by the operator providing context or actions taken.',
    `process_value` DECIMAL(18,2) COMMENT 'Measured process variable (e.g., temperature, pressure) at the time the alarm triggered.',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time when the alarm event record was ingested into the Silver layer.',
    `setpoint_value` DECIMAL(18,2) COMMENT 'The configured setpoint or threshold that the process value exceeded to cause the alarm.',
    `shelve_duration_seconds` DECIMAL(18,2) COMMENT 'Time in seconds that the alarm remained shelved before being re‑activated or cleared.',
    CONSTRAINT pk_alarm_event PRIMARY KEY(`alarm_event_id`)
) COMMENT 'Transactional record capturing every alarm occurrence and state transition event generated by SCADA, DCS, and PLC systems. Each record represents a discrete alarm lifecycle event (alarm active, acknowledged, shelved, suppressed, returned to normal, cleared). Captures alarm definition reference, device reference, event timestamp, alarm state (active, acknowledged, RTN, shelved), operator who acknowledged, acknowledgement timestamp, shelve duration, alarm message text, process value at alarm time, setpoint at alarm time, alarm duration (seconds), and whether the alarm was a nuisance alarm. Supports ISA-18.2 alarm performance KPI calculation (alarm rate, flood detection, standing alarms) and operator response analysis.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` (
    `control_mode_event_id` BIGINT COMMENT 'System‑generated unique identifier for each control mode change event.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the work order associated with the mode change, if any.',
    `batch_execution_id` BIGINT COMMENT 'Identifier of the production batch (lot) active at the time of the event.',
    `control_system_id` BIGINT COMMENT '',
    `device_registry_id` BIGINT COMMENT 'Unique identifier of the PLC/Controller that generated the mode change.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator (human) who initiated the mode change.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the equipment (e.g., machine, robot) whose controller changed mode.',
    `asset_plant_id` BIGINT COMMENT 'Unique identifier of the manufacturing plant where the event occurred.',
    `preceding_control_mode_event_id` BIGINT COMMENT 'Self-referencing FK on control_mode_event (preceding_control_mode_event_id)',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or cell that contains the controller.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order linked to the event, when applicable.',
    `shift_id` BIGINT COMMENT 'Identifier of the production shift during which the event occurred.',
    `comments` STRING COMMENT 'Optional free‑text notes entered by the operator or system.',
    `compliance_status` STRING COMMENT 'Indicates whether the mode change complies with ISA‑106 and internal SOPs.. Valid values are `compliant|non_compliant|pending`',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Elapsed time the controller remained in the new mode before the next change.',
    `event_severity` STRING COMMENT 'Severity level indicating the operational impact of the mode change.. Valid values are `info|warning|critical`',
    `event_status` STRING COMMENT 'Processing status of the event record within the data pipeline.. Valid values are `recorded|processed|rejected`',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the control mode change was recorded in the automation system.',
    `event_type` STRING COMMENT 'Category of the event; most commonly a mode change, but may include overrides or resets.. Valid values are `mode_change|override|reset`',
    `is_manual_override` BOOLEAN COMMENT 'True if the mode change was performed manually by an operator, otherwise false.',
    `is_safety_critical` BOOLEAN COMMENT 'True if the mode change impacts a safety‑critical control loop.',
    `new_mode` STRING COMMENT 'Control mode of the loop after the transition.. Valid values are `automatic|manual|cascade|remote`',
    `previous_mode` STRING COMMENT 'Control mode of the loop before the transition.. Valid values are `automatic|manual|cascade|remote`',
    `reason_code` STRING COMMENT 'Standard code describing why the mode change was performed.. Valid values are `scheduled|unscheduled|emergency|maintenance|test`',
    `reason_description` STRING COMMENT 'Free‑text explanation of the reason for the mode change.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the event record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    `source_module` STRING COMMENT 'Specific module or application within the source system that generated the event.',
    `tag_reference` STRING COMMENT 'Human‑readable tag name or address used in the control system for the mode signal.',
    `changed_by` STRING COMMENT '',
    CONSTRAINT pk_control_mode_event PRIMARY KEY(`control_mode_event_id`)
) COMMENT 'Transactional record capturing control mode change events for automation loops and controllers — transitions between automatic, manual, cascade, and remote modes. Captures controller/loop tag reference, control system reference, event timestamp, previous mode, new mode, operator ID who initiated the change, reason code, associated work order or production order reference, and duration in new mode. Critical for process safety analysis, operator behavior auditing, and identifying manual overrides that deviate from standard operating procedures. Supports ISA-106 procedural automation and operator effectiveness analysis.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` (
    `device_config_snapshot_id` BIGINT COMMENT 'Unique identifier for each configuration snapshot record.',
    `device_registry_id` BIGINT COMMENT 'Identifier of the automation device (PLC, HMI, drive, controller) whose configuration is being snapshot.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who initiated or approved the snapshot (if applicable).',
    `previous_device_config_snapshot_id` BIGINT COMMENT 'Self-referencing FK on device_config_snapshot (previous_device_config_snapshot_id)',
    `project_change_request_id` BIGINT COMMENT 'Reference to the change request or engineering change order associated with this snapshot.',
    `backup_job_reference` BIGINT COMMENT 'Identifier of the scheduled backup job that generated the snapshot.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to compute the configuration checksum.. Valid values are `sha256|md5|sha1`',
    `compression_algorithm` STRING COMMENT 'Algorithm used to compress the configuration file, if applicable.. Valid values are `gzip|zip`',
    `config_file_path` STRING COMMENT 'Blob storage path or URI where the configuration file is stored.',
    `config_hash` STRING COMMENT '',
    `config_version` STRING COMMENT '',
    `configuration_checksum` DECIMAL(18,2) COMMENT 'Hash value (e.g., SHA‑256) used to verify file integrity.',
    `configuration_format` DECIMAL(18,2) COMMENT 'File format of the stored configuration (e.g., XML, JSON, CSV).',
    `configuration_version` DECIMAL(18,2) COMMENT 'Version identifier for the configuration schema or layout.',
    `device_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the device.',
    `device_type` STRING COMMENT 'Category of the automation device (Programmable Logic Controller, Human‑Machine Interface, drive, controller).. Valid values are `plc|hmi|drive|controller`',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored configuration file in bytes.',
    `firmware_version` STRING COMMENT 'Version of the device firmware at the time of snapshot.',
    `is_compressed` BOOLEAN COMMENT 'Indicates whether the stored configuration file is compressed.',
    `notes` STRING COMMENT 'Additional free‑form information or comments about the snapshot.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the snapshot record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the snapshot record (e.g., after validation).',
    `retention_policy` STRING COMMENT 'Policy governing how long the snapshot is retained (e.g., keep 30 days, archival).',
    `snapshot_description` STRING COMMENT 'Free‑form notes describing the purpose or context of the snapshot.',
    `snapshot_status` STRING COMMENT 'Current lifecycle status of the snapshot record.. Valid values are `active|archived|deleted`',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Date and time when the configuration snapshot was captured from the device.',
    `snapshot_type` STRING COMMENT 'Indicates whether the snapshot is a full backup, delta change, scheduled capture, pre‑change, or post‑change.. Valid values are `full|delta|scheduled|pre_change|post_change`',
    `triggered_by` STRING COMMENT 'Mechanism that initiated the snapshot: scheduled job, manual operator action, or an automatic change event.. Valid values are `scheduled|manual|change_event`',
    `validation_status` STRING COMMENT 'Indicates whether the snapshot has been verified against expected configuration standards.. Valid values are `verified|unverified`',
    `created_by` STRING COMMENT 'Name of the operator or system that created the snapshot record.',
    CONSTRAINT pk_device_config_snapshot PRIMARY KEY(`device_config_snapshot_id`)
) COMMENT 'Transactional record capturing point-in-time configuration snapshots of automation devices (PLCs, HMIs, drives, controllers) for change management, backup, and audit purposes. Each record represents a complete or delta configuration backup taken from a device. Captures device reference, snapshot timestamp, snapshot type (full backup, delta, scheduled, pre-change, post-change), configuration file reference (blob storage path), file size, checksum/hash, firmware version at snapshot time, triggered-by (scheduled, manual, change event), operator reference, associated change request reference, and validation status (verified, unverified). Supports configuration management and rollback capabilities for OT change control.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` (
    `firmware_update_id` BIGINT COMMENT 'Unique system-generated identifier for each firmware update event.',
    `device_config_snapshot_id` BIGINT COMMENT 'Identifier of the backup snapshot taken before applying the new firmware.',
    `device_registry_id` BIGINT COMMENT 'Unique identifier of the automation device or edge gateway receiving the firmware update.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or system that initiated or approved the update.',
    `project_change_request_id` BIGINT COMMENT 'Link to the engineering change request that authorized the firmware change.',
    `rollback_firmware_update_id` BIGINT COMMENT 'Self-referencing FK on firmware_update (rollback_firmware_update_id)',
    `completed_timestamp` TIMESTAMP COMMENT '',
    `completion_timestamp` TIMESTAMP COMMENT 'Exact time the firmware update finished successfully.',
    `compliance_patch_reference` BIGINT COMMENT 'Reference to the IEC 62443 compliance patch record linked to this firmware change.',
    `device_name` STRING COMMENT 'Descriptive name of the device (e.g., PLC‑01‑LineA).',
    `device_type` STRING COMMENT 'Category of the device receiving the update.. Valid values are `controller|gateway|sensor|actuator`',
    `firmware_version_after` STRING COMMENT 'Version string of the firmware installed after the update.',
    `firmware_version_before` STRING COMMENT 'Version string of the firmware installed prior to the update.',
    `from_version` STRING COMMENT '',
    `is_critical_update` BOOLEAN COMMENT 'True if the update addresses a security vulnerability or safety issue requiring immediate deployment.',
    `lifecycle_status` STRING COMMENT 'Overall record status for retention and archival purposes.. Valid values are `active|inactive|archived`',
    `notes` STRING COMMENT 'Additional comments or observations captured by the operator.',
    `post_update_validation_status` STRING COMMENT 'Result of automated validation checks after the firmware was applied.. Valid values are `passed|failed|not_applicable`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this firmware update record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this record.',
    `rollback_flag` BOOLEAN COMMENT '',
    `rollback_reason` STRING COMMENT 'Free‑text description of why a rollback was required.',
    `rollback_timestamp` TIMESTAMP COMMENT 'Timestamp when a rollback to the previous firmware version was performed, if applicable.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time when the update was scheduled to start.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact time the firmware update began execution.',
    `to_version` STRING COMMENT '',
    `update_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time from start_timestamp to completion_timestamp (or rollback_timestamp).',
    `update_method` STRING COMMENT 'Mechanism used to deliver the firmware (remote push, manual USB, or OTA).. Valid values are `remote_push|manual_usb|ota`',
    `update_package_reference` BIGINT COMMENT 'Identifier of the firmware package applied during the update.',
    `update_reference_code` STRING COMMENT 'Human‑readable code used to reference the firmware update in reports and tickets.',
    `update_size_mb` DECIMAL(18,2) COMMENT 'Size of the firmware package transferred to the device.',
    `update_status` STRING COMMENT 'Current lifecycle state of the firmware update.. Valid values are `scheduled|in_progress|completed|failed|rolled_back`',
    `validation_timestamp` TIMESTAMP COMMENT 'Time when post‑update validation was performed.',
    CONSTRAINT pk_firmware_update PRIMARY KEY(`firmware_update_id`)
) COMMENT 'Transactional record tracking firmware and software update events applied to automation devices and edge gateways. Captures device reference, update event timestamp, previous firmware version, new firmware version, update package identifier, update method (remote push, manual USB, OTA), update status (scheduled, in-progress, completed, failed, rolled-back), applied-by operator reference, change request reference, pre-update backup snapshot reference, post-update validation status, and rollback timestamp if applicable. Provides a complete audit trail of all firmware changes across the OT device estate, supporting vulnerability management and compliance with IEC 62443 patch management requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` (
    `scada_session_id` BIGINT COMMENT 'Unique surrogate key for the SCADA operator session record.',
    `control_system_id` BIGINT COMMENT '',
    `device_registry_id` BIGINT COMMENT 'Identifier of the edge device or PLC that the workstation is connected to during the session.',
    `previous_scada_session_id` BIGINT COMMENT 'Self-referencing FK on scada_session (previous_scada_session_id)',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operator who logged into the SCADA system.',
    `alarm_ack_count` STRING COMMENT 'Number of alarm acknowledgements performed by the operator during the session.',
    `control_action_count` STRING COMMENT 'Number of manual control actions (e.g., start/stop) executed by the operator.',
    `ip_address` STRING COMMENT 'Network IP address of the workstation at session start.',
    `login_method` STRING COMMENT 'Authentication mechanism used for the session.. Valid values are `local|domain|biometric`',
    `login_timestamp` TIMESTAMP COMMENT 'Date‑time when the operator successfully logged into the SCADA system.',
    `logout_timestamp` TIMESTAMP COMMENT 'Date‑time when the session ended, either by logout, timeout or forced termination.',
    `os_version` STRING COMMENT 'Operating system version of the workstation hosting the SCADA client.',
    `plant_area` STRING COMMENT 'Logical area or zone of the manufacturing plant where the session took place (e.g., Assembly, Packaging).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `session_duration_seconds` DECIMAL(18,2) COMMENT 'Total length of the session measured in seconds (logout_timestamp – login_timestamp).',
    `session_end_timestamp` TIMESTAMP COMMENT '',
    `session_identifier` STRING COMMENT 'Human‑readable identifier or code for the session, often displayed in audit logs.',
    `session_notes` STRING COMMENT 'Free‑form notes entered by the operator or system during the session.',
    `session_source` STRING COMMENT 'Physical source of the session interface.. Valid values are `scada_workstation|hmi_panel|mobile_terminal`',
    `session_start_timestamp` TIMESTAMP COMMENT '',
    `session_status` STRING COMMENT 'Current lifecycle status of the session.. Valid values are `active|closed|terminated|error`',
    `session_type` STRING COMMENT 'Classification of the session purpose.. Valid values are `operator|maintenance|automated`',
    `setpoint_change_count` STRING COMMENT 'Number of setpoint modifications made by the operator.',
    `software_version` STRING COMMENT 'Version of the SCADA application running on the workstation.',
    `termination_reason` STRING COMMENT 'Reason why the session was terminated.. Valid values are `normal_logout|timeout|forced_logout|error`',
    `user_role` STRING COMMENT 'Role of the operator within the organization for this session.. Valid values are `operator|engineer|supervisor|admin`',
    `workstation_code` STRING COMMENT '',
    `workstation_reference` BIGINT COMMENT 'Identifier of the SCADA workstation or HMI panel used for the session.',
    CONSTRAINT pk_scada_session PRIMARY KEY(`scada_session_id`)
) COMMENT 'Transactional record capturing operator SCADA and HMI session activity for operational auditing and human factors analysis. Each record represents a discrete operator login session on a SCADA workstation or HMI panel. Captures operator ID, workstation/HMI device reference, session start timestamp, session end timestamp, session duration, login method (local, domain, biometric), associated plant area, number of alarm acknowledgements during session, number of control actions during session, number of setpoint changes during session, and session termination reason (normal logout, timeout, forced logout). Supports operator effectiveness analysis and ISA-101 HMI human factors compliance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` (
    `setpoint_change_id` BIGINT COMMENT 'Unique surrogate key for each setpoint change event.',
    `control_system_id` BIGINT COMMENT 'Surrogate key referencing the control system (e.g., PLC, DCS) that executed the setpoint change.',
    `employee_id` BIGINT COMMENT 'Identifier of the person (operator) or system that initiated the setpoint change.',
    `process_parameter_id` BIGINT COMMENT 'Identifier for the specific process parameter (e.g., temperature, pressure) whose setpoint was changed.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order associated with the setpoint change, linking the event to manufacturing execution.',
    `recipe_id` BIGINT COMMENT 'Reference to the recipe or procedure that defines the intended setpoint values for the operation.',
    `reversal_setpoint_change_id` BIGINT COMMENT 'Self-referencing FK on setpoint_change (reversal_setpoint_change_id)',
    `tag_definition_id` BIGINT COMMENT 'Reference to the OPC-UA or SCADA tag that represents the process variable being adjusted.',
    `approval_status` STRING COMMENT 'Current status of the approval workflow for the setpoint change.. Valid values are `approved|rejected|pending`',
    `change_reason_code` STRING COMMENT 'Standardized code describing the business reason for the setpoint modification.. Valid values are `maintenance|quality|optimization|emergency|operator_request|system_auto`',
    `change_status` STRING COMMENT 'Result of the setpoint change operation (e.g., completed, failed, pending).. Valid values are `completed|failed|pending`',
    `change_timestamp` TIMESTAMP COMMENT '',
    `comment` STRING COMMENT 'Free‑text field for operators or systems to add contextual notes about the change.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the setpoint change was applied on the control system.',
    `initiated_by_type` STRING COMMENT 'Indicates whether the change was triggered by a human operator or an automated system.. Valid values are `operator|system`',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the setpoint change has received required approvals.',
    `new_setpoint` DECIMAL(18,2) COMMENT '',
    `new_setpoint_value` DECIMAL(18,2) COMMENT 'Numeric value of the setpoint after the change.',
    `old_setpoint` DECIMAL(18,2) COMMENT '',
    `previous_setpoint_value` DECIMAL(18,2) COMMENT 'Numeric value of the setpoint before the change was applied.',
    `reason_code` STRING COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the setpoint change record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the setpoint change record.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the setpoint values (e.g., °C, bar, psi, rpm).',
    `within_normal_limits` BOOLEAN COMMENT 'True if the new setpoint remains within predefined normal operating limits; otherwise false.',
    `changed_by` STRING COMMENT '',
    CONSTRAINT pk_setpoint_change PRIMARY KEY(`setpoint_change_id`)
) COMMENT 'Transactional record capturing every operator or system-initiated setpoint change event on a controlled process variable. Each record represents a discrete setpoint modification event. Captures tag definition reference, process parameter reference, control system reference, change timestamp, previous setpoint value, new setpoint value, change initiated by (operator ID or automated system), change reason code, associated production order reference, associated recipe/procedure reference, approval reference (for safety-critical setpoints requiring dual authorization), and whether the change was within normal operating limits. Provides a complete audit trail of process setpoint modifications for process safety management (PSM) and MOC (Management of Change) compliance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` (
    `batch_execution_id` BIGINT COMMENT 'Unique system-generated identifier for the batch execution record.',
    `batch_schedule_id` BIGINT COMMENT 'Link to the planned schedule record for this batch.',
    `control_system_id` BIGINT COMMENT 'Identifier of the DCS/PLC control system that managed the batch.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch cost accounting: each batch run consumes resources charged to a cost center, required for the Batch Cost Summary report.',
    `parent_batch_execution_id` BIGINT COMMENT 'Self-referencing FK on batch_execution (parent_batch_execution_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the batch for release.',
    `production_work_order_id` BIGINT COMMENT 'FK to production.work_order.work_order_id — Batch execution records must link to production work orders for complete manufacturing traceability — ISA-95 Level 3 to Level 4 integration. Without this, batch genealogy cannot be traced to productio',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Batch revenue tracking: batches produce sellable output linked to profit centers, needed for the Production Revenue Allocation report.',
    `recipe_id` BIGINT COMMENT 'Reference to the recipe (formula) used for this batch execution.',
    `shift_id` BIGINT COMMENT 'Work‑shift during which the batch was executed.',
    `actual_quantity` DECIMAL(18,2) COMMENT '',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'Measured quantity of good product produced by the batch.',
    `batch_capa_action_count` STRING COMMENT 'Count of corrective and preventive actions generated from this batch.',
    `batch_co2_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions attributable to the batch.',
    `batch_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time of the batch execution measured in seconds.',
    `batch_disposition` STRING COMMENT 'Final disposition of the batch after execution.. Valid values are `released|rejected|under_review`',
    `batch_end_reason` STRING COMMENT 'Reason why the batch was terminated.. Valid values are `normal|abort|error|manual_stop`',
    `batch_energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed during the batch.',
    `batch_execution_status` STRING COMMENT 'Current lifecycle state of the batch execution as defined by ISA‑88.. Valid values are `created|running|paused|completed|aborted`',
    `batch_notes` STRING COMMENT 'Free‑form comments entered by operators or engineers.',
    `batch_number` STRING COMMENT 'Human‑readable identifier assigned to the batch run, often used on shop‑floor displays and reports.',
    `batch_priority` STRING COMMENT 'Priority level assigned to the batch for scheduling purposes.. Valid values are `high|medium|low`',
    `batch_release_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was released for downstream processes.',
    `batch_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch entered review status.',
    `batch_safety_incident_count` STRING COMMENT 'Number of safety incidents recorded during the batch.',
    `batch_scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped during the batch.',
    `batch_scrap_uom` STRING COMMENT 'Unit of measure for scrap quantity (e.g., kg, pcs).',
    `batch_start_reason` STRING COMMENT 'Reason why the batch was started.. Valid values are `scheduled|manual|auto|emergency`',
    `batch_type` STRING COMMENT 'Classification of the batch run (e.g., standard production, rework).. Valid values are `standard|rework|test|pilot`',
    `batch_version` STRING COMMENT 'Version identifier of the recipe or batch configuration used.',
    `batch_water_usage_liters` DECIMAL(18,2) COMMENT 'Volume of water used in the batch process.',
    `batch_yield_percentage` DECIMAL(18,2) COMMENT 'Yield expressed as a percentage of target.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch execution record was first created in the data lake.',
    `downtime_minutes` STRING COMMENT 'Total minutes of equipment downtime recorded during the batch.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch execution finished or was terminated.',
    `equipment_train_code` BIGINT COMMENT 'Identifier of the equipment train (set of machines) that executed the batch.',
    `exception_count` STRING COMMENT 'Number of exception events (alarms, faults) recorded during the batch.',
    `execution_status` STRING COMMENT '',
    `maintenance_flag` BOOLEAN COMMENT 'Indicates whether maintenance activities were performed during the batch.',
    `overall_equipment_effectiveness` DECIMAL(18,2) COMMENT 'OEE percentage captured for the batch execution.',
    `plant_area` STRING COMMENT 'Physical area or cell of the plant where the batch ran.',
    `quality_check_passed` BOOLEAN COMMENT 'Indicates whether the batch passed all mandatory quality checks.',
    `quality_status` STRING COMMENT 'Overall quality assessment result for the batch.. Valid values are `passed|failed|pending|rework`',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the batch execution started on the control system.',
    `target_yield_quantity` DECIMAL(18,2) COMMENT 'Planned quantity of good product expected from the batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the batch execution record.',
    `yield_uom` STRING COMMENT 'Unit of measure for yield quantities (e.g., kg, pcs).',
    CONSTRAINT pk_batch_execution PRIMARY KEY(`batch_execution_id`)
) COMMENT 'Transactional record representing the execution of a discrete batch or recipe-driven production run managed by a Batch Management System (BMS) or DCS batch engine. Captures batch ID, recipe reference, equipment train reference, control system reference, batch start timestamp, batch end timestamp, batch status (created, running, paused, completed, aborted), actual yield quantity, target yield quantity, yield unit of measure, batch disposition (released, rejected, under-review), operator reference, and exception count. Implements ISA-88 batch execution model. Distinct from production.work_order (which is the manufacturing execution layer) — this entity captures the automation-layer batch control execution record.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Unique identifier for the recipe.',
    `master_recipe_id` BIGINT COMMENT 'Self-referencing FK on recipe (master_recipe_id)',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Each recipe is tied to a specific SKU; the product_reference column is replaced by a FK for traceability.',
    `approval_status` STRING COMMENT '',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the recipe was approved.',
    `approval_user` STRING COMMENT 'User identifier who approved the recipe.',
    `batch_size` DECIMAL(18,2) COMMENT 'Target batch size for the recipe execution.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for batch size.. Valid values are `kg|lb|units|liters`',
    `changeover_time` TIMESTAMP COMMENT 'Estimated time to change over equipment to this recipe.',
    `recipe_code` STRING COMMENT 'Unique business code for the recipe.',
    `compliance_regulation` STRING COMMENT 'Regulatory standard applicable to the recipe.. Valid values are `ISO9001|ISO14001|ISO45001|IEC62443`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe record was created.',
    `critical_parameter_setpoints` STRING COMMENT 'Key process parameters with setpoint values and units, stored as JSON.',
    `documentation_url` STRING COMMENT 'Link to detailed recipe documentation.',
    `effective_from` DATE COMMENT 'Date from which the recipe is valid for production.',
    `effective_until` DATE COMMENT 'Date until which the recipe remains valid; null if indefinite.',
    `equipment_class` STRING COMMENT 'Class of equipment required to execute the recipe.',
    `ingredient_list` STRING COMMENT 'List of ingredients with target quantities and tolerances, stored as JSON.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the recipe.',
    `max_yield` DECIMAL(18,2) COMMENT 'Maximum expected yield percentage for the recipe.',
    `recipe_name` STRING COMMENT 'Human readable name of the recipe.',
    `oee_target` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness for this recipe.',
    `phase_sequence` STRING COMMENT 'Ordered list of phase identifiers defining the recipe flow, stored as JSON.',
    `process_time_unit` STRING COMMENT 'Time unit for total_process_time.. Valid values are `seconds|minutes|hours`',
    `recipe_status` STRING COMMENT '',
    `recipe_type` STRING COMMENT 'ISA-88 classification of the recipe.. Valid values are `master|control|site|general`',
    `recipe_version` STRING COMMENT '',
    `release_status` STRING COMMENT 'Current lifecycle status of the recipe.. Valid values are `draft|approved|released|obsolete`',
    `revision_number` STRING COMMENT 'Sequential revision number of the recipe.',
    `safety_integrity_level` STRING COMMENT 'Safety integrity level required for equipment executing the recipe.. Valid values are `SIL1|SIL2|SIL3|SIL4`',
    `total_process_time` DECIMAL(18,2) COMMENT 'Total expected duration of the recipe execution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recipe record.',
    `version` STRING COMMENT 'Version identifier of the recipe.. Valid values are `^vd+(.d+)*$`',
    `version_history` STRING COMMENT 'Historical changes of the recipe stored as JSON.',
    `yield_tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation from max yield.',
    `created_by` STRING COMMENT 'User identifier who created the recipe record.',
    CONSTRAINT pk_recipe PRIMARY KEY(`recipe_id`)
) COMMENT 'Master record for ISA-88 compliant process recipes defining the procedural instructions, ingredient quantities, process parameters, and equipment requirements for batch and continuous manufacturing processes managed by automation systems. Captures recipe name, recipe type (master recipe, control recipe, site recipe, general recipe per ISA-88), product reference, recipe version, revision number, release status (draft, approved, released, obsolete), total process time, equipment class requirements, phase sequence definition, ingredient list with target quantities and tolerances, critical process parameters with setpoints, and approval metadata. Serves as the automation-layer procedural definition consumed by batch execution systems.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` (
    `equipment_phase_id` BIGINT COMMENT 'System-generated unique identifier for the equipment phase record.',
    `control_system_id` BIGINT COMMENT 'Identifier of the control system (e.g., PLC, DCS) that executes the phase.',
    `plc_program_id` BIGINT COMMENT 'Identifier of the PLC program that defines abort handling for the phase.',
    `equipment_plc_program_id` BIGINT COMMENT 'Identifier of the PLC program or function block that implements the phase logic.',
    `parent_equipment_phase_id` BIGINT COMMENT 'Self-referencing FK on equipment_phase (parent_equipment_phase_id)',
    `recipe_id` BIGINT COMMENT '',
    `abortable` BOOLEAN COMMENT 'Indicates whether the phase can be safely aborted by the control system.',
    `average_execution_time_seconds` DECIMAL(18,2) COMMENT 'Statistically derived average runtime for the phase, used for scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the phase record was first created.',
    `equipment_phase_description` STRING COMMENT 'Detailed textual description of the phase purpose and behavior.',
    `documentation_url` STRING COMMENT 'Link to external documentation or engineering drawing for the phase.',
    `effective_from` DATE COMMENT 'Date from which the phase definition becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the phase definition is no longer valid (null for open‑ended).',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Typical energy usage of the phase per execution, measured in kilowatt‑hours.',
    `equipment_class_code` BIGINT COMMENT 'Identifier of the equipment class to which this phase applies.',
    `equipment_phase_status` STRING COMMENT 'Current operational status of the phase definition.. Valid values are `active|inactive|deprecated|retired`',
    `input_parameters` STRING COMMENT 'JSON‑encoded list of required input parameters (name, data type, allowed range).',
    `is_default_phase` BOOLEAN COMMENT 'Indicates whether this phase is the default for its equipment class.',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the phase definition within the engineering process.. Valid values are `defined|validated|released|obsolete`',
    `max_concurrent_instances` STRING COMMENT 'Maximum number of equipment units that may run this phase simultaneously.',
    `normal_duration_seconds` DECIMAL(18,2) COMMENT 'Typical execution time for the phase under normal conditions, expressed in seconds.',
    `operator_role` STRING COMMENT 'Role required to manually start or intervene in the phase.. Valid values are `operator|engineer|supervisor`',
    `output_parameters` STRING COMMENT 'JSON‑encoded list of output parameters produced by the phase.',
    `phase_code` STRING COMMENT 'Short alphanumeric code used to reference the phase in control logic.',
    `phase_duration_seconds` DECIMAL(18,2) COMMENT '',
    `phase_name` STRING COMMENT 'Human‑readable name of the phase (e.g., "Charge", "Heat").',
    `phase_sequence` STRING COMMENT '',
    `phase_status` STRING COMMENT '',
    `phase_type` STRING COMMENT 'Categorical type of the phase as defined by ISA‑88.. Valid values are `charge|heat|mix|transfer|cool|drain`',
    `pressure_setpoint_bar` DECIMAL(18,2) COMMENT 'Target pressure for the phase when pressure control is required.',
    `required_skill_level` STRING COMMENT 'Skill level needed by personnel to safely execute the phase.. Valid values are `basic|intermediate|advanced`',
    `revision_number` STRING COMMENT 'Sequential revision number for change control tracking.',
    `safety_critical` BOOLEAN COMMENT 'True if the phase is designated as safety‑critical per IEC 61508/IEC 62443.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature for the phase when temperature control is required.',
    `timeout_duration_seconds` DECIMAL(18,2) COMMENT 'Maximum allowed execution time before the phase is forced to abort, in seconds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the phase record.',
    `version` STRING COMMENT 'Version label of the phase definition (e.g., "v1.0").',
    CONSTRAINT pk_equipment_phase PRIMARY KEY(`equipment_phase_id`)
) COMMENT 'Master record defining ISA-88 equipment phases — the lowest-level procedural elements that can be commanded by a batch control system to perform a specific action on a piece of equipment (e.g., CHARGE, HEAT, MIX, TRANSFER, COOL, DRAIN). Captures phase name, phase type, associated equipment class, associated control system, phase logic reference (PLC program or function block), required input parameters with data types and ranges, output parameters, normal duration, timeout duration, abort logic reference, and phase status. Provides the procedural building blocks for recipe construction and batch execution in ISA-88 compliant automation architectures.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` (
    `opc_server_id` BIGINT COMMENT 'System-generated unique identifier for the OPC server record.',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to automation.network_segment. Business justification: OPC server resides in a network segment; FK to network_segment normalizes segment data and replaces the free‑text field.',
    `redundant_opc_server_id` BIGINT COMMENT 'Self-referencing FK on opc_server (redundant_opc_server_id)',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: OPC server hardware is sourced from a vendor; linking supports warranty management and regulatory compliance documentation.',
    `alarm_capacity` STRING COMMENT 'Maximum number of concurrent alarms the server can handle.',
    `authentication_mode` STRING COMMENT 'Method used by clients to authenticate with the server.. Valid values are `anonymous|username|certificate`',
    `certificate_thumbprint` STRING COMMENT 'SHA‑1 thumbprint of the servers X.509 certificate (if certificate authentication is used).',
    `commissioning_date` DATE COMMENT 'Date the server was placed into production service.',
    `connected_client_count` STRING COMMENT 'Current number of active client sessions connected to the server.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OPC server record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the server was retired from service (null if still active).',
    `opc_server_description` STRING COMMENT 'Free‑form description of the servers purpose, location, or special characteristics.',
    `endpoint_url` STRING COMMENT 'Network address (URL) through which clients connect to the server.',
    `engineering_workstation` STRING COMMENT 'Identifier of the engineering workstation used for server configuration.',
    `host_machine` STRING COMMENT 'Name or identifier of the physical/virtual host running the OPC server.',
    `installation_date` DATE COMMENT 'Date the OPC server software was first installed on the host.',
    `last_config_backup_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent backup of the server configuration.',
    `last_connectivity_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent health‑check ping to the server.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle phase of the server within asset management.. Valid values are `in_service|retired|maintenance|decommissioned`',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time between server failures, calculated by maintenance team.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the server after a failure.',
    `opc_server_name` STRING COMMENT 'Human‑readable name of the OPC server instance.',
    `opc_specification` STRING COMMENT '',
    `plant_area` STRING COMMENT 'Physical plant area or zone where the server is deployed.',
    `polling_interval_ms` STRING COMMENT 'Default client polling interval in milliseconds for data change monitoring.',
    `product_name` STRING COMMENT 'Commercial product name of the OPC server software.',
    `redundancy_configuration` DECIMAL(18,2) COMMENT 'High‑availability setup for the OPC server.',
    `safety_integrity_level` STRING COMMENT 'Safety integrity classification required for the server in safety‑critical environments.. Valid values are `SIL1|SIL2|SIL3|SIL4`',
    `security_policy` STRING COMMENT 'Security policy applied to the OPC communication channel.. Valid values are `None|Basic128Rsa15|Basic256Sha256`',
    `server_code` STRING COMMENT 'Enterprise‑wide unique code assigned to the server for reference.',
    `server_name` STRING COMMENT '',
    `server_status` STRING COMMENT 'Real‑time operational state of the OPC server.. Valid values are `running|stopped|error|maintenance`',
    `server_type` STRING COMMENT 'Protocol family implemented by the server.. Valid values are `OPC-UA|OPC-DA|OPC-HDA|OPC-AE`',
    `subscription_count` STRING COMMENT 'Number of active subscription objects on the server.',
    `tag_count` STRING COMMENT 'Total number of OPC tags (variables) the server makes available.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the OPC server record.',
    `uptime_hours` DECIMAL(18,2) COMMENT 'Cumulative operational hours since last start or commissioning.',
    `version` STRING COMMENT 'Version string of the OPC server software.',
    CONSTRAINT pk_opc_server PRIMARY KEY(`opc_server_id`)
) COMMENT 'Master record for OPC-UA and OPC-DA server instances deployed within the automation infrastructure, serving as the communication middleware between field devices and supervisory systems. Captures OPC server name, server type (OPC-UA, OPC-DA, OPC-HDA, OPC-AE), vendor and product name, server version, host machine reference, endpoint URL, security policy (None, Basic128Rsa15, Basic256Sha256), authentication mode (anonymous, username, certificate), certificate thumbprint, connected client count, tag count served, polling interval, subscription count, server status, and last connectivity check timestamp. Provides the communication topology map for data flow from field to supervisory layers.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` (
    `historian_config_id` BIGINT COMMENT 'System-generated unique identifier for each historian configuration record.',
    `superseded_historian_config_id` BIGINT COMMENT 'Self-referencing FK on historian_config (superseded_historian_config_id)',
    `tag_definition_id` BIGINT COMMENT 'Reference to the tag definition that this configuration applies to.',
    `alarm_enabled` BOOLEAN COMMENT 'Indicates whether alarm generation is active for tags under this configuration.',
    `alarm_priority` STRING COMMENT 'Default priority assigned to alarms generated from this configuration.. Valid values are `low|medium|high|critical`',
    `archive_group` STRING COMMENT 'Logical grouping used to route data to specific archive storage tiers.',
    `archive_group_description` STRING COMMENT 'Human‑readable description of the archive group purpose.',
    `collection_enabled` BOOLEAN COMMENT 'Indicates whether tag data collection is currently active for this configuration.',
    `collection_interval_ms` STRING COMMENT 'Desired sampling interval in milliseconds for tag data collection.',
    `compression_algorithm` STRING COMMENT 'Algorithm used for data compression when compression_enabled is true.. Valid values are `gzip|lz4|none`',
    `compression_deviation` DOUBLE COMMENT 'Maximum deviation (percentage) allowed before a new compressed data point is written.',
    `compression_enabled` BOOLEAN COMMENT 'Specifies whether collected data should be compressed before storage.',
    `compression_enabled_flag` BOOLEAN COMMENT '',
    `compression_timeout_seconds` STRING COMMENT 'Maximum time in seconds to wait before forcing a compressed write, regardless of deviation.',
    `config_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the configuration record was first created.',
    `data_quality_code` STRING COMMENT 'Quality classification of the collected data for this configuration.. Valid values are `good|questionable|bad`',
    `historian_config_description` STRING COMMENT 'Free‑form description of the configuration purpose and scope.',
    `exception_deviation` DOUBLE COMMENT 'Deviation threshold that triggers an exception event instead of normal compression.',
    `historian_config_status` STRING COMMENT 'Current lifecycle status of the historian configuration.. Valid values are `active|inactive|deprecated|pending`',
    `instance_name` STRING COMMENT 'Name of the historian server or instance to which this configuration applies.',
    `last_config_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the last time the historian settings were applied to the runtime system.',
    `lifecycle_status` STRING COMMENT 'Operational lifecycle stage of the historian configuration.. Valid values are `in_service|retired|decommissioned|planned`',
    `max_data_rate_per_sec` DOUBLE COMMENT 'Upper bound on data ingestion rate (records per second) for this configuration.',
    `max_tag_count` STRING COMMENT 'Maximum number of tags that can be collected under this configuration.',
    `historian_config_name` STRING COMMENT 'Human‑readable name identifying the historian configuration.',
    `owner` STRING COMMENT 'Name or identifier of the person or team responsible for this configuration.',
    `platform` STRING COMMENT 'Underlying historian technology platform used for time‑series storage.. Valid values are `OSIsoft_PI|AspenTech_IP21|Wonderware|InfluxDB`',
    `retention_days` STRING COMMENT '',
    `retention_period_days` STRING COMMENT 'Number of days that collected data is retained before archival or deletion.',
    `retention_policy` STRING COMMENT 'Policy governing how data is retained and purged.. Valid values are `rolling|fixed|archival`',
    `sampling_interval_ms` STRING COMMENT '',
    `scaling_factor` DOUBLE COMMENT 'Multiplicative factor applied to raw tag values before storage.',
    `storage_resolution_ms` STRING COMMENT 'Effective resolution at which data is stored after any compression or aggregation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the configuration.',
    `version` STRING COMMENT 'Version string of the configuration, updated on each change.',
    CONSTRAINT pk_historian_config PRIMARY KEY(`historian_config_id`)
) COMMENT 'Master record for process historian configuration defining which tags are collected, at what resolution, with what compression settings, and for what retention period within the process data historian (OSIsoft PI, Aspentech IP.21, Wonderware Historian, InfluxDB). Captures historian instance name, historian platform, tag definition reference, collection enabled flag, collection interval (ms), compression enabled flag, compression deviation, compression timeout, exception deviation, storage resolution, retention period (days), archive group, and last configuration update timestamp. Governs the data collection policy for process time-series data and ensures historian configuration is auditable and version-controlled.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` (
    `automation_change_request_id` BIGINT COMMENT 'System-generated unique identifier for the automation change request record.',
    `plc_program_id` BIGINT COMMENT 'Reference to the PLC program that will be changed or replaced.',
    `asset_work_order_id` BIGINT COMMENT 'Work order that will execute or has executed the change.',
    `employee_id` BIGINT COMMENT '',
    `control_system_id` BIGINT COMMENT 'Reference to the control system impacted by the change.',
    `device_registry_id` BIGINT COMMENT 'Reference to the specific PLC, sensor, or edge device being modified.',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: Engineering Change Notice drives automation change request; required for Regulatory Compliance Change Log.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Engineering Change Order triggers automation change request; essential for Change Impact Report linking ECO to automation actions.',
    `primary_automation_employee_id` BIGINT COMMENT 'Identifier of the employee or stakeholder who originated the change request.',
    `superseded_automation_change_request_id` BIGINT COMMENT 'Self-referencing FK on automation_change_request (superseded_automation_change_request_id)',
    `tertiary_automation_change_review_by_employee_id` BIGINT COMMENT 'Identifier of the engineer or auditor who performed the review.',
    `actual_downtime_minutes` STRING COMMENT 'Measured downtime that occurred during implementation.',
    `actual_implementation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the change was performed on the field.',
    `approval_status` STRING COMMENT 'Current status of the required approvals for the change request.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the approval decision was recorded.',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `automation_change_request_status` STRING COMMENT 'Current workflow state of the change request.. Valid values are `draft|submitted|approved|rejected|in_progress|closed`',
    `change_audit_log_reference` STRING COMMENT 'Link or identifier to the immutable audit log entry for this change request.',
    `change_closure_date` DATE COMMENT 'Date on which the change request was formally closed.',
    `change_description` STRING COMMENT 'Detailed narrative of the modification, including purpose and scope.',
    `change_effective_timestamp` TIMESTAMP COMMENT 'Timestamp when the change became operationally effective.',
    `change_origin` STRING COMMENT 'Source of the change request: internal team, external partner, or vendor.. Valid values are `internal|external|vendor`',
    `change_priority` STRING COMMENT 'Business‑defined priority level for scheduling the change.. Valid values are `low|medium|high|critical`',
    `change_rationale` DECIMAL(18,2) COMMENT 'Business justification for why the change is required.',
    `change_request_number` STRING COMMENT 'Human‑readable reference number assigned to the change request for tracking and communication.',
    `change_review_status` STRING COMMENT 'State of the post‑implementation review process.. Valid values are `pending|reviewed|closed`',
    `change_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the review was completed.',
    `change_status` STRING COMMENT '',
    `change_type` STRING COMMENT 'Category of automation modification being requested.. Valid values are `program_change|configuration_change|hardware_change|network_change|setpoint_change`',
    `comments` STRING COMMENT 'Free‑form notes from requestor or reviewers.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the change (e.g., ISA‑84, IEC 62443).. Valid values are `isa_84|iec_62443|none`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the record was first created in the data lake.',
    `estimated_downtime_minutes` STRING COMMENT 'Projected production downtime associated with the change.',
    `is_emergency_change` BOOLEAN COMMENT 'True if the change is classified as an emergency requiring expedited handling.',
    `planned_implementation_date` DATE COMMENT 'Target calendar date for executing the change.',
    `post_change_validation_status` STRING COMMENT 'Result of validation activities after the change is applied.. Valid values are `not_started|passed|failed`',
    `pre_change_backup_reference` STRING COMMENT 'Identifier or location of the backup taken before the change (e.g., file path, archive ID).',
    `production_impact` STRING COMMENT 'Qualitative assessment of potential impact on production output or quality.. Valid values are `none|low|medium|high|critical`',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the change request was initially submitted.',
    `requested_timestamp` TIMESTAMP COMMENT '',
    `risk_score` STRING COMMENT 'Numeric risk rating derived from safety and production impact assessments (0‑100).',
    `rollback_plan_reference` STRING COMMENT 'Identifier of the documented rollback procedure in case the change fails.',
    `safety_impact` STRING COMMENT 'Qualitative assessment of potential safety consequences of the change.. Valid values are `none|low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the record.',
    `validation_test_results` STRING COMMENT 'Summary of test outcomes performed after the change (e.g., pass/fail details).',
    CONSTRAINT pk_automation_change_request PRIMARY KEY(`automation_change_request_id`)
) COMMENT 'Transactional record governing the Management of Change (MOC) process for automation system modifications including PLC program changes, setpoint limit changes, control system configuration changes, network topology changes, and device replacements. Captures change request number, change type (program change, configuration change, hardware change, network change, setpoint limit change), affected system/device references, change description, risk assessment (safety impact, production impact), required approvals, approval status, planned implementation date, actual implementation date, pre-change backup reference, post-change validation status, and change closure date. Implements ISA-84 and IEC 62443 change management requirements for safety-critical automation systems.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` (
    `device_connectivity_event_id` BIGINT COMMENT 'Unique surrogate key for each connectivity event record.',
    `alarm_event_id` BIGINT COMMENT 'Reference to the alarm event that may have been generated by this connectivity issue.',
    `device_registry_id` BIGINT COMMENT 'Identifier of the automation device, edge gateway, or OPC server that generated the event.',
    `asset_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the device resides.',
    `preceding_device_connectivity_event_id` BIGINT COMMENT 'Self-referencing FK on device_connectivity_event (preceding_device_connectivity_event_id)',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or cell containing the device.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or station associated with the device.',
    `auto_recovery_attempted` TIMESTAMP COMMENT 'Flag indicating whether an automatic recovery action was triggered.',
    `communication_protocol` STRING COMMENT 'Network protocol used by the device for communication.. Valid values are `OPC-UA|Modbus|Ethernet/IP|Profinet|Ethernet`',
    `connectivity_status` STRING COMMENT '',
    `detection_source` STRING COMMENT 'Method or channel that detected the connectivity change.. Valid values are `heartbeat|opc_status|network_probe`',
    `device_connectivity_event_status` STRING COMMENT 'Current processing status of the event record within the data pipeline.. Valid values are `processed|pending|failed`',
    `device_model` STRING COMMENT 'Model designation of the device (e.g., PLC‑3000, Edge‑Gateway‑X).',
    `device_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the hardware unit.',
    `error_code` STRING COMMENT 'Standardized error identifier returned by the device or network layer.',
    `error_description` STRING COMMENT 'Human‑readable description of the error condition.',
    `event_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first inserted into the lakehouse.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the connectivity state change was detected.',
    `event_type` STRING COMMENT 'Category of connectivity event indicating the new state of the device.. Valid values are `online|offline|degraded|timeout|error`',
    `event_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this event record (e.g., after recovery information is added).',
    `last_successful_comm_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful communication before this event.',
    `network_address` STRING COMMENT 'IP address of the device on the OT network.',
    `new_state` STRING COMMENT 'Device connectivity state after the transition.. Valid values are `online|offline|degraded|timeout|error`',
    `notes` STRING COMMENT 'Free‑form field for additional context or operator comments.',
    `previous_state` STRING COMMENT 'Device connectivity state before the transition.. Valid values are `online|offline|degraded|timeout|error`',
    `recovery_timestamp` TIMESTAMP COMMENT 'Timestamp when the auto‑recovery (or manual recovery) completed, if applicable.',
    CONSTRAINT pk_device_connectivity_event PRIMARY KEY(`device_connectivity_event_id`)
) COMMENT 'Transactional record capturing device connectivity state change events — when automation devices, edge gateways, or OPC servers go online, offline, or enter degraded communication states. Each record represents a discrete connectivity transition event. Captures device reference, event timestamp, previous connectivity state, new connectivity state (online, offline, degraded, timeout, error), last successful communication timestamp, error code, error description, detection source (heartbeat monitor, OPC server status, network probe), auto-recovery attempted flag, recovery timestamp, and associated alarm event reference. Supports OT network health monitoring and mean-time-to-restore (MTTR) tracking for automation infrastructure.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` (
    `safety_function_id` BIGINT COMMENT 'System‑generated unique identifier for the safety function record.',
    `control_system_id` BIGINT COMMENT 'Identifier of the Safety Instrumented System (SIS) that hosts this function.',
    `parent_safety_function_id` BIGINT COMMENT 'Self-referencing FK on safety_function (parent_safety_function_id)',
    `process_hazard_id` BIGINT COMMENT 'Reference to the hazard that triggers this safety function.',
    `associated_sensor_tags` STRING COMMENT 'Comma‑separated list of OPC‑UA or SCADA tag identifiers for sensors feeding the SIF.',
    `bypass_allowed` BOOLEAN COMMENT 'Indicates whether the safety function may be bypassed during maintenance or abnormal operation.',
    `change_control_reference` STRING COMMENT 'Identifier of the change request or engineering change order that created/modified the SIF.',
    `compliance_standard` STRING COMMENT 'Reference to the governing safety standard (e.g., IEC 61511) applicable to this function.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety function record was first created in the system.',
    `safety_function_description` STRING COMMENT 'Extended free‑text description of the safety function purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the safety function is retired or superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the safety function becomes operationally effective.',
    `final_element_tags` STRING COMMENT 'Comma‑separated list of tags for final elements (valves, actuators) that execute the safe state.',
    `initiating_cause_description` STRING COMMENT 'Narrative of the hazardous condition that initiates the safety function.',
    `last_proof_test_date` DATE COMMENT 'Date on which the most recent proof test of the SIF was performed.',
    `logic_solver_reference` STRING COMMENT 'Identifier of the PLC/logic solver that implements the SIF logic.',
    `mean_time_to_failure_on_demand` DECIMAL(18,2) COMMENT 'Average probability of failure on demand for the SIF (PFDavg).',
    `safety_function_name` STRING COMMENT 'Human‑readable name of the safety function as used in engineering documentation.',
    `process_demand_rate` DECIMAL(18,2) COMMENT 'Average number of times per hour the safety function is demanded by the process.',
    `proof_test_interval_months` STRING COMMENT 'Planned interval, in months, between mandatory proof tests of the SIF.',
    `response_time_ms` STRING COMMENT '',
    `risk_reduction_factor` DECIMAL(18,2) COMMENT 'Calculated factor representing the reduction in risk achieved by the SIF.',
    `safe_state_description` STRING COMMENT 'Description of the process state that the SIF drives the system into when activated.',
    `safety_function_status` STRING COMMENT 'Current lifecycle status of the safety function.. Valid values are `active|inactive|decommissioned|pending`',
    `safety_integrity_level` STRING COMMENT 'Designated SIL for the function (SIL1‑SIL4) indicating required risk reduction.. Valid values are `SIL1|SIL2|SIL3|SIL4`',
    `sif_number` STRING COMMENT 'Unique code assigned to the SIF within the safety instrumented system.',
    `sil_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the safety function record.',
    `verification_method` STRING COMMENT 'Method used to verify that the SIF meets its SIL (e.g., LOPA, Fault Tree).. Valid values are `LOPA|FaultTree|FMEA|Other`',
    CONSTRAINT pk_safety_function PRIMARY KEY(`safety_function_id`)
) COMMENT 'Master record for Safety Instrumented Functions (SIFs) defined within Safety Instrumented Systems (SIS) per IEC 61511. Each SIF represents a discrete safety function designed to bring a process to a safe state upon detection of a hazardous condition. Captures SIF name, SIF number, associated SIS/control system reference, process hazard reference, Safety Integrity Level (SIL 1/2/3/4), SIL verification method (LOPA, fault tree), required risk reduction factor (RRF), initiating cause description, safe state description, process demand rate, proof test interval (months), mean time to failure on demand (PFDavg), associated sensor tags, logic solver reference, final element tags, bypass allowed flag, and last proof test date. Critical for functional safety lifecycle management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` (
    `proof_test_record_id` BIGINT COMMENT 'Unique system-generated identifier for the proof test record.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the equipment used to conduct the proof test.',
    `previous_proof_test_record_id` BIGINT COMMENT 'Self-referencing FK on proof_test_record (previous_proof_test_record_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the technician who performed the proof test.',
    `device_registry_id` BIGINT COMMENT 'Identifier of the final element component involved in the SIF.',
    `proof_component_logic_solver_device_registry_id` BIGINT COMMENT 'Identifier of the logic solver component involved in the SIF.',
    `proof_device_registry_id` BIGINT COMMENT 'Identifier of the sensor component involved in the SIF.',
    `proof_tested_by_employee_id` BIGINT COMMENT '',
    `safety_function_id` BIGINT COMMENT 'Reference to the Safety Instrumented Function (SIF) being tested.',
    `location_id` BIGINT COMMENT 'Reference to the physical location where the proof test was performed.',
    `test_procedure_id` BIGINT COMMENT 'Identifier of the documented test procedure used for this proof test.',
    `approval_signature_reference` BIGINT COMMENT 'Reference to the digital signature approving the test results.',
    `as_found_condition` STRING COMMENT 'Condition of the SIF components as found before any corrective action.',
    `as_left_condition` STRING COMMENT 'Condition of the SIF components after the proof test and any repairs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof test record was first created in the system.',
    `detected_failures` STRING COMMENT 'List of failures identified during the proof test.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next required proof test.',
    `proof_test_record_status` STRING COMMENT 'Current lifecycle status of the proof test record.. Valid values are `planned|in_progress|completed|approved|rejected`',
    `repair_actions_taken` STRING COMMENT 'Description of corrective actions performed to address detected failures.',
    `safety_integrity_level` STRING COMMENT 'Designated SIL of the safety instrumented function being tested.. Valid values are `SIL1|SIL2|SIL3|SIL4`',
    `test_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was formally approved.',
    `test_comments` STRING COMMENT 'Additional free‑form comments captured by the technician.',
    `test_date` DATE COMMENT 'Calendar date on which the proof test was performed.',
    `test_document_reference` STRING COMMENT 'Reference (e.g., file name or URL) to the detailed test procedure document.',
    `test_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the proof test in seconds.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the proof test ended.',
    `test_environment` STRING COMMENT 'Operational environment condition during the test.. Valid values are `normal|abnormal|maintenance`',
    `test_failed_criteria` STRING COMMENT 'List of criteria that were not met during the test.',
    `test_failure_count` STRING COMMENT 'Number of individual failures detected during the proof test.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded during the test.',
    `test_is_critical` BOOLEAN COMMENT 'Indicates whether the proof test is classified as critical for safety compliance.',
    `test_number` STRING COMMENT 'Business identifier assigned to the proof test event.',
    `test_operator_notes` STRING COMMENT 'Additional observations entered by the operator.',
    `test_passed_criteria` STRING COMMENT 'List of criteria that were successfully met during the test.',
    `test_pressure_bar` DECIMAL(18,2) COMMENT 'Process pressure measured during the test, in bar.',
    `test_result` STRING COMMENT 'Overall outcome of the proof test.. Valid values are `pass|fail|partial_pass`',
    `test_result_code` STRING COMMENT 'Standardized code representing the test result outcome.',
    `test_result_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was recorded.',
    `test_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was reviewed.',
    `test_revision_number` STRING COMMENT 'Revision number of the test execution.',
    `test_source_system` STRING COMMENT 'Name of the source system where the proof test record originated.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the proof test started.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature recorded during the test, in degrees Celsius.',
    `test_type` STRING COMMENT 'Type of proof test performed: full, partial stroke, or partial.. Valid values are `full|partial_stroke|partial`',
    `test_version` STRING COMMENT 'Version identifier of the test procedure applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the proof test record.',
    CONSTRAINT pk_proof_test_record PRIMARY KEY(`proof_test_record_id`)
) COMMENT 'Transactional record capturing the execution and results of periodic proof tests performed on Safety Instrumented Functions (SIFs) and their associated safety instrumented system components. Each record documents a discrete proof test event. Captures safety function reference, test date, test type (full proof test, partial stroke test, partial proof test), test procedure reference, tested components (sensor, logic solver, final element), test result (pass, fail, partial pass), as-found condition, as-left condition, detected failures, repair actions taken, next test due date, test duration, technician reference, and approval signature reference. Supports IEC 61511 proof test documentation and SIL verification maintenance requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` (
    `automation_project_id` BIGINT COMMENT 'Unique identifier for the automation engineering project.',
    `employee_id` BIGINT COMMENT '',
    `control_system_id` BIGINT COMMENT 'Reference to the control system that is the target of the automation project.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgeting: projects are funded from specific cost centers, required for the Project Cost Allocation Ledger.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Project budgeting, status reporting, and profitability analysis require associating each automation project with its customer.',
    `parent_automation_project_id` BIGINT COMMENT 'Self-referencing FK on automation_project (parent_automation_project_id)',
    `primary_automation_engineer_employee_id` BIGINT COMMENT 'Identifier of the lead automation engineer for the project.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue attribution: automation projects generate revenue tracked against profit centers, needed for the Project Profitability Dashboard.',
    `project_header_id` BIGINT COMMENT 'FK to project.project_header.project_header_id — Automation engineering projects must link to the enterprise project management domain for cost tracking, resource allocation, and milestone governance. Without this, automation projects are ungoverned',
    `tertiary_automation_approved_by_employee_id` BIGINT COMMENT 'Identifier of the person who approved the project budget or scope.',
    `actual_duration_days` DECIMAL(18,2) COMMENT 'Actual total duration of the project in days.',
    `actual_end_date` DATE COMMENT 'Actual date when project was completed.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred to date.',
    `actual_start_date` DATE COMMENT 'Actual date when project work started.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the project was approved.',
    `automation_project_status` STRING COMMENT 'Current lifecycle status of the automation project.. Valid values are `concept|design|installation|commissioning|handed_over|closed`',
    `automation_project_type` STRING COMMENT 'Classification of the automation project based on its nature.. Valid values are `greenfield|brownfield|migration|expansion|cybersecurity_hardening`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the project in the primary currency.',
    `budget_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the budget amount.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the project against regulatory standards.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the system.',
    `automation_project_description` STRING COMMENT 'Detailed description of scope, objectives, and deliverables.',
    `documentation_url` STRING COMMENT 'Link to the central project documentation repository.',
    `end_date` TIMESTAMP COMMENT '',
    `estimated_duration_days` DECIMAL(18,2) COMMENT 'Estimated total duration of the project in days.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the project is classified as critical to operations.',
    `is_cybersecurity_hardening` BOOLEAN COMMENT 'Indicates if the project includes cybersecurity hardening activities.',
    `automation_project_name` STRING COMMENT 'Descriptive name of the automation project.',
    `planned_end_date` DATE COMMENT 'Planned date for project completion.',
    `planned_start_date` DATE COMMENT 'Planned date for project commencement.',
    `priority` STRING COMMENT 'Priority level assigned to the project based on business impact.. Valid values are `low|medium|high|critical`',
    `project_code` STRING COMMENT 'Unique alphanumeric code assigned to the automation project.',
    `project_status` STRING COMMENT '',
    `risk_rating` STRING COMMENT 'Overall risk rating for the project.. Valid values are `low|medium|high|critical`',
    `safety_integrity_level` STRING COMMENT 'Safety Integrity Level assigned to the control system within the project.. Valid values are `SIL1|SIL2|SIL3|SIL4`',
    `sla_actual_hours` STRING COMMENT 'Actual hours achieved against SLA targets.',
    `sla_target_hours` STRING COMMENT 'Target hours for service level agreements related to project deliverables.',
    `stakeholder_group` STRING COMMENT 'Primary stakeholder group for the project.. Valid values are `operations|maintenance|engineering|executive|safety`',
    `start_date` TIMESTAMP COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_automation_project PRIMARY KEY(`automation_project_id`)
) COMMENT 'Master record for automation engineering projects representing discrete scopes of work for designing, implementing, commissioning, or upgrading automation systems. Captures project name, project type (greenfield installation, brownfield upgrade, migration, expansion, cybersecurity hardening), associated plant/facility, project manager reference, automation engineer reference, target control system reference, project status (concept, design, procurement, installation, commissioning, FAT, SAT, handover, closed), planned start date, planned completion date, actual start date, actual completion date, budget reference, and associated change requests. Distinct from project.project_header (capital projects) — this entity is the automation-domain-specific project record for OT engineering work.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` (
    `io_mapping_id` BIGINT COMMENT 'Unique system-generated identifier for the I/O mapping record.',
    `control_system_id` BIGINT COMMENT 'FK to automation.control_system',
    `device_registry_id` BIGINT COMMENT 'Unique identifier for the I/O module hardware.',
    `plc_program_id` BIGINT COMMENT '',
    `project_change_request_id` BIGINT COMMENT 'Identifier of the change request that drove the latest modification.',
    `remapped_io_mapping_id` BIGINT COMMENT 'Self-referencing FK on io_mapping (remapped_io_mapping_id)',
    `tag_definition_id` BIGINT COMMENT '',
    `access_level` STRING COMMENT 'Permission level for reading or writing the I/O point.. Valid values are `read|write|read_write`',
    `address` STRING COMMENT 'Logical address of the I/O point within the controller (e.g., %I0.0).',
    `alarm_enabled` BOOLEAN COMMENT 'Indicates whether alarms are generated for this I/O point.',
    `alarm_priority` STRING COMMENT 'Severity level assigned to alarms from this I/O point.. Valid values are `low|medium|high|critical`',
    `cable_number` STRING COMMENT 'Identifier of the cable linking the field device to the I/O module.',
    `change_reason` STRING COMMENT 'Reason for the most recent change to the I/O mapping.',
    `channel_code` STRING COMMENT 'Unique code assigned to the I/O channel within the control system.',
    `channel_name` STRING COMMENT 'Human‑readable name of the I/O channel used by engineers and operators.',
    `channel_number` STRING COMMENT 'Numeric channel index within the I/O module.',
    `commissioning_date` DATE COMMENT 'Date the I/O channel was commissioned into service.',
    `commissioning_status` STRING COMMENT 'Current commissioning state of the I/O channel.. Valid values are `commissioned|not_commissioned|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the I/O mapping record was created.',
    `data_source_system` STRING COMMENT 'Originating system of record for the I/O mapping (e.g., Siemens Opcenter MES).',
    `deadband` DECIMAL(18,2) COMMENT 'Minimum change in signal value required to trigger an update.',
    `decommission_date` DATE COMMENT 'Date the I/O channel was removed from service, if applicable.',
    `io_mapping_description` STRING COMMENT 'Free‑form description of the I/O channel purpose or special notes.',
    `device_name` STRING COMMENT 'Name of the PLC/DCS device to which the I/O channel is assigned.',
    `engineering_unit` STRING COMMENT 'Unit of measure used for the signal (e.g., psi, °C, bar).',
    `field_instrument_tag` STRING COMMENT 'Tag number from Piping & Instrument Diagram that identifies the field device.',
    `io_address` STRING COMMENT '',
    `io_mapping_status` STRING COMMENT 'Current operational status of the I/O mapping.. Valid values are `active|inactive|decommissioned|planned`',
    `io_module_type` STRING COMMENT 'Classification of the I/O module based on its capabilities.. Valid values are `input_module|output_module|mixed_module`',
    `io_type` STRING COMMENT 'Category of the I/O point indicating its function and signal direction.. Valid values are `digital_input|digital_output|analog_input|analog_output|pulse_input`',
    `is_historian_enabled` BOOLEAN COMMENT 'Indicates whether this I/O point is logged to the process historian.',
    `junction_box` STRING COMMENT 'Reference to the junction box used in the wiring path.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent audit of this I/O mapping record.',
    `mapping_status` STRING COMMENT '',
    `module_slot` STRING COMMENT 'Slot identifier within the I/O rack where the module resides.',
    `notes` STRING COMMENT 'Additional operational or engineering notes.',
    `quality_code` STRING COMMENT 'Code indicating the quality status of the I/O data (e.g., good, suspect).',
    `raw_range_high` DECIMAL(18,2) COMMENT 'Maximum raw signal value (e.g., mA or V) before scaling.',
    `raw_range_low` DECIMAL(18,2) COMMENT 'Minimum raw signal value (e.g., mA or V) before scaling.',
    `retention_period_days` STRING COMMENT 'Number of days the I/O data is retained in the historian.',
    `safety_critical` BOOLEAN COMMENT 'Flag indicating whether the I/O point is safety‑critical per IEC 61508/IEC 62443.',
    `scaling_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor applied during signal conversion.',
    `scaling_high` DECIMAL(18,2) COMMENT 'Upper bound of the engineering unit range after scaling.',
    `scaling_low` DECIMAL(18,2) COMMENT 'Lower bound of the engineering unit range after scaling.',
    `scan_rate_ms` DECIMAL(18,2) COMMENT 'Frequency at which the I/O point is scanned by the controller, in milliseconds.',
    `signal_type` STRING COMMENT 'Physical signal standard used for the I/O point.. Valid values are `4-20mA|0-10V|24VDC|thermocouple|RTD|HART`',
    `tag_name` STRING COMMENT 'Name of the historian/tag definition linked to this I/O point.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the I/O mapping record.',
    `version` STRING COMMENT 'Version identifier for the I/O mapping configuration.',
    `wiring_terminal` STRING COMMENT 'Terminal identifier on the I/O module where the wire connects.',
    CONSTRAINT pk_io_mapping PRIMARY KEY(`io_mapping_id`)
) COMMENT 'Master record defining the physical and logical Input/Output (I/O) mapping between field instruments/actuators and PLC/DCS controller I/O modules. Each record represents a single I/O channel assignment. Captures I/O channel identifier, associated device (PLC/DCS), I/O module slot and channel number, I/O type (digital input, digital output, analog input, analog output, pulse input), signal type (4-20mA, 0-10V, 24VDC, thermocouple, RTD, HART), associated tag definition, field instrument tag number (P&ID reference), engineering unit, scaling low/high, wiring terminal reference, cable number, junction box reference, and commissioning status. Provides the definitive I/O list linking physical field wiring to software tag definitions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` (
    `fat_sat_record_id` BIGINT COMMENT 'System-generated unique identifier for each FAT/SAT test execution record.',
    `automation_project_id` BIGINT COMMENT 'Identifier of the automation engineering project to which this test belongs.',
    `control_system_id` BIGINT COMMENT 'Identifier of the control system (PLC, DCS, etc.) under test.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the specific equipment or panel under test.',
    `location_id` BIGINT COMMENT 'Identifier of the plant or site area where the test was performed.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer or technician who performed the test.',
    `project_document_id` BIGINT COMMENT 'Reference to the approved test protocol document governing this test.',
    `retest_fat_sat_record_id` BIGINT COMMENT 'Self-referencing FK on fat_sat_record (retest_fat_sat_record_id)',
    `tertiary_fat_approved_by_employee_id` BIGINT COMMENT 'Identifier of the authority who approved the test record.',
    `test_case_id` BIGINT COMMENT 'Unique code for the specific test case within the test protocol.',
    `actual_observed_result` STRING COMMENT 'Measured value or condition observed during the test.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the test record received final approval.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the test execution.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action must be taken to resolve a deviation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the test record was first created in the system.',
    `deviation_description` STRING COMMENT 'Explanation of any difference between actual and expected results.',
    `expected_result` STRING COMMENT 'Target value or condition defined in the test protocol.',
    `fat_sat_record_status` STRING COMMENT 'Current lifecycle state of the test record.. Valid values are `OPEN|IN_REVIEW|CLOSED|REJECTED`',
    `record_number` STRING COMMENT 'Human‑readable sequential number assigned to the test record for traceability.',
    `record_status` STRING COMMENT '',
    `retest_required` BOOLEAN COMMENT 'Indicates whether the test must be repeated after corrective action.',
    `test_case_description` STRING COMMENT 'Narrative description of the test case purpose and steps.',
    `test_date` DATE COMMENT 'Calendar date on which the test was performed.',
    `test_result` STRING COMMENT 'Overall outcome of the test execution.. Valid values are `PASS|FAIL|CONDITIONAL_PASS|NOT_TESTED`',
    `test_type` STRING COMMENT 'Category of the test execution (Factory Acceptance Test, Site Acceptance Test, Integrated FAT, Loop Check, Functional Test).. Valid values are `FAT|SAT|IFAT|LOOP_CHECK|FUNCTIONAL_TEST`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the test record.',
    `witnessed_by` STRING COMMENT '',
    CONSTRAINT pk_fat_sat_record PRIMARY KEY(`fat_sat_record_id`)
) COMMENT 'Transactional record capturing Factory Acceptance Test (FAT) and Site Acceptance Test (SAT) execution results for automation systems and control panels. Each record represents a discrete test execution event against a specific test case within a FAT or SAT test protocol. Captures test record number, test type (FAT, SAT, IFAT, loop check, functional test), associated automation project reference, control system reference, test case identifier, test case description, test date, test result (pass, fail, conditional pass, not tested), actual observed result, expected result, deviation description, corrective action required, retest required flag, tested-by reference, witnessed-by reference, and test protocol document reference. Supports formal commissioning documentation and handover packages.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` (
    `batch_schedule_id` BIGINT COMMENT 'Primary key for batch_schedule',
    `control_system_id` BIGINT COMMENT '',
    `line_id` BIGINT COMMENT 'Identifier of the production line associated with the schedule.',
    `parent_batch_schedule_id` BIGINT COMMENT 'Self-referencing FK on batch_schedule (parent_batch_schedule_id)',
    `production_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the schedule is applied.',
    `recipe_id` BIGINT COMMENT '',
    `audit_comment` STRING COMMENT 'Free‑form comment for audit or change‑control purposes.',
    `batch_quantity` DECIMAL(18,2) COMMENT 'Standard quantity produced per execution of the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created.',
    `batch_schedule_description` STRING COMMENT 'Detailed description of the schedule purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date on which the schedule expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the schedule becomes valid.',
    `enabled_flag` BOOLEAN COMMENT 'Indicates whether the schedule is currently enabled for execution.',
    `estimated_duration_minutes` DECIMAL(18,2) COMMENT 'Typical runtime expected for a batch execution.',
    `frequency_minutes` STRING COMMENT 'Interval in minutes between successive executions when recurrence is time‑based.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this schedule.',
    `max_runtime_minutes` STRING COMMENT 'Maximum allowed runtime for a batch execution before it is flagged.',
    `min_runtime_minutes` STRING COMMENT 'Minimum expected runtime for a batch execution.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next scheduled execution.',
    `owner_email` STRING COMMENT 'Contact email for the schedule owner.',
    `planned_quantity` DECIMAL(18,2) COMMENT '',
    `priority` STRING COMMENT 'Numeric priority used by the scheduler to resolve conflicts; higher value = higher priority.',
    `recurrence_pattern` STRING COMMENT 'Pattern (e.g., cron expression) that defines how the schedule repeats.',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule in operational systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the batch schedule.',
    `schedule_owner` STRING COMMENT 'Name of the person or team responsible for the schedule.',
    `schedule_status` STRING COMMENT '',
    `schedule_type` STRING COMMENT 'Classification of the schedule execution model.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT '',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned start time for the next execution of the schedule.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT '',
    `shift` STRING COMMENT 'Work shift during which the batch is scheduled to run.',
    `batch_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.',
    `tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable deviation percentage from the estimated duration.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the batch quantity.',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `created_by` STRING COMMENT 'User or system that created the schedule record.',
    CONSTRAINT pk_batch_schedule PRIMARY KEY(`batch_schedule_id`)
) COMMENT 'Master reference table for batch_schedule. Referenced by batch_schedule_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`test_case` (
    `test_case_id` BIGINT COMMENT 'Primary key for test_case',
    `automation_project_id` BIGINT COMMENT '',
    `automation_script_id` BIGINT COMMENT 'Identifier of the automation script that implements the test case logic.',
    `parent_test_case_id` BIGINT COMMENT 'Self-referencing FK on test_case (parent_test_case_id)',
    `device_registry_id` BIGINT COMMENT 'Identifier of the PLC, sensor, or edge device that the test case targets.',
    `actual_duration_seconds` DECIMAL(18,2) COMMENT 'Measured execution time of the most recent run, in seconds.',
    `test_case_category` STRING COMMENT 'Classification of the test case by testing focus.',
    `test_case_code` STRING COMMENT 'Business identifier or code used to reference the test case in documentation and tooling.',
    `compliance_requirement` STRING COMMENT 'Regulatory or safety standard that the test case helps satisfy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test case record was first created.',
    `test_case_description` STRING COMMENT 'Detailed textual description of the test case purpose, steps, and expected outcomes.',
    `environment` STRING COMMENT 'Logical environment where the test case is intended to run.',
    `execution_result` STRING COMMENT 'Outcome of the most recent execution of the test case.',
    `expected_duration_seconds` DECIMAL(18,2) COMMENT 'Planned maximum execution time for the test case, in seconds.',
    `expected_result` STRING COMMENT '',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test case is executed automatically (true) or manually (false).',
    `is_critical` BOOLEAN COMMENT 'Marks the test case as critical for safety or compliance; true if failure has high impact.',
    `last_executed_by` STRING COMMENT 'User or system that performed the most recent execution.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date and time when the test case was last executed.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified the test case.',
    `test_case_name` STRING COMMENT 'Human‑readable name of the test case.',
    `owner_team` STRING COMMENT 'Team or functional group responsible for maintaining the test case.',
    `priority` STRING COMMENT 'Business priority indicating the importance of executing the test case.',
    `risk_level` STRING COMMENT 'Assessed risk associated with a failure of this test case.',
    `test_case_status` STRING COMMENT 'Current lifecycle state of the test case.',
    `steps_count` STRING COMMENT 'Number of individual steps or actions defined in the test case.',
    `tags` STRING COMMENT 'Comma‑separated list of free‑form tags for categorization and search.',
    `test_case_type` STRING COMMENT 'Granular type of test case based on testing scope.',
    `test_data_set` STRING COMMENT 'Name or identifier of the data set used during test execution.',
    `test_description` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test case record.',
    `version` STRING COMMENT 'Version label of the test case definition (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the test case.',
    CONSTRAINT pk_test_case PRIMARY KEY(`test_case_id`)
) COMMENT 'Master reference table for test_case. Referenced by test_case_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` (
    `test_procedure_id` BIGINT COMMENT 'Primary key for test_procedure',
    `parent_test_procedure_id` BIGINT COMMENT 'Self-referencing FK on test_procedure (parent_test_procedure_id)',
    `test_case_id` BIGINT COMMENT '',
    `author` STRING COMMENT 'Name of the person or team that authored the test procedure.',
    `test_procedure_code` STRING COMMENT 'External code or catalog number used to reference the test procedure.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that the test procedure satisfies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test procedure record was first created in the system.',
    `test_procedure_description` STRING COMMENT 'Detailed textual description of the test procedure steps and objectives.',
    `effective_from` DATE COMMENT 'Date when the test procedure becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the test procedure is retired or no longer valid (null if open‑ended).',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test procedure can be executed automatically by an edge gateway or control system.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the test procedure was last reviewed for relevance and accuracy.',
    `test_procedure_name` STRING COMMENT 'Human‑readable name of the test procedure.',
    `procedure_name` STRING COMMENT '',
    `procedure_status` STRING COMMENT '',
    `procedure_steps` STRING COMMENT '',
    `procedure_type` STRING COMMENT 'Category describing the purpose of the test procedure.',
    `required_equipment` STRING COMMENT 'Comma‑separated list of equipment or devices needed to execute the test procedure.',
    `safety_rating` STRING COMMENT 'Safety risk classification associated with performing the test procedure.',
    `test_procedure_status` STRING COMMENT 'Current lifecycle state of the test procedure.',
    `test_duration_seconds` DECIMAL(18,2) COMMENT 'Typical or maximum duration of the test procedure expressed in seconds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test procedure record.',
    `version` STRING COMMENT 'Version identifier for the test procedure definition.',
    CONSTRAINT pk_test_procedure PRIMARY KEY(`test_procedure_id`)
) COMMENT 'Master reference table for test_procedure. Referenced by test_procedure_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` (
    `automation_script_id` BIGINT COMMENT 'Primary key for automation_script',
    `called_by_automation_script_id` BIGINT COMMENT 'Self-referencing FK on automation_script (called_by_automation_script_id)',
    `control_system_id` BIGINT COMMENT '',
    `author_name` STRING COMMENT 'Name of the engineer or developer who created the script.',
    `average_execution_time_ms` DECIMAL(18,2) COMMENT 'Mean duration of script execution measured in milliseconds.',
    `checksum_sha256` STRING COMMENT 'SHA‑256 hash of the script file for integrity verification.',
    `compliance_requirements` STRING COMMENT 'Regulatory or industry compliance standards the script must satisfy (e.g., IEC 62443).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the script record was first created in the registry.',
    `deprecation_date` DATE COMMENT 'Date on which the script was marked as deprecated.',
    `automation_script_description` STRING COMMENT 'Detailed free‑text description of the scripts purpose and functionality.',
    `documentation_url` STRING COMMENT 'Link to the external documentation or wiki page for the script.',
    `error_count` BIGINT COMMENT 'Cumulative count of execution failures recorded for the script.',
    `execution_count` BIGINT COMMENT 'Total number of times the script has been executed.',
    `execution_mode` STRING COMMENT 'How the script is invoked: manually, on a schedule, or by an event.',
    `input_parameters_schema` STRING COMMENT 'JSON schema describing expected input parameters for the script.',
    `is_thread_safe` BOOLEAN COMMENT 'Indicates whether the script can safely run concurrently on multiple threads.',
    `language` STRING COMMENT 'Programming language or scripting language used to author the script.',
    `last_error_message` STRING COMMENT 'Error message captured from the most recent failed execution.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful execution.',
    `lifecycle_status` STRING COMMENT 'Lifecycle phase of the script within the development‑to‑production pipeline.',
    `max_execution_time_ms` DECIMAL(18,2) COMMENT 'Longest observed execution duration for the script.',
    `min_execution_time_ms` DECIMAL(18,2) COMMENT 'Shortest observed execution duration for the script.',
    `automation_script_name` STRING COMMENT 'Human‑readable name of the script used to identify it in catalogs and UI.',
    `output_parameters_schema` STRING COMMENT 'JSON schema describing output data produced by the script.',
    `required_permissions` STRING COMMENT 'List of security permissions or roles required to run the script.',
    `runtime_environment` STRING COMMENT 'Target execution environment for the script.',
    `schedule_cron` STRING COMMENT 'Cron expression defining the periodic schedule when execution_mode is scheduled.',
    `script_language` STRING COMMENT '',
    `script_name` STRING COMMENT '',
    `script_status` STRING COMMENT '',
    `script_type` STRING COMMENT 'Category of automation script based on its functional role.',
    `script_version` STRING COMMENT '',
    `security_classification` STRING COMMENT 'Data security level assigned to the script according to corporate policy.',
    `automation_script_status` STRING COMMENT 'Current operational status of the script.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorization and search.',
    `trigger_event` STRING COMMENT 'Name of the event that triggers the script when execution_mode is event_triggered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the script metadata.',
    `version` STRING COMMENT 'Version string following the internal versioning scheme (e.g., v1.2).',
    CONSTRAINT pk_automation_script PRIMARY KEY(`automation_script_id`)
) COMMENT 'Master reference table for automation_script. Referenced by automation_script_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ADD CONSTRAINT `fk_automation_device_registry_parent_device_registry_id` FOREIGN KEY (`parent_device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ADD CONSTRAINT `fk_automation_control_system_parent_control_system_id` FOREIGN KEY (`parent_control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_parent_plc_program_id` FOREIGN KEY (`parent_plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_primary_plc_device_registry_id` FOREIGN KEY (`primary_plc_device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ADD CONSTRAINT `fk_automation_plc_program_target_device_device_registry_id` FOREIGN KEY (`target_device_device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ADD CONSTRAINT `fk_automation_tag_definition_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ADD CONSTRAINT `fk_automation_tag_definition_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ADD CONSTRAINT `fk_automation_tag_definition_parent_tag_definition_id` FOREIGN KEY (`parent_tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ADD CONSTRAINT `fk_automation_edge_gateway_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ADD CONSTRAINT `fk_automation_edge_gateway_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ADD CONSTRAINT `fk_automation_edge_gateway_upstream_edge_gateway_id` FOREIGN KEY (`upstream_edge_gateway_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`edge_gateway`(`edge_gateway_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ADD CONSTRAINT `fk_automation_process_parameter_derived_from_process_parameter_id` FOREIGN KEY (`derived_from_process_parameter_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`process_parameter`(`process_parameter_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ADD CONSTRAINT `fk_automation_process_parameter_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ADD CONSTRAINT `fk_automation_alarm_definition_parent_alarm_definition_id` FOREIGN KEY (`parent_alarm_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_definition`(`alarm_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ADD CONSTRAINT `fk_automation_alarm_definition_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ADD CONSTRAINT `fk_automation_network_segment_parent_network_segment_id` FOREIGN KEY (`parent_network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_alarm_definition_id` FOREIGN KEY (`alarm_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_definition`(`alarm_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ADD CONSTRAINT `fk_automation_alarm_event_preceding_alarm_event_id` FOREIGN KEY (`preceding_alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_batch_execution_id` FOREIGN KEY (`batch_execution_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`batch_execution`(`batch_execution_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ADD CONSTRAINT `fk_automation_control_mode_event_preceding_control_mode_event_id` FOREIGN KEY (`preceding_control_mode_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_mode_event`(`control_mode_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ADD CONSTRAINT `fk_automation_device_config_snapshot_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ADD CONSTRAINT `fk_automation_device_config_snapshot_previous_device_config_snapshot_id` FOREIGN KEY (`previous_device_config_snapshot_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_config_snapshot`(`device_config_snapshot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ADD CONSTRAINT `fk_automation_firmware_update_device_config_snapshot_id` FOREIGN KEY (`device_config_snapshot_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_config_snapshot`(`device_config_snapshot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ADD CONSTRAINT `fk_automation_firmware_update_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ADD CONSTRAINT `fk_automation_firmware_update_rollback_firmware_update_id` FOREIGN KEY (`rollback_firmware_update_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`firmware_update`(`firmware_update_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ADD CONSTRAINT `fk_automation_scada_session_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ADD CONSTRAINT `fk_automation_scada_session_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ADD CONSTRAINT `fk_automation_scada_session_previous_scada_session_id` FOREIGN KEY (`previous_scada_session_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`scada_session`(`scada_session_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_process_parameter_id` FOREIGN KEY (`process_parameter_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`process_parameter`(`process_parameter_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_reversal_setpoint_change_id` FOREIGN KEY (`reversal_setpoint_change_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`setpoint_change`(`setpoint_change_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ADD CONSTRAINT `fk_automation_setpoint_change_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_batch_schedule_id` FOREIGN KEY (`batch_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`batch_schedule`(`batch_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_parent_batch_execution_id` FOREIGN KEY (`parent_batch_execution_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`batch_execution`(`batch_execution_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ADD CONSTRAINT `fk_automation_batch_execution_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ADD CONSTRAINT `fk_automation_recipe_master_recipe_id` FOREIGN KEY (`master_recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ADD CONSTRAINT `fk_automation_equipment_phase_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ADD CONSTRAINT `fk_automation_equipment_phase_plc_program_id` FOREIGN KEY (`plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ADD CONSTRAINT `fk_automation_equipment_phase_equipment_plc_program_id` FOREIGN KEY (`equipment_plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ADD CONSTRAINT `fk_automation_equipment_phase_parent_equipment_phase_id` FOREIGN KEY (`parent_equipment_phase_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`equipment_phase`(`equipment_phase_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ADD CONSTRAINT `fk_automation_equipment_phase_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ADD CONSTRAINT `fk_automation_opc_server_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`network_segment`(`network_segment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ADD CONSTRAINT `fk_automation_opc_server_redundant_opc_server_id` FOREIGN KEY (`redundant_opc_server_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`opc_server`(`opc_server_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ADD CONSTRAINT `fk_automation_historian_config_superseded_historian_config_id` FOREIGN KEY (`superseded_historian_config_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`historian_config`(`historian_config_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ADD CONSTRAINT `fk_automation_historian_config_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_plc_program_id` FOREIGN KEY (`plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ADD CONSTRAINT `fk_automation_automation_change_request_superseded_automation_change_request_id` FOREIGN KEY (`superseded_automation_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_change_request`(`automation_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ADD CONSTRAINT `fk_automation_device_connectivity_event_preceding_device_connectivity_event_id` FOREIGN KEY (`preceding_device_connectivity_event_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_connectivity_event`(`device_connectivity_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ADD CONSTRAINT `fk_automation_safety_function_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ADD CONSTRAINT `fk_automation_safety_function_parent_safety_function_id` FOREIGN KEY (`parent_safety_function_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`safety_function`(`safety_function_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_previous_proof_test_record_id` FOREIGN KEY (`previous_proof_test_record_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`proof_test_record`(`proof_test_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_proof_component_logic_solver_device_registry_id` FOREIGN KEY (`proof_component_logic_solver_device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_proof_device_registry_id` FOREIGN KEY (`proof_device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_safety_function_id` FOREIGN KEY (`safety_function_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`safety_function`(`safety_function_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ADD CONSTRAINT `fk_automation_proof_test_record_test_procedure_id` FOREIGN KEY (`test_procedure_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`test_procedure`(`test_procedure_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ADD CONSTRAINT `fk_automation_automation_project_parent_automation_project_id` FOREIGN KEY (`parent_automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_plc_program_id` FOREIGN KEY (`plc_program_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`plc_program`(`plc_program_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_remapped_io_mapping_id` FOREIGN KEY (`remapped_io_mapping_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`io_mapping`(`io_mapping_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ADD CONSTRAINT `fk_automation_io_mapping_tag_definition_id` FOREIGN KEY (`tag_definition_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`tag_definition`(`tag_definition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_automation_project_id` FOREIGN KEY (`automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_retest_fat_sat_record_id` FOREIGN KEY (`retest_fat_sat_record_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`fat_sat_record`(`fat_sat_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ADD CONSTRAINT `fk_automation_fat_sat_record_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ADD CONSTRAINT `fk_automation_batch_schedule_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ADD CONSTRAINT `fk_automation_batch_schedule_parent_batch_schedule_id` FOREIGN KEY (`parent_batch_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`batch_schedule`(`batch_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ADD CONSTRAINT `fk_automation_batch_schedule_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ADD CONSTRAINT `fk_automation_test_case_automation_project_id` FOREIGN KEY (`automation_project_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_project`(`automation_project_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ADD CONSTRAINT `fk_automation_test_case_automation_script_id` FOREIGN KEY (`automation_script_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_script`(`automation_script_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ADD CONSTRAINT `fk_automation_test_case_parent_test_case_id` FOREIGN KEY (`parent_test_case_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ADD CONSTRAINT `fk_automation_test_case_device_registry_id` FOREIGN KEY (`device_registry_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`device_registry`(`device_registry_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ADD CONSTRAINT `fk_automation_test_procedure_parent_test_procedure_id` FOREIGN KEY (`parent_test_procedure_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`test_procedure`(`test_procedure_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ADD CONSTRAINT `fk_automation_test_procedure_test_case_id` FOREIGN KEY (`test_case_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`test_case`(`test_case_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ADD CONSTRAINT `fk_automation_automation_script_called_by_automation_script_id` FOREIGN KEY (`called_by_automation_script_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`automation_script`(`automation_script_id`);
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ADD CONSTRAINT `fk_automation_automation_script_control_system_id` FOREIGN KEY (`control_system_id`) REFERENCES `vibe_manufacturing_v1`.`automation`.`control_system`(`control_system_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`automation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`automation` SET TAGS ('dbx_domain' = 'automation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `parent_device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Device Registry Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `parent_device_registry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (Plant ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (Line ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WC ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol (Protocol)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'OPC-UA|Modbus|PROFINET|EtherNet/IP|BACnet|MQTT');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `current_rating_a` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (A)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_description` SET TAGS ('dbx_business_glossary_term' = 'Device Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Code (DC)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (Status)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|faulted|decommissioned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'PLC|HMI|RTU|DCS|EdgeGateway|Sensor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version (HW)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (Lifecycle Status)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|pending|decommissioned|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `mac_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status (Maint Status)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'up_to_date|overdue|scheduled|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (Model No.)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `device_registry_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `network_address` SET TAGS ('dbx_business_glossary_term' = 'Network Address (Network Addr.)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `network_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `network_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `network_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `network_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `voltage_rating_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating (V)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_registry` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `parent_control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Control System Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `parent_control_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'System Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `alarm_capacity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'OPC-UA|Modbus|PROFIBUS|EtherNet/IP');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `control_program_version` SET TAGS ('dbx_business_glossary_term' = 'Control Program Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `control_system_description` SET TAGS ('dbx_business_glossary_term' = 'Control System Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `device_count` SET TAGS ('dbx_business_glossary_term' = 'Device Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `engineering_workstation` SET TAGS ('dbx_business_glossary_term' = 'Engineering Workstation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical System Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `last_config_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Backup Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'design|installed|operational|maintenance|decommissioned|retired');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `control_system_name` SET TAGS ('dbx_business_glossary_term' = 'Control System Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `control_system_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Control System Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `plant_area` SET TAGS ('dbx_business_glossary_term' = 'Plant Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level (SIL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL0|SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'Confidential|Restricted|Public');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'Control System Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `system_type` SET TAGS ('dbx_business_glossary_term' = 'Control System Type (DCS, SCADA, PLC, SIS, ESD)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `system_type` SET TAGS ('dbx_value_regex' = 'DCS|SCADA|PLC|SIS|ESD');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `tag_count` SET TAGS ('dbx_business_glossary_term' = 'Tag Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_system` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Uptime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'PLC Program Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `parent_plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Plc Program Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `parent_plc_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `primary_plc_device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Target Device Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Configuration Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `target_device_device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Target Device Device Registry Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `target_device_device_registry_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Program Author');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Program Checksum');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA1|SHA256');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `compatible_hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Compatible Hardware Model');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Programming Language (IEC 61131‑3)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'LD|FBD|ST|SFC|IL');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `plc_program_status` SET TAGS ('dbx_value_regex' = 'draft|tested|released|archived');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `program_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Program Size (Bytes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety‑Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `source_control_branch` SET TAGS ('dbx_business_glossary_term' = 'Source Control Branch');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `source_control_commit_hash` SET TAGS ('dbx_business_glossary_term' = 'Source Control Commit Hash');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `supported_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Supported Firmware Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `validation_passed` SET TAGS ('dbx_business_glossary_term' = 'Validation Passed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`plc_program` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Definition ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `control_system_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `parent_tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tag Definition Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `parent_tag_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'Read|Write|ReadWrite');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `alarm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alarm Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'Boolean|Int|Float|String|Double|Byte');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `deadband` SET TAGS ('dbx_business_glossary_term' = 'Deadband');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Tag Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `device_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `device_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `eu_range_high` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit Range High');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `eu_range_low` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit Range Low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `is_historian_enabled` SET TAGS ('dbx_business_glossary_term' = 'Historian Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `raw_range_high` SET TAGS ('dbx_business_glossary_term' = 'Raw Value Range High');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `raw_range_low` SET TAGS ('dbx_business_glossary_term' = 'Raw Value Range Low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `scaling_factor` SET TAGS ('dbx_business_glossary_term' = 'Scaling Factor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `scan_rate_ms` SET TAGS ('dbx_business_glossary_term' = 'Scan Rate (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `tag_path` SET TAGS ('dbx_business_glossary_term' = 'Tag Path (OPC‑UA Node ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`tag_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Edge Gateway Identifier (EDGE_GATEWAY_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `upstream_edge_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Edge Gateway Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `upstream_edge_gateway_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `connected_device_count` SET TAGS ('dbx_business_glossary_term' = 'Connected Device Count (DEV_CNT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `cpu_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'CPU Utilization (CPU_UTIL_PCT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `data_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Data Throughput (THROUGHPUT_MBPS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_gateway_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_gateway_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_group` SET TAGS ('dbx_business_glossary_term' = 'Edge Group (GROUP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_last_config_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Config Change Timestamp (CFG_CHANGE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_os_license_key` SET TAGS ('dbx_business_glossary_term' = 'Edge OS License Key (OS_LICENSE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_os_license_key` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_os_license_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_os_vendor` SET TAGS ('dbx_business_glossary_term' = 'Edge OS Vendor (OS_VENDOR)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_os_version` SET TAGS ('dbx_business_glossary_term' = 'Edge OS Version (OS_VER)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_processing_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Edge Processing Capabilities (PROC_CAP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_processing_capabilities` SET TAGS ('dbx_value_regex' = 'local_ml|protocol_translation|data_buffering|edge_storage');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_role` SET TAGS ('dbx_business_glossary_term' = 'Edge Role (ROLE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_role` SET TAGS ('dbx_value_regex' = 'data_aggregator|protocol_translator|edge_compute');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_security_status` SET TAGS ('dbx_business_glossary_term' = 'Edge Security Status (SEC_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_security_status` SET TAGS ('dbx_value_regex' = 'secure|vulnerable|compromised|unknown');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason (STATUS_REASON)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `edge_zone` SET TAGS ('dbx_business_glossary_term' = 'Edge Zone (ZONE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `gateway_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_business_glossary_term' = 'Gateway Type (GW_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_value_regex' = 'edge|gateway|aggregator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model (HW_MODEL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date (INST_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `it_protocol` SET TAGS ('dbx_business_glossary_term' = 'IT‑Side Protocol (IT_PROTO)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `it_protocol` SET TAGS ('dbx_value_regex' = 'MQTT|HTTPS|REST|AMQP');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `last_firmware_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Timestamp (FW_UPDATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `last_heartbeat_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Heartbeat Timestamp (HEARTBEAT_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `mac_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window (MAINT_WIN)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `memory_usage_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Usage (MEM_MB)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `network_bandwidth_limit_mbps` SET TAGS ('dbx_business_glossary_term' = 'Network Bandwidth Limit (NET_BW_LIMIT_MBPS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ot_protocol` SET TAGS ('dbx_business_glossary_term' = 'OT‑Side Protocol (OT_PROTO)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `ot_protocol` SET TAGS ('dbx_value_regex' = 'OPC-UA|Modbus|PROFINET|EtherNetIP');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type (POWER_SUPPLY)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'AC|DC|PoE');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `processing_capacity_ops` SET TAGS ('dbx_business_glossary_term' = 'Processing Capacity (PROC_CAP_OPS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `rack_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Position (RACK_POS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification (SEC_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `security_certification` SET TAGS ('dbx_value_regex' = 'ISO27001|IEC62443|NIST800-53');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `software_modules` SET TAGS ('dbx_business_glossary_term' = 'Software Modules (SW_MODULES)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `storage_capacity_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (STOR_GB)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `supports_local_ml` SET TAGS ('dbx_business_glossary_term' = 'Local ML Support (LOCAL_ML)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (TEMP_C)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`edge_gateway` ALTER COLUMN `uptime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Uptime (UPTIME_SEC)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `derived_from_process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Derived From Process Parameter Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `derived_from_process_parameter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Device Address');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `alarm_high` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `alarm_high_high` SET TAGS ('dbx_business_glossary_term' = 'High‑High Alarm Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `alarm_low` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `alarm_low_low` SET TAGS ('dbx_business_glossary_term' = 'Low‑Low Alarm Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `control_system` SET TAGS ('dbx_business_glossary_term' = 'Control System');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Data Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'float|int|bool|string');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `offset` SET TAGS ('dbx_business_glossary_term' = 'Offset');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'set_point|limit|alarm_threshold|pid_constant');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `process_parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `scaling_factor` SET TAGS ('dbx_business_glossary_term' = 'Scaling Factor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `tag_definition` SET TAGS ('dbx_business_glossary_term' = 'OPC‑UA Tag Definition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`process_parameter` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Definition ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `parent_alarm_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Alarm Definition Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `parent_alarm_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_category` SET TAGS ('dbx_business_glossary_term' = 'Alarm Category');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type (Process, Equipment, Safety, System)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'process|equipment|safety|system');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `auto_reset` SET TAGS ('dbx_business_glossary_term' = 'Auto Reset Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `class` SET TAGS ('dbx_business_glossary_term' = 'ISA‑18.2 Alarm Class');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `class` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard (e.g., ISA‑18.2)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `deadband` SET TAGS ('dbx_business_glossary_term' = 'Alarm Deadband Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `deadband_unit` SET TAGS ('dbx_business_glossary_term' = 'Deadband Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Alarm Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `escalation_policy` SET TAGS ('dbx_business_glossary_term' = 'Escalation Policy');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Alarm Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `alarm_definition_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|popup|none');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `off_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'Off‑Delay Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `on_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'On‑Delay Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `operator_group` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operator Group');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority (Critical, High, Medium, Low)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `rationalization_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Rationalization Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `related_equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Related Equipment Tag Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `reset_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'Reset Delay Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `setpoint_unit` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Alarm Setpoint Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `shelving_allowed` SET TAGS ('dbx_business_glossary_term' = 'Shelving Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `suppression_rules` SET TAGS ('dbx_business_glossary_term' = 'Alarm Suppression Rules');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Alarm Trigger Condition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_value_regex' = 'high|low|deviation|rate_of_change');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_definition` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Alarm Definition Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `parent_network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Network Segment Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `parent_network_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `addressing_scheme` SET TAGS ('dbx_business_glossary_term' = 'Addressing Scheme');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `addressing_scheme` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `addressing_scheme` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `allowed_protocols` SET TAGS ('dbx_business_glossary_term' = 'Allowed Protocols');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `backup_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Backup Connectivity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `connected_device_count` SET TAGS ('dbx_business_glossary_term' = 'Connected Device Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `firewall_reference` SET TAGS ('dbx_business_glossary_term' = 'Firewall Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `ip_subnet` SET TAGS ('dbx_business_glossary_term' = 'IP Subnet (CIDR)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `monitoring_tool` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Tool');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `network_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `owner_contact` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Contact');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level (IEC 62443)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'SL-1|SL-2|SL-3|SL-4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `topology` SET TAGS ('dbx_business_glossary_term' = 'Network Topology');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `topology` SET TAGS ('dbx_value_regex' = 'ring|star|linear|mesh|bus');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'VLAN Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type (ISA/IEC 62443 Security Zone)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`network_segment` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'level_0_field|level_1_control|level_2_supervisory|level_3_operations|dmz');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Definition ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `preceding_alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Alarm Event Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `preceding_alarm_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_category` SET TAGS ('dbx_business_glossary_term' = 'Alarm Category');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_category` SET TAGS ('dbx_value_regex' = 'process|equipment|environment|safety|quality');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Alarm Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_message` SET TAGS ('dbx_business_glossary_term' = 'Alarm Message');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_source_system` SET TAGS ('dbx_business_glossary_term' = 'Alarm Source System');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_source_system` SET TAGS ('dbx_value_regex' = 'SCADA|DCS|PLC|HMI');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_state` SET TAGS ('dbx_business_glossary_term' = 'Alarm State');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `alarm_state` SET TAGS ('dbx_value_regex' = 'active|acknowledged|shelved|suppressed|returned_to_normal|cleared');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `is_nuisance` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Alarm Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `operator_comment` SET TAGS ('dbx_business_glossary_term' = 'Operator Comment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `process_value` SET TAGS ('dbx_business_glossary_term' = 'Process Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`alarm_event` ALTER COLUMN `shelve_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Shelve Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `control_mode_event_id` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Event Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `batch_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Controller Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `preceding_control_mode_event_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Control Mode Event Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `preceding_control_mode_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in New Mode (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Event Severity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'info|warning|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Event Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'recorded|processed|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'mode_change|override|reset');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `new_mode` SET TAGS ('dbx_business_glossary_term' = 'New Control Mode');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `new_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|cascade|remote');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `previous_mode` SET TAGS ('dbx_business_glossary_term' = 'Previous Control Mode');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `previous_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|cascade|remote');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Change Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|emergency|maintenance|test');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Control Mode Change Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`control_mode_event` ALTER COLUMN `tag_reference` SET TAGS ('dbx_business_glossary_term' = 'OPC‑UA Tag Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `device_config_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Device Configuration Snapshot ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `previous_device_config_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Device Config Snapshot Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `previous_device_config_snapshot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `project_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `backup_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Backup Job ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'sha256|md5|sha1');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `compression_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Compression Algorithm');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `compression_algorithm` SET TAGS ('dbx_value_regex' = 'gzip|zip');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `config_file_path` SET TAGS ('dbx_business_glossary_term' = 'Configuration File Path');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `configuration_checksum` SET TAGS ('dbx_business_glossary_term' = 'Configuration Checksum');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `configuration_format` SET TAGS ('dbx_business_glossary_term' = 'Configuration Format');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'plc|hmi|drive|controller');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `is_compressed` SET TAGS ('dbx_business_glossary_term' = 'Is Compressed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_description` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'full|delta|scheduled|pre_change|post_change');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `triggered_by` SET TAGS ('dbx_business_glossary_term' = 'Triggered By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `triggered_by` SET TAGS ('dbx_value_regex' = 'scheduled|manual|change_event');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'verified|unverified');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_config_snapshot` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `firmware_update_id` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_config_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Update Backup Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `project_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `rollback_firmware_update_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback Firmware Update Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `rollback_firmware_update_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Update Completion Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `compliance_patch_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Patch Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'controller|gateway|sensor|actuator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `firmware_version_after` SET TAGS ('dbx_business_glossary_term' = 'New Firmware Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `firmware_version_before` SET TAGS ('dbx_business_glossary_term' = 'Previous Firmware Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `is_critical_update` SET TAGS ('dbx_business_glossary_term' = 'Critical Update Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Update Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `post_update_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post‑Update Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `post_update_validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Update Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Update Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_method` SET TAGS ('dbx_business_glossary_term' = 'Update Method');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_method` SET TAGS ('dbx_value_regex' = 'remote_push|manual_usb|ota');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Update Package Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Update Reference Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Update Package Size (MB)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_status` SET TAGS ('dbx_business_glossary_term' = 'Update Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `update_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|rolled_back');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`firmware_update` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `scada_session_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Session ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `previous_scada_session_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Scada Session Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `previous_scada_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `alarm_ack_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledgement Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `control_action_count` SET TAGS ('dbx_business_glossary_term' = 'Control Action Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `login_method` SET TAGS ('dbx_business_glossary_term' = 'Login Method');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `login_method` SET TAGS ('dbx_value_regex' = 'local|domain|biometric');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Login Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `logout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Logout Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `plant_area` SET TAGS ('dbx_business_glossary_term' = 'Plant Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_identifier` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_source` SET TAGS ('dbx_business_glossary_term' = 'Session Source');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_source` SET TAGS ('dbx_value_regex' = 'scada_workstation|hmi_panel|mobile_terminal');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'active|closed|terminated|error');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'operator|maintenance|automated');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `setpoint_change_count` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Change Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'SCADA Software Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'normal_logout|timeout|forced_logout|error');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `user_role` SET TAGS ('dbx_business_glossary_term' = 'User Role');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `user_role` SET TAGS ('dbx_value_regex' = 'operator|engineer|supervisor|admin');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`scada_session` ALTER COLUMN `workstation_reference` SET TAGS ('dbx_business_glossary_term' = 'Workstation ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `setpoint_change_id` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Change Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `reversal_setpoint_change_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Setpoint Change Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `reversal_setpoint_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'OPC-UA Tag Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'maintenance|quality|optimization|emergency|operator_request|system_auto');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Execution Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'completed|failed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Change Comment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `initiated_by_type` SET TAGS ('dbx_business_glossary_term' = 'Initiator Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `initiated_by_type` SET TAGS ('dbx_value_regex' = 'operator|system');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `new_setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'New Setpoint Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `previous_setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Setpoint Value');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`setpoint_change` ALTER COLUMN `within_normal_limits` SET TAGS ('dbx_business_glossary_term' = 'Within Normal Operating Limits Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` SET TAGS ('dbx_subdomain' = 'batch_processing');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Execution Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Schedule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `parent_batch_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Batch Execution Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `parent_batch_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Approval User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_capa_action_count` SET TAGS ('dbx_business_glossary_term' = 'Batch CAPA Action Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch CO2 Emissions (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Batch Cycle Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_value_regex' = 'released|rejected|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch End Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_end_reason` SET TAGS ('dbx_value_regex' = 'normal|abort|error|manual_stop');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Batch Energy Consumption (kWh)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_execution_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Execution Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_execution_status` SET TAGS ('dbx_value_regex' = 'created|running|paused|completed|aborted');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_priority` SET TAGS ('dbx_business_glossary_term' = 'Batch Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Review Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Batch Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_scrap_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Scrap Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_start_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch Start Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_start_reason` SET TAGS ('dbx_value_regex' = 'scheduled|manual|auto|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'standard|rework|test|pilot');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_version` SET TAGS ('dbx_business_glossary_term' = 'Batch Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_water_usage_liters` SET TAGS ('dbx_business_glossary_term' = 'Batch Water Usage (Liters)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `batch_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Batch Yield Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Batch Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `equipment_train_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Train Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Batch Exception Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `overall_equipment_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `plant_area` SET TAGS ('dbx_business_glossary_term' = 'Plant Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `quality_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Passed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|rework');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `target_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_execution` ALTER COLUMN `yield_uom` SET TAGS ('dbx_business_glossary_term' = 'Yield Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `master_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Master Recipe Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `master_recipe_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `approval_user` SET TAGS ('dbx_business_glossary_term' = 'Approval User');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (units)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|units|liters');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `changeover_time` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ISO9001|ISO14001|ISO45001|IEC62443');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `critical_parameter_setpoints` SET TAGS ('dbx_business_glossary_term' = 'Critical Parameter Setpoints');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `max_yield` SET TAGS ('dbx_business_glossary_term' = 'Maximum Yield Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `oee_target` SET TAGS ('dbx_business_glossary_term' = 'OEE Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `phase_sequence` SET TAGS ('dbx_business_glossary_term' = 'Phase Sequence Definition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `process_time_unit` SET TAGS ('dbx_business_glossary_term' = 'Process Time Unit');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `process_time_unit` SET TAGS ('dbx_value_regex' = 'seconds|minutes|hours');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_type` SET TAGS ('dbx_business_glossary_term' = 'Recipe Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `recipe_type` SET TAGS ('dbx_value_regex' = 'master|control|site|general');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `total_process_time` SET TAGS ('dbx_business_glossary_term' = 'Total Process Time (minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^vd+(.d+)*$');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `version_history` SET TAGS ('dbx_business_glossary_term' = 'Version History');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `yield_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Yield Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`recipe` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` SET TAGS ('dbx_subdomain' = 'control_programming');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_phase_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Phase Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Abort Logic Reference Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Logic Reference Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `parent_equipment_phase_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Phase Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `parent_equipment_phase_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `abortable` SET TAGS ('dbx_business_glossary_term' = 'Abortable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `average_execution_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Execution Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_phase_description` SET TAGS ('dbx_business_glossary_term' = 'Phase Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_class_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `equipment_phase_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `input_parameters` SET TAGS ('dbx_business_glossary_term' = 'Phase Input Parameters');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `is_default_phase` SET TAGS ('dbx_business_glossary_term' = 'Default Phase Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'defined|validated|released|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `max_concurrent_instances` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Instances');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `normal_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Normal Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `operator_role` SET TAGS ('dbx_business_glossary_term' = 'Operator Role');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `operator_role` SET TAGS ('dbx_value_regex' = 'operator|engineer|supervisor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `output_parameters` SET TAGS ('dbx_business_glossary_term' = 'Phase Output Parameters');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Phase Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Phase Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Phase Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `phase_type` SET TAGS ('dbx_value_regex' = 'charge|heat|mix|transfer|cool|drain');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `pressure_setpoint_bar` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (bar)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `required_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Level');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `required_skill_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety‑Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `timeout_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`equipment_phase` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Phase Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `opc_server_id` SET TAGS ('dbx_business_glossary_term' = 'OPC Server Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `redundant_opc_server_id` SET TAGS ('dbx_business_glossary_term' = 'Redundant Opc Server Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `redundant_opc_server_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `alarm_capacity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `authentication_mode` SET TAGS ('dbx_business_glossary_term' = 'Authentication Mode');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `authentication_mode` SET TAGS ('dbx_value_regex' = 'anonymous|username|certificate');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `certificate_thumbprint` SET TAGS ('dbx_business_glossary_term' = 'Certificate Thumbprint');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `connected_client_count` SET TAGS ('dbx_business_glossary_term' = 'Connected Client Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `opc_server_description` SET TAGS ('dbx_business_glossary_term' = 'Server Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'OPC Endpoint URL');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `engineering_workstation` SET TAGS ('dbx_business_glossary_term' = 'Engineering Workstation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `host_machine` SET TAGS ('dbx_business_glossary_term' = 'Host Machine Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `last_config_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Backup Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `last_connectivity_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Connectivity Check Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `opc_server_name` SET TAGS ('dbx_business_glossary_term' = 'OPC Server Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `opc_server_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `opc_server_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `plant_area` SET TAGS ('dbx_business_glossary_term' = 'Plant Area');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `polling_interval_ms` SET TAGS ('dbx_business_glossary_term' = 'Polling Interval (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Server Product Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `product_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `product_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level (SIL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `security_policy` SET TAGS ('dbx_business_glossary_term' = 'Security Policy');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `security_policy` SET TAGS ('dbx_value_regex' = 'None|Basic128Rsa15|Basic256Sha256');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_code` SET TAGS ('dbx_business_glossary_term' = 'OPC Server Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_status` SET TAGS ('dbx_business_glossary_term' = 'Server Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_status` SET TAGS ('dbx_value_regex' = 'running|stopped|error|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_type` SET TAGS ('dbx_business_glossary_term' = 'OPC Server Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `server_type` SET TAGS ('dbx_value_regex' = 'OPC-UA|OPC-DA|OPC-HDA|OPC-AE');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `subscription_count` SET TAGS ('dbx_business_glossary_term' = 'Subscription Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `tag_count` SET TAGS ('dbx_business_glossary_term' = 'Served Tag Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Uptime (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`opc_server` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Server Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_id` SET TAGS ('dbx_business_glossary_term' = 'Historian Configuration ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `superseded_historian_config_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Historian Config Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `superseded_historian_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Definition ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `alarm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alarm Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `archive_group` SET TAGS ('dbx_business_glossary_term' = 'Archive Group Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `archive_group_description` SET TAGS ('dbx_business_glossary_term' = 'Archive Group Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `collection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Collection Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `collection_interval_ms` SET TAGS ('dbx_business_glossary_term' = 'Collection Interval (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `compression_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Compression Algorithm');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `compression_algorithm` SET TAGS ('dbx_value_regex' = 'gzip|lz4|none');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `compression_deviation` SET TAGS ('dbx_business_glossary_term' = 'Compression Deviation Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `compression_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Compression Timeout (seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_description` SET TAGS ('dbx_business_glossary_term' = 'Historian Configuration Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `exception_deviation` SET TAGS ('dbx_business_glossary_term' = 'Exception Deviation Threshold');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `instance_name` SET TAGS ('dbx_business_glossary_term' = 'Historian Instance Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `instance_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `instance_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `last_config_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|decommissioned|planned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `max_data_rate_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Maximum Data Rate per Second');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `max_tag_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tag Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_name` SET TAGS ('dbx_business_glossary_term' = 'Historian Configuration Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `historian_config_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Configuration Owner');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Historian Platform');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'OSIsoft_PI|AspenTech_IP21|Wonderware|InfluxDB');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (days)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = 'rolling|fixed|archival');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `scaling_factor` SET TAGS ('dbx_business_glossary_term' = 'Scaling Factor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `storage_resolution_ms` SET TAGS ('dbx_business_glossary_term' = 'Storage Resolution (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`historian_config` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` SET TAGS ('dbx_subdomain' = 'safety_assurance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `automation_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Change Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Affected PLC Program Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Control System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Device Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `primary_automation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `primary_automation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `primary_automation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `superseded_automation_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Automation Change Request Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `superseded_automation_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `tertiary_automation_change_review_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Review By Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `tertiary_automation_change_review_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `tertiary_automation_change_review_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `actual_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `actual_implementation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `automation_change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `automation_change_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|in_progress|closed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Audit Log Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Effective Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_origin` SET TAGS ('dbx_business_glossary_term' = 'Change Origin');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_origin` SET TAGS ('dbx_value_regex' = 'internal|external|vendor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number (CRN)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_review_status` SET TAGS ('dbx_business_glossary_term' = 'Change Review Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|closed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Review Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'program_change|configuration_change|hardware_change|network_change|setpoint_change');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'isa_84|iec_62443|none');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `is_emergency_change` SET TAGS ('dbx_business_glossary_term' = 'Emergency Change Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `post_change_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post‑Change Validation Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `post_change_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|passed|failed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `pre_change_backup_reference` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Change Backup Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `production_impact` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `production_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `rollback_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `safety_impact` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `safety_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_change_request` ALTER COLUMN `validation_test_results` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Results');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_connectivity_event_id` SET TAGS ('dbx_business_glossary_term' = 'Device Connectivity Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Alarm Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `preceding_device_connectivity_event_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Device Connectivity Event Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `preceding_device_connectivity_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `auto_recovery_attempted` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Recovery Attempted');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'OPC-UA|Modbus|Ethernet/IP|Profinet|Ethernet');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'heartbeat|opc_status|network_probe');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_connectivity_event_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_connectivity_event_status` SET TAGS ('dbx_value_regex' = 'processed|pending|failed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_model` SET TAGS ('dbx_business_glossary_term' = 'Device Model');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `event_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'online|offline|degraded|timeout|error');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `event_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `last_successful_comm_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Communication Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `network_address` SET TAGS ('dbx_business_glossary_term' = 'Network Address (IP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `network_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `network_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `network_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `network_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New Connectivity State');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `new_state` SET TAGS ('dbx_value_regex' = 'online|offline|degraded|timeout|error');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_business_glossary_term' = 'Previous Connectivity State');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_value_regex' = 'online|offline|degraded|timeout|error');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`device_connectivity_event` ALTER COLUMN `recovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recovery Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` SET TAGS ('dbx_subdomain' = 'safety_assurance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Function Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Instrumented System Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `parent_safety_function_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Safety Function Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `parent_safety_function_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `process_hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Process Hazard Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `associated_sensor_tags` SET TAGS ('dbx_business_glossary_term' = 'Associated Sensor Tags');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `bypass_allowed` SET TAGS ('dbx_business_glossary_term' = 'Bypass Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Function Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `final_element_tags` SET TAGS ('dbx_business_glossary_term' = 'Final Element Tags');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `initiating_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Initiating Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `last_proof_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proof Test Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `logic_solver_reference` SET TAGS ('dbx_business_glossary_term' = 'Logic Solver Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `mean_time_to_failure_on_demand` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Failure on Demand (PFDavg)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Function Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `process_demand_rate` SET TAGS ('dbx_business_glossary_term' = 'Process Demand Rate (per hour)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `proof_test_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Interval (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `risk_reduction_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Reduction Factor (RRF)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safe_state_description` SET TAGS ('dbx_business_glossary_term' = 'Safe State Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Function Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_function_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level (SIL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `sif_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Instrumented Function (SIF) Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`safety_function` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'LOPA|FaultTree|FMEA|Other');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` SET TAGS ('dbx_subdomain' = 'safety_assurance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_test_record_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `previous_proof_test_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Proof Test Record Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `previous_proof_test_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Component Final Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_component_logic_solver_device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Component Logic Solver ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Component Sensor ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_tested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_tested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `safety_function_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Instrumented Function ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Test Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `approval_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Signature ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `as_found_condition` SET TAGS ('dbx_business_glossary_term' = 'As-Found Condition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `as_left_condition` SET TAGS ('dbx_business_glossary_term' = 'As-Left Condition');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `detected_failures` SET TAGS ('dbx_business_glossary_term' = 'Detected Failures');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Proof Test Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_test_record_status` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `proof_test_record_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `repair_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Repair Actions Taken');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level (SIL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Duration (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof Test End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'normal|abnormal|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_failed_criteria` SET TAGS ('dbx_business_glossary_term' = 'Test Failed Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity (%)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_is_critical` SET TAGS ('dbx_business_glossary_term' = 'Test Is Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_passed_criteria` SET TAGS ('dbx_business_glossary_term' = 'Test Passed Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Test Pressure (bar)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Result');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial_pass');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_result_code` SET TAGS ('dbx_business_glossary_term' = 'Test Result Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Result Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Review Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Test Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_source_system` SET TAGS ('dbx_business_glossary_term' = 'Test Source System');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Proof Test Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'full|partial_stroke|partial');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`proof_test_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` SET TAGS ('dbx_subdomain' = 'engineering_validation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Project Identifier (AUTOMATION_PROJECT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier (CONTROL_SYSTEM_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `parent_automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Automation Project Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `parent_automation_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `primary_automation_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Engineer Identifier (AUTOMATION_ENGINEER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `primary_automation_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `primary_automation_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `tertiary_automation_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (APPROVED_BY_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `tertiary_automation_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `tertiary_automation_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (ACTUAL_DURATION_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACTUAL_END_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount (ACTUAL_SPEND_AMOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date (ACTUAL_START_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status (PROJECT_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_status` SET TAGS ('dbx_value_regex' = 'concept|design|installation|commissioning|handed_over|closed');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (PROJECT_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_type` SET TAGS ('dbx_value_regex' = 'greenfield|brownfield|migration|expansion|cybersecurity_hardening');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BUDGET_AMOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency (BUDGET_CURRENCY)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RECORD_CREATION_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description (PROJECT_DESCRIPTION)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOCUMENTATION_URL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (ESTIMATED_DURATION_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Project Flag (CRITICAL_PROJECT)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `is_cybersecurity_hardening` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Hardening Flag (CYBERSECURITY_HARDENING)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name (PROJECT_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `automation_project_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (PLANNED_END_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date (PLANNED_START_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority (PROJECT_PRIORITY)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PROJECT_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Integrity Level (SIL)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `safety_integrity_level` SET TAGS ('dbx_value_regex' = 'SIL1|SIL2|SIL3|SIL4');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Hours (SLA_ACTUAL_HOURS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours (SLA_TARGET_HOURS)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `stakeholder_group` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Group (STAKEHOLDER_GROUP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `stakeholder_group` SET TAGS ('dbx_value_regex' = 'operations|maintenance|engineering|executive|safety');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RECORD_UPDATE_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` SET TAGS ('dbx_subdomain' = 'device_infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'I/O Mapping Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `control_system_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'I/O Module Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `project_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `remapped_io_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Remapped Io Mapping Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `remapped_io_mapping_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read|write|read_write');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'PLC/DCS Address');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `alarm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Alarm Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `cable_number` SET TAGS ('dbx_business_glossary_term' = 'Cable Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'I/O Channel Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'I/O Channel Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `channel_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `channel_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `commissioning_status` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `commissioning_status` SET TAGS ('dbx_value_regex' = 'commissioned|not_commissioned|pending');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `deadband` SET TAGS ('dbx_business_glossary_term' = 'Deadband');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_mapping_description` SET TAGS ('dbx_business_glossary_term' = 'I/O Mapping Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `device_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `device_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `field_instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Field Instrument Tag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'I/O Mapping Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_mapping_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|planned');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_module_type` SET TAGS ('dbx_business_glossary_term' = 'I/O Module Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_module_type` SET TAGS ('dbx_value_regex' = 'input_module|output_module|mixed_module');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_type` SET TAGS ('dbx_business_glossary_term' = 'I/O Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `io_type` SET TAGS ('dbx_value_regex' = 'digital_input|digital_output|analog_input|analog_output|pulse_input');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `is_historian_enabled` SET TAGS ('dbx_business_glossary_term' = 'Historian Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `junction_box` SET TAGS ('dbx_business_glossary_term' = 'Junction Box Reference');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `module_slot` SET TAGS ('dbx_business_glossary_term' = 'Module Slot');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'I/O Mapping Notes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `raw_range_high` SET TAGS ('dbx_business_glossary_term' = 'Raw Range High');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `raw_range_low` SET TAGS ('dbx_business_glossary_term' = 'Raw Range Low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `scaling_factor` SET TAGS ('dbx_business_glossary_term' = 'Scaling Factor');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `scaling_high` SET TAGS ('dbx_business_glossary_term' = 'Scaling High');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `scaling_low` SET TAGS ('dbx_business_glossary_term' = 'Scaling Low');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `scan_rate_ms` SET TAGS ('dbx_business_glossary_term' = 'Scan Rate (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `signal_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `signal_type` SET TAGS ('dbx_value_regex' = '4-20mA|0-10V|24VDC|thermocouple|RTD|HART');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `tag_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'I/O Mapping Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`io_mapping` ALTER COLUMN `wiring_terminal` SET TAGS ('dbx_business_glossary_term' = 'Wiring Terminal');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` SET TAGS ('dbx_subdomain' = 'safety_assurance');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `fat_sat_record_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Acceptance Test / Site Acceptance Test Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tested By ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `project_document_id` SET TAGS ('dbx_business_glossary_term' = 'Test Protocol Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `retest_fat_sat_record_id` SET TAGS ('dbx_business_glossary_term' = 'Retest Fat Sat Record Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `retest_fat_sat_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `tertiary_fat_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `tertiary_fat_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `tertiary_fat_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case ID');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `actual_observed_result` SET TAGS ('dbx_business_glossary_term' = 'Actual Observed Result');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `expected_result` SET TAGS ('dbx_business_glossary_term' = 'Expected Result');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `fat_sat_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `fat_sat_record_status` SET TAGS ('dbx_value_regex' = 'OPEN|IN_REVIEW|CLOSED|REJECTED');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Test Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `retest_required` SET TAGS ('dbx_business_glossary_term' = 'Retest Required');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_case_description` SET TAGS ('dbx_business_glossary_term' = 'Test Case Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|CONDITIONAL_PASS|NOT_TESTED');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'FAT|SAT|IFAT|LOOP_CHECK|FUNCTIONAL_TEST');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`fat_sat_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` SET TAGS ('dbx_subdomain' = 'batch_processing');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `batch_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Schedule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `parent_batch_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Batch Schedule Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `parent_batch_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `audit_comment` SET TAGS ('dbx_business_glossary_term' = 'Audit Comment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `batch_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `batch_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Frequency Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `max_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Max Runtime Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `min_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Min Runtime Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Email');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_owner` SET TAGS ('dbx_business_glossary_term' = 'Schedule Owner');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `batch_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percent');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`batch_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` SET TAGS ('dbx_subdomain' = 'engineering_validation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `automation_script_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Script Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `parent_test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Test Case Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `parent_test_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Related Device Device Registry Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Seconds');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `execution_result` SET TAGS ('dbx_business_glossary_term' = 'Execution Result');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `expected_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Expected Duration Seconds');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `last_executed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Executed By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `steps_count` SET TAGS ('dbx_business_glossary_term' = 'Steps Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_case_type` SET TAGS ('dbx_business_glossary_term' = 'Test Case Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `test_data_set` SET TAGS ('dbx_business_glossary_term' = 'Test Data Set');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_case` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` SET TAGS ('dbx_subdomain' = 'engineering_validation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `parent_test_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Test Procedure Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `parent_test_procedure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `procedure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `procedure_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `test_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Seconds');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`test_procedure` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` SET TAGS ('dbx_subdomain' = 'engineering_validation');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Script Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `called_by_automation_script_id` SET TAGS ('dbx_business_glossary_term' = 'Called By Automation Script Id');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `called_by_automation_script_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `author_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `author_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `average_execution_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Execution Time Ms');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Sha256');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Url');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Execution Count');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Execution Mode');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `input_parameters_schema` SET TAGS ('dbx_business_glossary_term' = 'Input Parameters Schema');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `is_thread_safe` SET TAGS ('dbx_business_glossary_term' = 'Is Thread Safe');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `last_error_message` SET TAGS ('dbx_business_glossary_term' = 'Last Error Message');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `max_execution_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Max Execution Time Ms');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `min_execution_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Min Execution Time Ms');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `output_parameters_schema` SET TAGS ('dbx_business_glossary_term' = 'Output Parameters Schema');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `required_permissions` SET TAGS ('dbx_business_glossary_term' = 'Required Permissions');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `runtime_environment` SET TAGS ('dbx_business_glossary_term' = 'Runtime Environment');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `schedule_cron` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cron');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `script_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `script_type` SET TAGS ('dbx_business_glossary_term' = 'Script Type');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `automation_script_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`automation`.`automation_script` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
