-- Schema for Domain: foodsafety | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`foodsafety` COMMENT 'Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the HACCP plan record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: HACCP plan approval is a regulatory compliance process requiring a named responsible employee (food safety manager). The existing approved_by text column is a denormalized representation; replacing ',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: HACCP plans are developed to satisfy specific brand food safety standards. Brand standard compliance audits require linking each HACCP plan to the brand_standard it fulfills. QSR franchise operations ',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: HACCP plans in restaurants are scoped to operational departments (kitchen, prep, bar). This FK enables department-level HACCP compliance reporting, ensures the correct plan is applied per department, ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: HACCP plans are authored and approved for a specific restaurant unit. Health inspectors, brand auditors, and operations managers query active HACCP plans by unit for compliance reporting and inspectio',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether allergen control procedures are defined in the plan.',
    `approval_date` DATE COMMENT 'Date the HACCP plan received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the HACCP plan.. Valid values are `approved|pending|rejected`',
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
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Each CCP maps to a specific kitchen station where the control point is monitored (e.g., fry station CCP for oil temperature, receiving dock CCP for incoming ingredient temps). HACCP plans assign CCPs ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Each CCP must have a qualified employee monitor it; linking enables CCP compliance reports and corrective‑action tracking.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: CCPs are defined and monitored at specific restaurant units. Operations and food safety managers query all active CCPs for a given unit for health inspection preparation and HACCP compliance reporting',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'Surrogate primary key for the food safety audit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Food safety audits are conducted against specific brand standards. Brand standard compliance audits are a named QSR business process — the audit score measures adherence to the brand_standard. Brand o',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Each food safety audit is conducted against a specific HACCP plan. The existing haccp_plan_version (STRING) is a loose textual reference that becomes redundant once a proper FK to haccp_plan is establ',
    `primary_food_employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the audit was conducted.',
    `sanitation_schedule_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sanitation_schedule. Business justification: food_safety_audit has a sanitation_schedule_compliant (BOOLEAN) field indicating the audit evaluated a specific sanitation schedule. A FK to sanitation_schedule identifies exactly which schedule was a',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Food safety audits are performed on suppliers; linking audit to supplier enables audit‑by‑supplier reports required by regulatory compliance.',
    `allergen_control_compliant` BOOLEAN COMMENT 'Indicates compliance with allergen control requirements.',
    `attached_documents_count` STRING COMMENT 'Number of supporting documents attached to the audit record.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit, often used in reports and communications.',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was performed on site.',
    `audit_type` STRING COMMENT 'Classification of the audit source: internal, third‑party, or health department.. Valid values are `internal|third_party|health_department`',
    `auditor_name` STRING COMMENT 'Full name of the auditor.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Aggregated compliance score based on weighted findings.',
    `corrective_action_deadline` DATE COMMENT 'Date by which all corrective actions must be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions associated with the audit.. Valid values are `pending|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical (high‑severity) findings identified.',
    `food_safety_audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `pending|in_progress|completed|closed|failed`',
    `non_critical_findings_count` STRING COMMENT 'Number of non‑critical (low‑severity) findings identified.',
    `notes` STRING COMMENT 'Free‑text field for auditor observations, comments, and recommendations.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall compliance, typically 0‑100.',
    `pass_fail` STRING COMMENT 'Overall result indicating whether the audit passed or failed.. Valid values are `pass|fail`',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the audit.. Valid values are `FDA|USDA|OSHA|Local_Health_Department`',
    `sanitation_schedule_compliant` BOOLEAN COMMENT 'Indicates compliance with scheduled sanitation procedures.',
    `temperature_monitoring_compliant` BOOLEAN COMMENT 'Indicates if temperature monitoring met required standards during the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    CONSTRAINT pk_food_safety_audit PRIMARY KEY(`food_safety_audit_id`)
) COMMENT 'Header-and-line transactional record of each food safety audit conducted at a restaurant unit, including audit metadata (type: internal/third-party/health-department, date, auditor, overall score, pass/fail) and individual findings (category: critical/major/minor, regulatory reference, corrective action required, responsible party, due date, resolution status). Managed via Zenput. Supports QA compliance tracking, trend analysis, and regulatory reporting. Each audit contains zero-to-many findings as line items.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique surrogate key for the health inspection record.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Official health inspections conducted by local health departments evaluate the restaurant units compliance with its active HACCP plan. Linking health_inspection to haccp_plan enables regulators and i',
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
    `fee_currency_code` STRING COMMENT 'Three-letter ISO currency code for the inspection fee.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'System-generated unique identifier for the corrective action record.',
    `allergen_incident_id` BIGINT COMMENT 'Foreign key linking to foodsafety.allergen_incident. Business justification: Allergen incidents frequently trigger corrective and preventive actions (CAPA) — e.g., menu labeling corrections, supplier ingredient reviews, or staff retraining. Linking foodsafety_corrective_action',
    `employee_id` BIGINT COMMENT 'Identifier of the manager accountable for executing the corrective action.',
    `food_safety_audit_id` BIGINT COMMENT 'Identifier of the food safety audit that generated the finding.',
    `corrective_foodsafety_related_food_safety_audit_id` BIGINT COMMENT 'Identifier of the food safety audit that generated the finding.',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that uncovered the violation.',
    `corrective_foodsafety_related_inspection_health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that uncovered the violation.',
    `corrective_foodsafety_verified_by_employee_id` BIGINT COMMENT 'Identifier of the individual who verified the corrective action.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: foodsafety_corrective_action has a ccp_deviation (BOOLEAN) flag indicating the corrective action was triggered by a CCP deviation. A proper FK to critical_control_point identifies exactly which CCP wa',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Corrective actions are frequently triggered by equipment failures (refrigeration out of temp range, sanitizer dispenser malfunction). The corrective action record must reference the specific equipment',
    `illness_report_id` BIGINT COMMENT 'Foreign key linking to foodsafety.illness_report. Business justification: Corrective and preventive actions (CAPA) are frequently initiated in response to employee foodborne illness reports. Linking foodsafety_corrective_action to illness_report establishes the causal chain',
    `primary_foodsafety_employee_id` BIGINT COMMENT 'Identifier of the manager accountable for executing the corrective action.',
    `temperature_log_id` BIGINT COMMENT 'Foreign key linking to foodsafety.temperature_log. Business justification: foodsafety_corrective_action has a temperature_exceedance (BOOLEAN) flag indicating the corrective action was triggered by a temperature exceedance event. A FK to the specific temperature_log record t',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Corrective actions are executed at a specific restaurant unit. Operations managers track open corrective actions by unit for compliance dashboards, follow-up scheduling, and regulatory reporting. No d',
    `action_code` STRING COMMENT 'Business identifier or code assigned to the corrective action for tracking and reporting.',
    `action_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred to implement the corrective action.',
    `action_type` STRING COMMENT 'Classification of the action as corrective, preventive, or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed.',
    `attachment_url` STRING COMMENT 'Link to supporting documents or images attached to the corrective action.',
    `ccp_deviation` BOOLEAN COMMENT 'Indicates whether the corrective action is related to a Critical Control Point deviation.',
    `closure_status` STRING COMMENT 'Final status indicating whether the corrective action has been closed, verified, or rejected.. Valid values are `pending|verified|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the action cost.',
    `effective_date` DATE COMMENT 'Date when the corrective action became effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action was created or initiated.',
    `foodsafety_corrective_action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken.',
    `foodsafety_corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `is_effective` BOOLEAN COMMENT 'Indicates whether the corrective action has been determined effective after verification.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `party_code` BIGINT COMMENT 'Identifier of the primary party (e.g., restaurant unit or franchise) responsible for the corrective action.',
    `priority` STRING COMMENT 'Priority assigned to the corrective action for scheduling and resource allocation.. Valid values are `low|medium|high`',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause that triggered the corrective action.',
    `severity_level` STRING COMMENT 'Severity rating of the issue that prompted the corrective action.. Valid values are `low|medium|high|critical`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be completed.',
    `temperature_exceedance` BOOLEAN COMMENT 'True if the action addresses a temperature limit breach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corrective action record.',
    `verification_date` DATE COMMENT 'Date on which the verification of the corrective action was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective.. Valid values are `observation|test|audit|review`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Tracks corrective and preventive actions (CAPA) initiated in response to food safety audit findings, health inspection violations, CCP deviations, temperature exceedances, pest control findings, or allergen incidents. Captures root cause analysis method (5-Why, fishbone), corrective action description, responsible manager, target and actual completion dates, verification method, effectiveness check outcome, and closure status. Serves as the central CAPA registry managed via Zenput task management, supporting FDA Food Code and ISO 22000 corrective action requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'System-generated unique identifier for each temperature reading record.',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to foodsafety.critical_control_point. Business justification: Temperature readings are captured specifically to monitor compliance at Critical Control Points (CCPs) defined in the HACCP plan. Linking temperature_log to critical_control_point enables direct CCP d',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: temperature_log carries an audit_reference (STRING) that is a loose textual pointer to the associated food safety audit. Replacing this with a proper FK food_safety_audit_id enables structured joins f',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Temperature monitoring is performed at specific kitchen stations (walk-in cooler, hot-hold station, receiving dock). Station-level temperature compliance is a core HACCP CCP monitoring requirement. Fo',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
    `shift_id` BIGINT COMMENT 'Identifier of the workforce shift during which the reading was taken.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the restaurant location or specific area (e.g., kitchen, dock) where the reading occurred.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the equipment or sensor that generated the temperature reading.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Temperature logs are recorded at a specific restaurant unit. Unit-level temperature compliance reporting, health inspection submissions, and regulatory filings require a direct unit FK without joining',
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
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: Sanitation schedules are operationally assigned to specific restaurant departments (kitchen, dishwashing, bar). This FK enables department managers to view their cleaning obligations, supports labor p',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Sanitation schedules are written for specific equipment assets (e.g., sanitize the slicer after each use, clean the fryer every 4 hours). The plain-text equipment field is a denormalization of e',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Sanitation schedules (Master Sanitation Schedules) are defined as part of the HACCP plan framework — each sanitation task supports the hazard controls identified in the HACCP plan. haccp_plan already ',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Sanitation schedules in restaurants are written at the kitchen station level (e.g., fryer station cleaned every 4 hours). Food safety managers assign sanitation tasks to specific stations. The plain-t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Sanitation schedule assigns a specific employee; FK provides traceability for health inspections and internal audits.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation schedules are defined per storage area; the FK associates each schedule with its location.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Sanitation schedules are assigned to specific restaurant units. Operations managers schedule and track cleaning tasks per unit; health inspectors verify sanitation compliance per unit during inspectio',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether the task includes allergen control measures.',
    `audit_required_flag` BOOLEAN COMMENT 'Whether a post‑task audit is required.',
    `chemical_concentration` STRING COMMENT 'Required concentration of the chemical (e.g., "200 ppm").',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` (
    `allergen_incident_id` BIGINT COMMENT 'System-generated unique identifier for the allergen incident record.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who responded to or recorded the incident.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the POS order associated with the incident, if applicable.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for root‑cause analysis: trace allergen incidents to the specific ingredient causing the reaction, supporting recall and corrective action reports.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: When an allergen incident involves a specific lot, linking to lot tracking provides precise traceability for recalls.',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: FDA MedWatch filings and allergen root cause analysis require identifying the specific order line item (not just the guest order) that triggered the reaction. allergen_incident already links to guest_',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who reported the allergen reaction.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: Allergen incident investigations require tracing the exact recipe version prepared at the time of the incident to identify whether a recipe change, substitution, or prep error caused the exposure. Exi',
    `shift_id` BIGINT COMMENT 'Identifier of the employee shift during which the incident happened.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Allergen incidents are traced to the offending ingredient; the FK connects the incident to the stock item for root‑cause analysis.',
    `temperature_log_id` BIGINT COMMENT 'Reference to the temperature monitoring record associated with the incident, if relevant.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Allergen incident root-cause analysis requires knowing the exact visit (daypart, server, table) during which the incident occurred. Linking allergen_incident to guest_visit enables operational reports',
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
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or is associated with the illness.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Foodborne illness outbreak investigations require direct traceability from the illness report to the specific ingredient lot suspected as the source. FSMA traceability rules and FDA outbreak response ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: When a loyalty member reports a foodborne illness after dining, the illness report must be linked to their member profile for regulatory notification tracking, targeted guest outreach, and potential g',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Foodborne illness investigations require linking the report to the specific menu item suspected as the vehicle of illness for health department notification, menu item withdrawal decisions, and outbre',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the employee fell ill.',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Outbreak investigation and health department regulatory reporting require identifying the exact order line item that caused illness. suspected_food_item is a denormalized text field replaced by this',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` (
    `audit_ccp_finding_id` BIGINT COMMENT 'Primary key for the audit_ccp_finding association',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to the Critical Control Point that was evaluated and produced this finding.',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to the food safety audit during which this CCP finding was recorded.',
    `compliance_status` STRING COMMENT 'Compliance classification for this CCP as assessed during this specific audit. Cannot reside on the CCP (which defines the standard) or the audit header (which aggregates all CCPs).',
    `corrective_action_required` STRING COMMENT 'Specific corrective action mandated for this CCP finding within this audit. Distinct from the CCPs generic corrective_action_procedure, this is the instance-level action for this specific deviation event.',
    `deviation_noted` BOOLEAN COMMENT 'Indicates whether a deviation from the critical limit was observed for this CCP during this audit. Drives corrective action workflows.',
    `evaluated_at` TIMESTAMP COMMENT 'Timestamp when this specific CCP was evaluated during the audit. Supports sequencing of findings within a multi-CCP audit.',
    `finding_result` STRING COMMENT 'The outcome of evaluating this specific CCP during the audit — whether it passed, failed, or a deviation was observed. Belongs to the finding, not to the audit aggregate or the CCP definition.',
    `finding_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to this CCPs performance within this audit. Contributes to the audits overall compliance_score but is specific to this CCP-audit intersection.',
    `finding_status` STRING COMMENT 'Lifecycle status of this individual CCP finding — tracks whether the corrective action has been addressed and the finding closed.',
    CONSTRAINT pk_audit_ccp_finding PRIMARY KEY(`audit_ccp_finding_id`)
) COMMENT 'This association product represents the Event between food_safety_audit and critical_control_point. It captures the individual finding recorded for each Critical Control Point evaluated during a specific food safety audit. Each record links one food_safety_audit to one critical_control_point and carries the outcome data — finding result, compliance status, deviation details, corrective action required, and finding score — that exists only in the context of evaluating a specific CCP within a specific audit. Food safety managers actively create, review, and close these records as part of the audit lifecycle.. Existence Justification: In HACCP-governed food safety operations, each audit systematically evaluates multiple Critical Control Points, and each CCP is evaluated across many audits over its lifecycle. The intersection — an audit CCP finding — is a recognized operational record that auditors actively create during each audit, capturing whether each CCP passed or failed, any deviation observed, and what corrective action is required. This is not derivable from existing FKs; it is a first-class operational entity that food safety managers create, review, and act upon.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_sanitation_schedule_id` FOREIGN KEY (`sanitation_schedule_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule`(`sanitation_schedule_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_allergen_incident_id` FOREIGN KEY (`allergen_incident_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`allergen_incident`(`allergen_incident_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_corrective_foodsafety_related_food_safety_audit_id` FOREIGN KEY (`corrective_foodsafety_related_food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_corrective_foodsafety_related_inspection_health_inspection_id` FOREIGN KEY (`corrective_foodsafety_related_inspection_health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_illness_report_id` FOREIGN KEY (`illness_report_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`illness_report`(`illness_report_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_temperature_log_id` FOREIGN KEY (`temperature_log_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`temperature_log`(`temperature_log_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ADD CONSTRAINT `fk_foodsafety_sanitation_schedule_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_temperature_log_id` FOREIGN KEY (`temperature_log_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`temperature_log`(`temperature_log_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ADD CONSTRAINT `fk_foodsafety_audit_ccp_finding_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ADD CONSTRAINT `fk_foodsafety_audit_ccp_finding_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `allergen_control_compliant` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Compliance (ALLERGEN_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `attached_documents_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count (DOC_COUNT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Date and Time (AUDIT_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|health_department');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name (AUDITOR_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (CORRECTIVE_DEADLINE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CORRECTIVE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count (CRIT_FINDINGS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|failed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `non_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Findings Count (NONCRIT_FINDINGS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (AUDIT_NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score (OVERALL_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result (PASS_FAIL)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|Local_Health_Department');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `sanitation_schedule_compliant` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Compliance (SANITATION_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `temperature_monitoring_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Compliance (TEMP_COMPLIANT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'compliance_inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Incident Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_related_food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `corrective_foodsafety_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `action_cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `ccp_deviation` SET TAGS ('dbx_business_glossary_term' = 'CCP Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Initiation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `is_effective` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `temperature_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Temperature Exceedance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'observation|test|audit|review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Concentration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizer Chemical Name');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'SOP Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `temperature_requirement_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement (°C)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_subdomain' = 'incident_reporting');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Incident ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_code` SET TAGS ('dbx_business_glossary_term' = 'Allergen Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Name');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (Shift ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Suspected Order Item Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_business_glossary_term' = 'Health Department Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|closed|rejected');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` SET TAGS ('dbx_association_edges' = 'foodsafety.food_safety_audit,foodsafety.critical_control_point');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `audit_ccp_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Ccp Finding - Audit Ccp Finding Id');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Ccp Finding - Critical Control Point Id');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Ccp Finding - Food Safety Audit Id');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'CCP Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `deviation_noted` SET TAGS ('dbx_business_glossary_term' = 'Deviation Noted');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `evaluated_at` SET TAGS ('dbx_business_glossary_term' = 'CCP Evaluation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `finding_result` SET TAGS ('dbx_business_glossary_term' = 'Finding Result');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `finding_score` SET TAGS ('dbx_business_glossary_term' = 'CCP Finding Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_ccp_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
