-- Schema for Domain: equipment | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`equipment` COMMENT 'Semiconductor manufacturing equipment assets including lithography scanners, deposition systems, etchers, CMP tools, ATE platforms, and metrology/inspection systems. Manages equipment qualification, utilization, preventive/corrective maintenance schedules, calibration, and tool performance metrics supporting OEE.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` (
    `fab_tool_id` BIGINT COMMENT 'Primary key for fab_tool',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: CAPEX approval links each purchased tool to its request for audit and funding traceability.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Equipment certification management (ISO, safety) mandates a FK from fab tool to the certification record for auditability.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: CHIPS Act reporting ties each capital equipment purchase to a specific obligation record for domestic production compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for OEE and maintenance cost reporting per cost center; finance tracks tool expenses by cost center, obvious for budgeting.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export classification (ECCN) of a fab tool is required for export‑license determination and regulatory filing.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export Control process requires each fab tool to be linked to its export license for legal shipment and usage tracking.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: REQUIRED: Tool‑node compatibility matrix used in capacity planning and regulatory compliance reporting; linking each fab_tool to its supported technology_node is standard in semiconductor fabs.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Fixed‑asset register must reference each fab tool for depreciation schedules and asset audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Depreciation and expense posting need a GL account per tool; finance GL accounts are used in asset accounting reports.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: OEM supplier needed for purchase contracts and warranty compliance; experts track OEM supplier per tool.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis attributes tool usage to profit centers; required for product line margin calculations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset Management assigns a responsible engineer to each fab tool; required for ownership, accountability, and compliance reporting.',
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
    `equipment_fab_id` BIGINT COMMENT 'Identifier of the fab where the chamber is installed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Chamber operation schedule tracks the primary operator; needed for shift planning and OEE attribution.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the multi‑chamber tool that houses this chamber.',
    `process_integration_run_id` BIGINT COMMENT 'Foreign key linking to research.process_integration_run. Business justification: Process Integration Run includes chamber‑specific parameters; linking to tool chamber enables performance and maintenance impact tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: Chamber vendor is a supplier; linking enables vendor performance reporting and spare‑part sourcing.',
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
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Tool qualification reports must reference the specific design project they validate, required for the Design Qualification Management process.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (lithography scanner, deposition system, etc.) being qualified.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the tool that was qualified.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe used during qualification.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer responsible for the qualification.',
    `tool_qualified_by_employee_id` BIGINT COMMENT 'Unique identifier for the tool qualified by employee record within the tool qualification equipment entity.',
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
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) for which the tool is qualified.',
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
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — PM schedules must reference the tool they apply to. This drives work order generation and maintenance planning.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the pm schedule equipment entity.',
    `pm_employee_id` BIGINT COMMENT 'User identifier of the person who created the schedule record.',
    `primary_pm_fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool or chamber to which the schedule applies.',
    `spare_part_id` BIGINT COMMENT 'Identifier of the spare part that must be available for the maintenance.',
    `reference_pm_fab_tool_id` BIGINT COMMENT 'Unique identifier for the reference pm fab tool record within the pm schedule equipment entity.',
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
    `fab_tool_id` BIGINT COMMENT 'Unique identifier for the to fab tool record within the maintenance event equipment entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary technician who performed the work.',
    `maintenance_plan_id` BIGINT COMMENT 'Identifier of the scheduled maintenance plan governing this event.',
    `maintenance_technician_employee_id` BIGINT COMMENT 'Unique identifier for the maintenance technician employee record within the maintenance event equipment entity.',
    `pm_schedule_id` BIGINT COMMENT 'FK to equipment.pm_schedule.pm_schedule_id — Scheduled PM events must link back to the PM schedule that triggered them, enabling PM compliance tracking.',
    `primary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Every maintenance event must reference the tool serviced. Core operational FK for maintenance history and MTTR calculation.',
    `spare_part_id` BIGINT COMMENT 'FK to equipment.spare_part.spare_part_id — Maintenance events consume spare parts. This link enables parts consumption tracking and inventory depletion.',
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
    `maintenance_event_id` BIGINT COMMENT 'FK to equipment.maintenance_event.maintenance_event_id — Downtime events caused by maintenance must link to the maintenance event for root cause tracing and planned vs unplanned analysis.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab tool or chamber that experienced the downtime.',
    `primary_tool_maintenance_event_id` BIGINT COMMENT 'Reference to the maintenance work order associated with the downtime, if any.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator on duty when the downtime was reported.',
    `tool_reported_by_employee_id` BIGINT COMMENT 'Unique identifier for the tool reported by employee record within the tool downtime equipment entity.',
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
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated reduction in Overall Equipment Effectiveness caused by the downtime, expressed as a percentage.',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the calibration calibrated by employee record within the calibration record equipment entity.',
    `calibration_employee_id` BIGINT COMMENT 'Unique identifier of the technician who performed the calibration.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Calibration records must reference the tool or instrument being calibrated. Required for ISO 9001 traceability.',
    `calibration_technician_employee_id` BIGINT COMMENT 'Unique identifier for the calibration technician employee record within the calibration record equipment entity.',
    `primary_calibration_fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab equipment that was calibrated.',
    `tertiary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Calibration records must reference the tool/instrument calibrated. Required for ISO 9001 traceability.',
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber record within the calibration record equipment entity.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` (
    `tool_alarm_id` BIGINT COMMENT 'Unique surrogate key for each alarm event generated by semiconductor manufacturing equipment.',
    `maintenance_event_id` BIGINT COMMENT 'Identifier of the maintenance work order or corrective action triggered by the alarm, if any.',
    `fab_tool_id` BIGINT COMMENT 'Surrogate key of the equipment (e.g., lithography scanner, CMP tool) that generated the alarm.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the tool acknowledged by employee record within the tool alarm equipment entity.',
    `tool_chamber_id` BIGINT COMMENT 'FK to equipment.tool_chamber.tool_chamber_id — Chamber-level alarm sourcing is critical for multi-chamber tools where one chamber may fault while others continue.',
    `tool_employee_id` BIGINT COMMENT 'Surrogate key of the operator who acknowledged or acted on the alarm.',
    `acknowledged_flag` BOOLEAN COMMENT 'The acknowledged flag of the tool alarm record in the equipment domain.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The acknowledged timestamp of the tool alarm record in the equipment domain.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when an operator or system acknowledged the alarm.',
    `alarm_category` STRING COMMENT 'High‑level classification of the alarm type for reporting and analytics.. Valid values are `process|equipment|environment|safety`',
    `alarm_code` STRING COMMENT 'Standardized code representing the specific alarm condition as defined by the equipment vendor.',
    `alarm_description` STRING COMMENT 'The alarm description of the tool alarm record in the equipment domain.',
    `alarm_duration_seconds` STRING COMMENT 'Elapsed time in seconds from alarm onset to clearance.',
    `alarm_group` STRING COMMENT 'Logical grouping identifier for related alarms (e.g., temperature excursions, pressure drops).',
    `alarm_message` STRING COMMENT 'Human‑readable description of the alarm condition provided by the equipment.',
    `alarm_origin` STRING COMMENT 'Indicates whether the alarm was generated automatically by the tool or manually triggered.. Valid values are `automatic|manual`',
    `alarm_priority` STRING COMMENT 'Numeric priority assigned to the alarm for routing and escalation (higher = more urgent).',
    `alarm_severity` STRING COMMENT 'Severity level of the alarm indicating impact on production (critical, major, minor, warning, info).. Valid values are `critical|major|minor|warning|info`',
    `alarm_source` STRING COMMENT 'Logical source within the tool that raised the alarm (e.g., chamber, subsystem, sensor, control system).. Valid values are `chamber|subsystem|sensor|control_system`',
    `alarm_status` STRING COMMENT 'Current lifecycle state of the alarm event.. Valid values are `active|acknowledged|cleared|escalated`',
    `alarm_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm condition was first detected on the tool.',
    `alarm_type` STRING COMMENT 'The alarm type of the tool alarm record in the equipment domain.',
    `clearance_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm condition was cleared or resolved.',
    `cleared_timestamp` TIMESTAMP COMMENT 'The cleared timestamp of the tool alarm record in the equipment domain.',
    `corrective_action` STRING COMMENT 'Planned or executed corrective action taken to resolve the alarm condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alarm record was first inserted into the lakehouse.',
    `tool_alarm_description` STRING COMMENT 'The description of the tool alarm record in the equipment domain.',
    `equipment_location` STRING COMMENT 'Plant or fab line location where the equipment resides (e.g., FAB1_LINEA).',
    `equipment_type` STRING COMMENT 'Category of the equipment (e.g., lithography_scanner, etcher, CMP_tool).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool alarm record in the equipment domain.',
    `oee_impact_flag` BOOLEAN COMMENT 'Indicates whether the alarm had a measurable impact on Overall Equipment Effectiveness.',
    `predicted_failure_flag` BOOLEAN COMMENT 'True if the alarm is identified by predictive models as a precursor to equipment failure.',
    `repeat_count` STRING COMMENT 'Number of times the same alarm code has recurred within a defined time window.',
    `resolution_notes` STRING COMMENT 'The resolution notes of the tool alarm record in the equipment domain.',
    `root_cause` STRING COMMENT 'Textual description of the underlying cause determined after investigation.',
    `sensor_value` DECIMAL(18,2) COMMENT 'The sensor value of the tool alarm record in the equipment domain.',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the quantitative severity of the alarm as calculated by vendor logic.',
    `shift` STRING COMMENT 'Shift during which the alarm occurred (e.g., A, B, C, D).. Valid values are `A|B|C|D`',
    `source_module` STRING COMMENT 'Name of the source system or module that supplied the alarm (e.g., MES, KLA ICOS, Camstar).',
    `triggered_timestamp` TIMESTAMP COMMENT 'The triggered timestamp of the tool alarm record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alarm record.',
    CONSTRAINT pk_tool_alarm PRIMARY KEY(`tool_alarm_id`)
) COMMENT 'Real-time and historical alarm events generated by fab tools and process equipment. Captures alarm ID, alarm code, alarm severity (critical, major, minor, warning), alarm source (chamber, subsystem, sensor), alarm message text, onset timestamp, acknowledgment timestamp, clearance timestamp, and associated maintenance event if escalated. Feeds fault detection and classification (FDC) workflows and predictive maintenance models.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` (
    `equipment_process_recipe_id` BIGINT COMMENT 'Unique identifier for the equipment process recipe record.',
    `change_notification_id` BIGINT COMMENT 'Identifier of the change request that introduced or modified this recipe version.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Process recipes are classified under ECCN codes; linking enables recipe‑level export control compliance checks.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the equipment approved by employee record within the equipment process recipe equipment entity.',
    `equipment_employee_id` BIGINT COMMENT 'Identifier of the operator or system that last executed the recipe.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Recipes must reference compatible tool types. Required for MES dispatching - lots can only be dispatched to tools with qualified recipes.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the equipment process recipe equipment entity.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Each process recipe is defined for a specific PDK version; needed for the Recipe Management report linking recipes to PDKs.',
    `primary_equipment_fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is owned by a specific fab tool; adding fab_tool_id enables direct navigation and removes redundant attributes that can be derived from the fab_tool record.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific equipment chamber where the recipe is executed.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Cross-domain FK to authoritative SSOT owner fabrication.fabrication_process_recipe (resolves MVM SSOT duplicate).',
    `approval_date` DATE COMMENT 'The approval date associated with the equipment process recipe equipment record.',
    `approval_status` STRING COMMENT 'Current approval state of the recipe within the change control process.. Valid values are `draft|pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'The approved by of the equipment process recipe record in the equipment domain.',
    `audit_status` STRING COMMENT 'Result of the latest audit (passed, failed, pending).. Valid values are `passed|failed|pending`',
    `authoritative_fabrication_process_recipe_id` BIGINT COMMENT 'Authoritative single-source-of-truth reference to owning entity fabrication.fabrication_process_recipe resolving the cross-domain SSOT duplicate with fabrication.equipment_process_recipe.',
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
    `process_node_target` STRING COMMENT 'Technology node the recipe is intended for (e.g., 7nm, 5nm).',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` (
    `recipe_execution_id` BIGINT COMMENT 'Unique system-generated identifier for each recipe execution event.',
    `equipment_process_recipe_id` BIGINT COMMENT 'FK to equipment.equipment_process_recipe.equipment_process_recipe_id — Each recipe execution must reference the recipe version used. Core traceability for yield correlation and process control.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Recipe executions must reference the tool where processing occurred for tool-specific performance analysis.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot that was processed in this execution.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Recipe execution on a wafer lot must be tied to the design project it produces, used in the Production Tracking dashboard.',
    `employee_id` BIGINT COMMENT 'Identifier of the human operator who initiated or supervised the execution.',
    `primary_recipe_fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool (e.g., lithography scanner, deposition system) where the recipe was executed.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe definition used for this execution.',
    `recipe_operator_employee_id` BIGINT COMMENT 'Unique identifier for the recipe operator employee record within the recipe execution equipment entity.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module inside the tool used for the execution.',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the individual wafer within the lot (e.g., Wafer 001).',
    `actual_duration_seconds` STRING COMMENT 'The actual duration seconds of the recipe execution record in the equipment domain.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the lot run.',
    `compliance_status` STRING COMMENT 'Indicates whether the execution met all applicable process compliance rules.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the recipe execution record in the equipment domain.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time of the execution in seconds (derived from start and end timestamps).',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the recipe execution completed or was terminated.',
    `equipment_type` STRING COMMENT 'Category of equipment (e.g., Lithography, CVD, Etcher).',
    `execution_result` STRING COMMENT 'The execution result of the recipe execution record in the equipment domain.',
    `execution_status` STRING COMMENT 'Outcome of the recipe execution: pass, fail, or abort.. Valid values are `pass|fail|abort`',
    `gas_flow_actual_sccm` DECIMAL(18,2) COMMENT 'Measured gas flow rate during the run.',
    `gas_flow_setpoint_sccm` DECIMAL(18,2) COMMENT 'Target gas flow rate in standard cubic centimeters per minute.',
    `is_calibrated` BOOLEAN COMMENT 'True if the tool was calibrated immediately before execution; otherwise false.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the execution is for a critical process step (true) or not (false).',
    `lot_number` STRING COMMENT 'The lot number of the recipe execution record in the equipment domain.',
    `measured_parameters` STRING COMMENT 'The measured parameters of the recipe execution record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the recipe execution record in the equipment domain.',
    `notes` STRING COMMENT 'Free‑form text field for operator comments or observations.',
    `oee_availability_percent` DECIMAL(18,2) COMMENT 'Availability component of Overall Equipment Effectiveness for this execution.',
    `oee_performance_percent` DECIMAL(18,2) COMMENT 'Performance component of Overall Equipment Effectiveness for this execution.',
    `oee_quality_percent` DECIMAL(18,2) COMMENT 'Quality component of Overall Equipment Effectiveness for this execution.',
    `power_actual_w` DECIMAL(18,2) COMMENT 'Measured power delivered during execution.',
    `power_setpoint_w` DECIMAL(18,2) COMMENT 'Target power level for plasma or laser processes, in watts.',
    `pressure_actual_pa` DECIMAL(18,2) COMMENT 'Measured chamber pressure during execution.',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target chamber pressure for the recipe, in pascals.',
    `process_step` STRING COMMENT 'Logical name of the process step within the overall flow (e.g., Etch, Deposition).',
    `recipe_version` STRING COMMENT 'Version string of the recipe (e.g., v3.2.1) applied during the run.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this execution record.',
    `result_code` STRING COMMENT 'Machine‑generated code providing detailed reason for pass/fail/abort.',
    `result_disposition` STRING COMMENT 'The result disposition of the recipe execution record in the equipment domain.',
    `run_number` STRING COMMENT 'Sequential number of the execution within the batch.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the recipe execution started.',
    `temperature_actual_c` DECIMAL(18,2) COMMENT 'Measured temperature achieved during execution.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature for the process step, in degrees Celsius.',
    `time_actual_sec` DECIMAL(18,2) COMMENT 'Measured duration the step actually ran.',
    `time_setpoint_sec` DECIMAL(18,2) COMMENT 'Target duration for the process step, in seconds.',
    `wafer_count` STRING COMMENT 'The wafer count of the recipe execution record in the equipment domain.',
    CONSTRAINT pk_recipe_execution PRIMARY KEY(`recipe_execution_id`)
) COMMENT 'Transactional record of each process recipe execution on a fab tool or chamber, linking a specific wafer lot run to the recipe version used, actual process parameter values recorded (as-run vs. as-set), execution start/end timestamps, operator ID, and pass/fail outcome. Enables recipe-to-yield correlation analysis and supports SPC control chart population. Sourced from SmartFactory MES and Camstar lot history.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` (
    `spc_control_id` BIGINT COMMENT 'Primary key for spc_control',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab tool (e.g., lithography scanner, etcher) where the violation occurred.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot being processed when the SPC event was recorded.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: SPC violations are tracked per design project to analyze yield, needed for the Yield Improvement analysis.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the spc control equipment entity.',
    `primary_spc_employee_id` BIGINT COMMENT 'Identifier of the operator who acknowledged or entered the violation.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe applied to the lot at the time of the violation.',
    `spc_chart_id` BIGINT COMMENT 'Identifier of the SPC control chart configuration associated with this violation.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the tool that generated the out‑of‑control signal.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation was analyzed for root cause.',
    `batch_number` STRING COMMENT 'Identifier of the wafer batch associated with the violation.',
    `center_line` DECIMAL(18,2) COMMENT 'The center line of the spc control record in the equipment domain.',
    `chart_type` STRING COMMENT 'Statistical chart type used for monitoring (X‑Bar/R, EWMA, or CUSUM).. Valid values are `xbar_r|ewma|cusum`',
    `compliance_flag` BOOLEAN COMMENT 'True if the violation triggers a regulatory or internal compliance requirement.',
    `control_chart_type` STRING COMMENT 'The control chart type of the spc control record in the equipment domain.',
    `control_code` STRING COMMENT 'Coded value representing the control code of the spc control equipment record.',
    `control_limit_lcl_at_time` DECIMAL(18,2) COMMENT 'Lower control limit value that was in effect at the moment of detection.',
    `control_limit_ucl_at_time` DECIMAL(18,2) COMMENT 'Upper control limit value that was in effect at the moment of detection.',
    `control_parameter` STRING COMMENT 'The control parameter of the spc control record in the equipment domain.',
    `control_status` STRING COMMENT 'The control status of the spc control record in the equipment domain.',
    `corrective_action_reference` STRING COMMENT 'Reference code or document identifier for the corrective action plan.',
    `cpk_value` DECIMAL(18,2) COMMENT 'The cpk value of the spc control record in the equipment domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `data_source` STRING COMMENT 'System that supplied the measurement data.. Valid values are `MES|ICOS|custom`',
    `detection_timestamp` TIMESTAMP COMMENT 'Duplicate of event_timestamp for legacy reporting compatibility.',
    `disposition_action` STRING COMMENT 'Immediate action taken in response to the violation.. Valid values are `lot_hold|tool_quarantine|false_alarm|investigate`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the SPC violation was detected on the fab floor.',
    `is_false_alarm` BOOLEAN COMMENT 'Flag indicating whether the violation was later determined to be a false alarm.',
    `is_repeat_violation` BOOLEAN COMMENT 'Indicates if this violation is a repeat occurrence within a defined time window.',
    `lcl` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the monitored parameter at the time of chart configuration.',
    `lcl_value` DECIMAL(18,2) COMMENT 'The lcl value of the spc control record in the equipment domain.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower control limit of the spc control record in the equipment domain.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'The lower spec limit of the spc control record in the equipment domain.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value that triggered the SPC violation.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the monitored parameter (e.g., nm, µm, sec).',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the spc control record in the equipment domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the operator or analyst.',
    `parameter_name` STRING COMMENT 'Name of the process parameter (e.g., film thickness, critical dimension) that is being controlled.',
    `process_step` STRING COMMENT 'Name of the fab process step (e.g., etch, deposition, CMP) during which the violation occurred.',
    `regulatory_reported` BOOLEAN COMMENT 'Indicates whether the violation has been reported to a regulatory body (e.g., SEMI, ISO).',
    `remediation_deadline` DATE COMMENT 'Target date by which corrective actions must be completed.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort.. Valid values are `pending|completed|deferred`',
    `root_cause` STRING COMMENT 'Narrative description of the identified root cause for the violation.',
    `rule_set` STRING COMMENT 'Specific Western Electric rule(s) that were violated.. Valid values are `rule1|rule2|rule3|rule4|rule5|rule6`',
    `sampling_frequency` STRING COMMENT 'How often samples are taken for the monitored parameter.. Valid values are `per_shift|per_hour|per_lot`',
    `severity_level` STRING COMMENT 'Business‑defined severity rating of the SPC breach.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Shift during which the violation occurred.. Valid values are `day|swing|night`',
    `spc_control_status` STRING COMMENT 'Current lifecycle status of the violation record.. Valid values are `open|closed|investigating|resolved`',
    `spc_status` STRING COMMENT 'The spc status of the spc control record in the equipment domain.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired target value for the monitored parameter.',
    `trend_direction` STRING COMMENT 'Direction of the observed trend when a trend rule is violated.. Valid values are `up|down|stable`',
    `ucl` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the monitored parameter at the time of chart configuration.',
    `ucl_value` DECIMAL(18,2) COMMENT 'The ucl value of the spc control record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper control limit of the spc control record in the equipment domain.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'The upper spec limit of the spc control record in the equipment domain.',
    `violation_type` STRING COMMENT 'Classification of the out‑of‑control condition (UCL breach, LCL breach, run‑rule, trend, or outlier).. Valid values are `ucl_breach|lcl_breach|run_rule|trend|outlier`',
    CONSTRAINT pk_spc_control PRIMARY KEY(`spc_control_id`)
) COMMENT 'Statistical Process Control (SPC) monitoring configuration and violation records for fab tool process parameters. Defines control chart setup (chart type: Xbar-R, EWMA, CUSUM; monitored parameter; UCL/LCL/target values; sampling frequency; Western Electric response rules) and captures out-of-control signals. Violation records include violation type (UCL breach, LCL breach, run rule violation, trend), measured value, control limits at time of violation, detection timestamp, affected tool and chamber, associated wafer lot, disposition action (lot hold, tool quarantine, false alarm), and corrective action reference. SSOT for all SPC chart configuration and process excursion management in the FAB. Sourced from SmartFactory MES SPC module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` (
    `oee_record_id` BIGINT COMMENT 'Unique surrogate key for each OEE measurement record.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier for the to fab tool record within the oee record equipment entity.',
    `primary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — OEE records must reference the measured tool. This is the fundamental relationship for equipment productivity reporting.',
    `availability_percent` DECIMAL(18,2) COMMENT 'The availability percent of the oee record record in the equipment domain.',
    `availability_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled time the equipment was available for production.',
    `available_hours` DECIMAL(18,2) COMMENT 'Total scheduled time the equipment was available for production.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the OEE measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OEE record was first inserted into the data lake.',
    `downtime_category` STRING COMMENT 'High‑level classification of downtime type.. Valid values are `planned|unplanned|maintenance|setup|breakdown|other`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'The downtime hours of the oee record record in the equipment domain.',
    `downtime_minutes` STRING COMMENT 'The downtime minutes of the oee record record in the equipment domain.',
    `downtime_reason_code` STRING COMMENT 'Standard code describing the root cause of downtime.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory cost allocation requires linking each spare part to the cost center that budgets its purchase.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Spare parts must reference compatible tool types/models for PM planning and emergency repair part identification. This is a many-to-many but critical for operations.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location record within the spare part equipment entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: INVENTORY/RISK: Each spare part has a primary supplier for lead‑time, quality, and risk assessment reports.',
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
    `equipment_compatible` STRING COMMENT 'List of equipment models or tool families that can use this spare part.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` (
    `metrology_run_id` BIGINT COMMENT 'Unique surrogate key for each metrology run record.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Metrology runs must reference the metrology tool used for tool-specific measurement bias tracking and calibration correlation.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Lot identifier of the wafer(s) measured in this run.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Metrology measurements are associated with a design project for CD verification, required by the Design Quality Assurance report.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician who initiated the run.',
    `metrology_operator_employee_id` BIGINT COMMENT 'Unique identifier for the metrology operator employee record within the metrology run equipment entity.',
    `primary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Metrology runs must reference the metrology tool that performed the measurement. Required for tool-to-tool matching and measurement system analysis.',
    `recipe_id` BIGINT COMMENT 'Identifier of the measurement recipe used for this run.',
    `equipment_site_map_id` BIGINT COMMENT 'Reference to the site‑map layout used for site‑specific measurements.',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the individual wafer within the lot.',
    `calibration_status` STRING COMMENT 'Current calibration state of the metrology tool at run time.. Valid values are `calibrated|uncalibrated|pending`',
    `comments` STRING COMMENT 'Free‑form notes entered by the operator or engineer.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the run record was first created in the data lake.',
    `data_source` STRING COMMENT 'System that supplied the metrology data.. Valid values are `KLA_ICOS|SmartFactory_MES`',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the metrology run record in the equipment domain.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity inside the tool during the run (%).',
    `lot_number` STRING COMMENT 'The lot number of the metrology run record in the equipment domain.',
    `lot_type` STRING COMMENT 'Classification of the wafer lot for the run.. Valid values are `prototype|volume|engineering`',
    `mean_value` DECIMAL(18,2) COMMENT 'Statistical mean of the measured values across all sites.',
    `measured_mean` DECIMAL(18,2) COMMENT 'The measured mean of the metrology run record in the equipment domain.',
    `measured_sigma` DECIMAL(18,2) COMMENT 'The measured sigma of the metrology run record in the equipment domain.',
    `measured_value` DECIMAL(18,2) COMMENT 'Raw measurement value recorded for the primary parameter.',
    `measurement_count` STRING COMMENT 'The measurement count of the metrology run record in the equipment domain.',
    `measurement_mode` STRING COMMENT 'Indicates whether the measurement was performed inline with production or offline.. Valid values are `inline|offline`',
    `measurement_type` STRING COMMENT 'Category of the physical parameter measured during the run.. Valid values are `cd|film_thickness|overlay|defect_density|refractive_index|resist_thickness`',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the measurement type.. Valid values are `nm|um|percent|mm|ps|GHz`',
    `metrology_run_status` STRING COMMENT 'Current lifecycle state of the run.. Valid values are `planned|running|completed|failed|cancelled`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the metrology run record in the equipment domain.',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE for the tool during the run, expressed as a percentage.',
    `pass_fail` STRING COMMENT 'Overall pass/fail result of the run against spec limits.. Valid values are `pass|fail`',
    `run_duration_seconds` STRING COMMENT 'Total elapsed time of the metrology run in seconds.',
    `run_number` STRING COMMENT 'Human‑readable identifier assigned to the metrology run, e.g., MR000123.. Valid values are `^MR[0-9]{6}$`',
    `run_status` STRING COMMENT 'The run status of the metrology run record in the equipment domain.',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the metrology run was executed on the tool.',
    `shift` STRING COMMENT 'Work shift during which the run was performed.. Valid values are `day|swing|night`',
    `sigma_value` DECIMAL(18,2) COMMENT 'Sigma (3‑sigma) statistic derived from mean and standard deviation.',
    `spec_limit_high` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable specification window for the measurement.',
    `spec_limit_low` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable specification window for the measurement.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the metrology run record in the equipment domain.',
    `std_dev` DECIMAL(18,2) COMMENT 'Standard deviation of the measured values across all sites.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature of the tool chamber during the run (°C).',
    `tool_name` STRING COMMENT 'Descriptive name of the metrology tool (e.g., KLA‑ICOS CD‑SEM 1234).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the run record.',
    CONSTRAINT pk_metrology_run PRIMARY KEY(`metrology_run_id`)
) COMMENT 'Metrology and inspection run records capturing in-line and off-line measurement results from metrology tools (CD-SEM, OCD, ellipsometer, profilometer) and inspection systems (KLA ICOS, brightfield/darkfield inspection). Records measurement recipe, wafer lot and site map, measured parameter (CD, film thickness, overlay, defect density), measured values per site, mean/3-sigma statistics, and pass/fail disposition against spec limits. SSOT for process control metrology data. Sourced from KLA ICOS and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` (
    `tool_warranty_id` BIGINT COMMENT 'System‑generated unique identifier for each tool warranty record.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule linked to this warranty.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool covered by this warranty.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record within the tool warranty equipment entity.',
    `claim_history_count` STRING COMMENT 'Total number of warranty claims filed under this warranty.',
    `coverage_description` STRING COMMENT 'The coverage description of the tool warranty record in the equipment domain.',
    `coverage_scope` STRING COMMENT 'The coverage scope of the tool warranty record in the equipment domain.',
    `coverage_terms` STRING COMMENT 'The coverage terms of the tool warranty record in the equipment domain.',
    `coverage_type` STRING COMMENT 'Classifies the warranty as OEM, third‑party, or extended coverage.. Valid values are `OEM|ThirdParty|Extended`',
    `covered_failure_modes` STRING COMMENT 'List or description of failure modes that are covered under the warranty.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the warranty cost.',
    `effective_from` DATE COMMENT 'Date when the warranty coverage becomes effective.',
    `effective_until` DATE COMMENT 'Date when the warranty coverage ends (null for open‑ended contracts).',
    `end_date` DATE COMMENT 'The end date associated with the tool warranty equipment record.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the person to contact for warranty escalation.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the tool warranty equipment record.',
    `extended_warranty_flag` BOOLEAN COMMENT 'Indicates whether the warranty is an extended (post‑OEM) warranty.',
    `last_claim_date` DATE COMMENT 'Date of the most recent warranty claim.',
    `last_claim_status` STRING COMMENT 'Current status of the most recent warranty claim.. Valid values are `open|closed|rejected|approved`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the warranty agreement.. Valid values are `active|inactive|expired|pending|terminated`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool warranty record in the equipment domain.',
    `oem_provider` STRING COMMENT 'Name of the original equipment manufacturer that issued the warranty.',
    `part_number` STRING COMMENT 'Part number of the equipment model covered by the warranty.',
    `response_time_sla_hours` STRING COMMENT 'Maximum response time in hours promised by the service provider for warranty incidents.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the equipment.',
    `service_provider` STRING COMMENT 'Name of the third‑party service organization responsible for warranty service.',
    `start_date` DATE COMMENT 'The start date associated with the tool warranty equipment record.',
    `terms_and_conditions` STRING COMMENT 'The terms and conditions of the tool warranty record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warranty record.',
    `warranty_contract_number` STRING COMMENT 'External contract number assigned by the OEM or service provider.',
    `warranty_cost` DECIMAL(18,2) COMMENT 'Monetary amount paid for the warranty agreement.',
    `warranty_number` STRING COMMENT 'The warranty number of the tool warranty record in the equipment domain.',
    `warranty_status` STRING COMMENT 'The warranty status of the tool warranty record in the equipment domain.',
    `warranty_terms_description` STRING COMMENT 'Free‑text description of the warranty terms and conditions.',
    `warranty_type` STRING COMMENT 'Indicates whether the warranty covers parts, labor, or full equipment.. Valid values are `parts|labor|full`',
    `warranty_value_usd` DECIMAL(18,2) COMMENT 'The warranty value usd of the tool warranty record in the equipment domain.',
    CONSTRAINT pk_tool_warranty PRIMARY KEY(`tool_warranty_id`)
) COMMENT 'Warranty and service contract records for fab tools covering OEM warranty terms, extended warranty agreements, and third-party service contracts. Captures warranty type (parts, labor, full coverage), coverage start/end dates, OEM service provider, covered failure modes, response time SLAs, escalation contacts, and warranty claim history. Supports maintenance cost management and make-vs-buy decisions for repair. Sourced from SAP S/4HANA contract management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` (
    `tool_installation_id` BIGINT COMMENT 'Unique identifier for each tool installation record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Installation compliance certifications (safety, environmental) are tracked per installation project for regulatory reporting.',
    `equipment_fab_id` BIGINT COMMENT 'Unique identifier for the fab record within the tool installation equipment entity.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the semiconductor tool being installed.',
    `employee_id` BIGINT COMMENT 'Name of the lead engineer or OEM field specialist responsible for the installation.',
    `tool_installed_by_employee_id` BIGINT COMMENT 'Unique identifier for the tool installed by employee record within the tool installation equipment entity.',
    `tool_installer_employee_id` BIGINT COMMENT 'Unique identifier for the tool installer employee record within the tool installation equipment entity.',
    `tool_project_manager_employee_id` BIGINT COMMENT 'Unique identifier for the tool project manager employee record within the tool installation equipment entity.',
    `acceptance_date` DATE COMMENT 'The acceptance date associated with the tool installation equipment record.',
    `acceptance_signoff_by` STRING COMMENT 'Name of the person (e.g., fab manager) who signed off the installation.',
    `acceptance_signoff_date` DATE COMMENT 'Date when the final acceptance sign‑off was recorded.',
    `actual_start_date` DATE COMMENT 'The actual start date associated with the tool installation equipment record.',
    `capital_expenditure_amount` DECIMAL(18,2) COMMENT 'Capital cost incurred for the tool installation.',
    `commissioning_date` DATE COMMENT 'The commissioning date associated with the tool installation equipment record.',
    `completion_date` DATE COMMENT 'The completion date associated with the tool installation equipment record.',
    `compliance_certifications` STRING COMMENT 'List of certifications (e.g., ISO, SEMI) applicable to the installed tool.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the installation expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the installation record was created in the system.',
    `delivery_date` DATE COMMENT 'Date the tool was delivered to the fab site.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation of the installed asset ends.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the installed asset begins.',
    `fab_bay` STRING COMMENT 'Specific bay or cleanroom area where the tool resides.',
    `fab_building` STRING COMMENT 'Building identifier within the fab site.',
    `fab_floor` STRING COMMENT 'Floor level of the installation location.',
    `fab_site_code` STRING COMMENT 'Code of the fabrication site where the tool is installed.',
    `hookup_status` STRING COMMENT 'The hookup status of the tool installation record in the equipment domain.',
    `installation_code` STRING COMMENT 'Business code or number assigned to the installation for tracking in ERP/MES.',
    `installation_cost` DECIMAL(18,2) COMMENT 'The installation cost of the tool installation record in the equipment domain.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'The installation cost usd of the tool installation record in the equipment domain.',
    `installation_date` DATE COMMENT 'The installation date associated with the tool installation equipment record.',
    `installation_end_date` DATE COMMENT 'Planned or actual completion date of the installation work.',
    `installation_location` STRING COMMENT 'The installation location of the tool installation record in the equipment domain.',
    `installation_name` STRING COMMENT 'Human‑readable name for the installation event (e.g., "Fab A Lithography Scanner Install").',
    `installation_number` STRING COMMENT 'The installation number of the tool installation record in the equipment domain.',
    `installation_project_reference` STRING COMMENT 'Reference number or code of the project governing the installation.',
    `installation_start_date` DATE COMMENT 'Planned or actual start date of the installation work.',
    `installation_status` STRING COMMENT 'Current lifecycle state of the installation.. Valid values are `planned|in_progress|completed|failed|cancelled`',
    `installation_type` STRING COMMENT 'Category of the installation activity.. Valid values are `new|relocation|upgrade|decommission`',
    `measurement_capacity_wafer_per_hour` DECIMAL(18,2) COMMENT 'Rated processing capacity of the tool after installation.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool installation record in the equipment domain.',
    `new_fab_site_code` STRING COMMENT 'Site code of the fab where the tool is now installed after relocation.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured during installation.',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE percentage for the tool post‑installation.',
    `planned_start_date` DATE COMMENT 'The planned start date associated with the tool installation equipment record.',
    `previous_fab_site_code` STRING COMMENT 'Site code of the fab where the tool was previously located.',
    `qualification_completion_date` DATE COMMENT 'The qualification completion date associated with the tool installation equipment record.',
    `record_status` STRING COMMENT 'Administrative status of the record for data‑governance purposes.. Valid values are `active|inactive|archived`',
    `regulatory_status` STRING COMMENT 'Current regulatory compliance status of the installation.. Valid values are `compliant|non_compliant|pending`',
    `relocation_date` DATE COMMENT 'Date when the tool relocation was executed.',
    `relocation_reason` STRING COMMENT 'Business reason for moving the tool to a new location.. Valid values are `capacity_rebalancing|fab_consolidation|technology_transfer|other`',
    `requalification_required` BOOLEAN COMMENT 'Indicates whether the tool must undergo re‑qualification after installation.',
    `sat_report_number` STRING COMMENT 'Reference number of the Site Acceptance Test report.',
    `sign_off_status` STRING COMMENT 'The sign off status of the tool installation record in the equipment domain.',
    `site_acceptance_test_result` STRING COMMENT 'Result of the SAT protocol after installation.. Valid values are `pass|fail|partial`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the installation record.',
    `utility_exhaust_hookup_completed_date` DATE COMMENT 'Date when exhaust/ventilation hookup was completed.',
    `utility_gas_hookup_completed_date` DATE COMMENT 'Date when process gas hookup (e.g., N2, Ar) was completed.',
    `utility_power_hookup_completed_date` DATE COMMENT 'Date when electrical power hookup was completed.',
    `utility_vacuum_hookup_completed_date` DATE COMMENT 'Date when vacuum system hookup was completed.',
    `utility_water_hookup_completed_date` DATE COMMENT 'Date when de‑ionized water hookup was completed.',
    `warranty_expiration_date` DATE COMMENT 'Date when the tools warranty expires after installation.',
    CONSTRAINT pk_tool_installation PRIMARY KEY(`tool_installation_id`)
) COMMENT 'Installation, commissioning, relocation, and site acceptance records for fab tools covering the full physical placement lifecycle. Captures initial delivery, installation project reference, delivery date, source and destination FAB location (bay, building, facility), installation start/end dates, installation team (OEM field engineers, FAB facilities), utility hookup completion (power, gases, DI water, exhaust, vacuum), relocation events (reason: capacity rebalancing, fab consolidation, technology transfer; move dates; decommission/recommission steps), site acceptance testing (SAT) protocol results, re-qualification requirements triggered, and final acceptance sign-off. SSOT for tool physical placement lifecycle, asset location history, and relocation tracking. Sourced from SAP S/4HANA Fixed Assets and SmartFactory MES.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` (
    `fdc_event_id` BIGINT COMMENT 'System-generated unique identifier for each fault detection and classification event.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer who reviewed or acted on the fault.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — FDC events must reference the affected tool for fault containment and engineer notification routing.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot being processed when the fault occurred.',
    `tool_chamber_id` BIGINT COMMENT 'FK to equipment.tool_chamber.tool_chamber_id — FDC events are often chamber-specific. Chamber-level fault detection is standard in multi-chamber tools.',
    `maintenance_event_id` BIGINT COMMENT 'Identifier of the maintenance order created as a result of the fault.',
    `primary_fdc_fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool that generated the fault event.',
    `primary_fdc_tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the tool where the fault originated.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe active on the tool at the time of the event.',
    `related_event_fdc_event_id` BIGINT COMMENT 'Identifier of a preceding or related fault event, if applicable.',
    `sensor_id` BIGINT COMMENT 'Identifier of the specific sensor that reported the out‑of‑range value.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when an operator or system acknowledged the alarm.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value of the fdc event record in the equipment domain.',
    `alarm_code` STRING COMMENT 'Standardized code representing the specific alarm condition as defined by the tool vendor or SEMI E116.',
    `alarm_status` STRING COMMENT 'Current lifecycle status of the alarm.. Valid values are `active|acknowledged|cleared`',
    `alarm_type` STRING COMMENT 'Indicates whether the record is an alarm (pre‑emptive) or a fault (critical failure).. Valid values are `alarm|fault`',
    `batch_number` STRING COMMENT 'Batch or run number associated with the wafer lot for traceability.',
    `classification_rule` STRING COMMENT 'Identifier of the rule set used to classify the event according to SEMI E116 logic.',
    `clearance_timestamp` TIMESTAMP COMMENT 'Date and time when the alarm was cleared or resolved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fault event record was first inserted into the data lake.',
    `fdc_event_description` STRING COMMENT 'The description of the fdc event record in the equipment domain.',
    `detected_timestamp` TIMESTAMP COMMENT 'The detected timestamp of the fdc event record in the equipment domain.',
    `disposition` STRING COMMENT 'System‑determined action taken automatically in response to the fault.. Valid values are `lot_hold|tool_stop|alert_only|none`',
    `duration_seconds` STRING COMMENT 'Total elapsed time in seconds between onset and clearance of the alarm.',
    `engineer_review_outcome` STRING COMMENT 'Result of the engineers investigation and corrective action.. Valid values are `resolved|unresolved|deferred`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the fault was escalated to a maintenance work order.',
    `event_code` STRING COMMENT 'Coded value representing the event code of the fdc event equipment record.',
    `event_severity` STRING COMMENT 'The event severity of the fdc event record in the equipment domain.',
    `event_status` STRING COMMENT 'The event status of the fdc event record in the equipment domain.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the fdc event record in the equipment domain.',
    `event_type` STRING COMMENT 'The event type of the fdc event record in the equipment domain.',
    `expected_value` DECIMAL(18,2) COMMENT 'The expected value of the fdc event record in the equipment domain.',
    `fault_classification` STRING COMMENT 'The fault classification of the fdc event record in the equipment domain.',
    `is_simulated` BOOLEAN COMMENT 'Indicates whether the record represents a simulated test event rather than a real fault.',
    `limit_violated` STRING COMMENT 'The limit violated of the fdc event record in the equipment domain.',
    `lot_step` STRING COMMENT 'Name of the process step (e.g., lithography, etch) being executed when the fault occurred.',
    `measured_value` DECIMAL(18,2) COMMENT 'The measured value of the fdc event record in the equipment domain.',
    `message` STRING COMMENT 'Descriptive text supplied by the tool explaining the nature of the alarm or fault.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the fdc event record in the equipment domain.',
    `normal_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the normal operating range for the monitored parameter.',
    `normal_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the normal operating range for the monitored parameter.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated impact of the fault on Overall Equipment Effectiveness expressed as a percentage.',
    `onset_timestamp` TIMESTAMP COMMENT 'Date and time when the fault or alarm was first detected on the equipment.',
    `parameter_name` STRING COMMENT 'Name of the monitored sensor or process parameter that exceeded its threshold.',
    `parameter_value` DECIMAL(18,2) COMMENT 'Measured value of the parameter at the moment the alarm was raised.',
    `priority` STRING COMMENT 'Numeric priority used for scheduling remediation actions.',
    `response_action` STRING COMMENT 'The response action of the fdc event record in the equipment domain.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of the fault.. Valid values are `equipment|process|material|human|environment`',
    `root_cause_detail` STRING COMMENT 'Free‑text description providing detailed analysis of the root cause.',
    `severity` STRING COMMENT 'Severity level of the event, used for prioritization and escalation.. Valid values are `critical|major|minor|warning|info`',
    `source_category` STRING COMMENT 'Broad category of the source that raised the alarm (e.g., sensor, subsystem).. Valid values are `sensor|subsystem|chamber|software`',
    `source_name` STRING COMMENT 'Human‑readable name of the specific sensor, subsystem, or software component that generated the event.',
    `threshold_high` DECIMAL(18,2) COMMENT 'Configured high threshold that, when crossed, triggers a fault condition.',
    `threshold_low` DECIMAL(18,2) COMMENT 'Configured low threshold that, when crossed, triggers a fault condition.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value of the fdc event record in the equipment domain.',
    `unit_of_measure` STRING COMMENT 'Engineering unit associated with the parameter value (e.g., °C, V, mA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fault event record.',
    CONSTRAINT pk_fdc_event PRIMARY KEY(`fdc_event_id`)
) COMMENT 'Fault Detection and Classification (FDC) monitoring configuration, real-time alarm management, and fault event records for fab tools per SEMI E116. Defines monitored sensor parameters (signal name, data type, engineering units, sampling rate, normal operating range, fault thresholds, classification rules) and captures all tool alarms and fault events. Records include alarm/fault ID, alarm code, type, severity (critical, major, minor, warning), alarm source (chamber, subsystem, sensor), alarm message text, affected tool and chamber, triggering parameter and value, onset/acknowledgment/clearance timestamps, associated wafer lot and recipe, automated disposition (lot hold, tool stop, alert only), escalation to maintenance event, and engineer review outcome. SSOT for real-time FDC configuration, tool alarm management, fault classification, and process excursion containment. Feeds predictive maintenance models. Sourced from SmartFactory MES FDC module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` (
    `tool_capex_id` BIGINT COMMENT 'Unique surrogate key for each tool capital expenditure record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee record within the tool capex equipment entity.',
    `capex_request_id` BIGINT COMMENT 'Unique identifier for the capex request record within the tool capex equipment entity.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Capital expenditure for a tool requires an associated export license to ensure legal acquisition and deployment.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool (equipment) that this capex record pertains to.',
    `tool_requested_by_employee_id` BIGINT COMMENT 'Unique identifier for the tool requested by employee record within the tool capex equipment entity.',
    `supplier_id` BIGINT COMMENT 'Identifier of the third‑party service organization responsible for maintenance contracts.',
    `tool_supplier_id` BIGINT COMMENT 'Identifier of the OEM or supplier providing the equipment.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd of the tool capex record in the equipment domain.',
    `approval_date` DATE COMMENT 'The approval date associated with the tool capex equipment record.',
    `approval_status` STRING COMMENT 'The approval status of the tool capex record in the equipment domain.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The approved amount of the tool capex record in the equipment domain.',
    `budget_year` STRING COMMENT 'The budget year of the tool capex record in the equipment domain.',
    `capex_amount_usd` DECIMAL(18,2) COMMENT 'The capex amount usd of the tool capex record in the equipment domain.',
    `capex_date` DATE COMMENT 'Date when the capex transaction was recorded or approved.',
    `capex_number` STRING COMMENT 'External reference number assigned to the capex project for tracking and audit.',
    `capex_status` STRING COMMENT 'The capex status of the tool capex record in the equipment domain.',
    `capitalization_date` DATE COMMENT 'Date when the asset is capitalized on the balance sheet.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier charging the capex expense.',
    `covered_failure_modes` STRING COMMENT 'List of failure modes that are covered under the warranty or service contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capex record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the tool over its useful life.. Valid values are `straight_line|double_declining|units_of_production`',
    `tool_capex_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special notes of the capex project.',
    `escalation_contact` STRING COMMENT 'Contact information (name/email) for escalation of critical warranty issues.',
    `extended_warranty_flag` BOOLEAN COMMENT 'Indicates whether an extended warranty beyond the standard period has been purchased.',
    `funding_source` STRING COMMENT 'Origin of the capital funds used for the purchase.. Valid values are `internal_capex|chips_grant|joint_venture|external_finance`',
    `installation_cost` DECIMAL(18,2) COMMENT 'Cost incurred to install and commission the tool at the fab site.',
    `make_vs_buy_repair_decision` STRING COMMENT 'Strategic choice for repairing the tool: performed in‑house (make), outsourced (buy), or hybrid.. Valid values are `make|buy|hybrid`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool capex record in the equipment domain.',
    `nre_charges` DECIMAL(18,2) COMMENT 'One‑time engineering fees associated with tool customization or integration.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the acquisition of the tool.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Final agreed purchase price paid to the vendor, excluding taxes and additional charges.',
    `quoted_price` DECIMAL(18,2) COMMENT 'Price quoted by the vendor before negotiation, in the transaction currency.',
    `requested_amount` DECIMAL(18,2) COMMENT 'The requested amount of the tool capex record in the equipment domain.',
    `response_time_sla_hours` DECIMAL(18,2) COMMENT 'Maximum response time promised by the service provider for a warranty claim.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the purchase price.',
    `third_party_service_contract_flag` BOOLEAN COMMENT 'True if a separate service contract exists with a third‑party provider.',
    `tool_capex_status` STRING COMMENT 'Current processing state of the capex record. [ENUM-REF-CANDIDATE: planned|approved|funded|purchased|installed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `total_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and any discounts, representing the final cost to the company.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the capex record.',
    `useful_life_years` STRING COMMENT 'Estimated economic life of the tool for depreciation purposes.',
    `warranty_claim_count` STRING COMMENT 'Number of warranty claims filed for this tool.',
    `warranty_claim_total_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all warranty claims settled.',
    `warranty_end_date` DATE COMMENT 'Date when warranty coverage expires.',
    `warranty_start_date` DATE COMMENT 'Date when warranty coverage becomes effective.',
    `warranty_type` STRING COMMENT 'Scope of warranty coverage provided by the vendor.. Valid values are `parts|labor|full_coverage|none`',
    CONSTRAINT pk_tool_capex PRIMARY KEY(`tool_capex_id`)
) COMMENT 'Capital expenditure, warranty, and service contract records for fab tool commercial and financial lifecycle. Captures capex project reference, tool asset reference, purchase order, OEM vendor, quoted and actual purchase price, installation cost, NRE charges, depreciation method, useful life, capitalization date, funding source (internal capex, CHIPS Act grant, JV contribution), warranty type (parts, labor, full coverage), warranty coverage start/end dates, OEM service provider, covered failure modes, response time SLAs, escalation contacts, warranty claim history with claim amounts and resolution, extended warranty agreements, third-party service contracts, and make-vs-buy repair decisions. SSOT for equipment financial management, warranty lifecycle, service contract management, and total cost of ownership. Sourced from SAP S/4HANA FI-AA and contract management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` (
    `tool_safety_cert_id` BIGINT COMMENT 'Unique surrogate key for each safety certification record.',
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record within the tool safety cert equipment entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the certifying employee record within the tool safety cert equipment entity.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool (lithography, deposition, etc.) to which this certification applies.',
    `cert_number` STRING COMMENT 'The cert number of the tool safety cert record in the equipment domain.',
    `cert_status` STRING COMMENT 'The cert status of the tool safety cert record in the equipment domain.',
    `cert_type` STRING COMMENT 'The cert type of the tool safety cert record in the equipment domain.',
    `certificate_number` STRING COMMENT 'The certificate number of the tool safety cert record in the equipment domain.',
    `certification_expiry_date` DATE COMMENT 'Date the certification becomes invalid unless renewed.',
    `certification_issue_date` DATE COMMENT 'Date the certification was originally issued.',
    `certification_status` STRING COMMENT 'Current lifecycle state of the certification.. Valid values are `valid|expired|revoked|pending`',
    `certification_type` STRING COMMENT 'Category of safety certification covering chemical, electrical, ergonomics, or environmental aspects.. Valid values are `chemical|electrical|ergonomics|environmental`',
    `certifying_body` STRING COMMENT 'The certifying body of the tool safety cert record in the equipment domain.',
    `compliance_standards` STRING COMMENT 'Applicable safety and environmental standards satisfied by the certification.. Valid values are `SEMI_S2|SEMI_S22|SEMI_S8|ISO_14001|RoHS|REACH`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the tool safety cert equipment record.',
    `identified_hazards` STRING COMMENT 'List of safety hazards identified for the tool (e.g., chemical exposure, electrical shock).',
    `issue_date` DATE COMMENT 'The issue date associated with the tool safety cert equipment record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the tool safety cert record in the equipment domain.',
    `next_recertification_date` DATE COMMENT 'Planned date for the next safety recertification activity.',
    `notes` STRING COMMENT 'Free‑form comments, observations, or special instructions related to the certification.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated impact of the certification status on Overall Equipment Effectiveness, expressed as a percentage.',
    `recertification_interval_days` STRING COMMENT 'Number of days between required recertifications.',
    `required_controls` STRING COMMENT 'Mitigation measures or engineering controls required to address the identified hazards.',
    `risk_level` STRING COMMENT 'Overall risk rating for the tool based on hazard assessment.. Valid values are `low|medium|high`',
    `safety_standard` STRING COMMENT 'The safety standard of the tool safety cert record in the equipment domain.',
    `scope_description` STRING COMMENT 'The scope description of the tool safety cert record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the certification record.',
    CONSTRAINT pk_tool_safety_cert PRIMARY KEY(`tool_safety_cert_id`)
) COMMENT 'Safety certification and compliance records for fab tools covering chemical safety (SEMI S2), electrical safety (SEMI S22), ergonomics (SEMI S8), and environmental compliance (ISO 14001, RoHS, REACH). Captures certification type, certifying body, certification date, expiry date, compliance status, identified hazards, required safety controls, and re-certification schedule. Mandatory for FAB operating permits and regulatory audits.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` (
    `part_substance_composition_id` BIGINT COMMENT 'Primary key',
    `declaration_substance_id` BIGINT COMMENT 'FK to declaration substance',
    `spare_part_id` BIGINT COMMENT 'FK to spare part',
    `substance_inventory_id` BIGINT COMMENT 'FK to substance inventory',
    `above_threshold` BOOLEAN COMMENT 'The above threshold of the part substance composition record in the equipment domain.',
    `cas_number` STRING COMMENT 'The cas number of the part substance composition record in the equipment domain.',
    `compliance_status` STRING COMMENT 'The compliance status of the part substance composition record in the equipment domain.',
    `concentration` DECIMAL(18,2) COMMENT 'Concentration value',
    `concentration_pct` DECIMAL(18,2) COMMENT 'The concentration pct of the part substance composition record in the equipment domain.',
    `concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration in ppm',
    `concentration_unit` STRING COMMENT 'The concentration unit of the part substance composition record in the equipment domain.',
    `concentration_weight_percent` DECIMAL(18,2) COMMENT 'The concentration weight percent of the part substance composition record in the equipment domain.',
    `conflict_mineral_flag` BOOLEAN COMMENT 'The conflict mineral flag of the part substance composition record in the equipment domain.',
    `created_at` TIMESTAMP COMMENT 'The created at of the part substance composition record in the equipment domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the part substance composition record in the equipment domain.',
    `data_basis` STRING COMMENT 'The data basis of the part substance composition record in the equipment domain.',
    `declaration_date` DATE COMMENT 'The declaration date associated with the part substance composition equipment record.',
    `declaration_source` STRING COMMENT 'The declaration source of the part substance composition record in the equipment domain.',
    `disclosure_threshold_exceeded_flag` BOOLEAN COMMENT 'The disclosure threshold exceeded flag of the part substance composition record in the equipment domain.',
    `exemption_code` STRING COMMENT 'Coded value representing the exemption code of the part substance composition equipment record.',
    `exemption_reference` STRING COMMENT 'The exemption reference of the part substance composition record in the equipment domain.',
    `expiration_date` DATE COMMENT 'The expiration date associated with the part substance composition equipment record.',
    `hazard_class` STRING COMMENT 'The hazard class of the part substance composition record in the equipment domain.',
    `homogeneous_material` STRING COMMENT 'The homogeneous material of the part substance composition record in the equipment domain.',
    `homogeneous_material_name` STRING COMMENT 'The homogeneous material name of the part substance composition record in the equipment domain.',
    `is_reach_svhc` BOOLEAN COMMENT 'Whether REACH SVHC',
    `is_rohs_relevant` BOOLEAN COMMENT 'Whether RoHS relevant',
    `is_rohs_restricted` BOOLEAN COMMENT 'Whether RoHS restricted',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the part substance composition record in the equipment domain.',
    `mass_grams` DECIMAL(18,2) COMMENT 'Mass in grams',
    `mass_percent` DECIMAL(18,2) COMMENT 'The mass percent of the part substance composition record in the equipment domain.',
    `material_category` STRING COMMENT 'The material category of the part substance composition record in the equipment domain.',
    `measured_date` DATE COMMENT 'The measured date associated with the part substance composition equipment record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the part substance composition record in the equipment domain.',
    `reach_flag` BOOLEAN COMMENT 'The reach flag of the part substance composition record in the equipment domain.',
    `reach_regulated_flag` BOOLEAN COMMENT 'The reach regulated flag of the part substance composition record in the equipment domain.',
    `reach_relevant` BOOLEAN COMMENT 'The reach relevant of the part substance composition record in the equipment domain.',
    `reach_status` STRING COMMENT 'The reach status of the part substance composition record in the equipment domain.',
    `reach_svhc_flag` BOOLEAN COMMENT 'The reach svhc flag of the part substance composition record in the equipment domain.',
    `rohs_exempt_flag` BOOLEAN COMMENT 'The rohs exempt flag of the part substance composition record in the equipment domain.',
    `rohs_flag` BOOLEAN COMMENT 'The rohs flag of the part substance composition record in the equipment domain.',
    `rohs_relevant` BOOLEAN COMMENT 'The rohs relevant of the part substance composition record in the equipment domain.',
    `rohs_restricted` BOOLEAN COMMENT 'The rohs restricted of the part substance composition record in the equipment domain.',
    `rohs_restricted_flag` BOOLEAN COMMENT 'The rohs restricted flag of the part substance composition record in the equipment domain.',
    `rohs_status` STRING COMMENT 'The rohs status of the part substance composition record in the equipment domain.',
    `source_document_reference` STRING COMMENT 'The source document reference of the part substance composition record in the equipment domain.',
    `source_documentation` STRING COMMENT 'The source documentation of the part substance composition record in the equipment domain.',
    `substance_name` STRING COMMENT 'The substance name of the part substance composition record in the equipment domain.',
    `supplier_declaration_reference` STRING COMMENT 'The supplier declaration reference of the part substance composition record in the equipment domain.',
    `svhc_flag` BOOLEAN COMMENT 'The svhc flag of the part substance composition record in the equipment domain.',
    `threshold_exceeded_flag` BOOLEAN COMMENT 'The threshold exceeded flag of the part substance composition record in the equipment domain.',
    `threshold_limit_pct` DECIMAL(18,2) COMMENT 'The threshold limit pct of the part substance composition record in the equipment domain.',
    `threshold_limit_ppm` DECIMAL(18,2) COMMENT 'Threshold limit in ppm',
    `updated_at` TIMESTAMP COMMENT 'The updated at of the part substance composition record in the equipment domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the part substance composition record in the equipment domain.',
    `usage_volume_kg` DECIMAL(18,2) COMMENT 'Usage volume in kg',
    `weight_grams` DECIMAL(18,2) COMMENT 'Weight in grams',
    `weight_percent` DECIMAL(18,2) COMMENT 'The weight percent of the part substance composition record in the equipment domain.',
    `weight_ppm` DECIMAL(18,2) COMMENT 'Weight in ppm',
    `valid_from` DATE COMMENT 'Valid from date',
    `valid_to` DATE COMMENT 'Valid to date',
    CONSTRAINT pk_part_substance_composition PRIMARY KEY(`part_substance_composition_id`)
) COMMENT 'This association captures the composition relationship between a spare part and a regulated chemical substance. It records the concentration of the substance in the part and the annual usage volume needed for compliance reporting (REACH, RoHS, TSCA, etc.). Each row links one spare_part to one substance_inventory.. Existence Justification: Each spare part can contain multiple regulated chemical substances, and each substance can be present in many spare parts. The company actively tracks the concentration of each substance in a part and the annual usage volume for compliance reporting, which is managed as a distinct record.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` (
    `sensor_id` BIGINT COMMENT 'Primary key for sensor',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier for the fab tool record within the sensor equipment entity.',
    `location_id` BIGINT COMMENT 'Identifier of the plant/facility where the sensor is installed.',
    `parent_sensor_id` BIGINT COMMENT 'Self-referencing FK on sensor (parent_sensor_id)',
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber record within the sensor equipment entity.',
    `accuracy` DECIMAL(18,2) COMMENT 'Typical measurement error expressed as a percentage of full scale.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the sensor.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration.',
    `sensor_code` STRING COMMENT 'Coded value representing the code of the sensor equipment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sensor record was first created in the system.',
    `data_rate_hz` DECIMAL(18,2) COMMENT 'Frequency at which the sensor reports data.',
    `sensor_description` STRING COMMENT 'Free‑form text describing the sensors purpose, mounting location, or special notes.',
    `firmware_version` STRING COMMENT 'Version identifier of the sensors embedded firmware.',
    `installation_date` DATE COMMENT 'Date the sensor was installed on equipment.',
    `ip_address` STRING COMMENT 'IPv4 address used for network communication with the sensor.',
    `last_maintenance_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent maintenance activity.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the sensors network interface.',
    `manufacturer` STRING COMMENT 'Company that produced the sensor.',
    `max_range` DECIMAL(18,2) COMMENT 'The max range of the sensor record in the equipment domain.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Highest value the sensor can accurately measure.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Lowest value the sensor can accurately measure.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the sensors primary reading.',
    `min_range` DECIMAL(18,2) COMMENT 'The min range of the sensor record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the sensor record in the equipment domain.',
    `model_number` STRING COMMENT 'Manufacturer‑provided model designation for the sensor.',
    `sensor_name` STRING COMMENT 'Human‑readable name or label assigned to the sensor.',
    `next_maintenance_timestamp` TIMESTAMP COMMENT 'Planned date‑time for the upcoming maintenance.',
    `power_rating_watts` DECIMAL(18,2) COMMENT 'Electrical power consumption of the sensor.',
    `resolution` DECIMAL(18,2) COMMENT 'Smallest distinguishable change in the measured value.',
    `sampling_rate_hz` DECIMAL(18,2) COMMENT 'The sampling rate hz of the sensor record in the equipment domain.',
    `sensor_status` STRING COMMENT 'Current operational status of the sensor.',
    `sensor_type` STRING COMMENT 'Category of physical quantity measured by the sensor.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the sensor hardware.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sensor record.',
    CONSTRAINT pk_sensor PRIMARY KEY(`sensor_id`)
) COMMENT 'Master reference table for sensor. Referenced by sensor_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Primary key for maintenance_plan',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the maintenance plan equipment entity.',
    `superseded_maintenance_plan_id` BIGINT COMMENT 'Self-referencing FK on maintenance_plan (superseded_maintenance_plan_id)',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'The annual budget usd of the maintenance plan record in the equipment domain.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibration activities.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the maintenance activities.',
    `cost_currency` STRING COMMENT 'Currency of the cost estimate; default is USD.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Projected monetary cost to execute the maintenance plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance plan record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance plan becomes effective.',
    `equipment_category` STRING COMMENT 'High‑level classification of equipment the plan applies to.',
    `frequency_unit` STRING COMMENT 'Time unit for the frequency value.',
    `frequency_value` STRING COMMENT 'Numeric interval defining how often the maintenance activity recurs.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the plan is considered critical for production continuity.',
    `last_performed_date` DATE COMMENT 'Date when the maintenance plan was last executed.',
    `maintenance_plan_status` STRING COMMENT 'Current lifecycle state of the maintenance plan.',
    `maintenance_task_description` STRING COMMENT 'Narrative description of the primary maintenance activities covered by the plan.',
    `maintenance_window_hours` DECIMAL(18,2) COMMENT 'Typical duration of a maintenance event expressed in hours.',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operating time between equipment failures, used for reliability analysis.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to complete a maintenance event.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the maintenance plan record in the equipment domain.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next execution of the maintenance plan.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the plan.',
    `plan_code` STRING COMMENT 'Business code used to reference the maintenance plan in operational systems.',
    `plan_description` STRING COMMENT 'The plan description of the maintenance plan record in the equipment domain.',
    `plan_name` STRING COMMENT 'Human‑readable name of the maintenance plan.',
    `plan_status` STRING COMMENT 'The plan status of the maintenance plan record in the equipment domain.',
    `plan_type` STRING COMMENT 'Category of maintenance activity the plan addresses.',
    `priority_level` STRING COMMENT 'Business priority assigned to the maintenance plan.',
    `required_skill_level` STRING COMMENT 'Skill tier required for personnel executing the plan.',
    `requires_calibration` BOOLEAN COMMENT 'True if the equipment requires periodic calibration as part of this plan.',
    `review_frequency_months` STRING COMMENT 'The review frequency months of the maintenance plan record in the equipment domain.',
    `safety_risk_level` STRING COMMENT 'Assessed safety risk associated with the maintenance plan.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned end timestamp for the first maintenance window.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned start timestamp for the first maintenance window under this plan.',
    `strategy` STRING COMMENT 'The strategy of the maintenance plan record in the equipment domain.',
    `task_count` STRING COMMENT 'Total count of distinct tasks defined in the maintenance plan.',
    `tool_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the equipment tool.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the maintenance plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the maintenance plan record.',
    `vendor_contact` STRING COMMENT 'Contact details (phone or email) for the vendor responsible for the maintenance service.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or service provider associated with the maintenance plan.',
    `warranty_expiration_date` DATE COMMENT 'Date when the equipment warranty expires, influencing maintenance decisions.',
    `created_by` STRING COMMENT 'User identifier of the person who created the maintenance plan record.',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Master reference table for maintenance_plan. Referenced by maintenance_plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` (
    `equipment_site_map_id` BIGINT COMMENT 'Primary key for site_map',
    `equipment_fab_id` BIGINT COMMENT 'Unique identifier for the fab record within the equipment site map equipment entity.',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier for the fab tool record within the equipment site map equipment entity.',
    `parent_site_id` BIGINT COMMENT 'Identifier of the parent site in hierarchical site structures.',
    `parent_site_map_id` BIGINT COMMENT 'Self-referencing FK on site_map (parent_site_map_id)',
    `primary_authoritative_process_site_map_id` BIGINT COMMENT 'Authoritative FK resolving SSOT duplicate ownership',
    `process_site_map_id` BIGINT COMMENT 'Authoritative cross-domain reference for site_map; SSOT owner is equipment.site_map',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_wafer_per_month` DECIMAL(18,2) COMMENT 'Maximum number of wafers the site can process per month.',
    `city` STRING COMMENT 'City where the site is located.',
    `closing_date` DATE COMMENT 'Date when the site ceased operations (null if still active).',
    `country` STRING COMMENT 'The country of the equipment site map record in the equipment domain.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the site resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site map record was first created in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the site in decimal degrees.',
    `layout_reference` STRING COMMENT 'The layout reference of the equipment site map record in the equipment domain.',
    `location_code` STRING COMMENT 'Coded value representing the location code of the equipment site map equipment record.',
    `location_zone` STRING COMMENT 'The location zone of the equipment site map record in the equipment domain.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Email address of the site manager.',
    `manager_name` STRING COMMENT 'Full name of the primary manager responsible for the site.',
    `manager_phone` STRING COMMENT 'Contact phone number of the site manager.',
    `map_code` STRING COMMENT 'Coded value representing the map code of the equipment site map equipment record.',
    `map_name` STRING COMMENT 'The map name of the equipment site map record in the equipment domain.',
    `map_version` STRING COMMENT 'The map version of the equipment site map record in the equipment domain.',
    `measurement_location` STRING COMMENT 'The measurement location of the equipment site map record in the equipment domain.',
    `measurement_point_count` STRING COMMENT 'The measurement point count of the equipment site map record in the equipment domain.',
    `measurement_site_count` STRING COMMENT 'The measurement site count of the equipment site map record in the equipment domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the equipment site map record in the equipment domain.',
    `number_of_tools` STRING COMMENT 'Count of major manufacturing tools (e.g., lithography scanners, etchers) located at the site.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Most recent measured Overall Equipment Effectiveness (OEE) for the site.',
    `oee_target` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness (OEE) percentage for the site.',
    `opening_date` DATE COMMENT 'Date when the site began operations.',
    `position_x` DECIMAL(18,2) COMMENT 'The position x of the equipment site map record in the equipment domain.',
    `position_y` DECIMAL(18,2) COMMENT 'The position y of the equipment site map record in the equipment domain.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `region` STRING COMMENT 'Higher‑level region grouping (e.g., APAC, EMEA, Americas).',
    `site_area_sqft` DECIMAL(18,2) COMMENT 'Total floor area of the site in square feet.',
    `site_code` STRING COMMENT 'External business code used to uniquely identify the site across systems.',
    `site_index` STRING COMMENT 'The site index of the equipment site map record in the equipment domain.',
    `site_map_description` STRING COMMENT 'Free‑form text describing the site, its purpose, and notable characteristics.',
    `site_map_name` STRING COMMENT 'The site map name of the equipment site map record in the equipment domain.',
    `site_map_status` STRING COMMENT 'Current operational status of the site.',
    `site_name` STRING COMMENT 'Human‑readable name of the manufacturing or support site.',
    `site_type` STRING COMMENT 'Categorizes the site by its primary function (e.g., fab, test, assembly, office, R&D).',
    `ssot_owner_reference` BIGINT COMMENT 'Single-source-of-truth owner reference for the site_map concept (process.site_map)',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `tertiary_process_site_map_id` BIGINT COMMENT 'SSOT reference to authoritative owner equipment.site_map for concept site_map',
    `timezone` STRING COMMENT 'IANA time zone identifier for the site (e.g., America/Los_Angeles).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site map record.',
    `x_coordinate` DECIMAL(18,2) COMMENT 'The x coordinate of the equipment site map record in the equipment domain.',
    `y_coordinate` DECIMAL(18,2) COMMENT 'The y coordinate of the equipment site map record in the equipment domain.',
    `zone_name` STRING COMMENT 'The zone name of the equipment site map record in the equipment domain.',
    CONSTRAINT pk_equipment_site_map PRIMARY KEY(`equipment_site_map_id`)
) COMMENT 'Master reference table for site_map. Referenced by site_map_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` (
    `equipment_fab_id` BIGINT COMMENT 'Primary key for fab',
    `maintenance_contract_id` BIGINT COMMENT 'Identifier of the maintenance contract governing service agreements for the fab.',
    `maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the maintenance plan record within the equipment fab equipment entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the manager employee record within the equipment fab equipment entity.',
    `parent_fab_id` BIGINT COMMENT 'Self-referencing FK on fab (parent_fab_id)',
    `fab_site_id` BIGINT COMMENT 'FK to fabrication.fab_site.fab_site_id',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the equipment fab equipment entity.',
    `address_line1` STRING COMMENT 'Primary street address of the fab.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sq_meters` DECIMAL(18,2) COMMENT 'Total floor area of the fab in square meters.',
    `capacity_wafer_per_month` STRING COMMENT 'Maximum number of wafers the fab can process per month.',
    `capacity_wafer_per_year` STRING COMMENT 'Maximum number of wafers the fab can process per year.',
    `cleanroom_class` STRING COMMENT 'Cleanroom class standard (ISO 14644‑1).',
    `compliance_status` STRING COMMENT 'Current compliance standing with industry regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fab record was first created.',
    `environmental_certifications` STRING COMMENT 'Environmental compliance certifications (e.g., ISO 14001).',
    `fab_code` STRING COMMENT 'Business‑assigned code used to reference the fab in external systems.',
    `fab_description` STRING COMMENT 'Free‑form description of the fabs capabilities and purpose.',
    `fab_location` STRING COMMENT 'The fab location of the equipment fab record in the equipment domain.',
    `fab_name` STRING COMMENT 'Human‑readable name of the fab.',
    `fab_status` STRING COMMENT 'Current operational status of the fab.',
    `fab_type` STRING COMMENT 'Classification of fab based on process focus.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the fab is considered critical to production continuity.',
    `last_maintenance_date` DATE COMMENT 'Most recent date a major maintenance activity was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the fab site.',
    `location` STRING COMMENT 'The location of the equipment fab record in the equipment domain.',
    `location_city` STRING COMMENT 'City where the fab is physically located.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code where the fab resides.',
    `location_state` STRING COMMENT 'State or province of the fab site.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the fab site.',
    `manager_email` STRING COMMENT 'Email address of the fab manager.',
    `manager_name` STRING COMMENT 'Name of the internal manager responsible for the fab.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the equipment fab record in the equipment domain.',
    `monthly_capacity_wafers` STRING COMMENT 'The monthly capacity wafers of the equipment fab record in the equipment domain.',
    `next_maintenance_due` DATE COMMENT 'Scheduled date for the next planned maintenance.',
    `number_of_cleanrooms` STRING COMMENT 'Number of cleanroom environments within the fab.',
    `oee_actual_percent` DECIMAL(18,2) COMMENT 'Measured Overall Equipment Effectiveness percentage.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness expressed as a percentage.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary fab contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary external contact for the fab.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary fab contact.',
    `process_node_capability` STRING COMMENT 'The process node capability of the equipment fab record in the equipment domain.',
    `region` STRING COMMENT 'Broad geographic region where the fab is located.',
    `risk_level` STRING COMMENT 'Risk classification for the fab based on operational and security factors.',
    `safety_certifications` STRING COMMENT 'List of safety certifications held by the fab (e.g., ISO 45001).',
    `site_owner` STRING COMMENT 'Business unit or subsidiary that owns the fab.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fab record.',
    `wafer_size_mm` STRING COMMENT 'The wafer size mm of the equipment fab record in the equipment domain.',
    `year_commissioned` DATE COMMENT 'Date the fab began production.',
    `year_decommissioned` DATE COMMENT 'Date the fab was retired or scheduled for retirement (nullable).',
    `zip_code` STRING COMMENT 'Postal/ZIP code for the fab location.',
    CONSTRAINT pk_equipment_fab PRIMARY KEY(`equipment_fab_id`)
) COMMENT 'Master reference table for fab. Referenced by fab_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` (
    `maintenance_contract_id` BIGINT COMMENT 'Primary key for maintenance_contract',
    `employee_id` BIGINT COMMENT 'Unique identifier for the maintenance contract owner employee record within the maintenance contract equipment entity.',
    `supplier_id` BIGINT COMMENT 'FK reference to supply.supplier.supplier_id',
    `maintenance_vendor_supplier_id` BIGINT COMMENT 'Unique identifier of the equipment vendor providing the maintenance service.',
    `owner_employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the maintenance contract equipment entity.',
    `renewed_maintenance_contract_id` BIGINT COMMENT 'Self-referencing FK on maintenance_contract (renewed_maintenance_contract_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'The annual cost of the maintenance contract record in the equipment domain.',
    `annual_cost_usd` DECIMAL(18,2) COMMENT 'The annual cost usd of the maintenance contract record in the equipment domain.',
    `annual_value_usd` DECIMAL(18,2) COMMENT 'The annual value usd of the maintenance contract record in the equipment domain.',
    `audit_trail_notes` STRING COMMENT 'Chronological notes capturing significant changes or approvals to the contract.',
    `compliance_requirements` STRING COMMENT 'Regulatory or industry compliance clauses applicable to the contract (e.g., ISO, RoHS).',
    `contract_document_url` STRING COMMENT 'Link to the stored digital copy of the signed contract.',
    `contract_number` STRING COMMENT 'External contract reference number assigned by the vendor or internal contract management system.',
    `contract_status` STRING COMMENT 'The contract status of the maintenance contract record in the equipment domain.',
    `contract_status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., reason for suspension or termination.',
    `contract_type` STRING COMMENT 'Classification of the maintenance agreement indicating the scope of services covered.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the maintenance contract as agreed with the vendor.',
    `coverage_scope` STRING COMMENT 'The coverage scope of the maintenance contract record in the equipment domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the contract value.',
    `currency_code` STRING COMMENT 'Coded value representing the currency code of the maintenance contract equipment record.',
    `effective_end_date` DATE COMMENT 'Date on which the contract expires or terminates; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date on which the contract becomes binding and service obligations commence.',
    `end_date` DATE COMMENT 'The end date associated with the maintenance contract equipment record.',
    `equipment_category` STRING COMMENT 'High‑level classification of equipment covered by the contract.',
    `equipment_model` STRING COMMENT 'Specific model identifier of the equipment units covered.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the vendor is the sole provider for the covered equipment.',
    `last_review_date` DATE COMMENT 'Date when the contract was last reviewed for renewal or amendment.',
    `maintenance_contract_status` STRING COMMENT 'Current lifecycle status of the maintenance contract.',
    `maintenance_scope` STRING COMMENT 'Narrative description of the equipment, parts, and activities covered by the contract.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the maintenance contract record in the equipment domain.',
    `next_review_date` DATE COMMENT 'Planned date for the upcoming contract performance or renewal review.',
    `payment_terms` STRING COMMENT 'Standard payment condition for invoicing under the contract.',
    `renewal_option` STRING COMMENT 'Indicates whether the contract renews automatically, requires manual renewal, or does not renew.',
    `renewal_terms` STRING COMMENT 'The renewal terms of the maintenance contract record in the equipment domain.',
    `response_time_hours` STRING COMMENT 'The response time hours of the maintenance contract record in the equipment domain.',
    `response_time_sla_hours` STRING COMMENT 'The response time sla hours of the maintenance contract record in the equipment domain.',
    `service_level` STRING COMMENT 'Tier of service commitment (e.g., response and resolution times) defined in the contract.',
    `sla_resolution_time_hours` STRING COMMENT 'Maximum time allowed for the vendor to resolve a reported issue.',
    `sla_response_hours` DECIMAL(18,2) COMMENT 'The sla response hours of the maintenance contract record in the equipment domain.',
    `sla_response_time_hours` STRING COMMENT 'Maximum time allowed for the vendor to acknowledge a service request.',
    `start_date` DATE COMMENT 'The start date associated with the maintenance contract equipment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor organization.',
    `warranty_period_months` STRING COMMENT 'Length of the warranty period provided by the vendor, expressed in months.',
    CONSTRAINT pk_maintenance_contract PRIMARY KEY(`maintenance_contract_id`)
) COMMENT 'Master reference table for maintenance_contract. Referenced by maintenance_contract_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_primary_pm_fab_tool_id` FOREIGN KEY (`primary_pm_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_reference_pm_fab_tool_id` FOREIGN KEY (`reference_pm_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_primary_fab_tool_id` FOREIGN KEY (`primary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_primary_tool_maintenance_event_id` FOREIGN KEY (`primary_tool_maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_primary_calibration_fab_tool_id` FOREIGN KEY (`primary_calibration_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tertiary_fab_tool_id` FOREIGN KEY (`tertiary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ADD CONSTRAINT `fk_equipment_tool_alarm_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ADD CONSTRAINT `fk_equipment_tool_alarm_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ADD CONSTRAINT `fk_equipment_tool_alarm_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_primary_equipment_fab_tool_id` FOREIGN KEY (`primary_equipment_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_primary_recipe_fab_tool_id` FOREIGN KEY (`primary_recipe_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ADD CONSTRAINT `fk_equipment_spc_control_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_primary_fab_tool_id` FOREIGN KEY (`primary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_primary_fab_tool_id` FOREIGN KEY (`primary_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_equipment_site_map_id` FOREIGN KEY (`equipment_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_site_map`(`equipment_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ADD CONSTRAINT `fk_equipment_tool_warranty_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ADD CONSTRAINT `fk_equipment_tool_warranty_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ADD CONSTRAINT `fk_equipment_tool_installation_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_primary_fdc_fab_tool_id` FOREIGN KEY (`primary_fdc_fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_primary_fdc_tool_chamber_id` FOREIGN KEY (`primary_fdc_tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_related_event_fdc_event_id` FOREIGN KEY (`related_event_fdc_event_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fdc_event`(`fdc_event_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ADD CONSTRAINT `fk_equipment_fdc_event_sensor_id` FOREIGN KEY (`sensor_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`sensor`(`sensor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ADD CONSTRAINT `fk_equipment_tool_capex_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ADD CONSTRAINT `fk_equipment_tool_safety_cert_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ADD CONSTRAINT `fk_equipment_part_substance_composition_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ADD CONSTRAINT `fk_equipment_sensor_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ADD CONSTRAINT `fk_equipment_sensor_parent_sensor_id` FOREIGN KEY (`parent_sensor_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`sensor`(`sensor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ADD CONSTRAINT `fk_equipment_sensor_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_superseded_maintenance_plan_id` FOREIGN KEY (`superseded_maintenance_plan_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_equipment_fab_id` FOREIGN KEY (`equipment_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_site_map`(`equipment_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_parent_site_map_id` FOREIGN KEY (`parent_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_site_map`(`equipment_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ADD CONSTRAINT `fk_equipment_equipment_site_map_primary_authoritative_process_site_map_id` FOREIGN KEY (`primary_authoritative_process_site_map_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_site_map`(`equipment_site_map_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ADD CONSTRAINT `fk_equipment_equipment_fab_parent_fab_id` FOREIGN KEY (`parent_fab_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`equipment_fab`(`equipment_fab_id`);
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ADD CONSTRAINT `fk_equipment_maintenance_contract_renewed_maintenance_contract_id` FOREIGN KEY (`renewed_maintenance_contract_id`) REFERENCES `vibe_semiconductors_v1`.`equipment`.`maintenance_contract`(`maintenance_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Oem Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fab_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Facility ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `process_integration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_chamber` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier (CHAMBER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier (RECIPE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Engineer Identifier (ENG_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_qualification` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (TECH_NODE)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `pm_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `primary_pm_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`pm_schedule` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Part ID');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `primary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_event` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Spare Part Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Downtime Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `primary_tool_maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `tool_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_downtime` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calibrated By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `calibration_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `primary_calibration_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tertiary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`calibration_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_alarm_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Alarm Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Maintenance Event Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledgment Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_category` SET TAGS ('dbx_business_glossary_term' = 'Alarm Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_category` SET TAGS ('dbx_value_regex' = 'process|equipment|environment|safety');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_description` SET TAGS ('dbx_business_glossary_term' = 'Alarm Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Alarm Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_group` SET TAGS ('dbx_business_glossary_term' = 'Alarm Group');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_message` SET TAGS ('dbx_business_glossary_term' = 'Alarm Message Text');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_origin` SET TAGS ('dbx_business_glossary_term' = 'Alarm Origin');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_origin` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_source` SET TAGS ('dbx_business_glossary_term' = 'Alarm Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_source` SET TAGS ('dbx_value_regex' = 'chamber|subsystem|sensor|control_system');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_status` SET TAGS ('dbx_value_regex' = 'active|acknowledged|cleared|escalated');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Clearance Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cleared Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `tool_alarm_description` SET TAGS ('dbx_business_glossary_term' = 'Tool Alarm Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `equipment_location` SET TAGS ('dbx_business_glossary_term' = 'Equipment Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `oee_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `predicted_failure_flag` SET TAGS ('dbx_business_glossary_term' = 'Predicted Failure Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Repeat Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `sensor_value` SET TAGS ('dbx_business_glossary_term' = 'Sensor Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Production Shift');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triggered Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_alarm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_subdomain' = 'recipe_execution');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_ssot_owner' = 'fabrication.fabrication_process_recipe');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Used By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `primary_equipment_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_ssot_owner_ref' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `authoritative_fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Fabrication Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `authoritative_fabrication_process_recipe_id` SET TAGS ('dbx_ssot' = 'owner_reference');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_node_target` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` SET TAGS ('dbx_subdomain' = 'recipe_execution');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Execution Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `primary_recipe_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Seconds');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Seconds)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `execution_result` SET TAGS ('dbx_business_glossary_term' = 'Execution Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'pass|fail|abort');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `gas_flow_actual_sccm` SET TAGS ('dbx_business_glossary_term' = 'Actual Gas Flow (sccm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `gas_flow_setpoint_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Setpoint (sccm)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `is_calibrated` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Execution Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `measured_parameters` SET TAGS ('dbx_business_glossary_term' = 'Measured Parameters');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `oee_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Availability (%)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `oee_performance_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Performance (%)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `oee_quality_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Quality (%)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `power_actual_w` SET TAGS ('dbx_business_glossary_term' = 'Actual Power (W)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `power_setpoint_w` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (W)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `pressure_actual_pa` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `result_code` SET TAGS ('dbx_business_glossary_term' = 'Result Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `result_disposition` SET TAGS ('dbx_business_glossary_term' = 'Result Disposition');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `temperature_actual_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `time_actual_sec` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Time (Sec)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `time_setpoint_sec` SET TAGS ('dbx_business_glossary_term' = 'Process Time Setpoint (Sec)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`recipe_execution` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tool Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `primary_spc_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `primary_spc_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `primary_spc_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'SPC Control Chart Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Root‑Cause Analysis Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `center_line` SET TAGS ('dbx_business_glossary_term' = 'Center Line');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'SPC Control Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|ewma|cusum');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Trigger Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_limit_lcl_at_time` SET TAGS ('dbx_business_glossary_term' = 'LCL at Detection Time');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_limit_ucl_at_time` SET TAGS ('dbx_business_glossary_term' = 'UCL at Detection Time');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_parameter` SET TAGS ('dbx_business_glossary_term' = 'Control Parameter');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Cpk Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'SPC Data Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'MES|ICOS|custom');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Violation Disposition Action');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'lot_hold|tool_quarantine|false_alarm|investigate');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Detection Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `is_false_alarm` SET TAGS ('dbx_business_glossary_term' = 'False Alarm Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `is_repeat_violation` SET TAGS ('dbx_business_glossary_term' = 'Repeat Violation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `lcl` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `lcl_value` SET TAGS ('dbx_business_glossary_term' = 'Lcl Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Process Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Violation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Process Parameter Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `regulatory_reported` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `rule_set` SET TAGS ('dbx_business_glossary_term' = 'Western Electric Rule Set');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `rule_set` SET TAGS ('dbx_value_regex' = 'rule1|rule2|rule3|rule4|rule5|rule6');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'SPC Sampling Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|per_hour|per_lot');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Production Shift');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `spc_control_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `spc_control_status` SET TAGS ('dbx_value_regex' = 'open|closed|investigating|resolved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `spc_status` SET TAGS ('dbx_business_glossary_term' = 'Spc Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Process Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'up|down|stable');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `ucl` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `ucl_value` SET TAGS ('dbx_business_glossary_term' = 'Ucl Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'SPC Violation Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spc_control` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'ucl_breach|lcl_breach|run_rule|trend|outlier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `oee_record_id` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Identifier (OEE_REC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `primary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability Rate (AVAIL_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `available_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Hours (AVAIL_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category (DT_CATEGORY)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'planned|unplanned|maintenance|setup|breakdown|other');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`oee_record` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code (DT_REASON_CD)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`spare_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (WAFER_LOT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (OPERATOR_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `primary_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Recipe Identifier (RECIPE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `equipment_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Site Map Identifier (SITE_MAP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (WAFER_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status (CALIBRATION_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Run Comments (COMMENTS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'KLA_ICOS|SmartFactory_MES');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Tool Humidity (HUMIDITY_PERCENT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (LOT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'prototype|volume|engineering');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value (MEAN_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measured_mean` SET TAGS ('dbx_business_glossary_term' = 'Measured Mean');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measured_sigma` SET TAGS ('dbx_business_glossary_term' = 'Measured Sigma');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value (MEASURED_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode (MEASUREMENT_MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'inline|offline');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MEASUREMENT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'cd|film_thickness|overlay|defect_density|refractive_index|resist_thickness');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEASUREMENT_UNIT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|percent|mm|ps|GHz');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_status` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_status` SET TAGS ('dbx_value_regex' = 'planned|running|completed|failed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE_PERCENT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Disposition (PASS_FAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (RUN_DURATION_SECONDS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Number (RUN_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = '^MR[0-9]{6}$');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Timestamp (RUN_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift (SHIFT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `sigma_value` SET TAGS ('dbx_business_glossary_term' = 'Sigma Value (SIGMA_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `spec_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (SPEC_LIMIT_HIGH)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `spec_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (SPEC_LIMIT_LOW)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `std_dev` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation (STD_DEV)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Tool Temperature (TEMPERATURE_C)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `tool_name` SET TAGS ('dbx_business_glossary_term' = 'Tool Name (TOOL_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`metrology_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `tool_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Warranty Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `claim_history_count` SET TAGS ('dbx_business_glossary_term' = 'Claim History Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Coverage Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `coverage_terms` SET TAGS ('dbx_business_glossary_term' = 'Coverage Terms');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'OEM|ThirdParty|Extended');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `covered_failure_modes` SET TAGS ('dbx_business_glossary_term' = 'Covered Failure Modes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Warranty Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Warranty Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `extended_warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `last_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `last_claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|rejected|approved');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `oem_provider` SET TAGS ('dbx_business_glossary_term' = 'OEM Provider');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Part Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time SLA (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `service_provider` SET TAGS ('dbx_business_glossary_term' = 'Service Provider');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms And Conditions');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_cost` SET TAGS ('dbx_business_glossary_term' = 'Warranty Cost');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'parts|labor|full');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_warranty` ALTER COLUMN `warranty_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Warranty Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Installation ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Team Lead');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installed By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installer Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_installer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `tool_project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `acceptance_signoff_by` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Sign‑off By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `acceptance_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Sign‑off Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Amount');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `fab_bay` SET TAGS ('dbx_business_glossary_term' = 'FAB Bay');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `fab_building` SET TAGS ('dbx_business_glossary_term' = 'FAB Building');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `fab_floor` SET TAGS ('dbx_business_glossary_term' = 'FAB Floor');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'FAB Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `hookup_status` SET TAGS ('dbx_business_glossary_term' = 'Hookup Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_code` SET TAGS ('dbx_business_glossary_term' = 'Installation Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_cost` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Installation End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_location` SET TAGS ('dbx_business_glossary_term' = 'Installation Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_name` SET TAGS ('dbx_business_glossary_term' = 'Installation Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_number` SET TAGS ('dbx_business_glossary_term' = 'Installation Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_project_reference` SET TAGS ('dbx_business_glossary_term' = 'Installation Project Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `installation_type` SET TAGS ('dbx_value_regex' = 'new|relocation|upgrade|decommission');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `measurement_capacity_wafer_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Wafer per Hour)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `new_fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'New FAB Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Installation Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `previous_fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Previous FAB Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `relocation_date` SET TAGS ('dbx_business_glossary_term' = 'Relocation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `relocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Relocation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `relocation_reason` SET TAGS ('dbx_value_regex' = 'capacity_rebalancing|fab_consolidation|technology_transfer|other');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `requalification_required` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Required');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `sat_report_number` SET TAGS ('dbx_business_glossary_term' = 'SAT Report Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign Off Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `site_acceptance_test_result` SET TAGS ('dbx_business_glossary_term' = 'Site Acceptance Test Result');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `site_acceptance_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `utility_exhaust_hookup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Exhaust Hookup Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `utility_gas_hookup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Gas Hookup Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `utility_power_hookup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Power Hookup Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `utility_vacuum_hookup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Hookup Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `utility_water_hookup_completed_date` SET TAGS ('dbx_business_glossary_term' = 'DI Water Hookup Completed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_installation` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `fdc_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fault Detection and Classification Event ID (FDCEID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Identifier (EID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (WLI)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier (MOID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `primary_fdc_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tool Identifier (ETID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `primary_fdc_tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Identifier (TCID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier (PRI)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `related_event_fdc_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Event Identifier (REID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `sensor_id` SET TAGS ('dbx_business_glossary_term' = 'Sensor Identifier (SID)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledgment Timestamp (AAT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code (AC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `alarm_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Status (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `alarm_status` SET TAGS ('dbx_value_regex' = 'active|acknowledged|cleared');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'alarm|fault');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `classification_rule` SET TAGS ('dbx_business_glossary_term' = 'Classification Rule Identifier (CRI)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Clearance Timestamp (ACT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `fdc_event_description` SET TAGS ('dbx_business_glossary_term' = 'Fdc Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Automated Disposition (AD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'lot_hold|tool_stop|alert_only|none');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Alarm Duration (seconds) (AD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `engineer_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Engineer Review Outcome (ERO)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `engineer_review_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|deferred');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (EF)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `fault_classification` SET TAGS ('dbx_business_glossary_term' = 'Fault Classification');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `is_simulated` SET TAGS ('dbx_business_glossary_term' = 'Simulated Event Flag (SEF)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `limit_violated` SET TAGS ('dbx_business_glossary_term' = 'Limit Violated');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `lot_step` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Step (LPS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Alarm Message Text (AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `normal_range_high` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Range High (NORH)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `normal_range_low` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Range Low (NORL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage (OEEIP)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `onset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Onset Timestamp (EOT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Triggering Parameter Name (TPN)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Triggering Parameter Value (TPV)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority (AP)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `response_action` SET TAGS ('dbx_business_glossary_term' = 'Response Action');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RCC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|material|human|environment');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail (RCD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity (AS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Source Category (SC)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'sensor|subsystem|chamber|software');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name (SN)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `threshold_high` SET TAGS ('dbx_business_glossary_term' = 'Fault Threshold High (FTH)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `threshold_low` SET TAGS ('dbx_business_glossary_term' = 'Fault Threshold Low (FTL)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`fdc_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_capex_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Capital Expenditure ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Asset ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capex_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Capex Amount Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capex_date` SET TAGS ('dbx_business_glossary_term' = 'Capex Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capex_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Number (CAPEX_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capex_status` SET TAGS ('dbx_business_glossary_term' = 'Capex Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `covered_failure_modes` SET TAGS ('dbx_business_glossary_term' = 'Covered Failure Modes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_capex_description` SET TAGS ('dbx_business_glossary_term' = 'Capex Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `extended_warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal_capex|chips_grant|joint_venture|external_finance');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `installation_cost` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `make_vs_buy_repair_decision` SET TAGS ('dbx_business_glossary_term' = 'Make‑vs‑Buy Repair Decision');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `make_vs_buy_repair_decision` SET TAGS ('dbx_value_regex' = 'make|buy|hybrid');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `nre_charges` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charges (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Price (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time SLA (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `third_party_service_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Service Contract Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `tool_capex_status` SET TAGS ('dbx_business_glossary_term' = 'Capex Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_claim_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Total Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_capex` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'parts|labor|full_coverage|none');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `tool_safety_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Safety Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool ID');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `cert_number` SET TAGS ('dbx_business_glossary_term' = 'Cert Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `cert_status` SET TAGS ('dbx_business_glossary_term' = 'Cert Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `cert_type` SET TAGS ('dbx_business_glossary_term' = 'Cert Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'valid|expired|revoked|pending');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'chemical|electrical|ergonomics|environmental');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_value_regex' = 'SEMI_S2|SEMI_S22|SEMI_S8|ISO_14001|RoHS|REACH');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `identified_hazards` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazards');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `next_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage (OEE IMPACT)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `recertification_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval (DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `required_controls` SET TAGS ('dbx_business_glossary_term' = 'Required Safety Controls');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK)');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `safety_standard` SET TAGS ('dbx_business_glossary_term' = 'Safety Standard');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`tool_safety_cert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` SET TAGS ('dbx_association_edges' = 'equipment.spare_part,compliance.substance_inventory');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `part_substance_composition_id` SET TAGS ('dbx_business_glossary_term' = 'Part Substance Composition Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `declaration_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Substance Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `above_threshold` SET TAGS ('dbx_business_glossary_term' = 'Above Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Cas Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `concentration` SET TAGS ('dbx_business_glossary_term' = 'Concentration');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Concentration Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `concentration_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Concentration Weight Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `data_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Basis');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `declaration_source` SET TAGS ('dbx_business_glossary_term' = 'Declaration Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `disclosure_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Threshold Exceeded Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Exemption Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `exemption_reference` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `homogeneous_material` SET TAGS ('dbx_business_glossary_term' = 'Homogeneous Material');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `homogeneous_material_name` SET TAGS ('dbx_business_glossary_term' = 'Homogeneous Material Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `is_reach_svhc` SET TAGS ('dbx_business_glossary_term' = 'Is Reach Svhc');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `is_rohs_relevant` SET TAGS ('dbx_business_glossary_term' = 'Is Rohs Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `is_rohs_restricted` SET TAGS ('dbx_business_glossary_term' = 'Is Rohs Restricted');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `mass_grams` SET TAGS ('dbx_business_glossary_term' = 'Mass Grams');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `mass_percent` SET TAGS ('dbx_business_glossary_term' = 'Mass Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `measured_date` SET TAGS ('dbx_business_glossary_term' = 'Measured Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `reach_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `reach_relevant` SET TAGS ('dbx_business_glossary_term' = 'Reach Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `reach_status` SET TAGS ('dbx_business_glossary_term' = 'Reach Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `reach_svhc_flag` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `rohs_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `rohs_relevant` SET TAGS ('dbx_business_glossary_term' = 'Rohs Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `rohs_restricted` SET TAGS ('dbx_business_glossary_term' = 'Rohs Restricted');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `rohs_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Rohs Restricted Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `rohs_status` SET TAGS ('dbx_business_glossary_term' = 'Rohs Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `supplier_declaration_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Declaration Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Exceeded Flag');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `threshold_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `usage_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Usage Volume Kg');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Weight Grams');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Weight Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `weight_ppm` SET TAGS ('dbx_business_glossary_term' = 'Weight Ppm');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`part_substance_composition` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_id` SET TAGS ('dbx_business_glossary_term' = 'Sensor Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `parent_sensor_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sensor Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `parent_sensor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `accuracy` SET TAGS ('dbx_business_glossary_term' = 'Accuracy');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `data_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Data Rate Hz');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Ip Address');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `last_maintenance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Mac Address');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `max_range` SET TAGS ('dbx_business_glossary_term' = 'Max Range');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Max');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Min');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `min_range` SET TAGS ('dbx_business_glossary_term' = 'Min Range');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `next_maintenance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `power_rating_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Rating Watts');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sampling_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate Hz');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `sensor_type` SET TAGS ('dbx_business_glossary_term' = 'Sensor Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`sensor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `superseded_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Maintenance Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `superseded_maintenance_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval Days');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `frequency_value` SET TAGS ('dbx_business_glossary_term' = 'Frequency Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `required_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `requires_calibration` SET TAGS ('dbx_business_glossary_term' = 'Requires Calibration');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `strategy` SET TAGS ('dbx_business_glossary_term' = 'Strategy');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `task_count` SET TAGS ('dbx_business_glossary_term' = 'Task Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `tool_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Serial Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `vendor_contact` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `vendor_contact` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `vendor_contact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `vendor_contact` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` SET TAGS ('dbx_subdomain' = 'recipe_execution');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` SET TAGS ('dbx_ssot_owner' = 'process.site_map');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `equipment_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Site Map Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `parent_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Site Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `parent_site_map_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `primary_authoritative_process_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Process Site Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `process_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Site Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `process_site_map_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `layout_reference` SET TAGS ('dbx_business_glossary_term' = 'Layout Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `map_code` SET TAGS ('dbx_business_glossary_term' = 'Map Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `map_name` SET TAGS ('dbx_business_glossary_term' = 'Map Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `map_version` SET TAGS ('dbx_business_glossary_term' = 'Map Version');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `measurement_location` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `measurement_point_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `measurement_site_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Site Count');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `number_of_tools` SET TAGS ('dbx_business_glossary_term' = 'Number Of Tools');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `oee_actual` SET TAGS ('dbx_business_glossary_term' = 'Oee Actual');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `oee_target` SET TAGS ('dbx_business_glossary_term' = 'Oee Target');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `position_x` SET TAGS ('dbx_business_glossary_term' = 'Position X');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `position_y` SET TAGS ('dbx_business_glossary_term' = 'Position Y');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Site Area Sqft');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_index` SET TAGS ('dbx_business_glossary_term' = 'Site Index');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_map_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_map_name` SET TAGS ('dbx_business_glossary_term' = 'Site Map Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_map_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Ssot Owner Reference');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `ssot_owner_reference` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `tertiary_process_site_map_id` SET TAGS ('dbx_business_glossary_term' = 'Process Site Map Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `tertiary_process_site_map_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_pii_geolocation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_site_map` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `equipment_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `parent_fab_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fab Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `parent_fab_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Fab Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `area_sq_meters` SET TAGS ('dbx_business_glossary_term' = 'Area Sq Meters');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `capacity_wafer_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `capacity_wafer_per_year` SET TAGS ('dbx_business_glossary_term' = 'Capacity Wafer Per Year');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `environmental_certifications` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'Fab Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `fab_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `monthly_capacity_wafers` SET TAGS ('dbx_business_glossary_term' = 'Monthly Capacity Wafers');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `number_of_cleanrooms` SET TAGS ('dbx_business_glossary_term' = 'Number Of Cleanrooms');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `oee_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'Oee Actual Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Oee Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `process_node_capability` SET TAGS ('dbx_business_glossary_term' = 'Process Node Capability');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `safety_certifications` SET TAGS ('dbx_business_glossary_term' = 'Safety Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `site_owner` SET TAGS ('dbx_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size Mm');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `year_commissioned` SET TAGS ('dbx_business_glossary_term' = 'Year Commissioned');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `year_decommissioned` SET TAGS ('dbx_business_glossary_term' = 'Year Decommissioned');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`equipment_fab` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `maintenance_vendor_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `renewed_maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Maintenance Contract Id');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `renewed_maintenance_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `annual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `annual_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Value Usd');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Url');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `maintenance_scope` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Scope');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Sla Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Sla Resolution Time Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `sla_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Sla Response Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Sla Response Time Hours');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_semiconductors_v1`.`equipment`.`maintenance_contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
