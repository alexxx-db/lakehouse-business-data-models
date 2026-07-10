-- Schema for Domain: foodsafety | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:39

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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'Surrogate primary key for the food safety audit record.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit expense tracking: each food safety audit is charged to a cost center for cost control and audit cost reporting.',
    `food_employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the audit was conducted.',
    `food_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the audit was conducted.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Food safety audits are conducted at a specific restaurant location; associating audits with site_id supports site‑wide audit tracking and rent‑related compliance.',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Food safety audits are performed on suppliers; linking audit to supplier enables audit‑by‑supplier reports required by regulatory compliance.',
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
    `haccp_plan_version` STRING COMMENT 'Version identifier of the HACCP plan referenced during the audit.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor accountable for corrective action.',
    `audit_responsible_party_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor accountable for corrective action.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the audit was performed.',
    `audit_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the audit was performed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remediation cost allocation: corrective actions for findings are budgeted against a cost center.',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: Audit findings are recorded under a specific food safety audit; adding food_safety_audit_id links findings to their audit.',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|in_progress|closed|deferred|rejected`',
    `corrective_action` STRING COMMENT 'Prescribed action required to remediate the finding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative of the violation or observation.',
    `due_date` DATE COMMENT 'Date by which the corrective action must be completed.',
    `finding_category` STRING COMMENT 'High‑level domain of the finding (e.g., HACCP, sanitation).. Valid values are `haccp|food_safety|sanitation|allergen|equipment|facility`',
    `finding_number` STRING COMMENT 'Human‑readable identifier assigned to the finding within the audit.',
    `finding_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was recorded during the audit.',
    `has_attachment` BOOLEAN COMMENT 'Indicates whether supporting documentation (photos, files) is attached.',
    `regulatory_reference` STRING COMMENT 'Code or citation of the applicable regulation (e.g., FDA Food Code section).',
    `resolution_date` DATE COMMENT 'Date when the finding was closed or resolved.',
    `severity_level` STRING COMMENT 'Categorical severity classification of the finding.. Valid values are `critical|major|minor|informational`',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) representing the seriousness of the finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding or violation recorded during a food safety audit, capturing finding category (critical, major, minor), description, regulatory reference (FDA Food Code, local health code), corrective action required, responsible party, due date, and resolution status. Each finding is linked to a specific audit and restaurant unit.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Unique surrogate key for the health inspection record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection cost accounting: health inspection fees and related expenses are charged to a cost center.',
    `employee_id` BIGINT COMMENT 'System identifier for the inspector.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location inspected.',
    `health_unit_id` BIGINT COMMENT 'Identifier of the restaurant location inspected.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Regulatory health inspection reports are filed per physical site; linking enables site‑level compliance dashboards and audit trails.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` (
    `inspection_violation_id` BIGINT COMMENT 'Unique identifier for the inspection violation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector who recorded the violation.',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that generated this violation.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation was observed.',
    `inspection_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation was observed.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` (
    `foodsafety_corrective_action_id` BIGINT COMMENT 'System-generated unique identifier for the corrective action record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial tracking of corrective action spend: each action is budgeted to a cost center for expense control.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager accountable for executing the corrective action.',
    `food_safety_audit_id` BIGINT COMMENT 'Identifier of the food safety audit that generated the finding.',
    `foodsafety_related_food_safety_audit_id` BIGINT COMMENT 'Identifier of the food safety audit that generated the finding.',
    `health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that uncovered the violation.',
    `foodsafety_related_inspection_health_inspection_id` BIGINT COMMENT 'Identifier of the health inspection that uncovered the violation.',
    `foodsafety_verified_by_employee_id` BIGINT COMMENT 'Identifier of the individual who verified the corrective action.',
    `primary_foodsafety_employee_id` BIGINT COMMENT 'Identifier of the manager accountable for executing the corrective action.',
    `action_code` STRING COMMENT 'Business identifier or code assigned to the corrective action for tracking and reporting.',
    `action_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred to implement the corrective action.',
    `action_type` STRING COMMENT 'Classification of the action as corrective, preventive, or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed.',
    `attachment_url` STRING COMMENT 'Link to supporting documents or images attached to the corrective action.',
    `ccp_deviation` BOOLEAN COMMENT 'Indicates whether the corrective action is related to a Critical Control Point deviation.',
    `closure_status` STRING COMMENT 'Final status indicating whether the corrective action has been closed, verified, or rejected.. Valid values are `pending|verified|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the action cost.',
    `foodsafety_corrective_action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken.',
    `effective_date` DATE COMMENT 'Date when the corrective action became effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action was created or initiated.',
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
    CONSTRAINT pk_foodsafety_corrective_action PRIMARY KEY(`foodsafety_corrective_action_id`)
) COMMENT 'Tracks corrective and preventive actions (CAPA) initiated in response to food safety audit findings, health inspection violations, CCP deviations, temperature exceedances, pest control findings, or allergen incidents. Captures root cause analysis method (5-Why, fishbone), corrective action description, responsible manager, target and actual completion dates, verification method, effectiveness check outcome, and closure status. Serves as the central CAPA registry managed via Zenput task management, supporting FDA Food Code and ISO 22000 corrective action requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'System-generated unique identifier for each temperature reading record.',
    `shift_id` BIGINT COMMENT 'Identifier of the workforce shift during which the reading was taken.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the restaurant location or specific area (e.g., kitchen, dock) where the reading occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
    `equipment_asset_id` BIGINT COMMENT 'Identifier of the equipment or sensor that generated the temperature reading.',
    `temperature_recorded_by_user_employee_id` BIGINT COMMENT 'Identifier of the employee who manually entered the reading, if applicable.',
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
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Sanitation schedule defines cleaning chemicals; linking to the chemical supplier enables compliance tracking, cost allocation, and audit of purchased sanitation supplies required by health regulations',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required: Sanitation schedule assigns a specific employee; FK provides traceability for health inspections and internal audits.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation schedules are defined per storage area; the FK associates each schedule with its location.',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether the task includes allergen control measures.',
    `area` STRING COMMENT 'Physical area or zone where the task is performed (e.g., Front‑of‑House, Back‑of‑House).. Valid values are `FOH|BOH|Kitchen|Dining|Bar|Outdoor`',
    `audit_required_flag` BOOLEAN COMMENT 'Whether a post‑task audit is required.',
    `chemical_concentration` STRING COMMENT 'Required concentration of the chemical (e.g., "200 ppm").',
    `chemical_name` STRING COMMENT 'Name of the chemical or sanitizer used.',
    `cleaning_method` STRING COMMENT 'Method used to perform the cleaning (e.g., manual, automated, steam).',
    `compliance_status` STRING COMMENT 'Current compliance status of the task against food‑safety regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was created.',
    `sanitation_schedule_description` STRING COMMENT 'Detailed description of the schedule purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the schedule expires or is superseded (nullable).',
    `equipment` STRING COMMENT 'Equipment, fixture, or asset the task applies to.',
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
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier of the equipment item that was sanitized.',
    `sanitation_equipment_equipment_asset_id` BIGINT COMMENT 'Unique identifier of the equipment item that was sanitized.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit where the sanitation activity took place.',
    `shift_id` BIGINT COMMENT 'Unique identifier of the employee shift associated with the task.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Sanitation tasks are scheduled per storage area; the FK ties task logs to the exact location for compliance tracking.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task log entry was first inserted into the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the sanitation task log entry.',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Numeric value of the chemical concentration measured during the task.',
    `chemical_name` STRING COMMENT 'Descriptive name of the chemical or sanitizer applied during the task.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time the sanitation task was marked as completed.',
    `compliance_regulation` STRING COMMENT 'Regulation or standard that the sanitation task satisfies.. Valid values are `FDA_FSMA|ServSafe|ISO_22000|Local_Health`',
    `concentration_unit` STRING COMMENT 'Unit of measure for the chemical concentration (e.g., parts per million).. Valid values are `ppm|mg_l|percent`',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` (
    `foodsafety_allergen_profile_id` BIGINT COMMENT 'System-generated unique identifier for the allergen profile record.',
    `ingredient_id` BIGINT COMMENT 'add column ingredient_id (BIGINT) with FK to supply.ingredient.ingredient_id - allergen profiles must link to specific ingredients to be actionable for food safety management',
    `allergen_version` STRING COMMENT 'Incremental version number for change tracking.',
    `celery` STRING COMMENT 'Indicates if celery is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allergen profile record was first created.',
    `cross_contact_risk_level` STRING COMMENT 'Risk rating for cross‑contact of allergens during preparation.. Valid values are `low|medium|high`',
    `effective_from` DATE COMMENT 'Date from which the allergen profile is considered valid.',
    `effective_until` DATE COMMENT 'Date after which the allergen profile is no longer valid (nullable for open‑ended).',
    `egg` STRING COMMENT 'Indicates if egg is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `fish` STRING COMMENT 'Indicates if fish is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `foodsafety_allergen_profile_status` STRING COMMENT 'Current lifecycle state of the allergen profile.. Valid values are `active|inactive|retired`',
    `last_review_date` DATE COMMENT 'Date the allergen profile was last reviewed for accuracy.',
    `lupin` STRING COMMENT 'Indicates if lupin is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `management_controls` STRING COMMENT 'Description of controls (e.g., segregation, cleaning procedures) used to mitigate allergen cross‑contact.',
    `milk` STRING COMMENT 'Indicates if milk is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `mollusk` STRING COMMENT 'Indicates if mollusk is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `mustard` STRING COMMENT 'Indicates if mustard is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the allergen profile.',
    `peanut` STRING COMMENT 'Indicates if peanuts are absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `profile_code` STRING COMMENT 'Business identifier used to reference the profile in external systems.',
    `profile_name` STRING COMMENT 'Human‑readable name for the allergen profile, typically the menu item or ingredient name.',
    `profile_type` STRING COMMENT 'Indicates whether the profile applies to a menu item or a raw ingredient.. Valid values are `menu_item|ingredient`',
    `review_status` STRING COMMENT 'Current status of the most recent review cycle.. Valid values are `pending|approved|rejected`',
    `review_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the last review was completed.',
    `reviewed_by` STRING COMMENT 'Name of the employee or auditor who performed the last review.',
    `sesame` STRING COMMENT 'Indicates if sesame is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `shellfish` STRING COMMENT 'Indicates if shellfish is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `soy` STRING COMMENT 'Indicates if soy is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `sulphites` STRING COMMENT 'Indicates if sulphites are absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `tree_nut` STRING COMMENT 'Indicates if tree nuts are absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `wheat` STRING COMMENT 'Indicates if wheat is absent, present, or may‑contain in the item.. Valid values are `absent|present|may_contain`',
    CONSTRAINT pk_foodsafety_allergen_profile PRIMARY KEY(`foodsafety_allergen_profile_id`)
) COMMENT 'Master allergen declaration record for each menu item or ingredient, specifying the presence, may-contain, or absence of each of the 14 major allergens (FDA Big 9 + EU 14), cross-contact risk level, allergen management controls in place, and last review date. Supports FDA FSMA labeling compliance and guest allergen inquiry management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` (
    `allergen_incident_id` BIGINT COMMENT 'System-generated unique identifier for the allergen incident record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who reported the allergen reaction.',
    `allergen_profile_id` BIGINT COMMENT 'Unique identifier of the guest who reported the allergen reaction.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who responded to or recorded the incident.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the POS order associated with the incident, if applicable.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for root‑cause analysis: trace allergen incidents to the specific ingredient causing the reaction, supporting recall and corrective action reports.',
    `lot_tracking_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_tracking. Business justification: When an allergen incident involves a specific lot, linking to lot tracking provides precise traceability for recalls.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Allergen incident handling awards loyalty points to members who report incidents; direct member link is required for points accrual and incident reporting.',
    `menu_item_id` BIGINT COMMENT 'Identifier of the menu item implicated in the incident.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Allergen incident response must identify the supplier of the allergen‑containing ingredient to issue recalls and enforce supplier corrective actions per FDA allergen regulations.',
    `shift_id` BIGINT COMMENT 'Identifier of the employee shift during which the incident happened.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Allergen incidents must be traced to the exact site for corrective action, liability reporting, and regulatory notification.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Allergen incidents are traced to the offending ingredient; the FK connects the incident to the stock item for root‑cause analysis.',
    `temperature_log_id` BIGINT COMMENT 'Reference to the temperature monitoring record associated with the incident, if relevant.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` (
    `sop_document_id` BIGINT COMMENT 'System-generated unique identifier for each SOP document record.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - SOP documents are completely isolated with zero inbound and zero outbound FKs beyond being referenced by restaurant.unit; they need explicit scope linkage',
    `applicable_restaurant_format` STRING COMMENT 'Restaurant format(s) to which the SOP applies (e.g., Quick-Service Restaurant, casual, fine-dining).. Valid values are `QSR|casual|fine_dining`',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approved the SOP.',
    `attached_files_count` STRING COMMENT 'Number of supplemental files (e.g., checklists, diagrams) linked to the SOP.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance audit against this SOP.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the SOP record was first created in the system.',
    `sop_document_description` STRING COMMENT 'Full textual description of the SOP purpose, scope, and key steps.',
    `distribution_scope` STRING COMMENT 'Scope of SOP distribution: global, regional, or specific to a site.. Valid values are `global|regional|site_specific`',
    `document_code` STRING COMMENT 'External business code or number used to reference the SOP document in franchise and compliance systems.',
    `document_url` STRING COMMENT 'Link to the stored SOP file in the document repository.',
    `effective_date` DATE COMMENT 'Date on which the SOP becomes operationally binding.',
    `expiration_date` DATE COMMENT 'Date after which the SOP is no longer valid; null if indefinite.',
    `file_type` STRING COMMENT 'File format of the SOP document.. Valid values are `pdf|docx|html|txt`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the SOP is mandatory (true) or advisory (false).',
    `language` STRING COMMENT 'Language in which the SOP is authored.. Valid values are `en|es|fr|de|zh`',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the SOP.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled review.',
    `owner_name` STRING COMMENT 'Name of the person or role responsible for maintaining the SOP.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework or standard that mandates the SOP (e.g., FDA FSMA, OSHA safety).. Valid values are `FDA|USDA|OSHA|ISO_22000|ServSafe`',
    `revision_history` STRING COMMENT 'Chronological log of changes made to the SOP, stored as free‑text.',
    `sop_category` STRING COMMENT 'High‑level classification of the SOP content area.. Valid values are `Food_Safety|Sanitation|Allergen_Management|Equipment|Training`',
    `sop_document_status` STRING COMMENT 'Current lifecycle status of the SOP.. Valid values are `draft|active|inactive|retired|archived`',
    `title` STRING COMMENT 'Descriptive title of the SOP, e.g., "Handwashing Procedure".',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the SOP record.',
    `version_number` STRING COMMENT 'Incremental version of the SOP; higher numbers indicate newer revisions.',
    CONSTRAINT pk_sop_document PRIMARY KEY(`sop_document_id`)
) COMMENT 'Master record for each Standard Operating Procedure (SOP) governing food safety and operational compliance, including SOP title, version number, effective date, expiration date, applicable restaurant formats (QSR/casual/fine-dining), regulatory basis (FDA, USDA, OSHA), approval authority, and distribution scope. Managed and distributed via Zenput.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` (
    `food_safety_certification_id` BIGINT COMMENT 'System‑generated unique identifier for each food safety certification record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds the certification.',
    `food_safety_audit_id` BIGINT COMMENT 'Unique identifier of the certification record in the source system.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - certifications must be trackable per unit for compliance dashboards',
    `attached_document_path` STRING COMMENT 'Location of the digital copy of the certification document in the document repository.',
    `audit_source_system` STRING COMMENT 'Name of the operational system of record (e.g., Zenput) that originated the certification data.',
    `certification_category` STRING COMMENT 'High‑level grouping used for analytics and compliance reporting.. Valid values are `Food Safety|Allergen Management|Quality Assurance|Other`',
    `certification_name` STRING COMMENT 'Descriptive name of the certification (e.g., "ServSafe Manager").',
    `certification_number` STRING COMMENT 'Unique number or code provided by the issuing organization.',
    `certification_type` STRING COMMENT 'Category of the certification according to industry standards.. Valid values are `ServSafe Manager|ServSafe Food Handler|HACCP|Allergen Awareness|Other`',
    `compliance_flag` BOOLEAN COMMENT 'True when the certification satisfies all applicable FDA, USDA, and ISO 22000 requirements.',
    `expiration_date` DATE COMMENT 'Calendar date on which the certification is no longer valid.',
    `expiration_notice_date` DATE COMMENT 'Date on which the expiration reminder was sent.',
    `expiration_notice_sent` BOOLEAN COMMENT 'True when a reminder about upcoming expiration has been communicated to the employee.',
    `food_safety_certification_status` STRING COMMENT 'Operational status indicating if the certification is currently valid, pending renewal, revoked, etc.. Valid values are `active|inactive|revoked|expired|pending`',
    `issue_date` DATE COMMENT 'Calendar date on which the certification became effective.',
    `issuing_body` STRING COMMENT 'Name of the authority that granted the certification.',
    `last_renewal_date` DATE COMMENT 'Date when the certification was last renewed, if applicable.',
    `next_renewal_due` DATE COMMENT 'Projected date by which the certification must be renewed to remain active.',
    `notes` STRING COMMENT 'Additional remarks, auditor comments, or special conditions related to the certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Date‑time when the certification record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the certification record.',
    `renewal_required` BOOLEAN COMMENT 'True if the certification must be renewed prior to its expiration date.',
    `revocation_reason` STRING COMMENT 'Explanation why a certification was revoked or invalidated.',
    `validity_period_days` STRING COMMENT 'Number of days between issue_date and expiration_date.',
    CONSTRAINT pk_food_safety_certification PRIMARY KEY(`food_safety_certification_id`)
) COMMENT 'Unified food safety workforce compliance record covering both training events and resulting certifications held by restaurant employees. Training attributes: program name, type (onboarding/annual refresher/corrective retraining/allergen awareness), delivery method (in-person/e-learning/Zenput), completion date, assessment score, pass/fail, trainer identity. Certification attributes: type (ServSafe Manager/Food Handler/HACCP/allergen awareness), issuing body (NRA ServSafe, ANSI-accredited provider), certification number, issue date, expiration date, validity status. Supports regulatory staffing requirements, retraining triggers, and compliance dashboards.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` (
    `illness_report_id` BIGINT COMMENT 'Unique identifier for the illness report record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported or is associated with the illness.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `illness_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the incident occurred.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Illness investigations must trace the suspected ingredient back to its supplier to issue recalls and corrective actions, supporting FDA/health‑department reporting.',
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
    `suspected_food_item` STRING COMMENT 'Food item or ingredient suspected to be the source of the illness.',
    `suspected_pathogen` STRING COMMENT 'Pathogen suspected to have caused the illness, if known.',
    `symptoms` STRING COMMENT 'Symptoms reported by the employee, captured for health analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    CONSTRAINT pk_illness_report PRIMARY KEY(`illness_report_id`)
) COMMENT 'Transactional record of a reported employee foodborne illness or suspected foodborne illness event at a restaurant unit, capturing report date, employee role, symptoms reported, onset date, suspected pathogen or food item, exclusion-from-work decision, return-to-work clearance date, and health department notification status. Supports FDA Food Code employee health policy compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` (
    `food_recall_id` BIGINT COMMENT 'System‑generated unique identifier for each recall event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall expense allocation: recall handling costs are charged to a cost center for financial impact analysis.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the manufacturer in the enterprise master data.',
    `lot_tracking_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_tracking. Business justification: Recalls target specific lots; the FK allows rapid identification of affected inventory records.',
    `primary_food_procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the supplier in the enterprise master data.',
    `affected_units` STRING COMMENT 'Total number of units (e.g., packages) identified as potentially unsafe.',
    `corrective_action` STRING COMMENT 'Planned or executed actions to mitigate the hazard (e.g., product pull, consumer notification).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall record was first created in the data lake.',
    `disposal_method` STRING COMMENT 'Method used to handle recalled product units.. Valid values are `return|destroy|quarantine|donate|other`',
    `distribution_region` STRING COMMENT 'Geographic region(s) where the affected product was distributed (e.g., Midwest, Northeast).',
    `hazard_description` STRING COMMENT 'Narrative description of the health hazard or safety issue prompting the recall.',
    `is_voluntary` BOOLEAN COMMENT 'True if the recall was initiated voluntarily by the company.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number associated with the recalled items.',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer that produced the recalled product.',
    `notification_date` DATE COMMENT 'Date the regulatory agency was formally notified of the recall.',
    `product_name` STRING COMMENT 'Descriptive name of the food product or ingredient subject to the recall.',
    `public_communication_date` DATE COMMENT 'Date the recall information was released to the public.',
    `recall_class` STRING COMMENT 'FDA classification indicating severity: Class I (most serious), Class II, or Class III.. Valid values are `I|II|III`',
    `recall_closure_reason` STRING COMMENT 'Reason why the recall was closed or terminated.',
    `recall_effective_date` DATE COMMENT 'Date on which the recall became effective for the public and supply chain.',
    `recall_end_date` DATE COMMENT 'Date when the recall was closed or deemed completed; null if still open.',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the recall was officially initiated.',
    `recall_number` STRING COMMENT 'Publicly assigned recall number used by regulatory agencies to track the event.',
    `recall_scope` STRING COMMENT 'Geographic extent of the recall.. Valid values are `local|regional|national|international`',
    `recall_source_system` STRING COMMENT 'System where the recall record originated.. Valid values are `Zenput|ERP|Manual|Other`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event.. Valid values are `open|closed|pending|withdrawn`',
    `recall_type` STRING COMMENT 'Primary cause category for the recall such as contamination, mislabeling, or allergen issue.. Valid values are `contamination|adulteration|mislabeling|foreign_object|allergen|other`',
    `regulatory_agency` STRING COMMENT 'Government body overseeing the recall.. Valid values are `FDA|USDA|State|Local|International`',
    `regulatory_reference_number` STRING COMMENT 'Official reference number assigned by the regulatory agency.',
    `root_cause` STRING COMMENT 'Underlying cause identified for the recall (e.g., supplier contamination).',
    `severity_level` STRING COMMENT 'Categorical severity derived from the severity score.. Valid values are `low|moderate|high|critical`',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the health risk severity.',
    `sku` STRING COMMENT 'Internal SKU or catalogue code identifying the recalled product.',
    `supplier_name` STRING COMMENT 'Legal name of the supplier providing the recalled product.',
    `units_disposed` STRING COMMENT 'Number of recalled units that were destroyed or otherwise disposed of.',
    `units_recalled` STRING COMMENT 'Number of units that were actually recalled from the supply chain.',
    `units_returned` STRING COMMENT 'Number of recalled units that were returned to the supplier or manufacturer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recall record.',
    CONSTRAINT pk_food_recall PRIMARY KEY(`food_recall_id`)
) COMMENT 'Header-and-line record managing food product recall or withdrawal events, including recall header (FDA classification: Class I/II/III, affected SKU/ingredient, supplier, lot numbers, initiation date, scope, disposition instructions, regulatory reference) and unit-level response lines (unit ID, quantity on hand, disposition action taken: returned/destroyed/quarantined, completion date, responsible manager, verification status). Ensures end-to-end recall traceability from corporate notification through individual unit compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` (
    `recall_unit_response_id` BIGINT COMMENT 'Surrogate primary key for the recall unit response record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Unit‑level recall response costs are tracked against a cost center for accurate cost accounting.',
    `food_recall_id` BIGINT COMMENT 'Identifier of the food safety recall event that triggered this response.',
    `lot_tracking_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_tracking. Business justification: Unit response records which lot(s) were affected; linking to lot tracking supports detailed recall execution.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the recall response.',
    `recall_manager_employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the recall response.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Recall responses are managed per restaurant location; site_id ties each response to the physical property for traceability.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location/unit responding to the recall.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product on hand that is subject to the recall.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the recalled product.',
    `compliance_status` STRING COMMENT 'Overall compliance outcome for the recall response.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective actions performed to address the recall.',
    `created_timestamp` TIMESTAMP COMMENT 'When the recall response record was first created.',
    `disposition_action` STRING COMMENT 'Action taken with the recalled product.. Valid values are `returned_to_supplier|destroyed_on_site|quarantined|reworked|donated`',
    `disposition_date` DATE COMMENT 'Date the disposition action was completed.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the recall event as it applies to this unit.',
    `evidence_documentation_flag` BOOLEAN COMMENT 'Indicates whether supporting documentation (photos, logs) was attached.',
    `expiration_date` DATE COMMENT 'Expiration date of the affected product batch, if applicable.',
    `lot_number` STRING COMMENT 'Lot identifier for the affected product batch.',
    `manager_name` STRING COMMENT 'Full name of the responsible manager.',
    `notes` STRING COMMENT 'Free‑form notes captured by staff during the recall response.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the affected product.. Valid values are `^[A-Z0-9]{3,10}$`',
    `recall_description` STRING COMMENT 'Brief description of the recall issue and affected product.',
    `recall_initiated_by` STRING COMMENT 'Entity that initiated the recall (e.g., supplier, regulator, internal QA).',
    `recall_severity` STRING COMMENT 'Severity level assigned to the recall (high, medium, low).. Valid values are `high|medium|low`',
    `recall_source` STRING COMMENT 'Origin of the recall notice (e.g., FDA, USDA, Supplier, Internal).',
    `recall_unit_response_status` STRING COMMENT 'Overall lifecycle status of the recall response.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the response meets all applicable regulatory requirements.',
    `response_number` STRING COMMENT 'Human‑readable identifier for the recall response transaction.',
    `temperature_log_reference` STRING COMMENT 'Reference ID to temperature monitoring logs related to the recalled product.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the affected quantity.. Valid values are `kg|lb|unit|case|gallon|liter`',
    `updated_timestamp` TIMESTAMP COMMENT 'When the recall response record was last modified.',
    `verification_status` STRING COMMENT 'Current verification state of the recall response.. Valid values are `verified|pending|rejected`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the response was verified.',
    CONSTRAINT pk_recall_unit_response PRIMARY KEY(`recall_unit_response_id`)
) COMMENT 'Transactional record capturing each restaurant units response to a food recall event, including unit ID, recall ID, quantity of affected product on hand, disposition action taken (returned to supplier, destroyed on-site, quarantined), completion date, responsible manager, and verification status. Ensures traceability and regulatory compliance at the unit level.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` (
    `pest_control_log_id` BIGINT COMMENT 'System-generated unique identifier for each pest control service record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pest control service costs are allocated to the responsible cost center for budgeting and reporting.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external pest control vendor or contractor.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the service was performed.',
    `pest_service_provider_procurement_supplier_id` BIGINT COMMENT 'Identifier of the external pest control vendor or contractor.',
    `pest_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the service was performed.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Pest‑control services are scheduled per site; linking logs to site_id enables site‑level pest‑control compliance monitoring.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Pest control services target specific storage locations; linking records pest findings and treatments per location.',
    `allergen_control_flag` BOOLEAN COMMENT 'Indicates whether allergen control procedures were verified during the service.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pest control log entry was initially created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the pest control log entry.',
    `chemicals_used` STRING COMMENT 'Names or codes of chemical agents applied during treatment.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the service met all regulatory and internal compliance requirements.',
    `corrective_actions` STRING COMMENT 'Specific actions taken to remediate identified pest issues.',
    `findings_description` STRING COMMENT 'Detailed narrative of observations made by the technician.',
    `next_service_date` DATE COMMENT 'Planned date for the subsequent pest control visit.',
    `notes` STRING COMMENT 'Free‑form field for any extra comments or observations.',
    `pests_identified` STRING COMMENT 'List or description of pest species observed during the visit.',
    `recommendations` STRING COMMENT 'Suggested follow‑up measures or preventive steps.',
    `record_status` STRING COMMENT 'Overall lifecycle status of the log record.. Valid values are `active|archived|voided`',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or standard (e.g., FDA FSMA, local health code) applicable to the service.',
    `service_order_number` STRING COMMENT 'External reference number assigned to the pest control service request.',
    `service_provider_name` STRING COMMENT 'Name of the pest control vendor or contractor.',
    `service_status` STRING COMMENT 'Current lifecycle state of the service record.. Valid values are `completed|pending|canceled|rescheduled`',
    `service_timestamp` TIMESTAMP COMMENT 'Date and time when the pest control service was executed.',
    `service_type` STRING COMMENT 'Category of pest control activity performed.. Valid values are `routine_inspection|treatment|exclusion|follow_up`',
    `severity_level` STRING COMMENT 'Qualitative assessment of pest infestation severity.. Valid values are `low|moderate|high|critical`',
    `severity_score` STRING COMMENT 'Numeric score (1‑5) representing infestation severity.',
    `temperature_log_reference` STRING COMMENT 'Identifier linking to related temperature monitoring records, if applicable.',
    `treatment_method` STRING COMMENT 'Technique used to address the pest issue (e.g., baiting, spraying, trapping).',
    CONSTRAINT pk_pest_control_log PRIMARY KEY(`pest_control_log_id`)
) COMMENT 'Transactional record of pest control service visits and findings at a restaurant unit, including service date, pest control provider, service type (routine inspection, treatment, exclusion), pests identified, treatment method and chemicals used, findings severity, corrective recommendations, and next scheduled service date. Supports GMP and local health department compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` (
    `foodsafety_supplier_certification_id` BIGINT COMMENT 'Primary key for supplier_certification',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Tracks each suppliers food safety certifications, required for supplier qualification and audit readiness.',
    CONSTRAINT pk_foodsafety_supplier_certification PRIMARY KEY(`foodsafety_supplier_certification_id`)
) COMMENT 'Master record of food safety certifications and compliance documents held by food and beverage suppliers, including certification type (SQF, BRC, FSSC 22000, GlobalG.A.P., USDA Organic), issuing body, scope of certification, issue date, expiration date, and current approval status. Supports approved supplier program management and FSMA Preventive Controls compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` (
    `receiving_inspection_id` BIGINT COMMENT 'System‑generated unique identifier for the receiving inspection record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving inspection labor/material costs are allocated to a cost center for expense reporting.',
    `foodsafety_corrective_action_id` BIGINT COMMENT 'Reference to the corrective action record linked to this inspection.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the inspection.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier delivering the product.',
    `receiving_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the inspection.',
    `receiving_order_id` BIGINT COMMENT 'Foreign key linking to inventory.receiving_order. Business justification: Required for the Receiving Inspection process to tie each inspection to its corresponding receiving order for compliance verification.',
    `audit_reference` STRING COMMENT 'Identifier linking this inspection to a broader food safety audit.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the receiving inspection.. Valid values are `compliant|non_compliant|conditional`',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether a corrective action is needed due to inspection failure.',
    `expiration_date` DATE COMMENT 'Date after which the product must not be used.',
    `inspection_number` STRING COMMENT 'Unique external identifier for the receiving inspection.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspector_name` STRING COMMENT 'Full name of the inspector.',
    `lot_number` STRING COMMENT 'Lot or batch number assigned by the supplier.',
    `notes` STRING COMMENT 'Additional free‑text observations recorded by the inspector.',
    `product_name` STRING COMMENT 'Descriptive name of the product received.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the product received.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of product received, expressed in the unit of measure.',
    `receiving_date` DATE COMMENT 'Date the delivery was received at the restaurant dock.',
    `receiving_inspection_status` STRING COMMENT 'Current lifecycle status of the inspection.. Valid values are `pending|completed|failed|cancelled`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first captured in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `rejection_reason` STRING COMMENT 'Reason provided for rejecting the delivery, if applicable.',
    `supplier_name` STRING COMMENT 'Legal name of the supplying vendor.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature reading at the time of receiving, in degrees Celsius.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature reading at the time of receiving, in degrees Fahrenheit.',
    `temperature_pass_flag` BOOLEAN COMMENT 'Indicates whether the temperature reading met the acceptable range.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity received.. Valid values are `kg|lb|g|oz|units|liters`',
    `visual_quality_pass` BOOLEAN COMMENT 'Result of the visual quality check (pass/fail).',
    CONSTRAINT pk_receiving_inspection PRIMARY KEY(`receiving_inspection_id`)
) COMMENT 'Transactional record of food and supply receiving inspections conducted at a restaurant units back-of-house (BOH) dock, capturing delivery date, supplier, product/SKU received, lot number, quantity, temperature at receiving, visual quality check result (pass/fail), rejection reason if applicable, and inspector identity. Supports HACCP receiving CCP monitoring and FSMA traceability requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` (
    `food_safety_training_id` BIGINT COMMENT 'System‑generated unique identifier for each food safety training record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training program costs are budgeted to the cost center responsible for food safety compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the trainer or platform that delivered the training.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee works.',
    `food_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee works.',
    `primary_food_employee_id` BIGINT COMMENT 'Identifier of the employee who completed the training.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment (0‑100).',
    `completion_timestamp` TIMESTAMP COMMENT 'Date‑time when the employee completed the training.',
    `compliance_status` STRING COMMENT 'Overall compliance outcome of the training record.. Valid values are `compliant|non_compliant|pending`',
    `delivery_method` STRING COMMENT 'Method used to deliver the training.. Valid values are `in_person|e_learning|zenput`',
    `expiration_date` DATE COMMENT 'Date by which the employee must retake the training to stay compliant.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training session.',
    `pass_fail_status` STRING COMMENT 'Result of the assessment indicating whether the employee passed.. Valid values are `pass|fail`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `training_program_name` STRING COMMENT 'Name of the training program (e.g., ServSafe Certified Food Handler).',
    `training_session_number` STRING COMMENT 'Human‑readable identifier or code assigned to the training session (e.g., FS‑2023‑001).',
    `training_status` STRING COMMENT 'Current lifecycle status of the training session.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `training_type` STRING COMMENT 'Category of the training session.. Valid values are `onboarding|annual_refresher|corrective|allergen_awareness`',
    CONSTRAINT pk_food_safety_training PRIMARY KEY(`food_safety_training_id`)
) COMMENT 'Transactional record of food safety training sessions completed by restaurant employees, including training program name, training type (onboarding, annual refresher, corrective retraining, allergen awareness), delivery method (in-person, e-learning, Zenput), completion date, assessment score, pass/fail status, and trainer or platform identity. Supports ServSafe and regulatory training compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental_monitoring data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - need to track who collected the environmental sample',
    `resampled_environmental_monitoring_id` BIGINT COMMENT 'Self-referencing FK on environmental_monitoring (resampled_environmental_monitoring_id)',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - environmental monitoring samples must be traceable to a specific restaurant unit',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Environmental monitoring (e.g., humidity) is performed at storage locations; linking ties readings to the location.',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Transactional record of environmental monitoring samples collected at restaurant units, including sample type (swab, sponge, air plate), target organism (Listeria monocytogenes, Salmonella spp., E. coli, total plate count), sampling location (food contact surface, non-food contact surface, drain, floor), sample date, collected by, laboratory results, pass/fail against established limits, corrective action triggered flag, and zone classification (Zone 1-4). Supports pathogen environmental monitoring programs (EMPs) required by FSMA Preventive Controls and large QSR chain food safety standards.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_foodsafety_related_food_safety_audit_id` FOREIGN KEY (`foodsafety_related_food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ADD CONSTRAINT `fk_foodsafety_foodsafety_corrective_action_foodsafety_related_inspection_health_inspection_id` FOREIGN KEY (`foodsafety_related_inspection_health_inspection_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ADD CONSTRAINT `fk_foodsafety_allergen_incident_temperature_log_id` FOREIGN KEY (`temperature_log_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`temperature_log`(`temperature_log_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ADD CONSTRAINT `fk_foodsafety_recall_unit_response_food_recall_id` FOREIGN KEY (`food_recall_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`food_recall`(`food_recall_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ADD CONSTRAINT `fk_foodsafety_receiving_inspection_foodsafety_corrective_action_id` FOREIGN KEY (`foodsafety_corrective_action_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`(`foodsafety_corrective_action_id`);
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ADD CONSTRAINT `fk_foodsafety_environmental_monitoring_resampled_environmental_monitoring_id` FOREIGN KEY (`resampled_environmental_monitoring_id`) REFERENCES `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring`(`environmental_monitoring_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`foodsafety` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID (AUDITOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version (HACCP_VER)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'haccp|food_safety|sanitation|allergen|equipment|facility');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `has_attachment` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Violation ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Area of Concern');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_value_regex' = 'kitchen|storage|dining|restroom|outside');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Photo URL');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `ccp_deviation` SET TAGS ('dbx_business_glossary_term' = 'CCP Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Initiation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `is_effective` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `temperature_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Temperature Exceedance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'observation|test|audit|review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `area` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Area');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `area` SET TAGS ('dbx_value_regex' = 'FOH|BOH|Kitchen|Dining|Bar|Outdoor');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `equipment` SET TAGS ('dbx_business_glossary_term' = 'Equipment or Asset');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_task_log_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Task Log Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_equipment_equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration (Measured)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Sanitizing Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'FDA_FSMA|ServSafe|ISO_22000|Local_Health');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg_l|percent');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_subdomain' = 'allergen_management');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `foodsafety_allergen_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `allergen_version` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `celery` SET TAGS ('dbx_business_glossary_term' = 'Celery Allergen Status (CELERY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `celery` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Contact Risk Level (CCR)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `egg` SET TAGS ('dbx_business_glossary_term' = 'Egg Allergen Status (EGG)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `egg` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `fish` SET TAGS ('dbx_business_glossary_term' = 'Fish Allergen Status (FISH)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `fish` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `foodsafety_allergen_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `foodsafety_allergen_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `lupin` SET TAGS ('dbx_business_glossary_term' = 'Lupin Allergen Status (LUPIN)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `lupin` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `management_controls` SET TAGS ('dbx_business_glossary_term' = 'Allergen Management Controls');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `milk` SET TAGS ('dbx_business_glossary_term' = 'Milk Allergen Status (MILK)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `milk` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mollusk` SET TAGS ('dbx_business_glossary_term' = 'Mollusk Allergen Status (MOLLUSK)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mollusk` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mustard` SET TAGS ('dbx_business_glossary_term' = 'Mustard Allergen Status (MUSTARD)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mustard` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profile Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `peanut` SET TAGS ('dbx_business_glossary_term' = 'Peanut Allergen Status (PEANUT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `peanut` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'menu_item|ingredient');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Allergen Review Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sesame` SET TAGS ('dbx_business_glossary_term' = 'Sesame Allergen Status (SESAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sesame` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `shellfish` SET TAGS ('dbx_business_glossary_term' = 'Shellfish Allergen Status (SHELLFISH)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `shellfish` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `soy` SET TAGS ('dbx_business_glossary_term' = 'Soy Allergen Status (SOY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `soy` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sulphites` SET TAGS ('dbx_business_glossary_term' = 'Sulphites Allergen Status (SULPHITES)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sulphites` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `tree_nut` SET TAGS ('dbx_business_glossary_term' = 'Tree Nut Allergen Status (TREE_NUT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `tree_nut` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `wheat` SET TAGS ('dbx_business_glossary_term' = 'Wheat Allergen Status (WHEAT)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `wheat` SET TAGS ('dbx_value_regex' = 'absent|present|may_contain');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_subdomain' = 'allergen_management');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Incident ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `applicable_restaurant_format` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant Format');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `applicable_restaurant_format` SET TAGS ('dbx_value_regex' = 'QSR|casual|fine_dining');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'SOP Approval Authority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `attached_files_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Files Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'SOP Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SOP Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_description` SET TAGS ('dbx_business_glossary_term' = 'SOP Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'SOP Distribution Scope');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'global|regional|site_specific');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_code` SET TAGS ('dbx_business_glossary_term' = 'SOP Document Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'SOP Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `file_type` SET TAGS ('dbx_business_glossary_term' = 'SOP File Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `file_type` SET TAGS ('dbx_value_regex' = 'pdf|docx|html|txt');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'SOP Mandatory Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'SOP Language');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'SOP Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'SOP Owner Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'FDA|USDA|OSHA|ISO_22000|ServSafe');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'SOP Revision History');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_category` SET TAGS ('dbx_business_glossary_term' = 'SOP Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_category` SET TAGS ('dbx_value_regex' = 'Food_Safety|Sanitation|Allergen_Management|Equipment|Training');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_status` SET TAGS ('dbx_business_glossary_term' = 'SOP Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|archived');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'SOP Title');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SOP Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SOP Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Path');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_value_regex' = 'Food Safety|Allergen Management|Quality Assurance|Other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'ServSafe Manager|ServSafe Food Handler|HACCP|Allergen Awareness|Other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `next_renewal_due` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Days)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Identifier (IRID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (Restaurant ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_food_item` SET TAGS ('dbx_business_glossary_term' = 'Suspected Food Item (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Suspected Pathogen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_business_glossary_term' = 'Reported Symptoms (PHI)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `food_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Food Recall Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identifier (MANUFACTURER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `primary_food_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPPLIER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `affected_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Units (AFFECTED_UNITS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CORRECTIVE_ACTION)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'return|destroy|quarantine|donate|other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `distribution_region` SET TAGS ('dbx_business_glossary_term' = 'Distribution Region (REGION)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description (HAZARD_DESC)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `is_voluntary` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Recall Flag (VOLUNTARY_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name (MANUFACTURER_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date (NOTIF_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PRODUCT_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `public_communication_date` SET TAGS ('dbx_business_glossary_term' = 'Public Communication Date (PUBLIC_COMM_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification (FDA CLASS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Closure Reason (CLOSURE_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recall End Date (END_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Timestamp (INITIATION_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number (RECALL_NO)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope (SCOPE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_source_system` SET TAGS ('dbx_business_glossary_term' = 'Recall Source System (SOURCE_SYS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_source_system` SET TAGS ('dbx_value_regex' = 'Zenput|ERP|Manual|Other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|withdrawn');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'contamination|adulteration|mislabeling|foreign_object|allergen|other');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency (AGENCY)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|State|Local|International');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number (REG_REF_NO)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause (ROOT_CAUSE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY_LEVEL)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score (SEVERITY_SCORE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SUPPLIER_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_disposed` SET TAGS ('dbx_business_glossary_term' = 'Units Disposed (UNITS_DISPOSED)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_recalled` SET TAGS ('dbx_business_glossary_term' = 'Units Recalled (UNITS_RECALLED)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_returned` SET TAGS ('dbx_business_glossary_term' = 'Units Returned (UNITS_RETURNED)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_unit_response_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Unit Response ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `food_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Recall ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'returned_to_supplier|destroyed_on_site|quarantined|reworked|donated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `evidence_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `product_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_severity` SET TAGS ('dbx_business_glossary_term' = 'Recall Severity');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_source` SET TAGS ('dbx_business_glossary_term' = 'Recall Source');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_unit_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_unit_response_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|case|gallon|liter');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_control_log_id` SET TAGS ('dbx_business_glossary_term' = 'Pest Control Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_service_provider_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `chemicals_used` SET TAGS ('dbx_business_glossary_term' = 'Chemicals Used');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `findings_description` SET TAGS ('dbx_business_glossary_term' = 'Findings Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `next_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Service Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pests_identified` SET TAGS ('dbx_business_glossary_term' = 'Pests Identified');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|voided');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'completed|pending|canceled|rescheduled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'routine_inspection|treatment|exclusion|follow_up');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Treatment Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `foodsafety_supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification Identifier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID (CA_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID (INSPECTOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID (INSPECTOR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference (AUDIT_REF)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CORRECTIVE_REQ)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INSP_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp (INSPECTION_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name (INSPECTOR_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PRODUCT_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU (SKU)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY_RECEIVED)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date (RECEIVING_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RECORD_CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RECORD_UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason (REJECTION_REASON)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SUPPLIER_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C) (TEMP_C)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°F) (TEMP_F)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Pass Flag (TEMP_PASS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|g|oz|units|liters');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `visual_quality_pass` SET TAGS ('dbx_business_glossary_term' = 'Visual Quality Pass (VISUAL_PASS)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `food_safety_training_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Training ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `food_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|zenput');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_session_number` SET TAGS ('dbx_business_glossary_term' = 'Training Session Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'onboarding|annual_refresher|corrective|allergen_awareness');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for environmental_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `resampled_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Resampled Environmental Monitoring Id');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `resampled_environmental_monitoring_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
