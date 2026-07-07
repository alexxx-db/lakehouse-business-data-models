-- Schema for Domain: foodsafety | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`foodsafety` COMMENT 'Governs HACCP plan management, food safety audit results, health inspection records, corrective action tracking, temperature monitoring logs, sanitation schedules, allergen management, and SOP compliance via Zenput. Ensures adherence to FDA FSMA, local health department requirements, ISO 22000, and ServSafe standards across all restaurant units.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` (
    `haccp_plan_id` BIGINT COMMENT 'Primary key for the HACCP plan',
    `cost_center_id` BIGINT COMMENT 'FK to finance cost center',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `allergen_control_flag` BOOLEAN COMMENT 'Whether allergen controls are included in this plan',
    `approval_date` DATE COMMENT 'Date the plan was approved',
    `approval_status` STRING COMMENT 'Current approval status of the plan',
    `approved_by` STRING COMMENT 'Name of person who approved the plan',
    `audit_last_date` DATE COMMENT 'Date of last audit of this plan',
    `audit_next_due` DATE COMMENT 'Date next audit is due',
    `audit_status` STRING COMMENT 'Current audit status',
    `compliance_status` STRING COMMENT 'Overall compliance status of the plan',
    `corrective_action_procedure` STRING COMMENT 'Description of corrective action procedures',
    `critical_control_points` STRING COMMENT 'Summary of critical control points in the plan',
    `document_status` STRING COMMENT 'Status of the plan document',
    `document_url` STRING COMMENT 'URL to the plan document',
    `effective_from` DATE COMMENT 'Start date of plan effectiveness',
    `effective_until` DATE COMMENT 'End date of plan effectiveness',
    `hazard_analysis_summary` STRING COMMENT 'Summary of hazard analysis',
    `last_review_date` DATE COMMENT 'Date of last review',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the plan',
    `monitoring_frequency` STRING COMMENT 'How often monitoring occurs',
    `next_review_date` DATE COMMENT 'Date of next scheduled review',
    `non_conformance_count` STRING COMMENT 'Number of non-conformances found',
    `plan_code` STRING COMMENT 'Unique code for the plan',
    `plan_name` STRING COMMENT 'Name of the HACCP plan',
    `plan_type` STRING COMMENT 'Type/category of the plan',
    `plan_version` STRING COMMENT 'Version identifier of the plan',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when record was created',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when record was last updated',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework',
    `revision_number` STRING COMMENT 'Current revision number',
    `risk_level` STRING COMMENT 'Overall risk level assessment',
    `sanitation_schedule_reference` STRING COMMENT 'Reference to associated sanitation schedule',
    `scope_description` STRING COMMENT 'Description of plan scope',
    `temperature_log_reference` STRING COMMENT 'Reference to temperature log',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Whether temperature monitoring is required',
    `training_completion_date` DATE COMMENT 'Date training was completed',
    `training_required_flag` BOOLEAN COMMENT 'Whether training is required for this plan',
    CONSTRAINT pk_haccp_plan PRIMARY KEY(`haccp_plan_id`)
) COMMENT 'HACCP (Hazard Analysis Critical Control Points) plan documents for food safety management';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` (
    `critical_control_point_id` BIGINT COMMENT 'Primary key',
    `haccp_plan_id` BIGINT COMMENT 'FK to parent HACCP plan',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `average_deviation_value` DECIMAL(18,2) COMMENT 'Average deviation from critical limits',
    `critical_control_point_code` STRING COMMENT 'Unique code for the CCP',
    `corrective_action_procedure` STRING COMMENT 'Procedure for corrective actions',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_control_point_status` STRING COMMENT 'Current status of the CCP',
    `critical_limit_max` DECIMAL(18,2) COMMENT 'Maximum critical limit value',
    `critical_limit_min` DECIMAL(18,2) COMMENT 'Minimum critical limit value',
    `deviation_count` STRING COMMENT 'Number of deviations recorded',
    `effective_end_date` DATE COMMENT 'End date of CCP effectiveness',
    `effective_start_date` DATE COMMENT 'Start date of CCP effectiveness',
    `haccp_plan_version` STRING COMMENT 'Version of the parent HACCP plan',
    `hazard_type` STRING COMMENT 'Type of hazard (biological, chemical, physical)',
    `is_critical` BOOLEAN COMMENT 'Whether this is a critical point',
    `last_monitored_timestamp` TIMESTAMP COMMENT 'Timestamp of last monitoring',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of last verification',
    `monitoring_frequency` STRING COMMENT 'How often monitoring occurs',
    `monitoring_method` STRING COMMENT 'Method used for monitoring',
    `critical_control_point_name` STRING COMMENT 'Name of the critical control point',
    `notes` STRING COMMENT 'Additional notes',
    `process_step` STRING COMMENT 'Process step where CCP applies',
    `regulatory_reference` STRING COMMENT 'Regulatory reference for this CCP',
    `responsible_role` STRING COMMENT 'Role responsible for monitoring',
    `unit_of_measure` STRING COMMENT 'Unit of measure for critical limits',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `verification_frequency` STRING COMMENT 'How often verification occurs',
    `verification_method` STRING COMMENT 'Method used for verification',
    CONSTRAINT pk_critical_control_point PRIMARY KEY(`critical_control_point_id`)
) COMMENT 'Critical control points within HACCP plans where hazards can be prevented or eliminated';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` (
    `food_safety_audit_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to auditor employee',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `food_employee_id` BIGINT COMMENT 'FK to employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `food_unit_id` BIGINT COMMENT 'FK to unit',
    `site_id` BIGINT COMMENT 'FK to real estate site',
    `supply_supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `allergen_control_compliant` BOOLEAN COMMENT 'Whether allergen controls are compliant',
    `attached_documents_count` STRING COMMENT 'Number of attached documents',
    `audit_number` STRING COMMENT 'Unique audit number',
    `audit_timestamp` TIMESTAMP COMMENT 'When the audit was conducted',
    `audit_type` STRING COMMENT 'Type of audit',
    `auditor_name` STRING COMMENT 'Name of the auditor',
    `compliance_score` DECIMAL(18,2) COMMENT 'Compliance score percentage',
    `corrective_action_deadline` DATE COMMENT 'Deadline for corrective actions',
    `corrective_action_status` STRING COMMENT 'Status of corrective actions',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_findings_count` STRING COMMENT 'Number of critical findings',
    `food_safety_audit_status` STRING COMMENT 'Current status of the audit',
    `haccp_plan_version` STRING COMMENT 'HACCP plan version audited against',
    `non_critical_findings_count` STRING COMMENT 'Number of non-critical findings',
    `notes` STRING COMMENT 'Additional notes',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall audit score',
    `pass_fail` STRING COMMENT 'Pass or fail result',
    `regulatory_body` STRING COMMENT 'Regulatory body conducting audit',
    `sanitation_schedule_compliant` BOOLEAN COMMENT 'Whether sanitation schedule is compliant',
    `temperature_monitoring_compliant` BOOLEAN COMMENT 'Whether temperature monitoring is compliant',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_food_safety_audit PRIMARY KEY(`food_safety_audit_id`)
) COMMENT 'Food safety audits conducted at restaurant units or supplier facilities';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `audit_responsible_party_employee_id` BIGINT COMMENT 'FK to responsible party',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `audit_unit_id` BIGINT COMMENT 'FK to unit',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `food_safety_audit_id` BIGINT COMMENT 'FK to parent audit',
    `audit_finding_status` STRING COMMENT 'Current status of the finding',
    `corrective_action` STRING COMMENT 'Corrective action taken',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `audit_finding_description` STRING COMMENT 'Description of the finding',
    `due_date` DATE COMMENT 'Due date for resolution',
    `finding_category` STRING COMMENT 'Category of the finding',
    `finding_number` STRING COMMENT 'Unique finding number',
    `finding_timestamp` TIMESTAMP COMMENT 'When the finding was identified',
    `has_attachment` BOOLEAN COMMENT 'Whether evidence is attached',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute value for this audit finding record in the foodsafety domain',
    `resolution_date` DATE COMMENT 'Date finding was resolved',
    `severity_level` STRING COMMENT 'Severity level of the finding',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity score',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings from food safety audits';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` (
    `health_inspection_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `site_id` BIGINT COMMENT 'FK to site',
    `agency_name` STRING COMMENT 'Name of inspecting agency',
    `attachment_flag` BOOLEAN COMMENT 'Whether attachments exist',
    `closure_order_date` DATE COMMENT 'Date of closure order if issued',
    `closure_order_flag` BOOLEAN COMMENT 'Whether a closure order was issued',
    `compliance_code` STRING COMMENT 'A standardized code representing the compliance classification for this health inspection',
    `corrective_action_deadline` DATE COMMENT 'Deadline for corrective actions',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required',
    `corrective_action_status` STRING COMMENT 'Status of corrective actions',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'Currency code for fees',
    `follow_up_inspection_date` DATE COMMENT 'Date of follow-up inspection',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Whether follow-up is required',
    `inspection_date` DATE COMMENT 'Date of inspection',
    `inspection_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount for inspection',
    `inspection_number` STRING COMMENT 'Unique inspection number',
    `inspection_status` STRING COMMENT 'Current status',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of inspection',
    `inspection_type` STRING COMMENT 'Type of inspection',
    `inspector_code` BIGINT COMMENT 'Code of the inspector',
    `inspector_name` STRING COMMENT 'Name of the inspector',
    `notes` STRING COMMENT 'Additional notes',
    `overall_grade` STRING COMMENT 'Overall grade assigned',
    `pass_fail` STRING COMMENT 'Pass or fail result',
    `permit_status` STRING COMMENT 'Status of operating permit',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `risk_level` STRING COMMENT 'Risk level assessment',
    `score` DECIMAL(18,2) COMMENT 'Numeric inspection score',
    `violation_summary` STRING COMMENT 'Summary of violations',
    `violations_count` STRING COMMENT 'Number of violations found',
    CONSTRAINT pk_health_inspection PRIMARY KEY(`health_inspection_id`)
) COMMENT 'Health department inspections of restaurant units';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` (
    `inspection_violation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `health_inspection_id` BIGINT COMMENT 'FK to parent inspection',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `area_of_concern` STRING COMMENT 'Area where violation was found',
    `compliance_deadline` DATE COMMENT 'Deadline for compliance',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required',
    `corrective_action_status` STRING COMMENT 'Status of corrective action',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `evidence_photo_url` STRING COMMENT 'URL to evidence photo',
    `follow_up_inspection_date` DATE COMMENT 'Date of follow-up inspection',
    `inspection_violation_status` STRING COMMENT 'Current status of the violation',
    `inspector_code` BIGINT COMMENT 'Code of the inspector',
    `notes` STRING COMMENT 'Additional notes',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount',
    `penalty_currency` STRING COMMENT 'Currency of penalty',
    `regulatory_citation` STRING COMMENT 'Regulatory citation for violation',
    `reinspection_outcome` STRING COMMENT 'Outcome of reinspection',
    `severity` STRING COMMENT 'Severity of the violation',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `violation_code` STRING COMMENT 'Code for the violation',
    `violation_description` STRING COMMENT 'Description of the violation',
    `violation_reported_by` STRING COMMENT 'Who reported the violation',
    `violation_timestamp` TIMESTAMP COMMENT 'When violation was observed',
    `violation_type` STRING COMMENT 'Type of violation',
    CONSTRAINT pk_inspection_violation PRIMARY KEY(`inspection_violation_id`)
) COMMENT 'Individual violations found during health inspections';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` (
    `foodsafety_corrective_action_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `food_safety_audit_id` BIGINT COMMENT 'FK to related audit',
    `foodsafety_related_food_safety_audit_id` BIGINT COMMENT 'FK to food safety audit',
    `health_inspection_id` BIGINT COMMENT 'FK to related inspection',
    `foodsafety_related_inspection_health_inspection_id` BIGINT COMMENT 'FK to health inspection',
    `foodsafety_verified_by_employee_id` BIGINT COMMENT 'FK to verifying employee',
    `primary_foodsafety_employee_id` BIGINT COMMENT 'FK to primary food safety employee',
    `action_code` STRING COMMENT 'Unique action code',
    `action_cost` DECIMAL(18,2) COMMENT 'Cost of corrective action',
    `action_type` STRING COMMENT 'Type of corrective action',
    `actual_completion_date` DATE COMMENT 'Actual date of completion',
    `attachment_url` STRING COMMENT 'URL to attachment',
    `ccp_deviation` BOOLEAN COMMENT 'Whether related to CCP deviation',
    `closure_status` STRING COMMENT 'The current status of the closure for this foodsafety corrective action',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code for costs',
    `foodsafety_corrective_action_description` STRING COMMENT 'Description of corrective action',
    `effective_date` DATE COMMENT 'Date action becomes effective',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of triggering event',
    `foodsafety_corrective_action_status` STRING COMMENT 'Current status',
    `is_effective` BOOLEAN COMMENT 'Whether action was effective',
    `notes` STRING COMMENT 'Additional notes',
    `party_code` BIGINT COMMENT 'Code of responsible party',
    `priority` STRING COMMENT 'Priority level',
    `root_cause` STRING COMMENT 'Root cause analysis',
    `severity_level` STRING COMMENT 'The severity level attribute value for this foodsafety corrective action record in the foodsafety domain',
    `target_completion_date` DATE COMMENT 'Target date for completion',
    `temperature_exceedance` BOOLEAN COMMENT 'Whether related to temperature exceedance',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `verification_date` DATE COMMENT 'Date of verification',
    `verification_method` STRING COMMENT 'Method used for verification',
    CONSTRAINT pk_foodsafety_corrective_action PRIMARY KEY(`foodsafety_corrective_action_id`)
) COMMENT 'Corrective actions taken in response to food safety findings, deviations, or non-conformances';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` (
    `temperature_log_id` BIGINT COMMENT 'Primary key',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `stock_location_id` BIGINT COMMENT 'FK to stock location',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `equipment_asset_id` BIGINT COMMENT 'FK to equipment asset',
    `temperature_equipment_equipment_asset_id` BIGINT COMMENT 'FK to equipment',
    `temperature_recorded_by_user_employee_id` BIGINT COMMENT 'FK to recording employee',
    `audit_reference` STRING COMMENT 'Reference to related audit',
    `batch_number` STRING COMMENT 'Batch number being monitored',
    `calibration_date` DECIMAL(18,2) COMMENT 'Last calibration date',
    `calibration_due_date` DECIMAL(18,2) COMMENT 'Next calibration due date',
    `compliance_status` STRING COMMENT 'Compliance status of reading',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_limit_high` DECIMAL(18,2) COMMENT 'Upper critical limit',
    `critical_limit_low` DECIMAL(18,2) COMMENT 'Lower critical limit',
    `data_quality_flag` BOOLEAN COMMENT 'Whether data quality issue exists',
    `deviation_flag` BOOLEAN COMMENT 'Whether reading deviates from limits',
    `maintenance_due_date` DATE COMMENT 'Next maintenance due date',
    `maintenance_required` BOOLEAN COMMENT 'Whether maintenance is required',
    `monitoring_method` STRING COMMENT 'Method of temperature monitoring',
    `notes` STRING COMMENT 'Additional notes',
    `reading_timestamp` TIMESTAMP COMMENT 'When reading was taken',
    `reading_type` STRING COMMENT 'Type of reading',
    `sensor_serial_number` STRING COMMENT 'Serial number of sensor',
    `temperature_log_status` STRING COMMENT 'Status of the log entry',
    `temperature_trend` STRING COMMENT 'Trend direction',
    `temperature_value` DECIMAL(18,2) COMMENT 'Recorded temperature value',
    `unit_of_measure` STRING COMMENT 'Unit of measure (C/F)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_temperature_log PRIMARY KEY(`temperature_log_id`)
) COMMENT 'Temperature readings for food safety monitoring of equipment and storage areas';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` (
    `sanitation_schedule_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to chemical supplier',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `stock_location_id` BIGINT COMMENT 'FK to stock location',
    `allergen_control_flag` BOOLEAN COMMENT 'Whether allergen control is part of schedule',
    `area` STRING COMMENT 'Area to be sanitized',
    `audit_required_flag` BOOLEAN COMMENT 'Whether audit is required',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Required chemical concentration',
    `chemical_name` STRING COMMENT 'Name of cleaning chemical',
    `cleaning_method` STRING COMMENT 'Method of cleaning',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this sanitation schedule',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `sanitation_schedule_description` STRING COMMENT 'Description of schedule',
    `effective_from` DATE COMMENT 'Start date of schedule',
    `effective_until` DATE COMMENT 'End date of schedule',
    `equipment` STRING COMMENT 'Equipment to be sanitized',
    `frequency` STRING COMMENT 'Frequency count',
    `frequency_unit` STRING COMMENT 'Unit of frequency (daily, weekly, etc.)',
    `is_mandatory` BOOLEAN COMMENT 'Whether task is mandatory',
    `last_performed_timestamp` TIMESTAMP COMMENT 'When last performed',
    `next_due_timestamp` TIMESTAMP COMMENT 'When next due',
    `notes` STRING COMMENT 'Additional notes',
    `priority_level` STRING COMMENT 'The priority level attribute value for this sanitation schedule record in the foodsafety domain',
    `responsible_role` STRING COMMENT 'Role responsible',
    `sanitation_schedule_status` STRING COMMENT 'Current status',
    `schedule_code` STRING COMMENT 'Unique schedule code',
    `schedule_name` STRING COMMENT 'Name of the schedule',
    `sop_reference` STRING COMMENT 'Reference to SOP document',
    `task_name` STRING COMMENT 'Name of the task',
    `temperature_requirement_celsius` DECIMAL(18,2) COMMENT 'Required temperature in Celsius',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `version_number` STRING COMMENT 'The version number attribute value for this sanitation schedule record in the foodsafety domain',
    `waste_disposal_method` STRING COMMENT 'Method of waste disposal',
    CONSTRAINT pk_sanitation_schedule PRIMARY KEY(`sanitation_schedule_id`)
) COMMENT 'Sanitation schedules defining cleaning tasks, frequencies, and responsibilities';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` (
    `sanitation_task_log_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `equipment_asset_id` BIGINT COMMENT 'FK to equipment asset',
    `sanitation_equipment_equipment_asset_id` BIGINT COMMENT 'FK to equipment',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `sanitation_unit_id` BIGINT COMMENT 'FK to unit',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `site_id` BIGINT COMMENT 'FK to site',
    `stock_location_id` BIGINT COMMENT 'FK to stock location',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Audit creation timestamp',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'The audit updated timestamp attribute value for this sanitation task log record in the foodsafety domain',
    `chemical_concentration` DECIMAL(18,2) COMMENT 'Measured chemical concentration',
    `chemical_name` STRING COMMENT 'Chemical used',
    `completion_timestamp` TIMESTAMP COMMENT 'When task was completed',
    `compliance_regulation` STRING COMMENT 'Applicable regulation',
    `concentration_unit` DECIMAL(18,2) COMMENT 'Unit of concentration',
    `corrective_action` STRING COMMENT 'Corrective action taken',
    `deviation_notes` STRING COMMENT 'Notes on deviations',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Humidity percentage',
    `is_critical` BOOLEAN COMMENT 'Whether task is critical',
    `location_area` STRING COMMENT 'Area where task was performed',
    `notes` STRING COMMENT 'Additional notes',
    `pass_fail_status` STRING COMMENT 'Pass or fail result',
    `photo_url` STRING COMMENT 'URL to evidence photo',
    `scheduled_timestamp` TIMESTAMP COMMENT 'When task was scheduled',
    `task_duration_seconds` DECIMAL(18,2) COMMENT 'Duration in seconds',
    `task_status` STRING COMMENT 'Current task status',
    `task_timestamp` TIMESTAMP COMMENT 'When task was performed',
    `task_type` STRING COMMENT 'Type of sanitation task',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature in Celsius',
    `verification_method` STRING COMMENT 'Method of verification',
    CONSTRAINT pk_sanitation_task_log PRIMARY KEY(`sanitation_task_log_id`)
) COMMENT 'Log of completed sanitation tasks with results and verification';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` (
    `foodsafety_allergen_profile_id` BIGINT COMMENT 'Primary key',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient',
    `allergen_version` STRING COMMENT 'Version of allergen profile',
    `celery` STRING COMMENT 'Celery allergen status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cross_contact_risk_level` STRING COMMENT 'Level of cross-contact risk',
    `effective_from` DATE COMMENT 'Start date of profile',
    `effective_until` DATE COMMENT 'End date of profile',
    `egg` STRING COMMENT 'Egg allergen status',
    `fish` STRING COMMENT 'Fish allergen status',
    `foodsafety_allergen_profile_status` STRING COMMENT 'Current status of profile',
    `last_review_date` DATE COMMENT 'Date of last review',
    `lupin` STRING COMMENT 'Lupin allergen status',
    `management_controls` STRING COMMENT 'Controls in place',
    `milk` STRING COMMENT 'Milk allergen status',
    `mollusk` STRING COMMENT 'Mollusk allergen status',
    `mustard` STRING COMMENT 'Mustard allergen status',
    `notes` STRING COMMENT 'Additional notes',
    `peanut` STRING COMMENT 'Peanut allergen status',
    `profile_code` STRING COMMENT 'Unique profile code',
    `profile_name` STRING COMMENT 'Name of the profile',
    `profile_type` STRING COMMENT 'Type of profile',
    `review_status` STRING COMMENT 'The current status of the review for this foodsafety allergen profile',
    `review_timestamp` TIMESTAMP COMMENT 'When last reviewed',
    `reviewed_by` STRING COMMENT 'Who reviewed',
    `sesame` STRING COMMENT 'Sesame allergen status',
    `shellfish` STRING COMMENT 'Shellfish allergen status',
    `soy` STRING COMMENT 'Soy allergen status',
    `sulphites` STRING COMMENT 'Sulphites allergen status',
    `tree_nut` STRING COMMENT 'Tree nut allergen status',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `wheat` STRING COMMENT 'Wheat allergen status',
    CONSTRAINT pk_foodsafety_allergen_profile PRIMARY KEY(`foodsafety_allergen_profile_id`)
) COMMENT 'Allergen profiles for ingredients and menu items documenting allergen presence and cross-contact risks';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` (
    `allergen_incident_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'FK to guest profile',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `allergen_unit_id` BIGINT COMMENT 'FK to unit',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `guest_order_id` BIGINT COMMENT 'FK to guest order',
    `ingredient_id` BIGINT COMMENT 'FK to ingredient',
    `lot_tracking_id` BIGINT COMMENT 'FK to lot tracking',
    `member_id` BIGINT COMMENT 'FK to loyalty member',
    `menu_item_id` BIGINT COMMENT 'FK to menu item',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `site_id` BIGINT COMMENT 'FK to site',
    `stock_item_id` BIGINT COMMENT 'FK to stock item',
    `temperature_log_id` BIGINT COMMENT 'FK to temperature log',
    `allergen_code` STRING COMMENT 'Code of the allergen',
    `allergen_incident_status` STRING COMMENT 'Current status',
    `allergen_name` STRING COMMENT 'Name of the allergen',
    `complaint_description` STRING COMMENT 'Description of complaint',
    `compliance_flag` BOOLEAN COMMENT 'Whether compliant',
    `corrective_action` STRING COMMENT 'Corrective action taken',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `fda_medwatch_filed` BOOLEAN COMMENT 'Whether FDA report filed',
    `guest_contact_info` STRING COMMENT 'Guest contact information',
    `guest_contact_method` STRING COMMENT 'Method of guest contact',
    `immediate_action_taken` STRING COMMENT 'The immediate action taken attribute value for this allergen incident record in the foodsafety domain',
    `incident_category` STRING COMMENT 'Category of incident',
    `incident_location` STRING COMMENT 'Location of incident',
    `incident_notes` STRING COMMENT 'Notes about the incident',
    `incident_number` STRING COMMENT 'Unique incident number',
    `incident_resolution_timestamp` TIMESTAMP COMMENT 'When incident was resolved',
    `incident_timestamp` TIMESTAMP COMMENT 'When incident occurred',
    `investigation_complete` BOOLEAN COMMENT 'Whether investigation is complete',
    `investigation_complete_timestamp` TIMESTAMP COMMENT 'When investigation completed',
    `is_repeat_incident` BOOLEAN COMMENT 'Whether this is a repeat',
    `notification_date` DATE COMMENT 'Date of notification',
    `regulatory_notification_status` STRING COMMENT 'Status of regulatory notification',
    `reported_by` STRING COMMENT 'Who reported the incident',
    `root_cause` STRING COMMENT 'Root cause analysis',
    `severity_score` DECIMAL(18,2) COMMENT 'The severity score attribute value for this allergen incident record in the foodsafety domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_allergen_incident PRIMARY KEY(`allergen_incident_id`)
) COMMENT 'Allergen-related incidents including guest reactions and cross-contamination events';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` (
    `sop_document_id` BIGINT COMMENT 'Primary key',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `applicable_restaurant_format` STRING COMMENT 'Restaurant format this applies to',
    `approval_authority` STRING COMMENT 'Authority that approved',
    `attached_files_count` STRING COMMENT 'Number of attached files',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this sop document',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `sop_document_description` STRING COMMENT 'Description of the SOP',
    `distribution_scope` STRING COMMENT 'Scope of distribution',
    `document_code` STRING COMMENT 'Unique document code',
    `document_url` STRING COMMENT 'URL to document',
    `effective_date` DATE COMMENT 'Date document becomes effective',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this sop document',
    `file_type` STRING COMMENT 'Type of file',
    `is_mandatory` BOOLEAN COMMENT 'Whether document is mandatory',
    `language` STRING COMMENT 'Language of document',
    `last_review_date` DATE COMMENT 'Date of last review',
    `next_review_date` DATE COMMENT 'Date of next review',
    `owner_name` STRING COMMENT 'Name of document owner',
    `regulatory_basis` STRING COMMENT 'Regulatory basis for document',
    `revision_history` STRING COMMENT 'History of revisions',
    `sop_category` STRING COMMENT 'Category of SOP',
    `sop_document_status` STRING COMMENT 'Current status',
    `title` STRING COMMENT 'Title of the document',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `version_number` STRING COMMENT 'The version number attribute value for this sop document record in the foodsafety domain',
    CONSTRAINT pk_sop_document PRIMARY KEY(`sop_document_id`)
) COMMENT 'Standard Operating Procedure documents for food safety processes';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` (
    `food_safety_certification_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `food_safety_audit_id` BIGINT COMMENT 'FK to audit',
    `attached_document_path` STRING COMMENT 'Path to attached document',
    `audit_source_system` STRING COMMENT 'Source system for audit',
    `certification_category` STRING COMMENT 'Category of certification',
    `certification_name` STRING COMMENT 'Name of certification',
    `certification_number` STRING COMMENT 'Unique certification number',
    `certification_type` STRING COMMENT 'Type of certification',
    `compliance_flag` BOOLEAN COMMENT 'Whether in compliance',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this food safety certification',
    `expiration_notice_date` DECIMAL(18,2) COMMENT 'Date notice was sent',
    `expiration_notice_sent` DECIMAL(18,2) COMMENT 'Whether notice was sent',
    `food_safety_certification_status` STRING COMMENT 'Current status',
    `issue_date` DATE COMMENT 'Date issued',
    `issuing_body` STRING COMMENT 'Body that issued certification',
    `last_renewal_date` DATE COMMENT 'Date of last renewal',
    `next_renewal_due` DATE COMMENT 'Date next renewal is due',
    `notes` STRING COMMENT 'Additional notes',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last updated timestamp',
    `renewal_required` BOOLEAN COMMENT 'Whether renewal is required',
    `revocation_reason` STRING COMMENT 'Reason for revocation',
    `validity_period_days` STRING COMMENT 'Validity period in days',
    CONSTRAINT pk_food_safety_certification PRIMARY KEY(`food_safety_certification_id`)
) COMMENT 'Food safety certifications held by employees';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` (
    `illness_report_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `action_plan` STRING COMMENT 'The action plan attribute value for this illness report record in the foodsafety domain',
    `action_plan_completed_date` DATE COMMENT 'Date action plan completed',
    `action_plan_due_date` DATE COMMENT 'Due date for action plan',
    `compliance_reference` STRING COMMENT 'The compliance reference attribute value for this illness report record in the foodsafety domain',
    `corrective_action_taken` STRING COMMENT 'The corrective action taken attribute value for this illness report record in the foodsafety domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `exclusion_decision` BOOLEAN COMMENT 'Whether employee was excluded',
    `exclusion_start_date` DATE COMMENT 'Start date of exclusion',
    `health_department_notification_date` DATE COMMENT 'Date health dept was notified',
    `health_department_notified` BOOLEAN COMMENT 'Whether health dept was notified',
    `illness_report_status` STRING COMMENT 'Current status',
    `investigation_end_date` DATE COMMENT 'End date of investigation',
    `investigation_start_date` DATE COMMENT 'Start date of investigation',
    `investigation_status` STRING COMMENT 'Status of investigation',
    `notes` STRING COMMENT 'Additional notes',
    `onset_date` DATE COMMENT 'Date of illness onset',
    `report_method` STRING COMMENT 'How report was submitted',
    `report_number` STRING COMMENT 'Unique report number',
    `report_timestamp` TIMESTAMP COMMENT 'When report was filed',
    `return_to_work_date` DATE COMMENT 'Date employee returned to work',
    `root_cause` STRING COMMENT 'Root cause analysis',
    `severity_level` STRING COMMENT 'The severity level attribute value for this illness report record in the foodsafety domain',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity score',
    `suspected_food_item` STRING COMMENT 'The suspected food item attribute value for this illness report record in the foodsafety domain',
    `suspected_pathogen` STRING COMMENT 'The suspected pathogen attribute value for this illness report record in the foodsafety domain',
    `symptoms` STRING COMMENT 'Reported symptoms',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_illness_report PRIMARY KEY(`illness_report_id`)
) COMMENT 'Reports of foodborne illness or employee illness that may impact food safety';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` (
    `food_recall_id` BIGINT COMMENT 'Primary key',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `lot_tracking_id` BIGINT COMMENT 'FK to lot tracking',
    `primary_food_procurement_supplier_id` BIGINT COMMENT 'FK to primary supplier',
    `affected_units` STRING COMMENT 'Number of affected units',
    `corrective_action` STRING COMMENT 'Corrective action taken',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disposal_method` STRING COMMENT 'Method of disposal',
    `distribution_region` STRING COMMENT 'Region of distribution',
    `hazard_description` STRING COMMENT 'Description of hazard',
    `is_voluntary` BOOLEAN COMMENT 'Whether recall is voluntary',
    `lot_number` STRING COMMENT 'The lot number attribute value for this food recall record in the foodsafety domain',
    `manufacturer_name` STRING COMMENT 'Name of manufacturer',
    `notification_date` DATE COMMENT 'Date of notification',
    `product_name` STRING COMMENT 'Name of recalled product',
    `public_communication_date` DATE COMMENT 'Date of public communication',
    `recall_class` STRING COMMENT 'Class of recall (I, II, III)',
    `recall_closure_reason` STRING COMMENT 'Reason for closure',
    `recall_effective_date` DATE COMMENT 'Effective date of recall',
    `recall_end_date` DATE COMMENT 'End date of recall',
    `recall_initiation_timestamp` TIMESTAMP COMMENT 'When recall was initiated',
    `recall_number` STRING COMMENT 'Unique recall number',
    `recall_scope` STRING COMMENT 'Scope of recall',
    `recall_source_system` STRING COMMENT 'Source system',
    `recall_status` STRING COMMENT 'Current status',
    `recall_type` STRING COMMENT 'Type of recall',
    `regulatory_agency` STRING COMMENT 'Regulatory agency involved',
    `regulatory_reference_number` STRING COMMENT 'The regulatory reference number attribute value for this food recall record in the foodsafety domain',
    `root_cause` STRING COMMENT 'The root cause attribute value for this food recall record in the foodsafety domain',
    `severity_level` STRING COMMENT 'The severity level attribute value for this food recall record in the foodsafety domain',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity score',
    `sku` STRING COMMENT 'SKU of recalled product',
    `supplier_name` STRING COMMENT 'Name of supplier',
    `units_disposed` STRING COMMENT 'Number of units disposed',
    `units_recalled` STRING COMMENT 'Number of units recalled',
    `units_returned` STRING COMMENT 'Number of units returned',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    CONSTRAINT pk_food_recall PRIMARY KEY(`food_recall_id`)
) COMMENT 'Food recall events initiated by suppliers, manufacturers, or regulatory agencies';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` (
    `recall_unit_response_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `food_recall_id` BIGINT COMMENT 'FK to food recall',
    `lot_tracking_id` BIGINT COMMENT 'FK to lot tracking',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `recall_manager_employee_id` BIGINT COMMENT 'FK to manager',
    `site_id` BIGINT COMMENT 'FK to site',
    `unit_id` BIGINT COMMENT 'FK to unit',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity affected',
    `batch_number` STRING COMMENT 'The batch number attribute value for this recall unit response record in the foodsafety domain',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this recall unit response',
    `corrective_action_taken` STRING COMMENT 'The corrective action taken attribute value for this recall unit response record in the foodsafety domain',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `disposition_action` STRING COMMENT 'Disposition action taken',
    `disposition_date` DATE COMMENT 'Date of disposition',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of event',
    `evidence_documentation_flag` BOOLEAN COMMENT 'Whether evidence is documented',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of product',
    `lot_number` STRING COMMENT 'The lot number attribute value for this recall unit response record in the foodsafety domain',
    `manager_name` STRING COMMENT 'Name of responding manager',
    `notes` STRING COMMENT 'Additional notes',
    `product_sku` STRING COMMENT 'SKU of product',
    `recall_description` STRING COMMENT 'Description of recall',
    `recall_initiated_by` STRING COMMENT 'Who initiated recall',
    `recall_severity` STRING COMMENT 'Severity of recall',
    `recall_source` STRING COMMENT 'Source of recall',
    `recall_unit_response_status` STRING COMMENT 'Current status',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Whether regulatory compliant',
    `response_number` STRING COMMENT 'Unique response number',
    `temperature_log_reference` STRING COMMENT 'Reference to temperature log',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this recall unit response record in the foodsafety domain',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `verification_status` STRING COMMENT 'The current status of the verification for this recall unit response',
    `verification_timestamp` TIMESTAMP COMMENT 'When verified',
    CONSTRAINT pk_recall_unit_response PRIMARY KEY(`recall_unit_response_id`)
) COMMENT 'Individual restaurant unit responses to food recall events';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` (
    `pest_control_log_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `pest_service_provider_procurement_supplier_id` BIGINT COMMENT 'FK to service provider',
    `pest_unit_id` BIGINT COMMENT 'FK to unit',
    `site_id` BIGINT COMMENT 'FK to site',
    `stock_location_id` BIGINT COMMENT 'FK to stock location',
    `allergen_control_flag` BOOLEAN COMMENT 'Whether allergen control applies',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Audit creation timestamp',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'The audit updated timestamp attribute value for this pest control log record in the foodsafety domain',
    `chemicals_used` STRING COMMENT 'Chemicals used in treatment',
    `compliance_flag` BOOLEAN COMMENT 'Whether compliant',
    `corrective_actions` STRING COMMENT 'Corrective actions taken',
    `findings_description` STRING COMMENT 'Description of findings',
    `next_service_date` DATE COMMENT 'Date of next service',
    `notes` STRING COMMENT 'Additional notes',
    `pests_identified` STRING COMMENT 'The pests identified attribute value for this pest control log record in the foodsafety domain',
    `recommendations` STRING COMMENT 'The recommendations attribute value for this pest control log record in the foodsafety domain',
    `record_status` STRING COMMENT 'Status of record',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute value for this pest control log record in the foodsafety domain',
    `service_order_number` STRING COMMENT 'The service order number attribute value for this pest control log record in the foodsafety domain',
    `service_provider_name` STRING COMMENT 'Name of service provider',
    `service_status` STRING COMMENT 'Status of service',
    `service_timestamp` TIMESTAMP COMMENT 'When service was performed',
    `service_type` STRING COMMENT 'Type of service',
    `severity_level` STRING COMMENT 'The severity level attribute value for this pest control log record in the foodsafety domain',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity score',
    `temperature_log_reference` STRING COMMENT 'Reference to temperature log',
    `treatment_method` STRING COMMENT 'Method of treatment',
    CONSTRAINT pk_pest_control_log PRIMARY KEY(`pest_control_log_id`)
) COMMENT 'Log of pest control services and inspections at restaurant units';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` (
    `foodsafety_supplier_certification_id` BIGINT COMMENT 'Primary key',
    `foodsafety_supply_supplier_id` BIGINT COMMENT 'FK to supply supplier',
    `certification_id` BIGINT COMMENT 'FK to procurement certification',
    `supply_supplier_id` BIGINT COMMENT 'FK to supplier',
    `audit_score` DECIMAL(18,2) COMMENT 'The audit score attribute value for this foodsafety supplier certification record in the foodsafety domain',
    `certificate_number` STRING COMMENT 'The certificate number attribute value for this foodsafety supplier certification record in the foodsafety domain',
    `certification_number` STRING COMMENT 'The certification number attribute value for this foodsafety supplier certification record in the foodsafety domain',
    `certification_status` STRING COMMENT 'The current status of the certification for this foodsafety supplier certification',
    `certification_type` STRING COMMENT 'Type of certification',
    `certifying_body` STRING COMMENT 'The certifying body attribute value for this foodsafety supplier certification record in the foodsafety domain',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this foodsafety supplier certification',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this foodsafety supplier certification',
    `is_active` BOOLEAN COMMENT 'Whether active',
    `is_current` BOOLEAN COMMENT 'Whether current',
    `is_valid` BOOLEAN COMMENT 'Whether currently valid',
    `issue_date` DATE COMMENT 'Date issued',
    `issued_date` DATE COMMENT 'Date issued',
    `issuing_body` STRING COMMENT 'Body that issued certification',
    `scope` STRING COMMENT 'Scope of certification',
    `foodsafety_supplier_certification_status` STRING COMMENT 'Current status',
    `updated_at` TIMESTAMP COMMENT 'Updated timestamp',
    `verified_at` TIMESTAMP COMMENT 'When verified',
    CONSTRAINT pk_foodsafety_supplier_certification PRIMARY KEY(`foodsafety_supplier_certification_id`)
) COMMENT 'Food safety certifications held by suppliers (e.g., SQF, BRC, FSSC 22000)';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` (
    `receiving_inspection_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `foodsafety_corrective_action_id` BIGINT COMMENT 'FK to corrective action',
    `employee_id` BIGINT COMMENT 'FK to inspector',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `receiving_employee_id` BIGINT COMMENT 'FK to employee',
    `receiving_order_id` BIGINT COMMENT 'FK to receiving order',
    `audit_reference` STRING COMMENT 'Reference to audit',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this receiving inspection',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action required',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of product',
    `inspection_number` STRING COMMENT 'Unique inspection number',
    `inspection_timestamp` TIMESTAMP COMMENT 'When inspection occurred',
    `inspector_name` STRING COMMENT 'Name of inspector',
    `lot_number` STRING COMMENT 'The lot number attribute value for this receiving inspection record in the foodsafety domain',
    `notes` STRING COMMENT 'Additional notes',
    `product_name` STRING COMMENT 'Name of product',
    `product_sku` STRING COMMENT 'SKU of product',
    `quantity_received` DECIMAL(18,2) COMMENT 'The quantity received attribute value for this receiving inspection record in the foodsafety domain',
    `receiving_date` DATE COMMENT 'Date of receiving',
    `receiving_inspection_status` STRING COMMENT 'Current status',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp',
    `rejection_reason` STRING COMMENT 'Reason for rejection',
    `supplier_name` STRING COMMENT 'Name of supplier',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature in Celsius',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature in Fahrenheit',
    `temperature_pass_flag` BOOLEAN COMMENT 'Whether temperature passed',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this receiving inspection record in the foodsafety domain',
    `visual_quality_pass` BOOLEAN COMMENT 'Whether visual quality passed',
    CONSTRAINT pk_receiving_inspection PRIMARY KEY(`receiving_inspection_id`)
) COMMENT 'Food safety inspections performed during goods receiving';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` (
    `food_safety_training_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `primary_food_employee_id` BIGINT COMMENT 'FK to primary employee',
    `assessment_score` DECIMAL(18,2) COMMENT 'The assessment score attribute value for this food safety training record in the foodsafety domain',
    `completion_timestamp` TIMESTAMP COMMENT 'When training was completed',
    `compliance_status` STRING COMMENT 'The current status of the compliance for this food safety training',
    `delivery_method` STRING COMMENT 'Method of delivery',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this food safety training',
    `notes` STRING COMMENT 'Additional notes',
    `pass_fail_status` STRING COMMENT 'Pass or fail result',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last updated timestamp',
    `training_program_name` STRING COMMENT 'Name of training program',
    `training_session_number` STRING COMMENT 'Session number',
    `training_status` STRING COMMENT 'Current status',
    `training_type` STRING COMMENT 'Type of training',
    CONSTRAINT pk_food_safety_training PRIMARY KEY(`food_safety_training_id`)
) COMMENT 'Food safety training records for employees';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Primary key',
    `resampled_environmental_monitoring_id` BIGINT COMMENT 'FK to resampled record',
    `unit_id` BIGINT COMMENT 'FK to restaurant unit',
    `stock_location_id` BIGINT COMMENT 'FK to stock location',
    `cfu_count` DECIMAL(18,2) COMMENT 'Colony forming units count',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action required',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Flag for corrective action',
    `corrective_action_taken` STRING COMMENT 'The corrective action taken attribute value for this environmental monitoring record in the foodsafety domain',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `is_pass` BOOLEAN COMMENT 'Whether test passed',
    `is_positive` BOOLEAN COMMENT 'Whether result is positive',
    `lab_name` STRING COMMENT 'Name of testing lab',
    `monitoring_date` DATE COMMENT 'Date of monitoring',
    `monitoring_location` STRING COMMENT 'Location of monitoring',
    `pathogen_detected` BOOLEAN COMMENT 'Whether pathogen was detected',
    `pathogen_detected_flag` BOOLEAN COMMENT 'Flag for pathogen detection',
    `pathogen_tested` STRING COMMENT 'Pathogen tested for',
    `result` STRING COMMENT 'Result value',
    `result_date` DATE COMMENT 'Date results received',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric result value',
    `retest_date` DATE COMMENT 'Date of retest',
    `sample_date` DATE COMMENT 'Date sample was taken',
    `sample_location` STRING COMMENT 'Location where sample was taken',
    `sample_point` STRING COMMENT 'Specific sample point',
    `sample_type` STRING COMMENT 'Type of sample',
    `technician_name` STRING COMMENT 'Name of technician',
    `test_organism` STRING COMMENT 'Organism tested for',
    `test_result` STRING COMMENT 'Result of test',
    `test_type` STRING COMMENT 'Type of test',
    `tested_by` STRING COMMENT 'Who performed the test',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Environmental monitoring samples and test results for pathogen detection';

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
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` SET TAGS ('dbx_category' = 'compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_next_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `critical_control_points` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Points');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `hazard_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `sanitation_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`haccp_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_subdomain' = 'hazard_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` SET TAGS ('dbx_category' = 'compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'CCP ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `average_deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Average Deviation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_code` SET TAGS ('dbx_business_glossary_term' = 'CCP Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `corrective_action_procedure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_status` SET TAGS ('dbx_business_glossary_term' = 'CCP Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_max` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Max');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_limit_min` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Min');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_monitored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Monitored');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_business_glossary_term' = 'CCP Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `critical_control_point_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`critical_control_point` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` SET TAGS ('dbx_category' = 'audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `allergen_control_compliant` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Compliant');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `attached_documents_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `food_safety_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `haccp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'HACCP Plan Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `non_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Findings Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `sanitation_schedule_compliant` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Schedule Compliant');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `temperature_monitoring_compliant` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Compliant');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` SET TAGS ('dbx_category' = 'audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_responsible_party_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `has_attachment` SET TAGS ('dbx_business_glossary_term' = 'Has Attachment');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` SET TAGS ('dbx_category' = 'inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `closure_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Closure Order Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Grade');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`health_inspection` ALTER COLUMN `violations_count` SET TAGS ('dbx_business_glossary_term' = 'Violations Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` SET TAGS ('dbx_category' = 'inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `area_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Area of Concern');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Photo URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `evidence_photo_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspection_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `inspector_code` SET TAGS ('dbx_business_glossary_term' = 'Inspector Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `reinspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Outcome');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`inspection_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_subdomain' = 'audit_compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_category' = 'compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` SET TAGS ('dbx_ssot_canonical' = 'franchise.franchise_corrective_action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_related_inspection_health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Food Safety Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `primary_foodsafety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Action Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_cost` SET TAGS ('dbx_business_glossary_term' = 'Action Cost');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `ccp_deviation` SET TAGS ('dbx_business_glossary_term' = 'CCP Deviation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `foodsafety_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `is_effective` SET TAGS ('dbx_business_glossary_term' = 'Is Effective');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Party Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `temperature_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Temperature Exceedance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` SET TAGS ('dbx_category' = 'monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_equipment_equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_recorded_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit High');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `critical_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Low');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `maintenance_required` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `sensor_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sensor Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_log_status` SET TAGS ('dbx_business_glossary_term' = 'Log Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_trend` SET TAGS ('dbx_business_glossary_term' = 'Temperature Trend');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `temperature_value` SET TAGS ('dbx_business_glossary_term' = 'Temperature Value');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`temperature_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` SET TAGS ('dbx_category' = 'sanitation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `area` SET TAGS ('dbx_business_glossary_term' = 'Area');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `chemical_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `cleaning_method` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `equipment` SET TAGS ('dbx_business_glossary_term' = 'Equipment');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `last_performed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Performed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `next_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Due');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sanitation_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'SOP Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `task_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `temperature_requirement_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_schedule` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` SET TAGS ('dbx_category' = 'sanitation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_task_log_id` SET TAGS ('dbx_business_glossary_term' = 'Task Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_equipment_equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `sanitation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_concentration` SET TAGS ('dbx_business_glossary_term' = 'Chemical Concentration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `chemical_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percent');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_business_glossary_term' = 'Location Area');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `location_area` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Photo URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `photo_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature C');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_subdomain' = 'allergen_incident');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_category' = 'allergen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` SET TAGS ('dbx_ssot_canonical' = 'guest.guest_allergen_profile');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `foodsafety_allergen_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `allergen_version` SET TAGS ('dbx_business_glossary_term' = 'Allergen Version');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `celery` SET TAGS ('dbx_business_glossary_term' = 'Celery');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Cross Contact Risk Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `egg` SET TAGS ('dbx_business_glossary_term' = 'Egg');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `fish` SET TAGS ('dbx_business_glossary_term' = 'Fish');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `foodsafety_allergen_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `lupin` SET TAGS ('dbx_business_glossary_term' = 'Lupin');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `management_controls` SET TAGS ('dbx_business_glossary_term' = 'Management Controls');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `milk` SET TAGS ('dbx_business_glossary_term' = 'Milk');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mollusk` SET TAGS ('dbx_business_glossary_term' = 'Mollusk');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `mustard` SET TAGS ('dbx_business_glossary_term' = 'Mustard');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `peanut` SET TAGS ('dbx_business_glossary_term' = 'Peanut');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Profile Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Profile Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Profile Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sesame` SET TAGS ('dbx_business_glossary_term' = 'Sesame');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `shellfish` SET TAGS ('dbx_business_glossary_term' = 'Shellfish');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `soy` SET TAGS ('dbx_business_glossary_term' = 'Soy');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `sulphites` SET TAGS ('dbx_business_glossary_term' = 'Sulphites');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `tree_nut` SET TAGS ('dbx_business_glossary_term' = 'Tree Nut');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_allergen_profile` ALTER COLUMN `wheat` SET TAGS ('dbx_business_glossary_term' = 'Wheat');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_subdomain' = 'allergen_incident');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` SET TAGS ('dbx_category' = 'allergen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `temperature_log_id` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_code` SET TAGS ('dbx_business_glossary_term' = 'Allergen Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_name` SET TAGS ('dbx_business_glossary_term' = 'Allergen Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `fda_medwatch_filed` SET TAGS ('dbx_business_glossary_term' = 'FDA MedWatch Filed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Info');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_info` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `guest_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `investigation_complete` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `investigation_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `is_repeat_incident` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Incident');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`allergen_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` SET TAGS ('dbx_category' = 'documentation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'SOP Document ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `applicable_restaurant_format` SET TAGS ('dbx_business_glossary_term' = 'Applicable Format');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `attached_files_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Files Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_code` SET TAGS ('dbx_business_glossary_term' = 'Document Code');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `file_type` SET TAGS ('dbx_business_glossary_term' = 'File Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_category` SET TAGS ('dbx_business_glossary_term' = 'SOP Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `sop_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `title` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`sop_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` SET TAGS ('dbx_category' = 'certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Document Path');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Audit Source System');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `food_safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `next_renewal_due` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_certification` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_subdomain' = 'allergen_incident');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` SET TAGS ('dbx_category' = 'incident');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Completed Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_decision` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Decision');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `exclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Health Dept Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_business_glossary_term' = 'Health Dept Notified');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `health_department_notified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `illness_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_method` SET TAGS ('dbx_business_glossary_term' = 'Report Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_food_item` SET TAGS ('dbx_business_glossary_term' = 'Suspected Food Item');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `suspected_pathogen` SET TAGS ('dbx_business_glossary_term' = 'Suspected Pathogen');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_business_glossary_term' = 'Symptoms');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `symptoms` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`illness_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` SET TAGS ('dbx_category' = 'recall');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `food_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Recall ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `primary_food_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `affected_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Units');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `distribution_region` SET TAGS ('dbx_business_glossary_term' = 'Distribution Region');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `is_voluntary` SET TAGS ('dbx_business_glossary_term' = 'Is Voluntary');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `public_communication_date` SET TAGS ('dbx_business_glossary_term' = 'Public Communication Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Class');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'SKU');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_disposed` SET TAGS ('dbx_business_glossary_term' = 'Units Disposed');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_recalled` SET TAGS ('dbx_business_glossary_term' = 'Units Recalled');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `units_returned` SET TAGS ('dbx_business_glossary_term' = 'Units Returned');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_recall` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` SET TAGS ('dbx_category' = 'recall');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_unit_response_id` SET TAGS ('dbx_business_glossary_term' = 'Response ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `food_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Food Recall');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `lot_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `evidence_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_severity` SET TAGS ('dbx_business_glossary_term' = 'Recall Severity');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_source` SET TAGS ('dbx_business_glossary_term' = 'Recall Source');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `recall_unit_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`recall_unit_response` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` SET TAGS ('dbx_category' = 'pest_control');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_control_log_id` SET TAGS ('dbx_business_glossary_term' = 'Pest Control Log ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_service_provider_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pest_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `allergen_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `chemicals_used` SET TAGS ('dbx_business_glossary_term' = 'Chemicals Used');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `findings_description` SET TAGS ('dbx_business_glossary_term' = 'Findings Description');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `next_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Service Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `pests_identified` SET TAGS ('dbx_business_glossary_term' = 'Pests Identified');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Treatment Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`pest_control_log` ALTER COLUMN `treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_category' = 'supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` SET TAGS ('dbx_ssot_canonical' = 'procurement.procurement_supplier_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `foodsafety_supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `foodsafety_supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `is_valid` SET TAGS ('dbx_business_glossary_term' = 'Is Valid');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `foodsafety_supplier_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`foodsafety_supplier_certification` ALTER COLUMN `verified_at` SET TAGS ('dbx_business_glossary_term' = 'Verified At');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_subdomain' = 'recall_response');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` SET TAGS ('dbx_category' = 'receiving');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspection ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `foodsafety_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_order_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Order');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `receiving_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `supplier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Celsius');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `temperature_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Pass');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`receiving_inspection` ALTER COLUMN `visual_quality_pass` SET TAGS ('dbx_business_glossary_term' = 'Visual Quality Pass');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` SET TAGS ('dbx_category' = 'training');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `food_safety_training_id` SET TAGS ('dbx_business_glossary_term' = 'Training ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Employee');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `primary_food_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_program_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_session_number` SET TAGS ('dbx_business_glossary_term' = 'Training Session Number');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`food_safety_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'sanitation_monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_domain' = 'foodsafety');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` SET TAGS ('dbx_category' = 'monitoring');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring ID');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `resampled_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Resampled Record');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `cfu_count` SET TAGS ('dbx_business_glossary_term' = 'CFU Count');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `is_pass` SET TAGS ('dbx_business_glossary_term' = 'Is Pass');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `is_positive` SET TAGS ('dbx_business_glossary_term' = 'Is Positive');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Lab Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `lab_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `pathogen_detected` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Detected');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `pathogen_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Detected Flag');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `pathogen_tested` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Tested');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `result_date` SET TAGS ('dbx_business_glossary_term' = 'Result Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Date');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `sample_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Location');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `sample_location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `sample_point` SET TAGS ('dbx_business_glossary_term' = 'Sample Point');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `test_organism` SET TAGS ('dbx_business_glossary_term' = 'Test Organism');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring` ALTER COLUMN `tested_by` SET TAGS ('dbx_business_glossary_term' = 'Tested By');
