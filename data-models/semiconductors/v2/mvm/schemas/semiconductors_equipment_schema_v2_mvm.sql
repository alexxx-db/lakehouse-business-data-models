-- Schema for Domain: equipment | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-27 11:13:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`equipment` COMMENT 'Semiconductor manufacturing equipment assets including lithography scanners, deposition systems, etchers, CMP tools, ATE platforms, and metrology/inspection systems. Manages equipment qualification, utilization, preventive/corrective maintenance schedules, calibration, and tool performance metrics supporting OEE.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` (
    `fab_tool_id` BIGINT COMMENT 'Primary key for fab_tool',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Fab capacity planning and tool qualification reports require knowing which process node each tool supports. Engineers query which tools are qualified for 7nm? daily. process_node_compatibility is a ',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: REQUIRED: Tool‑node compatibility matrix used in capacity planning and regulatory compliance reporting; linking each fab_tool to its supported technology_node is standard in semiconductor fabs.',
    `asset_status` STRING COMMENT 'Operational status of the asset within the enterprise.. Valid values are `active|inactive|scrapped`',
    `asset_tag` STRING COMMENT 'Internal asset tag used for inventory and tracking within the enterprise.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration activity.',
    `calibration_due_date` DATE COMMENT 'Planned date for the next calibration.',
    `capacity_wafer_per_hour` DECIMAL(18,2) COMMENT 'Maximum number of wafers the tool can process per hour.',
    `capital_expenditure_amount` DECIMAL(18,2) COMMENT 'Initial capital cost recorded for the asset.',
    `cleanroom_class` STRING COMMENT 'Cleanroom classification where the tool operates.. Valid values are `class1|class10|class100`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `depreciation_end_date` DATE COMMENT 'Date depreciation of the asset ends (end of useful life).',
    `depreciation_start_date` DATE COMMENT 'Date depreciation of the asset begins.',
    `fab_tool_description` STRING COMMENT 'Free‑form description of the equipment, including special features.',
    `energy_consumption_kwh_per_year` DECIMAL(18,2) COMMENT 'Estimated electricity usage per year.',
    `fab_site_code` STRING COMMENT 'Code identifying the fab location where the tool is installed.',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the tool.',
    `installation_date` DATE COMMENT 'Date the equipment was first installed in the fab.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive maintenance was performed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle phase of the equipment.. Valid values are `in_service|retired|maintenance|decommissioned|spare`',
    `maintenance_interval_days` STRING COMMENT 'Planned interval between preventive maintenance activities.',
    `manufacturer` STRING COMMENT 'The manufacturer of the fab tool record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the fab tool record in the equipment domain.',
    `model_number` STRING COMMENT 'Model designation assigned by the OEM.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the tool after a failure.',
    `fab_tool_name` STRING COMMENT 'Human‑readable name of the equipment (e.g., "EUV Scanner 1").',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE expressed as a percentage.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption of the tool.',
    `purchase_date` DATE COMMENT 'Date the equipment was purchased or capitalized.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the physical unit.',
    `software_version` STRING COMMENT 'Current version of the tools control software.',
    `tool_subtype` STRING COMMENT 'Technology subtype describing the process method. [ENUM-REF-CANDIDATE: euv|duv|cvd|pvd|ald|plasma|chemical — 7 candidates stripped; promote to reference product]',
    `tool_type` STRING COMMENT 'High‑level functional category of the equipment. [ENUM-REF-CANDIDATE: lithography|deposition|etch|cmp|metrology|ate|ion_implanter — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty ends.',
    CONSTRAINT pk_fab_tool PRIMARY KEY(`fab_tool_id`)
) COMMENT 'Master record for all semiconductor manufacturing equipment assets including lithography scanners (EUV/DUV), CVD/PVD/ALD deposition systems, etch chambers, CMP tools, ion implanters, ATE platforms, and metrology/inspection systems. Authoritative SSOT for tool identity, classification, OEM specifications, process node compatibility, FAB location, install date, and asset lifecycle status. Sourced from Applied Materials SmartFactory MES and SAP S/4HANA Fixed Assets.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` (
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the multi‑chamber tool that houses this chamber.',
    `audit_last_date` DATE COMMENT 'Date of the most recent compliance audit for the chamber.',
    `calibration_date` DATE COMMENT 'Date when the chamber was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration condition of the chamber.. Valid values are `calibrated|out_of_calibration|pending`',
    `chamber_code` STRING COMMENT 'Unique alphanumeric code assigned to the chamber by the manufacturer or fab.',
    `chamber_lifetime_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours the chamber has logged.',
    `chamber_name` STRING COMMENT 'Human‑readable name of the process chamber.',
    `chamber_status` STRING COMMENT 'The chamber status of the tool chamber record in the equipment domain.',
    `chamber_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., fault code, maintenance activity).',
    `chamber_type` STRING COMMENT 'Category of the chamber based on its primary process function.. Valid values are `deposition|etch|cvd|pvd|metrology|inspection`',
    `clean_interval_wafers` STRING COMMENT 'The clean interval wafers of the tool chamber record in the equipment domain.',
    `compliance_status` STRING COMMENT 'Regulatory and internal compliance state of the chamber.. Valid values are `compliant|non_compliant|pending_audit`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chamber record was first created in the system.',
    `tool_chamber_description` STRING COMMENT 'Free‑text description of the chambers purpose, capabilities, or special notes.',
    `firmware_version` STRING COMMENT 'Version of the embedded firmware controlling the chamber.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Standard cubic centimeters per minute flow rate for process gases.',
    `installation_date` DATE COMMENT 'Date the chamber was first installed in the fab.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration (e.g., pass, fail, deviation values).',
    `last_clean_date` DATE COMMENT 'The last clean date associated with the tool chamber equipment record.',
    `last_inspection_date` DATE COMMENT 'Date when the chamber was last inspected for wear or damage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the tool chamber record in the equipment domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the chamber record.',
    `location` STRING COMMENT 'Specific location within the fab (e.g., line, bay, floor).',
    `maintenance_cycle_days` STRING COMMENT 'Standard interval in days between scheduled maintenance events.',
    `max_pressure_torr` DECIMAL(18,2) COMMENT 'The max pressure torr of the tool chamber record in the equipment domain.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'The max temperature c of the tool chamber record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool chamber record in the equipment domain.',
    `model_number` STRING COMMENT 'Model designation of the chamber.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between failures for the chamber.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the chamber after a failure.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity based on the maintenance cycle.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Calculated OEE metric for the chamber (percentage).',
    `position_index` STRING COMMENT 'The position index of the tool chamber record in the equipment domain.',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target pressure setting for the chamber during operation.',
    `process_capability` STRING COMMENT 'The process capability of the tool chamber record in the equipment domain.',
    `qualification_date` DATE COMMENT 'Date when the chamber was last qualified.',
    `qualification_result` STRING COMMENT 'Detailed outcome of the qualification test (e.g., pass, fail, notes).',
    `qualification_status` STRING COMMENT 'Result of the most recent qualification run for the chamber.. Valid values are `qualified|unqualified|pending|failed`',
    `safety_lock_status` STRING COMMENT 'Current state of the chambers safety interlock.. Valid values are `engaged|disengaged`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for the chamber.',
    `software_version` STRING COMMENT 'Version of the control software used by the chamber.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for the chamber during operation.',
    `throughput_pph` DECIMAL(18,2) COMMENT 'Maximum parts‑per‑hour the chamber can process under nominal conditions.',
    `tool_chamber_status` STRING COMMENT 'Current operational state of the chamber.. Valid values are `in_service|maintenance|retired|decommissioned|qualified|unqualified`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the tool chamber record in the equipment domain.',
    `wafer_capacity` STRING COMMENT 'The wafer capacity of the tool chamber record in the equipment domain.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the chamber ends.',
    CONSTRAINT pk_tool_chamber PRIMARY KEY(`tool_chamber_id`)
) COMMENT 'Individual process chamber or module within a multi-chamber fab tool (e.g., a CVD cluster tool with 4 deposition chambers, or an etch system with multiple etch modules). Tracks chamber-level qualification status, process recipe assignments, chamber-specific utilization, and maintenance history independently from the parent tool. Essential for chamber-level SPC and yield correlation in multi-chamber tools.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` (
    `tool_qualification_id` BIGINT COMMENT 'Unique identifier for each tool qualification record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: QUALIFICATION COMPLIANCE report requires linking each tool qualification to the specific product family it supports, enabling audit of qualification status per family.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Tool qualification in semiconductor fabs is performed against a specific PDK version — the PDK defines process corners, DRC/LVS rule decks, and SPICE models that set qualification pass/fail criteria. ',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (lithography scanner, deposition system, etc.) being qualified.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the tool that was qualified.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Semiconductor fabs require formal tool qualification per process node before production release — a regulatory and quality compliance requirement (e.g., IATF 16949 for automotive). The plain string p',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Tool requalification is frequently triggered by maintenance events — maintenance_event has requalification_required (BOOLEAN) and requalification_status (STRING) fields explicitly modeling this workfl',
    `approval_date` DATE COMMENT 'Date the qualification was formally approved.',
    `approved_by` STRING COMMENT 'Name of the process engineer or manager who approved the qualification.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Target baseline value that the tool must meet or exceed.',
    `calibration_date` DATE COMMENT 'Date when the measurement tool was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration status of the measurement tool.. Valid values are `calibrated|due|overdue`',
    `change_control_number` STRING COMMENT 'Reference number of the change control request linked to this qualification.',
    `compliance_approval_status` STRING COMMENT 'Regulatory compliance sign‑off status for the qualification.. Valid values are `approved|pending|rejected`',
    `compliance_document_reference` STRING COMMENT 'Reference to the compliance document associated with the qualification.',
    `cpk_value` DECIMAL(18,2) COMMENT 'The cpk value of the tool qualification record in the equipment domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was created in the system.',
    `documentation_url` STRING COMMENT 'Link to detailed qualification documentation or report.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the equipment.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the tool qualification equipment record.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the tool is on the critical production path.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance on the equipment.',
    `maintenance_status` STRING COMMENT 'Indicates whether the equipment maintenance is current.. Valid values are `up_to_date|overdue`',
    `measurement_method` STRING COMMENT 'Method used to capture the qualification metric.. Valid values are `metrology|visual|electrical`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool qualification record in the equipment domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured during qualification.',
    `oee_impact` DECIMAL(18,2) COMMENT 'Estimated impact of the qualification on Overall Equipment Effectiveness, expressed as a percentage.',
    `qualification_date` DATE COMMENT 'The qualification date associated with the tool qualification equipment record.',
    `qualification_end_date` DATE COMMENT 'Date when the qualification activity completed.',
    `qualification_location` STRING COMMENT 'Plant or fab location where the qualification was performed.',
    `qualification_protocol` STRING COMMENT 'Name or code of the protocol used to qualify the tool.',
    `qualification_reason` STRING COMMENT 'Business driver for performing the qualification.. Valid values are `new_product|process_change|equipment_upgrade|maintenance`',
    `qualification_start_date` DATE COMMENT 'Date when the qualification activity began.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification process.. Valid values are `pending|in_progress|passed|failed|cancelled`',
    `qualification_type` STRING COMMENT 'Category of qualification performed on the tool.. Valid values are `initial|requalification|process_change|maintenance`',
    `qualification_validity_period_days` STRING COMMENT 'Number of days the qualification remains valid from the start date.',
    `qualification_version` STRING COMMENT 'Version identifier for the qualification record, incremented on re‑qualifications.',
    `requalification_due_date` DATE COMMENT 'The requalification due date associated with the tool qualification equipment record.',
    `result` STRING COMMENT 'Overall outcome of the qualification.. Valid values are `pass|fail`',
    `result_metric_unit` STRING COMMENT 'Unit of measure for the result metric.. Valid values are `nm|um|mm|percent`',
    `result_metric_value` DECIMAL(18,2) COMMENT 'Measured value of the primary qualification metric (e.g., overlay error).',
    `result_summary` STRING COMMENT 'The result summary of the tool qualification record in the equipment domain.',
    `risk_assessment` STRING COMMENT 'Risk level associated with the qualification outcome.. Valid values are `low|medium|high`',
    `standard_reference` STRING COMMENT 'The standard reference of the tool qualification record in the equipment domain.',
    `tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation from the baseline value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `validity_end_date` DATE COMMENT 'Date after which the qualification expires and must be renewed.',
    `validity_start_date` DATE COMMENT 'Date from which the qualification is considered valid for production.',
    CONSTRAINT pk_tool_qualification PRIMARY KEY(`tool_qualification_id`)
) COMMENT 'Qualification and certification records for fab tools and chambers against specific process nodes, recipes, and product families. Captures qualification type (initial qual, re-qual, process change qual), qualification protocol, pass/fail criteria, baseline metrology results, approving process engineer, and qualification validity period. A tool must be qualified before it can run production wafer lots. Sourced from Oracle Agile PLM and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool or chamber to which the schedule applies.',
    `spare_part_id` BIGINT COMMENT 'Identifier of the spare part that must be available for the maintenance.',
    `to_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — PM schedules must reference the tool they apply to. This drives work order generation and maintenance planning.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: PM schedules are defined for fab tools (to_fab_tool_id and primary_pm_fab_tool_id exist), but for multi-chamber tools, PM activities are often chamber-specific — e.g., chamber wet clean, chamber liner',
    `compliance_requirement` STRING COMMENT 'Regulatory or industry standard that the maintenance activity must satisfy.. Valid values are `SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `pm_schedule_description` STRING COMMENT 'Free‑text description of the maintenance activity and its purpose.',
    `estimated_downtime_minutes` STRING COMMENT 'Planned equipment downtime in minutes for the maintenance activity.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated duration hours of the pm schedule record in the equipment domain.',
    `frequency_days` STRING COMMENT 'The frequency days of the pm schedule record in the equipment domain.',
    `frequency_interval` STRING COMMENT 'The frequency interval of the pm schedule record in the equipment domain.',
    `interval_unit` STRING COMMENT 'Unit of measure for the interval value (day, week, month, wafer, or run).. Valid values are `day|week|month|wafer|run`',
    `interval_value` STRING COMMENT 'Numeric value defining the interval between maintenance events (e.g., 500 wafers, 1000 runs, 30 days).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the equipment is classified as critical for production (true) or not (false).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the pm schedule record in the equipment domain.',
    `last_performed_date` DATE COMMENT 'Date on which the maintenance activity was last executed.',
    `last_pm_date` DATE COMMENT 'The last pm date associated with the pm schedule equipment record.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Planned end time of the maintenance window.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Planned start time of the maintenance window.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the pm schedule record in the equipment domain.',
    `next_due_date` DATE COMMENT 'The next due date associated with the pm schedule equipment record.',
    `next_pm_date` DATE COMMENT 'The next pm date associated with the pm schedule equipment record.',
    `next_scheduled_date` DATE COMMENT 'Planned calendar date for the next execution of the maintenance.',
    `oee_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated impact of the maintenance on Overall Equipment Effectiveness expressed as a percentage.',
    `pm_description` STRING COMMENT 'The pm description of the pm schedule record in the equipment domain.',
    `pm_name` STRING COMMENT 'The pm name of the pm schedule record in the equipment domain.',
    `pm_procedure_reference` STRING COMMENT 'Reference code or document ID for the detailed preventive maintenance procedure.',
    `pm_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|retired|planned`',
    `pm_status` STRING COMMENT 'The pm status of the pm schedule record in the equipment domain.',
    `pm_type` STRING COMMENT 'Category of preventive maintenance activity (e.g., daily, weekly, monthly, wafer‑count‑based, run‑count‑based).. Valid values are `daily|weekly|monthly|wafer_count|run_count`',
    `priority` STRING COMMENT 'Business priority assigned to the maintenance activity.. Valid values are `high|medium|low`',
    `procedure_reference` STRING COMMENT 'The procedure reference of the pm schedule record in the equipment domain.',
    `required_technician_skill_level` STRING COMMENT 'Skill level required of the technician performing the maintenance.. Valid values are `junior|mid|senior|expert`',
    `schedule_basis` STRING COMMENT 'The schedule basis of the pm schedule record in the equipment domain.',
    `schedule_code` STRING COMMENT 'Business code used to uniquely reference the schedule across systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the maintenance schedule.',
    `schedule_status` STRING COMMENT 'The schedule status of the pm schedule record in the equipment domain.',
    `scheduling_constraint` STRING COMMENT 'Business rule or production window constraint that influences when the PM can be run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    `work_order_template_code` BIGINT COMMENT 'Identifier of the work‑order template used to generate PM work orders.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance (PM) schedule master defining planned PM activities for each fab tool or chamber. Specifies PM type (daily, weekly, monthly, wafer-count-based, run-count-based), PM procedure reference, estimated downtime window, required spare parts, required technician skill level, and scheduling constraints relative to production WIP. Drives the PM work order generation cadence in SAP PM module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` (
    `maintenance_event_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance event record.',
    `pm_schedule_id` BIGINT COMMENT 'FK to equipment.pm_schedule.pm_schedule_id — Scheduled PM events must link back to the PM schedule that triggered them, enabling PM compliance tracking.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Every maintenance event must reference the tool serviced. Core operational FK for maintenance history and MTTR calculation.',
    `to_fab_tool_id` BIGINT COMMENT 'Unique identifier for the to fab tool record within the maintenance event equipment entity.',
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber record within the maintenance event equipment entity.',
    `actual_duration_minutes` STRING COMMENT 'The actual duration minutes of the maintenance event record in the equipment domain.',
    `baseline_change_flag` BOOLEAN COMMENT 'True if the maintenance altered the equipment baseline for qualification.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by technicians or supervisors.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to the maintenance activity.. Valid values are `ISO9001|ITAR|EAR|RoHS|REACH|SOX`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the maintenance event record in the equipment domain.',
    `maintenance_event_description` STRING COMMENT 'The description of the maintenance event record in the equipment domain.',
    `downtime_duration_minutes` STRING COMMENT 'Total equipment downtime measured in minutes.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'The downtime hours of the maintenance event record in the equipment domain.',
    `downtime_minutes` STRING COMMENT 'The downtime minutes of the maintenance event record in the equipment domain.',
    `eco_reference` STRING COMMENT 'Identifier of the ECO that drove the modification, if applicable.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work was completed.',
    `event_description` STRING COMMENT 'The event description of the maintenance event record in the equipment domain.',
    `event_number` STRING COMMENT 'Human‑readable identifier or ticket number assigned to the maintenance event.',
    `event_status` STRING COMMENT 'The event status of the maintenance event record in the equipment domain.',
    `event_type` STRING COMMENT 'Classification of the maintenance activity.. Valid values are `preventive|corrective|emergency|upgrade|modification`',
    `failure_mode` STRING COMMENT 'The failure mode of the maintenance event record in the equipment domain.',
    `labor_cost` DECIMAL(18,2) COMMENT 'The labor cost of the maintenance event record in the equipment domain.',
    `labor_cost_total` DECIMAL(18,2) COMMENT 'Monetary cost of labor based on labor hours and rate.',
    `labor_cost_usd` DECIMAL(18,2) COMMENT 'The labor cost usd of the maintenance event record in the equipment domain.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total technician labor time recorded for the event.',
    `maintenance_category` STRING COMMENT 'Strategic classification of the maintenance approach.. Valid values are `preventive|predictive|reactive`',
    `maintenance_event_status` STRING COMMENT 'Current processing state of the maintenance event.. Valid values are `open|in_progress|completed|cancelled`',
    `maintenance_type` STRING COMMENT 'The maintenance type of the maintenance event record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the maintenance event record in the equipment domain.',
    `notes` STRING COMMENT 'The notes of the maintenance event record in the equipment domain.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated impact on Overall Equipment Effectiveness expressed as a percent.',
    `parts_cost` DECIMAL(18,2) COMMENT 'The parts cost of the maintenance event record in the equipment domain.',
    `parts_cost_total` DECIMAL(18,2) COMMENT 'Aggregate cost of all spare parts and consumables used.',
    `parts_cost_usd` DECIMAL(18,2) COMMENT 'The parts cost usd of the maintenance event record in the equipment domain.',
    `performance_improvement_target` STRING COMMENT 'Planned performance gain (e.g., throughput increase) resulting from the event.',
    `post_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration after maintenance.',
    `pre_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration before maintenance.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the maintenance event record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance event record.',
    `repair_action_description` STRING COMMENT 'Narrative of the corrective actions performed during the event.',
    `requalification_required` BOOLEAN COMMENT 'Indicates whether a formal re‑qualification is needed after the event.',
    `requalification_status` STRING COMMENT 'Current status of any required re‑qualification process.. Valid values are `pending|completed|not_required`',
    `root_cause` STRING COMMENT 'The root cause of the maintenance event record in the equipment domain.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of failure.. Valid values are `mechanical|electrical|software|process|human_error|unknown`',
    `root_cause_detail` STRING COMMENT 'Free‑text description of the specific root cause identified.',
    `safety_incident_description` STRING COMMENT 'Details of any safety incident associated with the maintenance.',
    `safety_incident_flag` BOOLEAN COMMENT 'True if the maintenance event involved a safety incident.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work actually began.',
    `technician_name` STRING COMMENT 'Full name of the technician responsible for the maintenance.',
    `total_cost` DECIMAL(18,2) COMMENT 'Combined cost of parts, labor, and any additional charges.',
    `trigger_source` STRING COMMENT 'Origin that caused the maintenance event to be created.. Valid values are `scheduled_pm|alarm|operator_report|fdc_event|eco`',
    `updated_by` STRING COMMENT 'System user identifier that last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the maintenance event record in the equipment domain.',
    `upgrade_type` STRING COMMENT 'Indicates whether the event involved a hardware, software, or firmware upgrade.. Valid values are `none|hardware|software|firmware`',
    `work_order_number` STRING COMMENT 'The work order number of the maintenance event record in the equipment domain.',
    `created_by` STRING COMMENT 'System user identifier that created the record.',
    CONSTRAINT pk_maintenance_event PRIMARY KEY(`maintenance_event_id`)
) COMMENT 'Transactional record of every maintenance activity executed on a fab tool or chamber, including preventive maintenance (PM), corrective maintenance (CM), emergency breakdown repair, engineering-driven modifications, tool upgrades/retrofits, and hardware/software modifications. Captures event type, trigger (scheduled PM, alarm, operator-reported, FDC event, ECO), start/end timestamps, actual downtime duration, root cause classification (5-why, fishbone), repair actions taken, spare parts and consumables consumed (part ID, quantity, unit cost, planned vs unplanned), technician IDs, upgrade/retrofit details (upgrade type, ECO reference, pre/post configuration, performance improvement targets, baseline change flag), and return-to-service sign-off including re-qualification requirements. SSOT for tool downtime attribution, MTTR/MTBF calculation, parts consumption tracking, upgrade history, and total cost of ownership. Sourced from SAP S/4HANA PM and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` (
    `tool_downtime_id` BIGINT COMMENT 'System-generated unique identifier for each downtime event record.',
    `oee_record_id` BIGINT COMMENT 'Foreign key linking to equipment.oee_record. Business justification: Granular downtime records (tool_downtime) contribute to OEE calculations in a specific measurement period. Linking tool_downtime to the oee_record for the period in which the downtime occurred enables',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab tool or chamber that experienced the downtime.',
    `maintenance_event_id` BIGINT COMMENT 'Reference to the maintenance work order associated with the downtime, if any.',
    `to_maintenance_event_id` BIGINT COMMENT 'FK to equipment.maintenance_event.maintenance_event_id — Downtime events caused by maintenance must link to the maintenance event for root cause tracing and planned vs unplanned analysis.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Downtime in multi-chamber fab tools (e.g., CVD cluster tools) is often chamber-specific — a single chamber may go offline while others remain productive. tool_downtime already has primary_fab_tool_id ',
    `tool_downtime_category` STRING COMMENT 'The category of the tool downtime record in the equipment domain.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the downtime event.',
    `corrective_action_taken` STRING COMMENT 'Brief description of the corrective action performed to resolve the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime record was first created in the system.',
    `downtime_category` STRING COMMENT 'The downtime category of the tool downtime record in the equipment domain.',
    `downtime_code` STRING COMMENT 'Coded value representing the downtime code of the tool downtime equipment record.',
    `downtime_duration_minutes` STRING COMMENT 'Total duration of the downtime event expressed in whole minutes.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool exited the downtime state.',
    `downtime_minutes` STRING COMMENT 'The downtime minutes of the tool downtime record in the equipment domain.',
    `downtime_reason` STRING COMMENT 'The downtime reason of the tool downtime record in the equipment domain.',
    `downtime_reason_code` STRING COMMENT 'Standardized code representing the root cause of the downtime.',
    `downtime_reason_description` STRING COMMENT 'Human‑readable description of why the tool was down.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool entered the downtime state.',
    `downtime_state` STRING COMMENT 'The downtime state of the tool downtime record in the equipment domain.',
    `downtime_type` STRING COMMENT 'Classification of the downtime according to the SEMI E10 state model.. Valid values are `productive|standby|engineering|scheduled|unscheduled|non_scheduled`',
    `duration_hours` DECIMAL(18,2) COMMENT 'The duration hours of the tool downtime record in the equipment domain.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'The duration minutes of the tool downtime record in the equipment domain.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the tool downtime record in the equipment domain.',
    `impact_severity` STRING COMMENT 'The impact severity of the tool downtime record in the equipment domain.',
    `impact_wip_lot_count` STRING COMMENT 'Number of work‑in‑process lots affected by the downtime.',
    `is_scheduled` BOOLEAN COMMENT 'The is scheduled of the tool downtime record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool downtime record in the equipment domain.',
    `notes` STRING COMMENT 'The notes of the tool downtime record in the equipment domain.',
    `responsible_party` STRING COMMENT 'Team or role accountable for handling the downtime event.. Valid values are `maintenance|engineering|facilities|scheduling|operator`',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause of the downtime.. Valid values are `equipment|process|material|human|environment`',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether the downtime was planned (true) or unplanned (false).',
    `sematech_state` STRING COMMENT 'The sematech state of the tool downtime record in the equipment domain.',
    `severity_level` STRING COMMENT 'Severity rating of the downtime event based on impact and urgency.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Production shift during which the downtime occurred.. Valid values are `day|night|swing`',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the tool downtime record in the equipment domain.',
    `state_after` STRING COMMENT 'Equipment state after the downtime event concluded.',
    `state_before` STRING COMMENT 'Equipment state immediately prior to the downtime event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the downtime record.',
    CONSTRAINT pk_tool_downtime PRIMARY KEY(`tool_downtime_id`)
) COMMENT 'Granular downtime records for each fab tool and chamber classified per SEMI E10 equipment state model (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled). Captures state transition timestamps, downtime reason code, responsible party (maintenance, engineering, facilities, scheduling), and impact on WIP lots. Feeds OEE (Overall Equipment Effectiveness) calculation and capacity planning models.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'System-generated unique identifier for each calibration record.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab equipment that was calibrated.',
    `tertiary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Calibration records must reference the tool/instrument calibrated. Required for ISO 9001 traceability.',
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber record within the calibration record equipment entity.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Calibration activities in semiconductor fabs are frequently triggered by maintenance events — after a PM or corrective maintenance, the tool must be recalibrated before returning to production. mainte',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer on which the calibration measurement was taken.',
    `as_found_value` DECIMAL(18,2) COMMENT 'The as found value of the calibration record record in the equipment domain.',
    `as_left_value` DECIMAL(18,2) COMMENT 'The as left value of the calibration record record in the equipment domain.',
    `calibration_date` DATE COMMENT 'The calibration date associated with the calibration record equipment record.',
    `calibration_interval_days` STRING COMMENT 'Planned interval in days between successive calibrations for this equipment.',
    `calibration_method` STRING COMMENT 'Technique used to perform the calibration.. Valid values are `sensor|reference|laser|electrical`',
    `calibration_number` STRING COMMENT 'The calibration number of the calibration record record in the equipment domain.',
    `calibration_record_status` STRING COMMENT 'Current processing status of the calibration record.. Valid values are `pending|completed|rejected|archived`',
    `calibration_report_url` STRING COMMENT 'Link to the detailed calibration report stored in the document repository.',
    `calibration_result` STRING COMMENT 'The calibration result of the calibration record record in the equipment domain.',
    `calibration_result_code` STRING COMMENT 'Standardized code representing the calibration outcome for downstream analytics.',
    `calibration_source_system` STRING COMMENT 'Name of the source system that generated the record (e.g., KLA ICOS, SmartFactory MES).',
    `calibration_standard` STRING COMMENT 'Reference standard used for calibration (e.g., NIST traceable, SEMI E30).',
    `calibration_status` STRING COMMENT 'The calibration status of the calibration record record in the equipment domain.',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration activity was performed.',
    `calibration_type` STRING COMMENT 'Method of calibration applied to the equipment.. Valid values are `in-situ|offline|periodic|initial|post-maintenance`',
    `certificate_number` STRING COMMENT 'The certificate number of the calibration record record in the equipment domain.',
    `comments` STRING COMMENT 'Additional remarks or observations captured by the technician.',
    `compliance_reference` STRING COMMENT 'Reference to the compliance clause (e.g., ISO 9001, IATF 16949) satisfied by this calibration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration record was first created in the system.',
    `due_date` DATE COMMENT 'The due date associated with the calibration record equipment record.',
    `location` STRING COMMENT 'Plant or fab line where the equipment resides (e.g., FAB1, LineA).',
    `lot_number` STRING COMMENT 'Identifier of the wafer lot associated with the calibration (if applicable).',
    `measured_value` DECIMAL(18,2) COMMENT 'Value recorded by the instrument during calibration.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measured value.',
    `measurement_unit` STRING COMMENT 'Unit of the measured and nominal values (e.g., nanometers, volts).. Valid values are `nm|um|mm|V|A|%`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the calibration record record in the equipment domain.',
    `next_calibration_date` DATE COMMENT 'The next calibration date associated with the calibration record equipment record.',
    `next_due_date` DATE COMMENT 'Date by which the next calibration must be performed.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target or nominal value that the equipment should meet.',
    `notes` STRING COMMENT 'The notes of the calibration record record in the equipment domain.',
    `pass_fail_result` STRING COMMENT 'Pass/Fail outcome of the calibration activity.. Valid values are `pass|fail`',
    `standard_used` STRING COMMENT 'The standard used of the calibration record record in the equipment domain.',
    `technician_name` STRING COMMENT 'Full name of the calibration technician.',
    `tolerance` DECIMAL(18,2) COMMENT 'The tolerance of the calibration record record in the equipment domain.',
    `tolerance_range` STRING COMMENT 'The tolerance range of the calibration record record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration record.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Calibration and metrology verification records for fab tools and measurement instruments. Tracks calibration type (in-situ, offline, periodic), calibration standard used, measured vs. nominal values, calibration pass/fail result, calibration interval, next due date, calibrating technician, and traceability to NIST or SEMI standards. Mandatory for ISO 9001 and IATF 16949 compliance. Sourced from KLA ICOS and SmartFactory MES calibration modules.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` (
    `equipment_process_recipe_id` BIGINT COMMENT 'Unique identifier for the equipment process recipe record.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner fabrication.fabrication_process_recipe (resolves MVM SSOT duplicate).',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is owned by a specific fab tool; adding fab_tool_id enables direct navigation and removes redundant attributes that can be derived from the fab_tool record.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process engineers must identify all qualified recipes for a given technology node before releasing a new node to production. process_node_target is a denormalized string; a proper FK to process_node e',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific equipment chamber where the recipe is executed.',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: A process recipe on a fab tool is only valid for production use if the tool has been qualified for that recipe and process node. Linking equipment_process_recipe to the tool_qualification record that ',
    `approval_date` DATE COMMENT 'The approval date associated with the equipment process recipe equipment record.',
    `approval_status` STRING COMMENT 'Current approval state of the recipe within the change control process.. Valid values are `draft|pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'The approved by of the equipment process recipe record in the equipment domain.',
    `audit_status` STRING COMMENT 'Result of the latest audit (passed, failed, pending).. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the recipe (e.g., SEMI, ISO).. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the detailed recipe documentation or PDF.',
    `effective_end_date` DATE COMMENT 'Date after which the recipe version is no longer valid (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the recipe version is valid for production.',
    `exposure_dose_mj_cm2` DECIMAL(18,2) COMMENT 'Energy dose applied during lithography exposure.',
    `focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus adjustment offset for the lithography tool, in nanometers.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Standard cubic centimeters per minute flow rate for process gases.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the recipe version is currently active for scheduling.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the recipe has been superseded and should no longer be used.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit of the recipe.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the equipment process recipe record in the equipment domain.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this recipe version.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the equipment process recipe record in the equipment domain.',
    `oee_actual_percent` DECIMAL(18,2) COMMENT 'Measured OEE percentage achieved during the most recent execution.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage for the recipe.',
    `parameter_count` STRING COMMENT 'Number of distinct process parameters defined in the recipe.',
    `parameter_set` STRING COMMENT 'The parameter set of the equipment process recipe record in the equipment domain.',
    `parameter_set_description` STRING COMMENT 'Narrative description of the key process parameters defined in the recipe.',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target chamber pressure for the process, in pascals.',
    `process_step_count` STRING COMMENT 'Number of discrete process steps defined in the recipe.',
    `process_type` STRING COMMENT 'The process type of the equipment process recipe record in the equipment domain.',
    `recipe_category` STRING COMMENT 'High‑level process domain the recipe belongs to.. Valid values are `Front-End|Back-End|Middle-Of-Line|Packaging`',
    `recipe_code` STRING COMMENT 'Business identifier code for the recipe used in change management and scheduling.',
    `recipe_hash` STRING COMMENT 'Checksum or hash value used to verify recipe integrity.',
    `recipe_name` STRING COMMENT 'Human‑readable name of the process recipe.',
    `recipe_owner` STRING COMMENT 'Name or identifier of the person or group responsible for the recipe.',
    `recipe_status` STRING COMMENT 'The recipe status of the equipment process recipe record in the equipment domain.',
    `recipe_version` STRING COMMENT 'The recipe version of the equipment process recipe record in the equipment domain.',
    `rf_power_watts` DECIMAL(18,2) COMMENT 'Radio‑frequency power setting for plasma processes, in watts.',
    `safety_status` STRING COMMENT 'Safety classification of the recipe based on hazardous materials or process risk.. Valid values are `safe|warning|critical`',
    `spin_speed_rpm` STRING COMMENT 'Rotational speed for spin‑coat steps, in revolutions per minute.',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the process_recipe concept (fabrication.fabrication_process_recipe)',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for the process step, in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the recipe record.',
    `validation_status` STRING COMMENT 'The validation status of the equipment process recipe record in the equipment domain.',
    `version` STRING COMMENT 'Version string of the recipe (e.g., v1.2, rev3).',
    `version_history_note` STRING COMMENT 'Free‑text note describing changes made in this version.',
    `yield_actual_percent` DECIMAL(18,2) COMMENT 'Actual yield percentage observed in the latest run.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target good‑die yield percentage for the recipe.',
    CONSTRAINT pk_equipment_process_recipe PRIMARY KEY(`equipment_process_recipe_id`)
) COMMENT 'Master and execution records for process recipes on fab tools. Defines complete recipe parameters (temperature, pressure, gas flows, RF power, spin speed, exposure dose, focus offset, etc.) for each process step and tool type, including recipe name, version, process node target, tool compatibility, recipe owner, approval status, and effective date range. Also captures each recipe execution instance linking a specific wafer lot run to the recipe version used, actual as-run vs as-set parameter values, execution start/end timestamps, operator ID, chamber used, and pass/fail outcome. SSOT for recipe configuration, version management, recipe execution history, and recipe-to-yield correlation analysis. Sourced from SmartFactory MES and Camstar recipe management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` (
    `oee_record_id` BIGINT COMMENT 'Unique surrogate key for each OEE measurement record.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: OEE records capture downtime_hours, downtime_category, and downtime_reason_code — these are denormalized copies of data that exists on the maintenance_event record. Linking oee_record to the specific ',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — OEE records must reference the measured tool. This is the fundamental relationship for equipment productivity reporting.',
    `to_fab_tool_id` BIGINT COMMENT 'Unique identifier for the to fab tool record within the oee record equipment entity.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: OEE metrics are tracked at the fab tool level (primary_fab_tool_id exists), but for multi-chamber tools, OEE must also be tracked per chamber to identify which chamber is the bottleneck. Adding tool_c',
    `availability_percent` DECIMAL(18,2) COMMENT 'The availability percent of the oee record record in the equipment domain.',
    `availability_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled time the equipment was available for production.',
    `available_hours` DECIMAL(18,2) COMMENT 'Total scheduled time the equipment was available for production.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the OEE measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OEE record was first inserted into the data lake.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'The downtime hours of the oee record record in the equipment domain.',
    `downtime_minutes` STRING COMMENT 'The downtime minutes of the oee record record in the equipment domain.',
    `engineering_hours` DECIMAL(18,2) COMMENT 'Hours spent in engineering or setup state (non‑productive).',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the OEE measurement was recorded.',
    `good_units` STRING COMMENT 'The good units of the oee record record in the equipment domain.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was idle (no work) while available.',
    `measurement_period` STRING COMMENT 'Granularity of the OEE aggregation (e.g., shift, day, week).. Valid values are `shift|day|week|month|quarter|year`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the oee record record in the equipment domain.',
    `oee_calculation_method` STRING COMMENT 'Methodology used to compute OEE (e.g., SEMI E10 standard or custom algorithm).. Valid values are `semie10|custom`',
    `oee_percent` DECIMAL(18,2) COMMENT 'The oee percent of the oee record record in the equipment domain.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Composite OEE metric calculated as availability × performance × quality.',
    `performance_percent` DECIMAL(18,2) COMMENT 'The performance percent of the oee record record in the equipment domain.',
    `performance_rate` DECIMAL(18,2) COMMENT 'Ratio of actual production speed to ideal speed, expressed as a percentage.',
    `period_end_date` DATE COMMENT 'The period end date associated with the oee record equipment record.',
    `period_start_date` DATE COMMENT 'The period start date associated with the oee record equipment record.',
    `planned_production_minutes` STRING COMMENT 'The planned production minutes of the oee record record in the equipment domain.',
    `productive_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment spent in productive state during the measurement period.',
    `quality_percent` DECIMAL(18,2) COMMENT 'The quality percent of the oee record record in the equipment domain.',
    `quality_rate` DECIMAL(18,2) COMMENT 'Percentage of good units produced out of total units processed.',
    `record_date` DATE COMMENT 'The record date associated with the oee record equipment record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the OEE record.. Valid values are `active|archived|deleted`',
    `responsible_party` STRING COMMENT 'Team or function accountable for the recorded downtime or state.. Valid values are `maintenance|engineering|facilities|scheduling|operator|other`',
    `scheduled_downtime_hours` DECIMAL(18,2) COMMENT 'Planned downtime (e.g., maintenance, changeover) duration in hours.',
    `shift_date` DATE COMMENT 'Calendar date of the production shift associated with the OEE record.',
    `shift_name` STRING COMMENT 'Label of the shift (e.g., A, B, C, D) during which the OEE data was collected.. Valid values are `A|B|C|D`',
    `state_current` STRING COMMENT 'Equipment state at the end of the measurement period.. Valid values are `productive|standby|engineering|scheduled_downtime|unscheduled_downtime|non_scheduled`',
    `state_last_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent state transition within the period.',
    `state_transition_count` STRING COMMENT 'Number of equipment state changes recorded in the period.',
    `total_units` STRING COMMENT 'The total units of the oee record record in the equipment domain.',
    `unscheduled_downtime_hours` DECIMAL(18,2) COMMENT 'Unplanned downtime (e.g., breakdown) duration in hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the OEE record.',
    `uptime_hours` DECIMAL(18,2) COMMENT 'The uptime hours of the oee record record in the equipment domain.',
    `wafer_throughput` DECIMAL(18,2) COMMENT 'Number of good wafers produced per hour (WPH) during the period.',
    CONSTRAINT pk_oee_record PRIMARY KEY(`oee_record_id`)
) COMMENT 'Periodic equipment productivity measurement and state tracking records for each fab tool combining SEMI E10 equipment state model data and OEE (Overall Equipment Effectiveness) metrics. Captures granular state transitions (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled), state transition timestamps, downtime reason codes, responsible party attribution (maintenance, engineering, facilities, scheduling), WIP lot impact, measurement period (shift, day, week), availability rate, performance rate, quality rate, composite OEE percentage, productive hours, available hours, idle hours, engineering hours, wafer throughput (WPH), and downtime breakdown. SSOT for all equipment state tracking, downtime attribution, productivity reporting, capacity consumption analysis, bottleneck identification, and fab scheduling inputs. Sourced from SmartFactory MES run data and OEE calculation engine.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique surrogate key for each spare part record.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location record within the spare part equipment entity.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations for the part.',
    `calibration_required_flag` BOOLEAN COMMENT 'True if the part must be calibrated periodically (e.g., sensors, metrology tools).',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of regulatory or industry certifications applicable to the part (e.g., RoHS, REACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the spare part record was first created in the system.',
    `criticality` STRING COMMENT 'The criticality of the spare part record in the equipment domain.',
    `criticality_rating` STRING COMMENT 'Business impact rating if the part is unavailable (high = production‑stop risk).. Valid values are `high|medium|low|none|unknown|reserved`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the unit cost.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `current_stock_qty` STRING COMMENT 'Number of units of the part currently available in the fab stockroom.',
    `spare_part_description` STRING COMMENT 'Detailed textual description of the part, including function and key specifications.',
    `disposal_method` STRING COMMENT 'Preferred method for disposing of excess or expired parts.. Valid values are `recycle|sell|destroy|return|donate|store`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous under safety regulations.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection activity.. Valid values are `passed|failed|pending|deferred|not_required|exempt`',
    `last_inspection_date` DATE COMMENT 'Date the part was most recently inspected for quality or safety compliance.',
    `last_received_date` DATE COMMENT 'Date the most recent shipment of this part was received into inventory.',
    `last_used_date` DATE COMMENT 'Date the part was last issued for equipment maintenance or repair.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to receipt of the part.',
    `lifecycle_end_date` DATE COMMENT 'Date the part was officially retired or marked obsolete.',
    `lifecycle_start_date` DATE COMMENT 'Date the part was first introduced into the inventory catalog.',
    `location_code` STRING COMMENT 'Alphanumeric code identifying the specific storage bin or area within the fab stockroom.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturer part number of the spare part record in the equipment domain.',
    `min_stock_level` STRING COMMENT 'Minimum quantity that must be on hand to avoid stock‑out situations.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the spare part record in the equipment domain.',
    `part_category` STRING COMMENT 'High‑level equipment domain the part supports. [ENUM-REF-CANDIDATE: lithography|deposition|etch|cmp|metrology|ate|assembly|test|other — 9 candidates stripped; promote to reference product]',
    `part_description` STRING COMMENT 'The part description of the spare part record in the equipment domain.',
    `part_image_url` STRING COMMENT 'Link to a digital image or drawing of the spare part.',
    `part_name` STRING COMMENT 'Human‑readable name of the spare part used in inventory and work orders.',
    `part_number` STRING COMMENT 'Manufacturer‑assigned part number that uniquely identifies the component across suppliers.',
    `part_status` STRING COMMENT 'The part status of the spare part record in the equipment domain.',
    `part_type` STRING COMMENT 'Classification of the part based on its usage and criticality to fab operations.. Valid values are `consumable|spare|critical|standard|optional|custom`',
    `part_volume_cm3` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of the part in cubic centimeters.',
    `part_weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of a single unit of the part in kilograms.',
    `quantity_on_hand` STRING COMMENT 'The quantity on hand of the spare part record in the equipment domain.',
    `reorder_point` STRING COMMENT 'Inventory quantity threshold that triggers a replenishment order.',
    `safety_stock_qty` STRING COMMENT 'Buffer quantity kept to protect against demand variability and supply delays.',
    `spare_part_status` STRING COMMENT 'Current lifecycle status of the part within the inventory system.. Valid values are `active|inactive|obsolete|pending|discontinued|reserved`',
    `stock_quantity` STRING COMMENT 'The stock quantity of the spare part record in the equipment domain.',
    `storage_condition` STRING COMMENT 'Environmental condition required for safe storage of the part.. Valid values are `cleanroom|ambient|refrigerated|sealed|dry|controlled`',
    `storage_location` STRING COMMENT 'The storage location of the spare part record in the equipment domain.',
    `supplier` STRING COMMENT 'Primary external supplier or vendor from which the part is sourced.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard purchase cost per individual unit of the part.',
    `unit_cost_usd` DECIMAL(18,2) COMMENT 'The unit cost usd of the spare part record in the equipment domain.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the spare part record in the equipment domain.',
    `updated_by` STRING COMMENT 'Identifier of the system user who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the spare part record.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the manufacturers warranty for the part expires.',
    `created_by` STRING COMMENT 'Identifier of the system user who created the record.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for spare parts and consumables inventory specific to fab tool maintenance, including critical spare parts (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), their OEM part numbers, compatible tool types, minimum stock levels, lead times, and storage location in the FAB stockroom. Supports PM planning and emergency repair readiness. Sourced from SAP S/4HANA MM module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` (
    `maintenance_parts_consumed_id` BIGINT COMMENT 'System-generated unique identifier for each parts consumption record',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to the maintenance event during which the spare part was consumed',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the specific spare part that was consumed during maintenance',
    `consumption_timestamp` TIMESTAMP COMMENT 'Date-time when the part was consumed or issued from inventory during the maintenance event.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost at time of use.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consumption record was created in the data model.',
    `part_condition_after` STRING COMMENT 'Disposition of the part after the maintenance activity, tracking whether it was installed, removed for refurbishment, disposed, or returned.',
    `part_condition_before` STRING COMMENT 'Condition assessment of the part being replaced or removed, used for root cause analysis and warranty claim validation.',
    `planned_vs_unplanned` STRING COMMENT 'Indicates whether this part consumption was planned (scheduled PM with parts list) or unplanned (emergency repair, discovered during maintenance).',
    `quantity_used` DECIMAL(18,2) COMMENT 'Number of units of the spare part consumed during this maintenance event. Supports fractional quantities for consumables measured in non-integer units (e.g., liters, kilograms).',
    `replacement_reason` STRING COMMENT 'Free-form or coded explanation for why the part was replaced or consumed, supporting root cause analysis and preventive maintenance optimization.',
    `technician_code` BIGINT COMMENT 'Identifier of the technician who recorded or performed the parts consumption, supporting accountability and training needs analysis.',
    `unit_cost_at_time_of_use` DECIMAL(18,2) COMMENT 'The unit cost of the spare part at the time it was consumed, captured for accurate maintenance cost accounting and variance analysis against current catalog prices.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this consumption record was last modified.',
    `warranty_claim_eligible` BOOLEAN COMMENT 'Flag indicating whether this parts consumption is eligible for warranty claim against the OEM or supplier.',
    `work_order_line_number` STRING COMMENT 'Sequential line number within the maintenance event work order, supporting integration with CMMS and ERP systems.',
    CONSTRAINT pk_maintenance_parts_consumed PRIMARY KEY(`maintenance_parts_consumed_id`)
) COMMENT 'This association product represents the consumption event between maintenance_event and spare_part. It captures the specific parts and consumables used during each maintenance activity, including quantity consumed, cost at time of use, part condition assessment, and replacement rationale. Each record links one maintenance_event to one spare_part with attributes that exist only in the context of this consumption relationship. This is the SSOT for parts consumption tracking, maintenance cost attribution, inventory replenishment triggers, and warranty claim validation.. Existence Justification: In semiconductor fab maintenance operations, a single maintenance event (PM, CM, breakdown repair, upgrade) routinely consumes multiple spare parts and consumables (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), and each spare part is consumed across many maintenance events over time. The business explicitly tracks parts consumption as a core CMMS function for cost accounting, inventory replenishment, warranty management, and total cost of ownership analysis. This is an operational M:N relationship that humans actively create and manage.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` (
    `tool_spare_part_compatibility_id` BIGINT COMMENT 'Unique surrogate key for each tool-spare part compatibility record',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to the fab tool in the compatibility relationship',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part in the compatibility relationship',
    `compatibility_type` STRING COMMENT 'Classification of the compatibility relationship: primary (OEM-recommended), alternate (approved substitute), emergency (temporary use only), or consumable (routine replacement item). Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compatibility record was first created in the system',
    `criticality_for_tool` STRING COMMENT 'Business impact rating if this specific part is unavailable for this specific tool. A part may be critical for one tool type but low criticality for another. Identified in detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date after which this spare part is no longer compatible or approved for this tool (null if still active)',
    `effective_start_date` DATE COMMENT 'Date from which this spare part became compatible or approved for use with this tool (supports tool upgrades and part obsolescence tracking)',
    `equipment_compatible` STRING COMMENT 'List of equipment models or tool families that can use this spare part. [Moved from spare_part: This denormalized STRING field (list of compatible equipment models) is direct evidence that the data model needs a proper M:N association. This field should be decomposed into individual tool_spare_part_compatibility records, enabling proper querying, maintenance planning, and compatibility matrix management.]',
    `installation_procedure_reference` STRING COMMENT 'Reference to the tool-specific installation or replacement procedure document (e.g., work instruction ID, SOP number) for installing this part on this tool',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compatibility record',
    `lead_time_for_tool` STRING COMMENT 'Tool-specific lead time in days for procuring this part for this tool, which may differ from the general part lead time due to tool-specific certifications or supplier agreements. Identified in detection phase relationship data.',
    `quantity_required_per_pm` DECIMAL(18,2) COMMENT 'Number of units of this spare part required for one preventive maintenance cycle on this specific tool. Varies by tool type and maintenance procedure. Identified in detection phase relationship data.',
    CONSTRAINT pk_tool_spare_part_compatibility PRIMARY KEY(`tool_spare_part_compatibility_id`)
) COMMENT 'This association product represents the compatibility matrix between fab tools and spare parts in semiconductor manufacturing. It captures which spare parts are compatible with which tools, along with maintenance-specific attributes such as quantity required per preventive maintenance cycle, criticality rating for each tool-part combination, and tool-specific lead times. Each record links one fab_tool to one spare_part with attributes that exist only in the context of this compatibility relationship. This replaces the denormalized equipment_compatible STRING field in spare_part and enables proper many-to-many equipment BOM management.. Existence Justification: In semiconductor fab equipment management, spare parts are compatible with multiple tool types (e.g., O-rings, filters, and electronic components used across lithography, etch, and deposition tools), and each tool requires multiple spare parts for maintenance. Equipment engineers actively manage the tool-to-spare-part compatibility matrix (equipment BOM for maintenance) with tool-specific attributes like quantity per PM cycle, criticality rating per tool, and installation procedures. This is a core operational relationship managed in MES and CMMS systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_to_fab_tool_id` FOREIGN KEY (`to_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_to_fab_tool_id` FOREIGN KEY (`to_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_oee_record_id` FOREIGN KEY (`oee_record_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`oee_record`(`oee_record_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_to_maintenance_event_id` FOREIGN KEY (`to_maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tertiary_fab_tool_id` FOREIGN KEY (`tertiary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_tool_qualification_id` FOREIGN KEY (`tool_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_qualification`(`tool_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_to_fab_tool_id` FOREIGN KEY (`to_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ADD CONSTRAINT `fk_equipment_maintenance_parts_consumed_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ADD CONSTRAINT `fk_equipment_maintenance_parts_consumed_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ADD CONSTRAINT `fk_equipment_tool_spare_part_compatibility_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ADD CONSTRAINT `fk_equipment_tool_spare_part_compatibility_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `capacity_wafer_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity (Wafer/Hour)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Amount');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_value_regex' = 'class1|class10|class100');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_description` SET TAGS ('dbx_business_glossary_term' = 'Tool Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `energy_consumption_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption (kWh)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|spare');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Tool Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `tool_subtype` SET TAGS ('dbx_business_glossary_term' = 'Tool Subtype');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `tool_type` SET TAGS ('dbx_business_glossary_term' = 'Tool Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|out_of_calibration|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_code` SET TAGS ('dbx_business_glossary_term' = 'Chamber Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_lifetime_hours` SET TAGS ('dbx_business_glossary_term' = 'Chamber Lifetime (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_name` SET TAGS ('dbx_business_glossary_term' = 'Chamber Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_status` SET TAGS ('dbx_business_glossary_term' = 'Chamber Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Current Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_business_glossary_term' = 'Chamber Type (e.g., Deposition, Etch, CVD, PVD, Metrology, Inspection)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_value_regex' = 'deposition|etch|cvd|pvd|metrology|inspection');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `clean_interval_wafers` SET TAGS ('dbx_business_glossary_term' = 'Clean Interval Wafers');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Chamber');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (sccm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_clean_date` SET TAGS ('dbx_business_glossary_term' = 'Last Clean Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location of Chamber');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `max_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Max Pressure Torr');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Max Temperature C');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `position_index` SET TAGS ('dbx_business_glossary_term' = 'Position Index');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `process_capability` SET TAGS ('dbx_business_glossary_term' = 'Process Capability');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|pending|failed');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `safety_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Lock Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `safety_lock_status` SET TAGS ('dbx_value_regex' = 'engaged|disengaged');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `throughput_pph` SET TAGS ('dbx_business_glossary_term' = 'Throughput (Parts Per Hour)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_status` SET TAGS ('dbx_business_glossary_term' = 'Chamber Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_status` SET TAGS ('dbx_value_regex' = 'in_service|maintenance|retired|decommissioned|qualified|unqualified');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `wafer_capacity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Capacity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier (CHAMBER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Metric Value (BASELINE_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date (CALIB_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status (CALIB_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|due|overdue');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CC_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status (COMP_APPROVAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier (COMP_DOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Cpk Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number (SERIAL_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag (IS_CRITICAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (MAINT_LAST_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status (MAINT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'up_to_date|overdue');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MEAS_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'metrology|visual|electrical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (QUAL_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `oee_impact` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage (OEE_IMPACT_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification End Date (QUAL_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_location` SET TAGS ('dbx_business_glossary_term' = 'Qualification Location (QUAL_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_protocol` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol (QUAL_PROTOCOL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reason (QUAL_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_reason` SET TAGS ('dbx_value_regex' = 'new_product|process_change|equipment_upgrade|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date (QUAL_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|requalification|process_change|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validity Period (VALIDITY_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Version (QUAL_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result (QUAL_RESULT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Unit (QUAL_METRIC_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Value (QUAL_METRIC_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment (RISK_ASSESS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Tolerance (QUAL_TOLERANCE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VALID_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VALID_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Part ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `to_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency Days');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_value_regex' = 'day|week|month|wafer|run');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Interval Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Equipment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_pm_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pm Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `next_pm_date` SET TAGS ('dbx_business_glossary_term' = 'Next Pm Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `oee_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Estimate (%)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_description` SET TAGS ('dbx_business_glossary_term' = 'Pm Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_name` SET TAGS ('dbx_business_glossary_term' = 'Pm Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'PM Procedure Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_status` SET TAGS ('dbx_business_glossary_term' = 'Pm Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Type (PM Type)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|wafer_count|run_count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Procedure Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Technician Skill Level Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|expert');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_basis` SET TAGS ('dbx_business_glossary_term' = 'Schedule Basis');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `scheduling_constraint` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraint');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `work_order_template_code` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `to_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `baseline_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ISO9001|ITAR|EAR|RoHS|REACH|SOX');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `eco_reference` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Number (EVT_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Type (MTN_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|upgrade|modification');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `parts_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `parts_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `performance_improvement_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Target');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `post_config_version` SET TAGS ('dbx_business_glossary_term' = 'Post‑Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `pre_config_version` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `repair_action_description` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_required` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Required');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RC_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|software|process|human_error|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Trigger Source (TRG_SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'scheduled_pm|alarm|operator_report|fdc_event|eco');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Type (UPG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_value_regex' = 'none|hardware|software|firmware');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Downtime Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `oee_record_id` SET TAGS ('dbx_business_glossary_term' = 'Oee Record Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `to_maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Tool Downtime Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_state` SET TAGS ('dbx_business_glossary_term' = 'Downtime State');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'productive|standby|engineering|scheduled|unscheduled|non_scheduled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `impact_wip_lot_count` SET TAGS ('dbx_business_glossary_term' = 'WIP Lot Impact Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `is_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Is Scheduled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'maintenance|engineering|facilities|scheduling|operator');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|material|human|environment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Downtime Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `sematech_state` SET TAGS ('dbx_business_glossary_term' = 'Sematech State');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `state_after` SET TAGS ('dbx_business_glossary_term' = 'State After Downtime');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `state_before` SET TAGS ('dbx_business_glossary_term' = 'State Before Downtime');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tertiary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `as_found_value` SET TAGS ('dbx_business_glossary_term' = 'As Found Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `as_left_value` SET TAGS ('dbx_business_glossary_term' = 'As Left Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'sensor|reference|laser|electrical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_report_url` SET TAGS ('dbx_business_glossary_term' = 'Calibration Report URL');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_result_code` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Calibration Source System');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calibration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'in-situ|offline|periodic|initial|post-maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Equipment Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Calibration Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|V|A|%');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Calibration Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `standard_used` SET TAGS ('dbx_business_glossary_term' = 'Standard Used');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Tolerance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tolerance_range` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Range');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `exposure_dose_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'Exposure Dose (mJ/cm²)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Focus Offset (nm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (sccm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `oee_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Actual Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `parameter_count` SET TAGS ('dbx_business_glossary_term' = 'Parameter Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `parameter_set_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_step_count` SET TAGS ('dbx_business_glossary_term' = 'Process Step Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_category` SET TAGS ('dbx_business_glossary_term' = 'Recipe Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_category` SET TAGS ('dbx_value_regex' = 'Front-End|Back-End|Middle-Of-Line|Packaging');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_hash` SET TAGS ('dbx_business_glossary_term' = 'Recipe Hash');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_owner` SET TAGS ('dbx_business_glossary_term' = 'Recipe Owner');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `rf_power_watts` SET TAGS ('dbx_business_glossary_term' = 'RF Power (W)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `safety_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `safety_status` SET TAGS ('dbx_value_regex' = 'safe|warning|critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `spin_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Spin Speed (RPM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `version_history_note` SET TAGS ('dbx_business_glossary_term' = 'Version History Note');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `yield_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Actual Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_record_id` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Identifier (OEE_REC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `to_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability Rate (AVAIL_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `available_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Hours (AVAIL_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `engineering_hours` SET TAGS ('dbx_business_glossary_term' = 'Engineering Hours (ENG_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVENT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `good_units` SET TAGS ('dbx_business_glossary_term' = 'Good Units');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours (IDLE_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period (MEAS_PERIOD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'shift|day|week|month|quarter|year');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'OEE Calculation Method (OEE_CALC_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_calculation_method` SET TAGS ('dbx_value_regex' = 'semie10|custom');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Oee Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage (OEE_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `performance_percent` SET TAGS ('dbx_business_glossary_term' = 'Performance Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Rate (PERF_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `planned_production_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `productive_hours` SET TAGS ('dbx_business_glossary_term' = 'Productive Hours (PROD_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `quality_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `quality_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rate (QUAL_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party (RESP_PARTY)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'maintenance|engineering|facilities|scheduling|operator|other');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `scheduled_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Downtime Hours (SCH_DOWNTIME_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date (SHIFT_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name (SHIFT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `state_current` SET TAGS ('dbx_business_glossary_term' = 'Current Equipment State (EQ_STATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `state_current` SET TAGS ('dbx_value_regex' = 'productive|standby|engineering|scheduled_downtime|unscheduled_downtime|non_scheduled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `state_last_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'State Last Change Timestamp (EQ_STATE_CHANGE_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `state_transition_count` SET TAGS ('dbx_business_glossary_term' = 'State Transition Count (STATE_TRANS_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `unscheduled_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Unscheduled Downtime Hours (UNSCH_DOWNTIME_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Uptime Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `wafer_throughput` SET TAGS ('dbx_business_glossary_term' = 'Wafer Throughput (WAFER_TPH)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` SET TAGS ('dbx_subdomain' = 'inventory_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Criticality');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|none|unknown|reserved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `current_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_description` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|sell|destroy|return|donate|store');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|deferred|not_required|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_image_url` SET TAGS ('dbx_business_glossary_term' = 'Part Image URL');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Number (OEM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_business_glossary_term' = 'Part Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'consumable|spare|critical|standard|optional|custom');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Part Volume (cm³)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Part Weight (kg)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending|discontinued|reserved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Condition');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'cleanroom|ambient|refrigerated|sealed|dry|controlled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` SET TAGS ('dbx_subdomain' = 'inventory_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` SET TAGS ('dbx_association_edges' = 'equipment.maintenance_event,equipment.spare_part');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `maintenance_parts_consumed_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Parts Consumed ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Parts Consumed - Maintenance Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Parts Consumed - Spare Part Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `part_condition_after` SET TAGS ('dbx_business_glossary_term' = 'Part Condition After');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `part_condition_before` SET TAGS ('dbx_business_glossary_term' = 'Part Condition Before');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `planned_vs_unplanned` SET TAGS ('dbx_business_glossary_term' = 'Planned vs Unplanned');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Replacement Reason');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `technician_code` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `unit_cost_at_time_of_use` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost at Time of Use');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `warranty_claim_eligible` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed` ALTER COLUMN `work_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` SET TAGS ('dbx_subdomain' = 'inventory_logistics');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` SET TAGS ('dbx_association_edges' = 'equipment.fab_tool,equipment.spare_part');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `tool_spare_part_compatibility_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Spare Part Compatibility ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Spare Part Compatibility - Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Spare Part Compatibility - Spare Part Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `compatibility_type` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `criticality_for_tool` SET TAGS ('dbx_business_glossary_term' = 'Criticality For Tool');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `equipment_compatible` SET TAGS ('dbx_business_glossary_term' = 'Compatible Equipment Types');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `installation_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Installation Procedure Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `lead_time_for_tool` SET TAGS ('dbx_business_glossary_term' = 'Lead Time For Tool');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility` ALTER COLUMN `quantity_required_per_pm` SET TAGS ('dbx_business_glossary_term' = 'Quantity Required Per PM');
