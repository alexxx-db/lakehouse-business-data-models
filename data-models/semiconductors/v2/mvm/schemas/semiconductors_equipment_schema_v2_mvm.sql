-- Schema for Domain: equipment | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-07-10 14:04:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`equipment` COMMENT 'Semiconductor manufacturing equipment assets including lithography scanners, deposition systems, etchers, CMP tools, ATE platforms, and metrology/inspection systems. Manages equipment qualification, utilization, preventive/corrective maintenance schedules, calibration, and tool performance metrics supporting OEE.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` (
    `fab_tool_id` BIGINT COMMENT 'Primary key for fab_tool',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Export Control process requires each fab tool to be linked to its export license for legal shipment and usage tracking.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: REQUIRED: Tool‑node compatibility matrix used in capacity planning and regulatory compliance reporting; linking each fab_tool to its supported technology_node is standard in semiconductor fabs.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: OEM supplier needed for purchase contracts and warranty compliance; experts track OEM supplier per tool.',
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
    `model_number` STRING COMMENT 'Model designation assigned by the OEM.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the tool after a failure.',
    `fab_tool_name` STRING COMMENT 'Human‑readable name of the equipment (e.g., "EUV Scanner 1").',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE expressed as a percentage.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption of the tool.',
    `process_node_compatibility` STRING COMMENT 'Semiconductor process nodes the tool can support.. Valid values are `5nm|7nm|10nm|14nm|28nm|40nm`',
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
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: Chamber vendor is a supplier; linking enables vendor performance reporting and spare‑part sourcing.',
    `audit_last_date` DATE COMMENT 'Date of the most recent compliance audit for the chamber.',
    `calibration_date` DATE COMMENT 'Date when the chamber was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration condition of the chamber.. Valid values are `calibrated|out_of_calibration|pending`',
    `chamber_code` STRING COMMENT 'Unique alphanumeric code assigned to the chamber by the manufacturer or fab.',
    `chamber_lifetime_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours the chamber has logged.',
    `chamber_name` STRING COMMENT 'Human‑readable name of the process chamber.',
    `chamber_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., fault code, maintenance activity).',
    `chamber_type` STRING COMMENT 'Category of the chamber based on its primary process function.. Valid values are `deposition|etch|cvd|pvd|metrology|inspection`',
    `compliance_status` STRING COMMENT 'Regulatory and internal compliance state of the chamber.. Valid values are `compliant|non_compliant|pending_audit`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chamber record was first created in the system.',
    `tool_chamber_description` STRING COMMENT 'Free‑text description of the chambers purpose, capabilities, or special notes.',
    `firmware_version` STRING COMMENT 'Version of the embedded firmware controlling the chamber.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Standard cubic centimeters per minute flow rate for process gases.',
    `installation_date` DATE COMMENT 'Date the chamber was first installed in the fab.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration (e.g., pass, fail, deviation values).',
    `last_inspection_date` DATE COMMENT 'Date when the chamber was last inspected for wear or damage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance event.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the chamber record.',
    `location` STRING COMMENT 'Specific location within the fab (e.g., line, bay, floor).',
    `maintenance_cycle_days` STRING COMMENT 'Standard interval in days between scheduled maintenance events.',
    `model_number` STRING COMMENT 'Model designation of the chamber.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between failures for the chamber.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the chamber after a failure.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity based on the maintenance cycle.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Calculated OEE metric for the chamber (percentage).',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target pressure setting for the chamber during operation.',
    `qualification_date` DATE COMMENT 'Date when the chamber was last qualified.',
    `qualification_result` STRING COMMENT 'Detailed outcome of the qualification test (e.g., pass, fail, notes).',
    `qualification_status` STRING COMMENT 'Result of the most recent qualification run for the chamber.. Valid values are `qualified|unqualified|pending|failed`',
    `safety_lock_status` STRING COMMENT 'Current state of the chambers safety interlock.. Valid values are `engaged|disengaged`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for the chamber.',
    `software_version` STRING COMMENT 'Version of the control software used by the chamber.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for the chamber during operation.',
    `throughput_pph` DECIMAL(18,2) COMMENT 'Maximum parts‑per‑hour the chamber can process under nominal conditions.',
    `tool_chamber_status` STRING COMMENT 'Current operational state of the chamber.. Valid values are `in_service|maintenance|retired|decommissioned|qualified|unqualified`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the chamber ends.',
    CONSTRAINT pk_tool_chamber PRIMARY KEY(`tool_chamber_id`)
) COMMENT 'Individual process chamber or module within a multi-chamber fab tool (e.g., a CVD cluster tool with 4 deposition chambers, or an etch system with multiple etch modules). Tracks chamber-level qualification status, process recipe assignments, chamber-specific utilization, and maintenance history independently from the parent tool. Essential for chamber-level SPC and yield correlation in multi-chamber tools.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` (
    `tool_qualification_id` BIGINT COMMENT 'Unique identifier for each tool qualification record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: QUALIFICATION COMPLIANCE report requires linking each tool qualification to the specific product family it supports, enabling audit of qualification status per family.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (lithography scanner, deposition system, etc.) being qualified.',
    `approval_date` DATE COMMENT 'Date the qualification was formally approved.',
    `approved_by` STRING COMMENT 'Name of the process engineer or manager who approved the qualification.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Target baseline value that the tool must meet or exceed.',
    `calibration_date` DATE COMMENT 'Date when the measurement tool was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration status of the measurement tool.. Valid values are `calibrated|due|overdue`',
    `change_control_number` STRING COMMENT 'Reference number of the change control request linked to this qualification.',
    `compliance_approval_status` STRING COMMENT 'Regulatory compliance sign‑off status for the qualification.. Valid values are `approved|pending|rejected`',
    `compliance_document_reference` STRING COMMENT 'Reference to the compliance document associated with the qualification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was created in the system.',
    `documentation_url` STRING COMMENT 'Link to detailed qualification documentation or report.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the equipment.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the tool is on the critical production path.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance on the equipment.',
    `maintenance_status` STRING COMMENT 'Indicates whether the equipment maintenance is current.. Valid values are `up_to_date|overdue`',
    `measurement_method` STRING COMMENT 'Method used to capture the qualification metric.. Valid values are `metrology|visual|electrical`',
    `notes` STRING COMMENT 'Free‑form comments or observations captured during qualification.',
    `oee_impact` DECIMAL(18,2) COMMENT 'Estimated impact of the qualification on Overall Equipment Effectiveness, expressed as a percentage.',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) for which the tool is qualified.',
    `qualification_end_date` DATE COMMENT 'Date when the qualification activity completed.',
    `qualification_location` STRING COMMENT 'Plant or fab location where the qualification was performed.',
    `qualification_protocol` STRING COMMENT 'Name or code of the protocol used to qualify the tool.',
    `qualification_reason` STRING COMMENT 'Business driver for performing the qualification.. Valid values are `new_product|process_change|equipment_upgrade|maintenance`',
    `qualification_start_date` DATE COMMENT 'Date when the qualification activity began.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification process.. Valid values are `pending|in_progress|passed|failed|cancelled`',
    `qualification_type` STRING COMMENT 'Category of qualification performed on the tool.. Valid values are `initial|requalification|process_change|maintenance`',
    `qualification_validity_period_days` STRING COMMENT 'Number of days the qualification remains valid from the start date.',
    `qualification_version` STRING COMMENT 'Version identifier for the qualification record, incremented on re‑qualifications.',
    `result` STRING COMMENT 'Overall outcome of the qualification.. Valid values are `pass|fail`',
    `result_metric_unit` STRING COMMENT 'Unit of measure for the result metric.. Valid values are `nm|um|mm|percent`',
    `result_metric_value` DECIMAL(18,2) COMMENT 'Measured value of the primary qualification metric (e.g., overlay error).',
    `risk_assessment` STRING COMMENT 'Risk level associated with the qualification outcome.. Valid values are `low|medium|high`',
    `tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation from the baseline value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `validity_end_date` DATE COMMENT 'Date after which the qualification expires and must be renewed.',
    `validity_start_date` DATE COMMENT 'Date from which the qualification is considered valid for production.',
    CONSTRAINT pk_tool_qualification PRIMARY KEY(`tool_qualification_id`)
) COMMENT 'Qualification and certification records for fab tools and chambers against specific process nodes, recipes, and product families. Captures qualification type (initial qual, re-qual, process change qual), qualification protocol, pass/fail criteria, baseline metrology results, approving process engineer, and qualification validity period. A tool must be qualified before it can run production wafer lots. Sourced from Oracle Agile PLM and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool or chamber to which the schedule applies.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Preventive maintenance schedules in semiconductor fabs are defined at the chamber level for multi-chamber tools — e.g., a weekly chamber clean cycle for chamber A of a CVD tool, or a quarterly RF gene',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: PM schedules reference specific consumable materials (process gases, cleaning agents, replacement consumables) beyond spare parts. Linking to material_master enables MRP-driven consumable planning and',
    `spare_part_id` BIGINT COMMENT 'Identifier of the spare part that must be available for the maintenance.',
    `compliance_requirement` STRING COMMENT 'Regulatory or industry standard that the maintenance activity must satisfy.. Valid values are `SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `pm_schedule_description` STRING COMMENT 'Free‑text description of the maintenance activity and its purpose.',
    `estimated_downtime_minutes` STRING COMMENT 'Planned equipment downtime in minutes for the maintenance activity.',
    `interval_unit` STRING COMMENT 'Unit of measure for the interval value (day, week, month, wafer, or run).. Valid values are `day|week|month|wafer|run`',
    `interval_value` STRING COMMENT 'Numeric value defining the interval between maintenance events (e.g., 500 wafers, 1000 runs, 30 days).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the equipment is classified as critical for production (true) or not (false).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the schedule record.',
    `last_performed_date` DATE COMMENT 'Date on which the maintenance activity was last executed.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Planned end time of the maintenance window.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Planned start time of the maintenance window.',
    `next_scheduled_date` DATE COMMENT 'Planned calendar date for the next execution of the maintenance.',
    `oee_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated impact of the maintenance on Overall Equipment Effectiveness expressed as a percentage.',
    `pm_procedure_reference` STRING COMMENT 'Reference code or document ID for the detailed preventive maintenance procedure.',
    `pm_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|retired|planned`',
    `pm_type` STRING COMMENT 'Category of preventive maintenance activity (e.g., daily, weekly, monthly, wafer‑count‑based, run‑count‑based).. Valid values are `daily|weekly|monthly|wafer_count|run_count`',
    `priority` STRING COMMENT 'Business priority assigned to the maintenance activity.. Valid values are `high|medium|low`',
    `required_technician_skill_level` STRING COMMENT 'Skill level required of the technician performing the maintenance.. Valid values are `junior|mid|senior|expert`',
    `schedule_code` STRING COMMENT 'Business code used to uniquely reference the schedule across systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the maintenance schedule.',
    `scheduling_constraint` STRING COMMENT 'Business rule or production window constraint that influences when the PM can be run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    `work_order_template_code` BIGINT COMMENT 'Identifier of the work‑order template used to generate PM work orders.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance (PM) schedule master defining planned PM activities for each fab tool or chamber. Specifies PM type (daily, weekly, monthly, wafer-count-based, run-count-based), PM procedure reference, estimated downtime window, required spare parts, required technician skill level, and scheduling constraints relative to production WIP. Drives the PM work order generation cadence in SAP PM module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` (
    `maintenance_event_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance event record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Maintenance events consume tracked materials (cleaning chemicals, process gases, consumables) that must be linked to the ERP material master for inventory deduction, cost accounting, and compliance re',
    `pm_schedule_id` BIGINT COMMENT 'FK to equipment.pm_schedule.pm_schedule_id — Scheduled PM events must link back to the PM schedule that triggered them, enabling PM compliance tracking.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Every maintenance event must reference the tool serviced. Core operational FK for maintenance history and MTTR calculation.',
    `spare_part_id` BIGINT COMMENT 'FK to equipment.spare_part.spare_part_id — Maintenance events consume spare parts. This link enables parts consumption tracking and inventory depletion.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Maintenance activities in semiconductor fabs are frequently performed at the chamber level — e.g., chamber clean, liner replacement, RF match tuning, or gas line purge on a specific chamber within a m',
    `baseline_change_flag` BOOLEAN COMMENT 'True if the maintenance altered the equipment baseline for qualification.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by technicians or supervisors.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to the maintenance activity.. Valid values are `ISO9001|ITAR|EAR|RoHS|REACH|SOX`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `downtime_duration_minutes` STRING COMMENT 'Total equipment downtime measured in minutes.',
    `eco_reference` STRING COMMENT 'Identifier of the ECO that drove the modification, if applicable.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work was completed.',
    `event_number` STRING COMMENT 'Human‑readable identifier or ticket number assigned to the maintenance event.',
    `event_type` STRING COMMENT 'Classification of the maintenance activity.. Valid values are `preventive|corrective|emergency|upgrade|modification`',
    `labor_cost_total` DECIMAL(18,2) COMMENT 'Monetary cost of labor based on labor hours and rate.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total technician labor time recorded for the event.',
    `maintenance_category` STRING COMMENT 'Strategic classification of the maintenance approach.. Valid values are `preventive|predictive|reactive`',
    `maintenance_event_status` STRING COMMENT 'Current processing state of the maintenance event.. Valid values are `open|in_progress|completed|cancelled`',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated impact on Overall Equipment Effectiveness expressed as a percent.',
    `parts_cost_total` DECIMAL(18,2) COMMENT 'Aggregate cost of all spare parts and consumables used.',
    `performance_improvement_target` STRING COMMENT 'Planned performance gain (e.g., throughput increase) resulting from the event.',
    `post_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration after maintenance.',
    `pre_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration before maintenance.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the maintenance event record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance event record.',
    `repair_action_description` STRING COMMENT 'Narrative of the corrective actions performed during the event.',
    `requalification_required` BOOLEAN COMMENT 'Indicates whether a formal re‑qualification is needed after the event.',
    `requalification_status` STRING COMMENT 'Current status of any required re‑qualification process.. Valid values are `pending|completed|not_required`',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of failure.. Valid values are `mechanical|electrical|software|process|human_error|unknown`',
    `root_cause_detail` STRING COMMENT 'Free‑text description of the specific root cause identified.',
    `safety_incident_description` STRING COMMENT 'Details of any safety incident associated with the maintenance.',
    `safety_incident_flag` BOOLEAN COMMENT 'True if the maintenance event involved a safety incident.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work actually began.',
    `technician_name` STRING COMMENT 'Full name of the technician responsible for the maintenance.',
    `total_cost` DECIMAL(18,2) COMMENT 'Combined cost of parts, labor, and any additional charges.',
    `trigger_source` STRING COMMENT 'Origin that caused the maintenance event to be created.. Valid values are `scheduled_pm|alarm|operator_report|fdc_event|eco`',
    `updated_by` STRING COMMENT 'System user identifier that last modified the record.',
    `upgrade_type` STRING COMMENT 'Indicates whether the event involved a hardware, software, or firmware upgrade.. Valid values are `none|hardware|software|firmware`',
    `created_by` STRING COMMENT 'System user identifier that created the record.',
    CONSTRAINT pk_maintenance_event PRIMARY KEY(`maintenance_event_id`)
) COMMENT 'Transactional record of every maintenance activity executed on a fab tool or chamber, including preventive maintenance (PM), corrective maintenance (CM), emergency breakdown repair, engineering-driven modifications, tool upgrades/retrofits, and hardware/software modifications. Captures event type, trigger (scheduled PM, alarm, operator-reported, FDC event, ECO), start/end timestamps, actual downtime duration, root cause classification (5-why, fishbone), repair actions taken, spare parts and consumables consumed (part ID, quantity, unit cost, planned vs unplanned), technician IDs, upgrade/retrofit details (upgrade type, ECO reference, pre/post configuration, performance improvement targets, baseline change flag), and return-to-service sign-off including re-qualification requirements. SSOT for tool downtime attribution, MTTR/MTBF calculation, parts consumption tracking, upgrade history, and total cost of ownership. Sourced from SAP S/4HANA PM and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` (
    `tool_downtime_id` BIGINT COMMENT 'System-generated unique identifier for each downtime event record.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab tool or chamber that experienced the downtime.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: SEMI E10 equipment state tracking is most granular at the chamber level for multi-chamber cluster tools. tool_downtime currently only links to fab_tool via primary_fab_tool_id, but in a CVD cluster to',
    `maintenance_event_id` BIGINT COMMENT 'Reference to the maintenance work order associated with the downtime, if any.',
    `tool_triggering_maintenance_event_id` BIGINT COMMENT 'FK to equipment.maintenance_event.maintenance_event_id — Downtime events caused by maintenance must link to the maintenance event for root cause tracing and planned vs unplanned analysis.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the downtime event.',
    `corrective_action_taken` STRING COMMENT 'Brief description of the corrective action performed to resolve the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime record was first created in the system.',
    `downtime_duration_minutes` STRING COMMENT 'Total duration of the downtime event expressed in whole minutes.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool exited the downtime state.',
    `downtime_reason_code` STRING COMMENT 'Standardized code representing the root cause of the downtime.',
    `downtime_reason_description` STRING COMMENT 'Human‑readable description of why the tool was down.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool entered the downtime state.',
    `downtime_type` STRING COMMENT 'Classification of the downtime according to the SEMI E10 state model.. Valid values are `productive|standby|engineering|scheduled|unscheduled|non_scheduled`',
    `impact_wip_lot_count` STRING COMMENT 'Number of work‑in‑process lots affected by the downtime.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated reduction in Overall Equipment Effectiveness caused by the downtime, expressed as a percentage.',
    `responsible_party` STRING COMMENT 'Team or role accountable for handling the downtime event.. Valid values are `maintenance|engineering|facilities|scheduling|operator`',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause of the downtime.. Valid values are `equipment|process|material|human|environment`',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether the downtime was planned (true) or unplanned (false).',
    `severity_level` STRING COMMENT 'Severity rating of the downtime event based on impact and urgency.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Production shift during which the downtime occurred.. Valid values are `day|night|swing`',
    `state_after` STRING COMMENT 'Equipment state after the downtime event concluded.',
    `state_before` STRING COMMENT 'Equipment state immediately prior to the downtime event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the downtime record.',
    CONSTRAINT pk_tool_downtime PRIMARY KEY(`tool_downtime_id`)
) COMMENT 'Granular downtime records for each fab tool and chamber classified per SEMI E10 equipment state model (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled). Captures state transition timestamps, downtime reason code, responsible party (maintenance, engineering, facilities, scheduling), and impact on WIP lots. Feeds OEE (Overall Equipment Effectiveness) calculation and capacity planning models.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'System-generated unique identifier for each calibration record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Calibration records reference specific calibration materials (reference gases, calibration standards, reference wafers) tracked in the material master. ISO-certified semiconductor fabs require traceab',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab equipment that was calibrated.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Calibration in semiconductor equipment is often chamber-specific — e.g., calibrating the temperature setpoint, pressure setpoint, or gas flow rate of an individual chamber within a cluster tool. calib',
    `tertiary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Calibration records must reference the tool/instrument calibrated. Required for ISO 9001 traceability.',
    `calibration_interval_days` STRING COMMENT 'Planned interval in days between successive calibrations for this equipment.',
    `calibration_method` STRING COMMENT 'Technique used to perform the calibration.. Valid values are `sensor|reference|laser|electrical`',
    `calibration_record_status` STRING COMMENT 'Current processing status of the calibration record.. Valid values are `pending|completed|rejected|archived`',
    `calibration_report_url` STRING COMMENT 'Link to the detailed calibration report stored in the document repository.',
    `calibration_result_code` STRING COMMENT 'Standardized code representing the calibration outcome for downstream analytics.',
    `calibration_source_system` STRING COMMENT 'Name of the source system that generated the record (e.g., KLA ICOS, SmartFactory MES).',
    `calibration_standard` STRING COMMENT 'Reference standard used for calibration (e.g., NIST traceable, SEMI E30).',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration activity was performed.',
    `calibration_type` STRING COMMENT 'Method of calibration applied to the equipment.. Valid values are `in-situ|offline|periodic|initial|post-maintenance`',
    `comments` STRING COMMENT 'Additional remarks or observations captured by the technician.',
    `compliance_reference` STRING COMMENT 'Reference to the compliance clause (e.g., ISO 9001, IATF 16949) satisfied by this calibration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration record was first created in the system.',
    `location` STRING COMMENT 'Plant or fab line where the equipment resides (e.g., FAB1, LineA).',
    `lot_number` STRING COMMENT 'Identifier of the wafer lot associated with the calibration (if applicable).',
    `measured_value` DECIMAL(18,2) COMMENT 'Value recorded by the instrument during calibration.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measured value.',
    `measurement_unit` STRING COMMENT 'Unit of the measured and nominal values (e.g., nanometers, volts).. Valid values are `nm|um|mm|V|A|%`',
    `next_due_date` DATE COMMENT 'Date by which the next calibration must be performed.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target or nominal value that the equipment should meet.',
    `pass_fail_result` STRING COMMENT 'Pass/Fail outcome of the calibration activity.. Valid values are `pass|fail`',
    `technician_name` STRING COMMENT 'Full name of the calibration technician.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration record.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Calibration and metrology verification records for fab tools and measurement instruments. Tracks calibration type (in-situ, offline, periodic), calibration standard used, measured vs. nominal values, calibration pass/fail result, calibration interval, next due date, calibrating technician, and traceability to NIST or SEMI standards. Mandatory for ISO 9001 and IATF 16949 compliance. Sourced from KLA ICOS and SmartFactory MES calibration modules.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique surrogate key for each spare part record.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Spare parts must reference compatible tool types/models for PM planning and emergency repair part identification. This is a many-to-many but critical for operations.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Spare parts are procured items with a corresponding ERP material master record governing procurement, storage conditions, compliance (RoHS/REACH), and valuation. The denormalized material_number on sp',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Spare Parts Inventory Management: semiconductor fabs physically store MRO spare parts in tracked storage locations (cleanroom cabinets, bonded stores). Linking spare_part to inventory.storage_location',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: INVENTORY/RISK: Each spare part has a primary supplier for lead‑time, quality, and risk assessment reports.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations for the part.',
    `calibration_required_flag` BOOLEAN COMMENT 'True if the part must be calibrated periodically (e.g., sensors, metrology tools).',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of regulatory or industry certifications applicable to the part (e.g., RoHS, REACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the spare part record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business impact rating if the part is unavailable (high = production‑stop risk).. Valid values are `high|medium|low|none|unknown|reserved`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the unit cost.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `current_stock_qty` STRING COMMENT 'Number of units of the part currently available in the fab stockroom.',
    `spare_part_description` STRING COMMENT 'Detailed textual description of the part, including function and key specifications.',
    `disposal_method` STRING COMMENT 'Preferred method for disposing of excess or expired parts.. Valid values are `recycle|sell|destroy|return|donate|store`',
    `equipment_compatible` STRING COMMENT 'List of equipment models or tool families that can use this spare part.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous under safety regulations.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection activity.. Valid values are `passed|failed|pending|deferred|not_required|exempt`',
    `last_inspection_date` DATE COMMENT 'Date the part was most recently inspected for quality or safety compliance.',
    `last_received_date` DATE COMMENT 'Date the most recent shipment of this part was received into inventory.',
    `last_used_date` DATE COMMENT 'Date the part was last issued for equipment maintenance or repair.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to receipt of the part.',
    `lifecycle_end_date` DATE COMMENT 'Date the part was officially retired or marked obsolete.',
    `lifecycle_start_date` DATE COMMENT 'Date the part was first introduced into the inventory catalog.',
    `min_stock_level` STRING COMMENT 'Minimum quantity that must be on hand to avoid stock‑out situations.',
    `part_category` STRING COMMENT 'High‑level equipment domain the part supports. [ENUM-REF-CANDIDATE: lithography|deposition|etch|cmp|metrology|ate|assembly|test|other — 9 candidates stripped; promote to reference product]',
    `part_image_url` STRING COMMENT 'Link to a digital image or drawing of the spare part.',
    `part_name` STRING COMMENT 'Human‑readable name of the spare part used in inventory and work orders.',
    `part_number` STRING COMMENT 'Manufacturer‑assigned part number that uniquely identifies the component across suppliers.',
    `part_type` STRING COMMENT 'Classification of the part based on its usage and criticality to fab operations.. Valid values are `consumable|spare|critical|standard|optional|custom`',
    `part_volume_cm3` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of the part in cubic centimeters.',
    `part_weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of a single unit of the part in kilograms.',
    `reorder_point` STRING COMMENT 'Inventory quantity threshold that triggers a replenishment order.',
    `safety_stock_qty` STRING COMMENT 'Buffer quantity kept to protect against demand variability and supply delays.',
    `spare_part_status` STRING COMMENT 'Current lifecycle status of the part within the inventory system.. Valid values are `active|inactive|obsolete|pending|discontinued|reserved`',
    `storage_condition` STRING COMMENT 'Environmental condition required for safe storage of the part.. Valid values are `cleanroom|ambient|refrigerated|sealed|dry|controlled`',
    `supplier` STRING COMMENT 'Primary external supplier or vendor from which the part is sourced.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard purchase cost per individual unit of the part.',
    `updated_by` STRING COMMENT 'Identifier of the system user who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the spare part record.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the manufacturers warranty for the part expires.',
    `created_by` STRING COMMENT 'Identifier of the system user who created the record.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for spare parts and consumables inventory specific to fab tool maintenance, including critical spare parts (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), their OEM part numbers, compatible tool types, minimum stock levels, lead times, and storage location in the FAB stockroom. Supports PM planning and emergency repair readiness. Sourced from SAP S/4HANA MM module.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_triggering_maintenance_event_id` FOREIGN KEY (`tool_triggering_maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tertiary_fab_tool_id` FOREIGN KEY (`tertiary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Oem Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Tool Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Process Node Compatibility');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_value_regex' = '5nm|7nm|10nm|14nm|28nm|40nm');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|out_of_calibration|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_code` SET TAGS ('dbx_business_glossary_term' = 'Chamber Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_lifetime_hours` SET TAGS ('dbx_business_glossary_term' = 'Chamber Lifetime (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_name` SET TAGS ('dbx_business_glossary_term' = 'Chamber Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Current Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_business_glossary_term' = 'Chamber Type (e.g., Deposition, Etch, CVD, PVD, Metrology, Inspection)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_value_regex' = 'deposition|etch|cvd|pvd|metrology|inspection');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Chamber');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (sccm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location of Chamber');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number (SERIAL_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag (IS_CRITICAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (MAINT_LAST_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status (MAINT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'up_to_date|overdue');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MEAS_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'metrology|visual|electrical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (QUAL_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `oee_impact` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage (OEE_IMPACT_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (TECH_NODE)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result (QUAL_RESULT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Unit (QUAL_METRIC_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Value (QUAL_METRIC_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment (RISK_ASSESS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Tolerance (QUAL_TOLERANCE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VALID_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VALID_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Pm Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Required Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Part ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_value_regex' = 'day|week|month|wafer|run');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Interval Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Equipment Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `oee_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Estimate (%)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'PM Procedure Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Type (PM Type)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|wafer_count|run_count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Technician Skill Level Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|expert');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `scheduling_constraint` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraint');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `work_order_template_code` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Spare Part Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `baseline_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ISO9001|ITAR|EAR|RoHS|REACH|SOX');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `eco_reference` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Number (EVT_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Type (MTN_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|upgrade|modification');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `parts_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `performance_improvement_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Target');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `post_config_version` SET TAGS ('dbx_business_glossary_term' = 'Post‑Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `pre_config_version` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Configuration Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `repair_action_description` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_required` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Required');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RC_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|software|process|human_error|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Trigger Source (TRG_SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'scheduled_pm|alarm|operator_report|fdc_event|eco');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Type (UPG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_value_regex' = 'none|hardware|software|firmware');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Downtime Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_triggering_maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'productive|standby|engineering|scheduled|unscheduled|non_scheduled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `impact_wip_lot_count` SET TAGS ('dbx_business_glossary_term' = 'WIP Lot Impact Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'maintenance|engineering|facilities|scheduling|operator');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|material|human|environment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Downtime Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `state_after` SET TAGS ('dbx_business_glossary_term' = 'State After Downtime');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `state_before` SET TAGS ('dbx_business_glossary_term' = 'State Before Downtime');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Calibration Tool Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tertiary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'sensor|reference|laser|electrical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|archived');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_report_url` SET TAGS ('dbx_business_glossary_term' = 'Calibration Report URL');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_result_code` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Calibration Source System');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calibration Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'in-situ|offline|periodic|initial|post-maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Equipment Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Calibration Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|V|A|%');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Calibration Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|none|unknown|reserved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `current_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_description` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|sell|destroy|return|donate|store');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `equipment_compatible` SET TAGS ('dbx_business_glossary_term' = 'Compatible Equipment Types');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|deferred|not_required|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_image_url` SET TAGS ('dbx_business_glossary_term' = 'Part Image URL');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Number (OEM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'consumable|spare|critical|standard|optional|custom');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Part Volume (cm³)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `part_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Part Weight (kg)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending|discontinued|reserved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Condition');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'cleanroom|ambient|refrigerated|sealed|dry|controlled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
