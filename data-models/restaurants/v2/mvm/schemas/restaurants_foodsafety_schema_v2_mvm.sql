-- Schema for Domain: foodsafety | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-01 14:08:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`foodsafety` COMMENT 'Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the HACCP plan record.',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether allergen control procedures are defined in the plan.',
    `approval_date` DATE COMMENT 'Date the HACCP plan received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the HACCP plan.. Valid values are `approved|pending|rejected`',
    `approved_by` STRING COMMENT 'Name of the food safety manager or authority who approved the plan.',
    `audit_last_date` DATE COMMENT 'Date of the most recent HACCP audit.',
    `audit_next_due` DATE COMMENT 'Scheduled date for the next HACCP audit.',
    `audit_status` STRING COMMENT 'Result of the most recent HACCP audit.. Valid values are `compliant|non_compliant|pending|in_progress|failed|not_applicable`',
    `compliance_status` STRING COMMENT 'Current overall compliance standing of the HACCP plan.. Valid values are `compliant|non_compliant|under_review`',
    `corrective_action_procedure` STRING COMMENT 'Standard steps to be taken when a CCP deviation occurs.',
    `critical_control_points` STRING COMMENT 'List of CCPs defined in the plan, stored as a delimited string.',
    `document_status` STRING COMMENT 'Current status of the HACCP document in the document lifecycle.. Valid values are `active|archived|superseded|draft|retired|pending`',
    `document_url` STRING COMMENT 'Link to the stored electronic version of the HACCP plan.',
    `effective_from` DATE COMMENT 'Date when the HACCP plan becomes effective and enforceable.',
    `effective_until` DATE COMMENT 'Date when the HACCP plan expires or is superseded; null if open‑ended.',
    `hazard_analysis_summary` STRING COMMENT 'Brief narrative summarizing identified hazards and risk assessments.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the HACCP plan.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the HACCP plan.. Valid values are `draft|active|inactive|retired|suspended|pending`',
    `monitoring_frequency` STRING COMMENT 'How often each CCP is monitored.. Valid values are `per_shift|daily|weekly|monthly|quarterly|annually`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the HACCP plan.',
    `non_conformance_count` STRING COMMENT 'Number of recorded non‑conformances since the last review.',
    `plan_code` STRING COMMENT 'External business code or identifier used to reference the HACCP plan in reports and audits.',
    `plan_name` STRING COMMENT 'Descriptive name of the HACCP plan for the restaurant unit.',
    `plan_type` STRING COMMENT 'Classification of the plan based on the entity it governs (e.g., restaurant, franchise, corporate, supplier).. Valid values are `Restaurant|Franchise|Corporate|Supplier`',
    `plan_version` STRING COMMENT 'Version identifier of the HACCP plan, typically following a major.minor scheme.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the HACCP plan record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the HACCP plan record.',
    `regulatory_framework` STRING COMMENT 'Regulatory standard(s) the HACCP plan aligns with.. Valid values are `FDA_FSMA|ISO_22000|ServSafe|Local_Health`',
    `revision_number` STRING COMMENT 'Sequential revision count for the HACCP plan.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the plan.. Valid values are `low|medium|high|critical`',
    `sanitation_schedule_reference` STRING COMMENT 'Link or code to the sanitation schedule tied to this HACCP plan.',
    `scope_description` STRING COMMENT 'Narrative describing the physical or operational scope covered by the plan.',
    `temperature_log_reference` STRING COMMENT 'Identifier or path to the temperature log data associated with this plan.',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Indicates if temperature monitoring is a required control in this plan.',
    `training_completion_date` DATE COMMENT 'Date when required training was completed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether staff training is required for this plan.',
    CONSTRAINT pk_haccp_plan PRIMARY KEY(`haccp_plan_id`)
) COMMENT 'Master record for each restaurant units Hazard Analysis and Critical Control Points (HACCP) plan, including plan version, scope, approval status, regulatory framework alignment (FDA FSMA, ISO 22000, Codex Alimentarius), effective and expiration dates, responsible food safety manager, team members, and prerequisite program references. Serves as the authoritative SSOT for HACCP program governance across all company-owned and franchised units. Each plan undergoes annual review and revalidation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` (
    `critical_control_point_id` BIGINT COMMENT 'Unique system-generated identifier for the critical control point.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each Critical Control Point belongs to a single HACCP plan; adding haccp_plan_id creates the required parent link.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: CCPs are physically located at specific kitchen stations — the grill station is a CCP for cook temperature, the cold-hold station for storage temperature. Linking CCP to kitchen_station enables statio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Each CCP must have a qualified employee monitor it; linking enables CCP compliance reports and corrective‑action tracking.',
    `average_deviation_value` DECIMAL(18,2) COMMENT 'Average magnitude of deviations observed across monitoring events.',
    `critical_control_point_code` STRING COMMENT 'Business identifier code used to reference the CCP in SOPs and audits.',
    `corrective_action_procedure` STRING COMMENT 'Standardized steps to take when a deviation from the critical limit occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CCP record was first created in the system.',
    `critical_control_point_status` STRING COMMENT 'Current lifecycle status of the CCP.. Valid values are `active|inactive|retired|pending_review`',
    `critical_limit_max` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable range for the control parameter (e.g., maximum temperature).',
    `critical_limit_min` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable range for the control parameter (e.g., minimum temperature).',
    `deviation_count` STRING COMMENT 'Cumulative number of recorded deviations from the critical limits.',
    `effective_end_date` DATE COMMENT 'Date when the CCP is retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the CCP became effective.',
    `haccp_plan_version` STRING COMMENT 'Version identifier of the HACCP plan to which this CCP belongs.',
    `hazard_type` STRING COMMENT 'Category of hazard the CCP is designed to control.. Valid values are `biological|chemical|physical`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the CCP is classified as a critical control point (true) or a control point (false).',
    `last_monitored_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent monitoring observation.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent verification activity.',
    `monitoring_frequency` STRING COMMENT 'How often the CCP is monitored.. Valid values are `continuous|hourly|per_batch|daily|weekly|monthly`',
    `monitoring_method` STRING COMMENT 'Technique or instrument used to monitor the CCP (e.g., calibrated thermometer).',
    `critical_control_point_name` STRING COMMENT 'Human‑readable name of the critical control point.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the CCP.',
    `process_step` STRING COMMENT 'Operational step in the food preparation flow where the CCP applies.. Valid values are `receiving|storage|preparation|cooking|cooling|serving`',
    `regulatory_reference` STRING COMMENT 'Applicable regulatory or certification reference (e.g., FDA FSMA, ISO 22000, ServSafe).',
    `responsible_role` STRING COMMENT 'Job role accountable for monitoring and maintaining the CCP.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the critical limit values.. Valid values are `C|F|pH|minutes|seconds|hours`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CCP record.',
    `verification_frequency` STRING COMMENT 'How often the CCP is independently verified for compliance.. Valid values are `weekly|monthly|quarterly|annually`',
    `verification_method` STRING COMMENT 'Method used during verification (e.g., internal audit, third‑party audit).',
    CONSTRAINT pk_critical_control_point PRIMARY KEY(`critical_control_point_id`)
) COMMENT 'Defines each Critical Control Point (CCP) within a HACCP plan, including the hazard type (biological, chemical, physical), critical limits (min/max temperature, pH, time), monitoring method, corrective action procedure, and verification frequency. Each CCP is tied to a specific process step (e.g., cooking, cooling, receiving) and HACCP plan version.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique surrogate key for the health inspection record.',
    `employee_id` BIGINT COMMENT 'System identifier for the inspector.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location inspected.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Health inspections evaluate specific storage locations; linking enables location‑level inspection reports and corrective actions.',
    `agency_name` STRING COMMENT 'Name of the regulatory agency that performed the inspection.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates if supporting documents (photos, reports) are attached.',
    `closure_order_date` DATE COMMENT 'Date when the closure order was issued.',
    `closure_order_flag` BOOLEAN COMMENT 'Indicates if the inspection resulted in a closure order.',
    `compliance_code` STRING COMMENT 'Regulatory framework or code applicable to the inspection.. Valid values are `FSMA|HACCP|Local_Code`',
    `corrective_action_deadline` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates if corrective actions are required.',
    `corrective_action_status` STRING COMMENT 'Current status of required corrective actions.. Valid values are `pending|completed|not_applicable`',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO currency code for the inspection fee.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled date for the follow-up inspection.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Indicates if a follow-up inspection is mandated.',
    `inspection_date` DATE COMMENT 'Date when the health inspection was conducted.',
    `inspection_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the agency for conducting the inspection.',
    `inspection_number` STRING COMMENT 'Official inspection number assigned by the regulatory agency.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `scheduled|in_progress|completed|closed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Exact date and time when the health inspection took place.',
    `inspection_type` STRING COMMENT 'Category of the inspection based on its trigger.. Valid values are `routine|follow_up|complaint|reinspection`',
    `inspector_code` BIGINT COMMENT 'System identifier for the inspector.',
    `inspector_name` STRING COMMENT 'Name of the inspector who performed the health inspection.',
    `notes` STRING COMMENT 'Additional comments or observations recorded by the inspector.',
    `overall_grade` STRING COMMENT 'Overall grade assigned by the inspector.. Valid values are `A|B|C|D|F|NA`',
    `pass_fail` STRING COMMENT 'Indicates whether the restaurant passed the inspection.. Valid values are `pass|fail`',
    `permit_status` STRING COMMENT 'Current status of the health permit.. Valid values are `active|suspended|revoked|expired`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first entered into the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `risk_level` STRING COMMENT 'Overall risk classification based on inspection findings.. Valid values are `low|medium|high|critical`',
    `score` STRING COMMENT 'Numeric score representing compliance level (higher is better).',
    `violation_summary` STRING COMMENT 'Brief description of the violations identified.',
    `violations_count` STRING COMMENT 'Number of violations cited in the inspection.',
    CONSTRAINT pk_health_inspection PRIMARY KEY(`health_inspection_id`)
) COMMENT 'Header-and-line record of official health inspections conducted by local health departments or regulatory authorities at restaurant units, including inspection header (date, inspector, agency, type: routine/follow-up/complaint-driven, overall grade, permit status, closure orders) and individual violations as line items (violation code, severity: critical/non-critical, FDA Food Code citation, corrective action required, compliance deadline, re-inspection outcome). This is the authoritative regulatory inspection record distinct from internal food safety audits.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` (
    `inspection_violation_id` BIGINT COMMENT 'Unique identifier for the inspection violation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector who recorded the violation.',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that generated this violation.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation was observed.',
    `area_of_concern` STRING COMMENT 'Physical area within the restaurant where the violation occurred.. Valid values are `kitchen|storage|dining|restroom|outside`',
    `compliance_deadline` DATE COMMENT 'Date by which the corrective action must be completed to achieve compliance.',
    `corrective_action_required` STRING COMMENT 'Action that must be taken to remediate the violation.',
    `corrective_action_status` STRING COMMENT 'Current progress status of the corrective action.. Valid values are `not_started|in_progress|completed|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `evidence_photo_url` STRING COMMENT 'Link to photographic evidence associated with the violation.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled date for the re‑inspection after corrective actions.',
    `inspection_violation_status` STRING COMMENT 'Current lifecycle status of the violation record.. Valid values are `open|closed|in_progress|dismissed`',
    `inspector_code` BIGINT COMMENT 'Identifier of the inspector who recorded the violation.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the violation.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for the violation, if any.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory provision (e.g., FDA Food Code section) that the violation breaches.',
    `reinspection_outcome` STRING COMMENT 'Result of the follow‑up inspection after corrective actions were taken.. Valid values are `resolved|unresolved|pending|not_applicable`',
    `severity` STRING COMMENT 'Severity level of the violation indicating its impact on food safety.. Valid values are `critical|non-critical|minor`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violation_code` STRING COMMENT 'Standardized code assigned to the violation by the regulatory authority.. Valid values are `^[A-Z0-9.-]+$`',
    `violation_description` STRING COMMENT 'Full textual description of the violation observed during the inspection.',
    `violation_reported_by` STRING COMMENT 'Full name of the inspector who reported the violation.',
    `violation_timestamp` TIMESTAMP COMMENT 'Exact date and time when the violation was observed.',
    `violation_type` STRING COMMENT 'Broad category describing the nature of the violation.. Valid values are `food|facility|equipment|hygiene|documentation`',
    CONSTRAINT pk_inspection_violation PRIMARY KEY(`inspection_violation_id`)
) COMMENT 'Individual violation cited during an official health inspection, including violation code, description, severity classification (critical, non-critical), regulatory citation (FDA Food Code section, local ordinance), corrective action required, compliance deadline, and re-inspection outcome. Supports regulatory compliance tracking and trend analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'System-generated unique identifier for each temperature reading record.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Temperature logs are captured specifically at Critical Control Points (CCPs) as part of HACCP monitoring requirements. Each temperature reading is associated with a specific CCP being monitored (e.g.,',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: HACCP cold-chain monitoring requires temperature logs to be traceable to specific ingredient lots in storage. When a temperature deviation is flagged, food safety managers must identify which lots wer',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Temperature logs are recorded at specific kitchen stations (walk-in cooler, hot-holding line, prep station). While equipment_asset FKs exist, not all temperature monitoring is equipment-specific — sta',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the equipment or sensor that generated the temperature reading.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: Temperature logs record actual prep/holding temperatures during food production. Linking to the recipe being prepared enables automated HACCP compliance verification: actual temperature vs. recipe-req',
    `shift_id` BIGINT COMMENT 'Identifier of the workforce shift during which the reading was taken.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the restaurant location or specific area (e.g., kitchen, dock) where the reading occurred.',
    `audit_reference` STRING COMMENT 'Identifier linking the reading to a specific food safety audit or inspection.',
    `batch_number` STRING COMMENT 'Optional batch identifier grouping a set of readings for a specific audit period.',
    `calibration_date` DATE COMMENT 'Date when the sensor was last calibrated.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next sensor calibration.',
    `compliance_status` STRING COMMENT 'Result of compliance check for this reading against HACCP requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the temperature log record was initially created in the system.',
    `critical_limit_high` DECIMAL(18,2) COMMENT 'Upper temperature threshold defined by HACCP for the monitoring point.',
    `critical_limit_low` DECIMAL(18,2) COMMENT 'Lower temperature threshold defined by HACCP for the monitoring point.',
    `data_quality_flag` BOOLEAN COMMENT 'Indicator of the data quality assessment for the reading.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the temperature reading falls outside the defined critical limits.',
    `maintenance_due_date` DATE COMMENT 'Planned date for required maintenance activities.',
    `maintenance_required` BOOLEAN COMMENT 'Indicates whether the equipment requires maintenance based on the reading or schedule.',
    `monitoring_method` STRING COMMENT 'Method used to capture the temperature (manual probe or automated sensor).. Valid values are `manual|automated`',
    `notes` STRING COMMENT 'Free‑text field for additional observations or comments about the reading.',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature measurement was taken at the monitoring point.',
    `reading_type` STRING COMMENT 'Category of the monitoring point where the temperature was recorded.. Valid values are `cooler|freezer|hot_holding|cooking|receiving`',
    `sensor_serial_number` STRING COMMENT 'Manufacturer serial number of the temperature sensor device.',
    `temperature_log_status` STRING COMMENT 'Current lifecycle status of the temperature log record.. Valid values are `active|archived`',
    `temperature_trend` STRING COMMENT 'Observed trend of temperature change relative to previous readings.. Valid values are `rising|falling|stable`',
    `temperature_value` DECIMAL(18,2) COMMENT 'Measured temperature value captured by the sensor or manual probe.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the temperature reading (Fahrenheit or Celsius).. Valid values are `F|C`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the temperature log record.',
    CONSTRAINT pk_temperature_log PRIMARY KEY(`temperature_log_id`)
) COMMENT 'Time-series log of temperature readings captured at critical monitoring points (walk-in coolers, freezers, hot-holding units, cooking equipment, receiving docks), including equipment ID, reading timestamp, measured temperature, unit of measure (°F/°C), critical limit thresholds, deviation flag, and monitoring method (manual probe, automated sensor). Core HACCP monitoring record per Principle 4.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` (
    `sanitation_schedule_id` BIGINT COMMENT 'Unique identifier for the sanitation schedule.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Sanitation schedules are created as part of a HACCP plans requirements — the HACCP plan governs what sanitation activities must be performed and at what frequency. haccp_plan already has a sanitation',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Sanitation schedules are assigned to specific kitchen stations (prep station, dish station, grill area). The plain-text area column denormalizes kitchen_station. A FK enables station-level sanitatio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Sanitation schedule assigns a specific employee; FK provides traceability for health inspections and internal audits.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Equipment-specific sanitation schedules (fryer cleaning, ice machine sanitation, hood cleaning) are a core food safety requirement. The existing plain-text equipment column is a denormalization of e',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Sanitation schedules are unit-specific operational documents required for health inspections. Linking sanitation_schedule to its restaurant unit enables unit-level sanitation compliance reporting, hea',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation schedules are defined per storage area; the FK associates each schedule with its location.',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether the task includes allergen control measures.',
    `audit_required_flag` BOOLEAN COMMENT 'Whether a post‑task audit is required.',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Required concentration of the chemical (e.g., "200 ppm").',
    `chemical_name` STRING COMMENT 'Name of the chemical or sanitizer used.',
    `cleaning_method` STRING COMMENT 'Method used to perform the cleaning (e.g., manual, automated, steam).',
    `compliance_status` STRING COMMENT 'Current compliance status of the task against food‑safety regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was created.',
    `sanitation_schedule_description` STRING COMMENT 'Detailed description of the schedule purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the schedule expires or is superseded (nullable).',
    `frequency` STRING COMMENT 'Number of times the task occurs within the defined frequency unit.',
    `frequency_unit` STRING COMMENT 'Time unit for the task frequency.. Valid values are `hourly|daily|weekly|monthly|quarterly|annually`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the task is mandatory for compliance.',
    `last_performed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the task.',
    `next_due_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next required execution of the task.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `priority_level` STRING COMMENT 'Priority assigned to the task for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `responsible_role` STRING COMMENT 'Job role responsible for executing the task (e.g., Shift Lead, Kitchen Manager).',
    `sanitation_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|retired|draft`',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule.. Valid values are `^[A-Z0-9]{3,10}$`',
    `schedule_name` STRING COMMENT 'Human‑readable name of the schedule.',
    `sop_reference` STRING COMMENT 'Identifier of the Standard Operating Procedure that governs the task.',
    `task_name` STRING COMMENT 'Name of the specific cleaning or sanitizing task.',
    `temperature_requirement_celsius` DECIMAL(18,2) COMMENT 'Required temperature condition for the cleaning task, expressed in Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `version_number` STRING COMMENT 'Version number of the schedule for change management.',
    `waste_disposal_method` STRING COMMENT 'Method used to dispose of waste generated by the task (e.g., biohazard, recyclable).',
    CONSTRAINT pk_sanitation_schedule PRIMARY KEY(`sanitation_schedule_id`)
) COMMENT 'Master sanitation schedule (MSS) with execution log for each restaurant unit, including schedule template (task name, target area: FOH/BOH zone/equipment, frequency: hourly/daily/weekly, chemical/sanitizer, concentration requirements, responsible role, SOP reference) and task execution records (completion timestamp, employee, actual concentration measured, pass/fail, deviation notes). Managed via Zenput task management. Serves as both the authoritative sanitation template and the compliance evidence of task completion.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` (
    `sanitation_task_log_id` BIGINT COMMENT 'Unique system-generated identifier for each sanitation task log entry.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who executed the sanitation task.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit where the sanitation activity took place.',
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier of the equipment item that was sanitized.',
    `sanitation_schedule_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sanitation_schedule. Business justification: sanitation_task_log is the transactional execution record of tasks defined in sanitation_schedule. Each task log entry records the actual execution (or missed execution) of a scheduled sanitation task',
    `shift_id` BIGINT COMMENT 'Unique identifier of the employee shift associated with the task.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation tasks are scheduled per storage area; the FK ties task logs to the exact location for compliance tracking.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task log entry was first inserted into the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the sanitation task log entry.',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Numeric value of the chemical concentration measured during the task.',
    `chemical_name` STRING COMMENT 'Descriptive name of the chemical or sanitizer applied during the task.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task was marked as completed.',
    `compliance_regulation` STRING COMMENT 'Regulation or standard that the sanitation task satisfies.. Valid values are `FDA_FSMA|ServSafe|ISO_22000|Local_Health`',
    `concentration_unit` DECIMAL(18,2) COMMENT 'Unit of measure for the chemical concentration (e.g., parts per million).',
    `corrective_action` STRING COMMENT 'Description of any corrective measures applied after a failed sanitation check.',
    `deviation_notes` STRING COMMENT 'Free‑text description of any deviations, issues, or observations noted during the task.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage measured in the task area at the time of execution.',
    `is_critical` BOOLEAN COMMENT 'True if the sanitation task is deemed critical for food safety compliance.',
    `location_area` STRING COMMENT 'Specific area (e.g., Front‑of‑House, Back‑of‑House) where sanitation was executed.. Valid values are `FOH|BOH|kitchen|dining|storage`',
    `notes` STRING COMMENT 'Any supplemental information not captured in other fields.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the sanitation task met compliance criteria.. Valid values are `pass|fail`',
    `photo_url` STRING COMMENT 'Web address of a photo taken as evidence of task completion.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task was scheduled to occur.',
    `task_duration_seconds` STRING COMMENT 'Total time taken to complete the sanitation task, measured in seconds.',
    `task_status` STRING COMMENT 'Operational status of the sanitation task record.. Valid values are `completed|missed|overdue|in_progress`',
    `task_timestamp` TIMESTAMP COMMENT 'Exact date and time the sanitation task was completed.',
    `task_type` STRING COMMENT 'Classification of the sanitation task (e.g., surface cleaning, equipment sanitization).. Valid values are `surface_clean|equipment_sanitize|hand_wash|trash_bin_clean`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius measured in the task area at the time of execution.',
    `verification_method` STRING COMMENT 'Technique employed to confirm task compliance.. Valid values are `visual|sensor|chemical_test`',
    CONSTRAINT pk_sanitation_task_log PRIMARY KEY(`sanitation_task_log_id`)
) COMMENT 'Transactional record of each completed or missed sanitation task execution at a restaurant unit, capturing task completion timestamp, employee who performed the task, actual chemical concentration measured, pass/fail status, and any deviation notes. Linked to the master sanitation schedule and managed via Zenput task management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` (
    `allergen_incident_id` BIGINT COMMENT 'System-generated unique identifier for the allergen incident record.',
    `allergen_declaration_id` BIGINT COMMENT 'Foreign key linking to menu.allergen_declaration. Business justification: Allergen incident investigations must reference the allergen declaration in effect at the time of the incident to determine if the declaration was accurate or incomplete. Required for FDA MedWatch fil',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who reported the allergen reaction.',
    `catering_order_id` BIGINT COMMENT 'Foreign key linking to order.catering_order. Business justification: Catering events serving large groups carry elevated allergen liability. Linking allergen incidents directly to catering orders enables catering-specific food safety reporting, liability management, an',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to guest.complaint. Business justification: Regulatory traceability requirement: allergen incidents triggered by guest complaints must be linked for FDA/health dept investigations and root-cause analysis. Food safety managers need to pull the o',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who responded to or recorded the incident.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the POS order associated with the incident, if applicable.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for root‑cause analysis: trace allergen incidents to the specific ingredient causing the reaction, supporting recall and corrective action reports.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: FDA recall and allergen investigation regulations require lot-level traceability. allergen_incident already links to ingredient (master), but investigators must identify the exact lot to scope a recal',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Allergen incident handling awards loyalty points to members who report incidents; direct member link is required for points accrual and incident reporting.',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Regulatory allergen incident investigations require tracing the exact order line item (specific preparation, modifiers, ingredient lot) that caused the reaction. Direct FK enables incident-to-line-ite',
    `prep_usage_id` BIGINT COMMENT 'Foreign key linking to inventory.prep_usage. Business justification: Allergen incidents are frequently caused by cross-contamination during prep. Linking allergen_incident to the specific prep_usage batch enables root cause investigation, FDA MedWatch filing support, a',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: Allergen incident root cause analysis requires tracing back to the specific recipe version prepared at the time of the incident. Enables investigation of whether recipe ingredients or substitutions ca',
    `shift_id` BIGINT COMMENT 'Identifier of the employee shift during which the incident happened.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Allergen incidents are traced to the offending ingredient; the FK connects the incident to the stock item for root‑cause analysis.',
    `temperature_log_id` BIGINT COMMENT 'Reference to the temperature monitoring record associated with the incident, if relevant.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Allergen incident root-cause analysis requires tracing the specific guest visit (visit date/time, table, party size, service channel) during which the incident occurred. Food safety auditors and healt',
    `allergen_code` STRING COMMENT 'Standardized code for the allergen (e.g., ISO 22000 allergen code).',
    `allergen_incident_status` STRING COMMENT 'Current lifecycle state of the incident.. Valid values are `open|investigating|resolved|closed|rejected`',
    `allergen_name` STRING COMMENT 'Name of the allergen involved in the incident (e.g., peanuts, shellfish).',
    `complaint_description` STRING COMMENT 'Narrative provided by the guest describing the allergic reaction and circumstances.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the incident complies with internal SOPs and external regulations.',
    `corrective_action` STRING COMMENT 'Planned or executed corrective measures to prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `fda_medwatch_filed` BOOLEAN COMMENT 'Indicates whether the incident was reported to the FDA MedWatch system.',
    `guest_contact_info` STRING COMMENT 'Phone number or email address used to reach the guest.',
    `guest_contact_method` STRING COMMENT 'Preferred method used to contact the guest for follow‑up.. Valid values are `phone|email|in_person`',
    `immediate_action_taken` STRING COMMENT 'Actions performed at the time of the incident (e.g., administered epinephrine, called emergency services).',
    `incident_category` STRING COMMENT 'High‑level classification of the incident type.. Valid values are `food_allergy|cross_contamination|mislabel|ingredient_error|other`',
    `incident_location` STRING COMMENT 'Physical location within the restaurant where the incident occurred (e.g., kitchen, dining area).',
    `incident_notes` STRING COMMENT 'Free‑form notes captured by staff during investigation.',
    `incident_number` STRING COMMENT 'Business-facing identifier assigned to the incident for tracking and reporting.',
    `incident_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was formally closed or resolved.',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the allergen incident was observed or reported.',
    `investigation_complete` BOOLEAN COMMENT 'Indicates whether the root‑cause investigation has been completed.',
    `investigation_complete_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation was marked complete.',
    `is_repeat_incident` BOOLEAN COMMENT 'Indicates whether a similar allergen incident has been recorded previously at the same location.',
    `notification_date` DATE COMMENT 'Date on which the regulatory notification was submitted.',
    `regulatory_notification_status` STRING COMMENT 'Status of required notifications to regulatory bodies (e.g., FDA MedWatch).. Valid values are `not_notified|notified|pending|completed`',
    `reported_by` STRING COMMENT 'Name or identifier of the staff member who logged the incident.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the allergen exposure (e.g., cross‑contamination, mislabeling).',
    `severity_score` STRING COMMENT 'Numeric representation of incident severity (e.g., 1‑5 scale) for analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident record.',
    CONSTRAINT pk_allergen_incident PRIMARY KEY(`allergen_incident_id`)
) COMMENT 'Transactional record of a reported allergen-related incident at a restaurant unit, including incident date, guest complaint details, allergen involved, menu item implicated, severity (mild reaction, anaphylaxis, hospitalization), immediate response actions taken, root cause determination, and regulatory notification status (FDA MedWatch if applicable).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` (
    `illness_report_id` BIGINT COMMENT 'Unique identifier for the illness report record.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to guest.complaint. Business justification: FDA Food Code and local health department reporting requires linking foodborne illness reports to the originating guest complaint. Enables regulatory audit trail from guest complaint through illness i',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or is associated with the illness.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Employee foodborne illness reports are frequently associated with health inspections — either the illness triggers a follow-up health inspection, or an existing inspection is referenced as context for',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Illness reports track which menu item is suspected of causing foodborne illness — a core food safety traceability requirement. suspected_food_item is a plain text denormalization of menu_item. Prope',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the employee fell ill.',
    `action_plan` STRING COMMENT 'Planned actions to prevent recurrence.',
    `action_plan_completed_date` DATE COMMENT 'Date when the action plan was completed.',
    `action_plan_due_date` DATE COMMENT 'Target date for completing the action plan.',
    `compliance_reference` STRING COMMENT 'Reference to the specific regulatory requirement or guidance applicable to the report.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action performed in response to the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the report record was first created in the system.',
    `exclusion_decision` BOOLEAN COMMENT 'Indicates whether the employee was excluded from work due to the illness.',
    `exclusion_start_date` DATE COMMENT 'Date when the employees work exclusion began.',
    `health_department_notification_date` DATE COMMENT 'Date when the health department was notified about the incident.',
    `health_department_notified` BOOLEAN COMMENT 'Flag indicating whether the local health department was notified.',
    `illness_report_status` STRING COMMENT 'Current lifecycle status of the illness report.. Valid values are `reported|under_review|closed|rejected`',
    `investigation_end_date` DATE COMMENT 'Date when the health investigation concluded.',
    `investigation_start_date` DATE COMMENT 'Date when the health investigation began.',
    `investigation_status` STRING COMMENT 'Current status of the health investigation.. Valid values are `not_started|in_progress|completed|closed`',
    `notes` STRING COMMENT 'Free‑form notes captured by investigators or managers.',
    `onset_date` DATE COMMENT 'Date when the employee first experienced symptoms.',
    `report_method` STRING COMMENT 'Method by which the illness was reported.. Valid values are `self|manager|hr`',
    `report_number` STRING COMMENT 'Business identifier assigned to the illness report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the illness was reported.',
    `return_to_work_date` DATE COMMENT 'Date when the employee was cleared to return to work.',
    `root_cause` STRING COMMENT 'Identified root cause of the illness, if determined.',
    `severity_level` STRING COMMENT 'Categorical severity level derived from the severity score.. Valid values are `mild|moderate|severe`',
    `severity_score` STRING COMMENT 'Numeric score representing the severity of the reported illness.',
    `suspected_pathogen` STRING COMMENT 'Pathogen suspected to have caused the illness, if known.',
    `symptoms` STRING COMMENT 'Symptoms reported by the employee, captured for health analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    CONSTRAINT pk_illness_report PRIMARY KEY(`illness_report_id`)
) COMMENT 'Transactional record of a reported employee foodborne illness or suspected foodborne illness event at a restaurant unit, capturing report date, employee role, symptoms reported, onset date, suspected pathogen or food item, exclusion-from-work decision, return-to-work clearance date, and health department notification status. Supports FDA Food Code employee health policy compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_sanitation_schedule_id` FOREIGN KEY (`sanitation_schedule_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule`(`sanitation_schedule_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_temperature_log_id` FOREIGN KEY (`temperature_log_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`temperature_log`(`temperature_log_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|in_progress|failed|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `critical_control_points` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Points (CCPs)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'active|archived|superseded|draft|retired|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `hazard_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|suspended|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Conformance Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Business Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'Restaurant|Franchise|Corporate|Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ISO_22000|ServSafe|Local_Health');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `sanitation_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point ID (CCP ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `average_deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Average Deviation Value (Avg Deviation)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_code` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Code (CCP Code)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure (CAP)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_business_glossary_term' = 'Status (CCP Status)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_max` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Maximum Value (Critical Limit Max)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_min` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Minimum Value (Critical Limit Min)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count (Number of Deviations)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (End Date)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Start Date)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version (Plan Version)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type (Biological/Chemical/Physical)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical (Critical Flag)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_monitored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Monitored Timestamp (Last Monitored At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (Last Verified At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Frequency)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|per_batch|daily|weekly|monthly');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method (Method)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Name (CCP Name)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (CCP Notes)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step (HACCP Process Step)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_value_regex' = 'receiving|storage|preparation|cooking|cooling|serving');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (Regulation)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role (Role)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'C|F|pH|minutes|seconds|hours');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency (Verification Frequency)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (Verification Method)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Issued');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_value_regex' = 'FSMA|HACCP|Local_Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Inspection Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fee Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INS_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint|reinspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name (INSPECTOR_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Grade (GRADE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|NA');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violations_count` SET TAGS ('dbx_business_glossary_term' = 'Violations Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Area of Concern');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_value_regex' = 'kitchen|storage|dining|restroom|outside');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Photo URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|dismissed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Outcome');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|pending|not_applicable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity (SEVERITY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|non-critical|minor');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code (CODE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]+$');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'food|facility|equipment|hygiene|documentation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Critical High Limit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Limit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_required` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'cooler|freezer|hot_holding|cooking|receiving');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sensor Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_value_regex' = 'active|archived');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_business_glossary_term' = 'Temperature Trend');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_value_regex' = 'rising|falling|stable');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_value` SET TAGS ('dbx_business_glossary_term' = 'Temperature Value');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Restaurant Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Concentration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `cleaning_method` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Task Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `last_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `next_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Due Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'SOP Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `temperature_requirement_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement (°C)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_task_log_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Task Log Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration (Measured)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizing Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ServSafe|ISO_22000|Local_Health');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (%)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Task Indicator');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_business_glossary_term' = 'Location Area');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_value_regex' = 'FOH|BOH|kitchen|dining|storage');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Photo URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `photo_url` SET TAGS ('dbx_pii_flag' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Task Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'completed|missed|overdue|in_progress');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Execution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Task Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'surface_clean|equipment_sanitize|hand_wash|trash_bin_clean');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'visual|sensor|chemical_test');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Incident ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `prep_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Prep Usage Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_code` SET TAGS ('dbx_business_glossary_term' = 'Allergen Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `fda_medwatch_filed` SET TAGS ('dbx_business_glossary_term' = 'FDA MedWatch Filed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Information');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|in_person');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'food_allergy|cross_contamination|mislabel|ingredient_error|other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Resolution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `investigation_complete` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `investigation_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `is_repeat_incident` SET TAGS ('dbx_business_glossary_term' = 'Repeat Incident Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_notified|notified|pending|completed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Identifier (IRID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (Shift ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_decision` SET TAGS ('dbx_business_glossary_term' = 'Exclusion From Work Decision');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Symptom Onset Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_business_glossary_term' = 'Report Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_value_regex' = 'self|manager|hr');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Number (IRN)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return To Work Clearance Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Illness Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Suspected Pathogen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_business_glossary_term' = 'Reported Symptoms (PHI)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
