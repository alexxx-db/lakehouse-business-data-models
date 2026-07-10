-- Schema for Domain: scheduling | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`scheduling` COMMENT 'Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` (
    `appointment_type_id` BIGINT COMMENT 'Unique identifier',
    `board_certification_id` BIGINT COMMENT 'Required board certification',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling appointment type record.',
    `cdm_entry_id` BIGINT COMMENT 'Charge master entry',
    `cpt_code_id` BIGINT COMMENT 'Default CPT code',
    `allows_self_scheduling` BOOLEAN COMMENT 'Whether patients can self-schedule',
    `allows_telehealth` BOOLEAN COMMENT 'Whether telehealth is allowed',
    `appointment_type_status` STRING COMMENT 'Status (active, inactive)',
    `billing_class` STRING COMMENT 'The billing class of the scheduling appointment type record.',
    `cancellation_notice_hours` STRING COMMENT 'Required cancellation notice hours',
    `care_setting` STRING COMMENT 'The care setting of the scheduling appointment type record.',
    `appointment_type_category` STRING COMMENT 'Category of appointment type',
    `appointment_type_code` STRING COMMENT 'Code for appointment type',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling appointment type record.',
    `default_duration_minutes` STRING COMMENT 'Default duration in minutes',
    `appointment_type_description` STRING COMMENT 'The appointment type description of the scheduling appointment type record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling appointment type record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling appointment type record.',
    `equipment_required` STRING COMMENT 'Required equipment',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling appointment type record.',
    `maximum_duration_minutes` STRING COMMENT 'Maximum duration',
    `minimum_duration_minutes` STRING COMMENT 'Minimum duration',
    `appointment_type_name` STRING COMMENT 'The appointment type name of the scheduling appointment type record.',
    `no_show_penalty_applies` BOOLEAN COMMENT 'Whether no-show penalty applies',
    `notes` STRING COMMENT 'The notes of the scheduling appointment type record.',
    `patient_class` STRING COMMENT 'The patient class of the scheduling appointment type record.',
    `preparation_instructions` STRING COMMENT 'Patient preparation instructions',
    `quality_measure_applicable` BOOLEAN COMMENT 'Whether quality measures apply',
    `reminder_lead_time_days` STRING COMMENT 'Reminder lead time in days',
    `requires_interpreter` BOOLEAN COMMENT 'Whether interpreter is required',
    `requires_referral` BOOLEAN COMMENT 'Whether referral is required',
    `room_type_required` STRING COMMENT 'Required room type',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice RVU',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense RVU',
    `rvu_work` DECIMAL(18,2) COMMENT 'The rvu work of the scheduling appointment type record.',
    `specialty` STRING COMMENT 'The specialty of the scheduling appointment type record.',
    `staff_roles_required` STRING COMMENT 'Required staff roles',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_type_code` STRING COMMENT 'The visit type code value classifying the scheduling appointment type record.',
    `waitlist_eligible` BOOLEAN COMMENT 'Whether waitlist eligible',
    CONSTRAINT pk_appointment_type PRIMARY KEY(`appointment_type_id`)
) COMMENT 'Master catalog of appointment types defining duration, requirements, and billing characteristics.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` (
    `schedule_template_id` BIGINT COMMENT 'Unique identifier',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling schedule template record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary schedule employee within the scheduling schedule template record.',
    `schedulable_resource_id` BIGINT COMMENT 'Schedulable resource',
    `tertiary_schedule_approved_by_user_employee_id` BIGINT COMMENT 'Approved by user',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the workforce org unit within the scheduling schedule template record.',
    `appointment_type_code` STRING COMMENT 'The appointment type code value classifying the scheduling schedule template record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the scheduling schedule template record.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp of the scheduling schedule template record.',
    `auto_confirm_flag` BOOLEAN COMMENT 'The auto confirm flag of the scheduling schedule template record.',
    `buffer_time_minutes` STRING COMMENT 'The buffer time minutes of the scheduling schedule template record.',
    `cancellation_policy_code` STRING COMMENT 'The cancellation policy code value classifying the scheduling schedule template record.',
    `care_setting` STRING COMMENT 'The care setting of the scheduling schedule template record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling schedule template record.',
    `day_of_week` STRING COMMENT 'The day of week of the scheduling schedule template record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling schedule template record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling schedule template record.',
    `insurance_type_accepted` STRING COMMENT 'The insurance type accepted of the scheduling schedule template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling schedule template record.',
    `max_slots_per_session` STRING COMMENT 'The max slots per session of the scheduling schedule template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the scheduling schedule template record.',
    `no_show_tracking_enabled_flag` BOOLEAN COMMENT 'No show tracking enabled',
    `notes` STRING COMMENT 'The notes of the scheduling schedule template record.',
    `overbooking_allowed_flag` BOOLEAN COMMENT 'Overbooking allowed',
    `overbooking_limit` STRING COMMENT 'The overbooking limit of the scheduling schedule template record.',
    `patient_class` STRING COMMENT 'The patient class of the scheduling schedule template record.',
    `priority_level` STRING COMMENT 'The priority level of the scheduling schedule template record.',
    `provider_npi` STRING COMMENT 'The provider npi of the scheduling schedule template record.',
    `recurrence_pattern` STRING COMMENT 'The recurrence pattern of the scheduling schedule template record.',
    `recurrence_rule` STRING COMMENT 'The recurrence rule of the scheduling schedule template record.',
    `reminder_enabled_flag` BOOLEAN COMMENT 'Reminder enabled',
    `reminder_lead_time_hours` STRING COMMENT 'The reminder lead time hours of the scheduling schedule template record.',
    `service_type_code` STRING COMMENT 'The service type code value classifying the scheduling schedule template record.',
    `session_duration_minutes` STRING COMMENT 'The session duration minutes of the scheduling schedule template record.',
    `session_end_time` TIMESTAMP COMMENT 'Timestamp capturing the session end time associated with the scheduling schedule template record.',
    `session_start_time` TIMESTAMP COMMENT 'Timestamp capturing the session start time associated with the scheduling schedule template record.',
    `slot_duration_minutes` STRING COMMENT 'The slot duration minutes of the scheduling schedule template record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the scheduling schedule template record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the scheduling schedule template record.',
    `schedule_template_status` STRING COMMENT 'The schedule template status value classifying the scheduling schedule template record.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Telehealth enabled',
    `template_name` STRING COMMENT 'The template name of the scheduling schedule template record.',
    `template_status` STRING COMMENT 'The template status value classifying the scheduling schedule template record.',
    `template_type` STRING COMMENT 'The template type value classifying the scheduling schedule template record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Waitlist enabled',
    CONSTRAINT pk_schedule_template PRIMARY KEY(`schedule_template_id`)
) COMMENT 'Recurring schedule templates defining provider availability patterns and slot configurations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` (
    `open_slot_id` BIGINT COMMENT 'Unique identifier',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling open slot record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the scheduling open slot record.',
    `equipment_asset_id` BIGINT COMMENT 'Equipment asset',
    `research_study_id` BIGINT COMMENT 'Research study',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the scheduling open slot record.',
    `schedule_template_id` BIGINT COMMENT 'Schedule template',
    `appointment_type_eligibility` STRING COMMENT 'The appointment type eligibility of the scheduling open slot record.',
    `block_reason` STRING COMMENT 'The block reason of the scheduling open slot record.',
    `block_type` STRING COMMENT 'The block type value classifying the scheduling open slot record.',
    `care_setting` STRING COMMENT 'The care setting of the scheduling open slot record.',
    `comment` STRING COMMENT 'The comment of the scheduling open slot record.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp capturing the created datetime associated with the scheduling open slot record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling open slot record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling open slot record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling open slot record.',
    `hold_expiration_datetime` TIMESTAMP COMMENT 'Timestamp capturing the hold expiration datetime associated with the scheduling open slot record.',
    `hold_reason` STRING COMMENT 'The hold reason of the scheduling open slot record.',
    `hold_status` STRING COMMENT 'The hold status value classifying the scheduling open slot record.',
    `insurance_eligibility` STRING COMMENT 'The insurance eligibility of the scheduling open slot record.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Timestamp capturing the last modified datetime associated with the scheduling open slot record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling open slot record.',
    `max_capacity` STRING COMMENT 'The max capacity of the scheduling open slot record.',
    `notes` STRING COMMENT 'The notes of the scheduling open slot record.',
    `online_booking_cutoff_hours` STRING COMMENT 'The online booking cutoff hours of the scheduling open slot record.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Online booking enabled',
    `overbook_allowed_flag` BOOLEAN COMMENT 'Overbook allowed',
    `patient_type_eligibility` STRING COMMENT 'The patient type eligibility of the scheduling open slot record.',
    `remaining_capacity` STRING COMMENT 'The remaining capacity of the scheduling open slot record.',
    `slot_category` STRING COMMENT 'The slot category of the scheduling open slot record.',
    `slot_duration_minutes` STRING COMMENT 'The slot duration minutes of the scheduling open slot record.',
    `slot_end_datetime` TIMESTAMP COMMENT 'Timestamp capturing the slot end datetime associated with the scheduling open slot record.',
    `slot_identifier` STRING COMMENT 'The slot identifier of the scheduling open slot record.',
    `slot_start_datetime` TIMESTAMP COMMENT 'Timestamp capturing the slot start datetime associated with the scheduling open slot record.',
    `slot_status` STRING COMMENT 'The slot status value classifying the scheduling open slot record.',
    `slot_type` STRING COMMENT 'The slot type value classifying the scheduling open slot record.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling open slot record.',
    `specialty` STRING COMMENT 'The specialty of the scheduling open slot record.',
    `open_slot_status` STRING COMMENT 'The open slot status value classifying the scheduling open slot record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Waitlist enabled',
    CONSTRAINT pk_open_slot PRIMARY KEY(`open_slot_id`)
) COMMENT 'Available appointment slots generated from schedule templates and block time.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` (
    `surgical_case_id` BIGINT COMMENT 'Unique identifier',
    `capital_project_id` BIGINT COMMENT 'Capital project',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling surgical case record.',
    `prior_authorization_id` BIGINT COMMENT 'Prior authorization',
    `clinical_order_id` BIGINT COMMENT 'Clinical order',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the diagnosis within the scheduling surgical case record.',
    `drg_id` BIGINT COMMENT 'Unique identifier for the drg within the scheduling surgical case record.',
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the or suite within the scheduling surgical case record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the scheduling surgical case record.',
    `icd_code_id` BIGINT COMMENT 'Pre-op diagnosis ICD code',
    `cpt_code_id` BIGINT COMMENT 'Primary procedure CPT code',
    `privileging_id` BIGINT COMMENT 'Privileging',
    `procedure_event_id` BIGINT COMMENT 'Procedure event',
    `research_study_id` BIGINT COMMENT 'Research study',
    `surgical_bom_id` BIGINT COMMENT 'Surgical BOM',
    `treatment_consent_id` BIGINT COMMENT 'Treatment consent',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the scheduling surgical case record.',
    `actual_duration_minutes` STRING COMMENT 'The actual duration minutes of the scheduling surgical case record.',
    `actual_end_time` TIMESTAMP COMMENT 'Timestamp capturing the actual end time associated with the scheduling surgical case record.',
    `actual_start_time` TIMESTAMP COMMENT 'Timestamp capturing the actual start time associated with the scheduling surgical case record.',
    `add_on_case_indicator` BOOLEAN COMMENT 'The add on case indicator of the scheduling surgical case record.',
    `anesthesia_type` STRING COMMENT 'The anesthesia type value classifying the scheduling surgical case record.',
    `asa_classification` STRING COMMENT 'The asa classification of the scheduling surgical case record.',
    `block_owner_npi` STRING COMMENT 'The block owner npi of the scheduling surgical case record.',
    `block_time_indicator` BOOLEAN COMMENT 'The block time indicator of the scheduling surgical case record.',
    `cancellation_reason` STRING COMMENT 'The cancellation reason of the scheduling surgical case record.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The cancellation timestamp of the scheduling surgical case record.',
    `case_number` STRING COMMENT 'The case number of the scheduling surgical case record.',
    `case_status` STRING COMMENT 'The case status value classifying the scheduling surgical case record.',
    `case_type` STRING COMMENT 'The case type value classifying the scheduling surgical case record.',
    `consent_obtained_indicator` BOOLEAN COMMENT 'The consent obtained indicator of the scheduling surgical case record.',
    `consent_timestamp` TIMESTAMP COMMENT 'The consent timestamp of the scheduling surgical case record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling surgical case record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling surgical case record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling surgical case record.',
    `equipment_requirements` STRING COMMENT 'The equipment requirements of the scheduling surgical case record.',
    `estimated_duration_minutes` STRING COMMENT 'The estimated duration minutes of the scheduling surgical case record.',
    `facility_code` STRING COMMENT 'The facility code value classifying the scheduling surgical case record.',
    `implant_required` BOOLEAN COMMENT 'The implant required of the scheduling surgical case record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling surgical case record.',
    `laterality` STRING COMMENT 'The laterality of the scheduling surgical case record.',
    `mrn` STRING COMMENT 'The mrn of the scheduling surgical case record.',
    `notes` STRING COMMENT 'The notes of the scheduling surgical case record.',
    `patient_class` STRING COMMENT 'The patient class of the scheduling surgical case record.',
    `post_op_diagnosis` STRING COMMENT 'The post op diagnosis of the scheduling surgical case record.',
    `record_number` BIGINT COMMENT 'Consent record',
    `requires_blood_products` BOOLEAN COMMENT 'The requires blood products of the scheduling surgical case record.',
    `requires_icu_bed` BOOLEAN COMMENT 'The requires icu bed of the scheduling surgical case record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the scheduling surgical case record.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled end time associated with the scheduling surgical case record.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled start time associated with the scheduling surgical case record.',
    `secondary_procedure_codes` STRING COMMENT 'The secondary procedure codes of the scheduling surgical case record.',
    `service_line` STRING COMMENT 'The service line of the scheduling surgical case record.',
    `site_marked_indicator` BOOLEAN COMMENT 'The site marked indicator of the scheduling surgical case record.',
    `specialty` STRING COMMENT 'The specialty of the scheduling surgical case record.',
    `surgical_case_status` STRING COMMENT 'The surgical case status value classifying the scheduling surgical case record.',
    `timeout_completed_indicator` BOOLEAN COMMENT 'The timeout completed indicator of the scheduling surgical case record.',
    `urgency_level` STRING COMMENT 'The urgency level of the scheduling surgical case record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_surgical_case PRIMARY KEY(`surgical_case_id`)
) COMMENT 'Surgical case scheduling records including OR time, team, equipment, and case details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` (
    `or_block_id` BIGINT COMMENT 'Unique identifier for the operating room block time allocation record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the hospital or surgical facility where the OR block is allocated.',
    `clinician_id` BIGINT COMMENT 'Identifier of the individual surgeon who owns the block, if block_owner_type is surgeon. References provider master data.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: OR block allocation governed by utilization policies, fair access rules, release policies, and anti-discrimination requirements. Real governance need in surgical scheduling operations.',
    `contract_id` BIGINT COMMENT 'Identifier of the contract or agreement governing this block allocation, if the block is part of a formal contractual arrangement with a surgeon or service.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified the block allocation record, for audit trail purposes.',
    `or_suite_id` BIGINT COMMENT 'Identifier of the specific operating room or surgical suite assigned to this block.',
    `service_id` BIGINT COMMENT 'Identifier of the surgical service or service line that owns the block, if block_owner_type is service.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: OR blocks allocated by procedure type require CPT reference for duration estimation, equipment planning, anesthesia type determination, and block utilization analysis. Core to perioperative capacity m',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that owns the block, if block_owner_type is department.',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether cases can be scheduled beyond the allocated block end time, allowing for extended use of the OR suite.',
    `allows_sharing` BOOLEAN COMMENT 'Indicates whether the block owner permits other surgeons or services to share unused portions of the block time.',
    `anesthesia_type_required` STRING COMMENT 'Type of anesthesia typically required for cases scheduled in this block (e.g., general, regional, local, MAC). Used for resource planning.',
    `block_duration_minutes` STRING COMMENT 'Total duration of the OR block in minutes, calculated from start to end time.',
    `block_end_time` TIMESTAMP COMMENT 'Time of day when the OR block ends, in HH:mm format (e.g., 15:30). Represents the scheduled end of the allocated time window.',
    `block_name` STRING COMMENT 'Descriptive name of the OR block, often including the service or surgeon name for easy identification.',
    `block_number` STRING COMMENT 'Business identifier or code for the OR block allocation, used for scheduling and reporting purposes.',
    `block_owner_type` STRING COMMENT 'Type of entity that owns or controls the block time allocation (service line, individual surgeon, specialty, department, or open block).. Valid values are `service|surgeon|specialty|department|open`',
    `block_start_time` TIMESTAMP COMMENT 'Time of day when the OR block begins, in HH:mm format (e.g., 07:30). Represents the scheduled start of the allocated time window.',
    `block_status` STRING COMMENT 'Current operational status of the OR block allocation indicating whether it is available for scheduling.. Valid values are `active|suspended|cancelled|expired|pending`',
    `block_type` STRING COMMENT 'Classification of the block allocation indicating priority and usage rules (primary block has first priority, secondary is backup, open is available to all, flex is flexible allocation, call is for on-call cases).. Valid values are `primary|secondary|tertiary|open|flex|call`',
    `cancellation_reason` STRING COMMENT 'Reason why the block allocation was permanently cancelled (e.g., surgeon departure, service line closure, contract termination).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which OR block time and associated costs are allocated for accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was first created in the system.',
    `day_of_week` STRING COMMENT 'Day of the week on which this block time is allocated (recurring weekly schedule). [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this block allocation expires or is no longer active. Null indicates an open-ended allocation.',
    `effective_start_date` DATE COMMENT 'Date when this block allocation becomes active and available for scheduling.',
    `equipment_set_required` STRING COMMENT 'Standard equipment set or configuration required for cases in this block (e.g., orthopedic, cardiac, robotic). Used for OR setup and resource allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was most recently updated or modified.',
    `minimum_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of block time that must be utilized to maintain the block allocation. Used for performance monitoring and block reallocation decisions.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the block allocation, including scheduling preferences, restrictions, or coordination requirements.',
    `owner_specialty_code` STRING COMMENT 'Code representing the surgical specialty that owns the block, if block_owner_type is specialty.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority of this block when multiple blocks overlap or compete for the same OR suite. Lower numbers indicate higher priority.',
    `recurring_pattern` STRING COMMENT 'Pattern describing how the block recurs over time (e.g., every week, every other week, first Monday of month). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|first_week|second_week|third_week|fourth_week|custom — 8 candidates stripped; promote to reference product]',
    `release_lead_time_days` STRING COMMENT 'Number of days before the block date that unused time must be released, if release_rule_type is days_before.',
    `release_lead_time_hours` STRING COMMENT 'Number of hours before the block start time that unused time must be released, if release_rule_type is hours_before.',
    `release_rule_type` STRING COMMENT 'Type of rule governing when unused block time is released back to the general pool for other surgeons or services to use.. Valid values are `days_before|hours_before|no_release|manual`',
    `staff_roles_required` STRING COMMENT 'Comma-separated list of staff roles or specialties required to support cases in this block (e.g., scrub nurse, circulating nurse, surgical tech, perfusionist).',
    `or_block_status` STRING COMMENT 'The or block status value classifying the scheduling or block record.',
    `suspension_reason` STRING COMMENT 'Reason why the block was suspended or temporarily inactivated (e.g., low utilization, surgeon leave, facility maintenance).',
    `target_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Target percentage of block time utilization that the owner is expected to achieve for optimal OR capacity management.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_or_block PRIMARY KEY(`or_block_id`)
) COMMENT 'Operating room block time allocations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` (
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource. Primary key for the schedulable resource entity.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or hospital where this resource is located or primarily operates. Links to the facility domain master.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this resource record. Supports audit trail and accountability.',
    `equipment_asset_id` BIGINT COMMENT 'Unique asset identifier or serial number for equipment resources. Links to the supply chain domain equipment asset master. Applicable only to equipment resources. Null for non-equipment resources.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or service line to which this resource is assigned. Links to organizational hierarchy.',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider resource is currently accepting new patient appointments. True if accepting new patients, False otherwise. Applicable only to provider resources.',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether the resource permits overbooking (scheduling more appointments than standard capacity allows). True if overbooking is permitted, False otherwise.',
    `building` STRING COMMENT 'Building name or number within the facility where the resource is located. Applicable primarily to room and equipment resources.',
    `care_setting` STRING COMMENT 'Primary care setting or service delivery environment where the resource operates (e.g., inpatient, outpatient, emergency department, ambulatory surgery center, home health, telehealth).. Valid values are `inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was first created in the system. Supports audit trail and data lineage.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the providers current credentialing and privileging expires and must be renewed. Applicable only to provider resources.',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing and privileging process. Applicable only to provider resources. Active indicates fully credentialed and privileged; pending indicates credentialing in progress; expired, suspended, or revoked indicate loss of privileges.. Valid values are `active|pending|expired|suspended|revoked`',
    `default_slot_duration_minutes` STRING COMMENT 'Standard duration in minutes for a single scheduling slot or appointment block for this resource. Used as the default when creating schedules.',
    `effective_end_date` DATE COMMENT 'Date when the resource was retired or became unavailable for scheduling. Null for currently active resources. Supports historical tracking and temporal queries.',
    `effective_start_date` DATE COMMENT 'Date when the resource became active and available for scheduling. Supports historical tracking and temporal queries.',
    `floor` STRING COMMENT 'Floor number or level within the building where the resource is located. Applicable primarily to room and equipment resources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was most recently updated. Supports audit trail and change tracking.',
    `license_number` STRING COMMENT 'State-issued professional license number for provider resources. Applicable only to provider resources. Null for non-provider resources.',
    `license_state` STRING COMMENT 'Two-letter state code where the provider license was issued. Applicable only to provider resources.. Valid values are `^[A-Z]{2}$`',
    `location_code` STRING COMMENT 'Code representing the specific location, building, or campus where the resource is situated. Used for geographic and logistical scheduling.',
    `maintenance_window_end` TIMESTAMP COMMENT 'End date and time of scheduled maintenance or downtime window. Applicable primarily to equipment and room resources.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Start date and time of scheduled maintenance or downtime window during which the resource is unavailable for scheduling. Applicable primarily to equipment and room resources.',
    `minimum_turnover_time_minutes` STRING COMMENT 'Minimum time in minutes required between consecutive appointments or uses of the resource. Includes cleaning, setup, and preparation time. Critical for scheduling optimization and capacity planning.',
    `notes` STRING COMMENT 'The notes of the scheduling schedulable resource record.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS. Applicable only to provider resources (physicians, APPs, therapists). Null for non-provider resources.. Valid values are `^[0-9]{10}$`',
    `overbooking_limit` STRING COMMENT 'Maximum number of additional appointments that can be overbooked beyond standard capacity. Applicable only when allows_overbooking is True.',
    `provider_type` STRING COMMENT 'Classification of provider role or credential level (e.g., physician, nurse practitioner, physician assistant, physical therapist, registered nurse). Applicable only to provider resources. Null for non-provider resources.',
    `resource_code` STRING COMMENT 'Unique business identifier or code for the resource. May be an internal system code, asset tag, or room number depending on resource type.',
    `resource_name` STRING COMMENT 'Human-readable name or title of the schedulable resource. For providers, this is the full name; for rooms, the room designation; for equipment, the equipment name or model.',
    `resource_type` STRING COMMENT 'Classification of the schedulable resource: provider (physicians, APPs, therapists), room (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), or care team.. Valid values are `provider|room|equipment|care_team`',
    `room_capacity` STRING COMMENT 'Maximum number of patients or occupants that can be accommodated in the room simultaneously. Applicable only to room resources. Null for non-room resources.',
    `room_configuration` STRING COMMENT 'Physical configuration or layout of the room (e.g., single-bed, multi-bed, open bay, private suite). Applicable only to room resources.',
    `scheduling_constraints` STRING COMMENT 'Free-text description of any special scheduling rules, restrictions, or constraints that apply to this resource (e.g., only available for specific appointment types, requires advance booking, limited to certain patient populations).',
    `scheduling_status` STRING COMMENT 'Current availability status of the resource for scheduling purposes. Active resources are available for scheduling; inactive resources are temporarily unavailable; maintenance resources are undergoing service; reserved resources are held for specific purposes; retired resources are permanently removed from service.. Valid values are `active|inactive|maintenance|reserved|retired`',
    `specialty_code` STRING COMMENT 'Medical specialty or service line associated with the resource. For providers, this is their clinical specialty; for rooms and equipment, the specialty they support (e.g., cardiology, orthopedics, radiology).',
    `schedulable_resource_status` STRING COMMENT 'The schedulable resource status value classifying the scheduling schedulable resource record.',
    `sterilization_cycle_required` BOOLEAN COMMENT 'Indicates whether the resource requires a sterilization cycle between uses. True if sterilization is required, False otherwise. Applicable primarily to equipment and room resources used in surgical or procedural settings.',
    `sterilization_duration_minutes` STRING COMMENT 'Duration in minutes required to complete the sterilization cycle for the resource. Applicable only when sterilization_cycle_required is True.',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the resource supports telehealth or virtual visit appointments. True if telehealth is supported, False otherwise. Applicable primarily to provider resources.',
    `unit` STRING COMMENT 'Unit, wing, or zone designation within the floor where the resource is located. Applicable primarily to room and equipment resources.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_schedulable_resource PRIMARY KEY(`schedulable_resource_id`)
) COMMENT 'Schedulable resources';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` (
    `resource_assignment_id` BIGINT COMMENT 'Unique identifier for the resource assignment record. Primary key for the resource assignment entity.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling resource assignment record.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider (physician, surgeon, specialist) assigned to this appointment or case. Populated when resource_type is provider.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource assignments (clinicians, staff, equipment) incur costs allocated to cost centers for activity-based costing, resource utilization financial analysis, and departmental cost tracking. Supports ',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key reference to the specific equipment asset assigned or reserved for this appointment or procedure. Includes surgical instruments, imaging devices, anesthesia machines, and specialized medical equipment.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the staff member (nurse, technician, assistant) assigned to support this appointment or procedure. Populated when resource_type is staff or care_team_member.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure-based resource assignments require CPT lookup for equipment requirements, staff role determination, privilege verification, and billing modifier application. Essential for surgical and proce',
    `procedure_event_id` BIGINT COMMENT 'Foreign key reference to the specific procedure or service being performed. Links to the procedure master for clinical and billing context.',
    `room_id` BIGINT COMMENT 'Foreign key reference to the physical room or space assigned for this appointment or procedure. Includes Operating Rooms (OR), exam rooms, treatment rooms, and procedure suites.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key reference to the appointment or scheduled event to which this resource is assigned.',
    `study_visit_id` BIGINT COMMENT 'Foreign key linking to research.study_visit. Business justification: Research visits require assignment of protocol-specific resources: certified research staff, specialized equipment (PET scanners, research-grade devices), and credentialed investigators. Resource assi',
    `substitute_for_resource_assignment_id` BIGINT COMMENT 'Foreign key reference to another resource assignment that this assignment is substituting for. Used when a resource is replaced due to unavailability, conflict, or last-minute changes.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key reference to the surgical case record when the assignment is for an Operating Room (OR) procedure. Null for non-surgical appointments.',
    `tertiary_resource_requested_by_user_employee_id` BIGINT COMMENT 'Foreign key reference to the user who initially requested or created this resource assignment. Typically a scheduler, care coordinator, or provider.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Resource assignments (staff, rooms, equipment) must reconcile with actual encounter visits for billing charge capture, utilization analysis, and clinical documentation workflows. Healthcare operations',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the resource assignment concluded. Used to calculate actual duration, resource utilization, and case completion metrics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the resource assignment began. Captures real-world start time for variance analysis, billing accuracy, and operational performance measurement.',
    `assignment_notes` STRING COMMENT 'Free-text notes or special instructions related to this resource assignment. May include preferences, constraints, special equipment needs, or coordination details.',
    `assignment_priority` STRING COMMENT 'Priority level for this resource assignment. Determines scheduling precedence and resource allocation urgency, especially critical for Operating Room (OR) and Emergency Department (ED) scheduling.. Valid values are `routine|urgent|emergent|elective|stat`',
    `assignment_role` STRING COMMENT 'Specific role or function the resource performs in this appointment or case. Examples include primary surgeon, co-surgeon, anesthesiologist, Certified Registered Nurse Anesthetist (CRNA), scrub technician, circulating nurse, perfusionist, equipment operator, primary care provider. [ENUM-REF-CANDIDATE: primary_surgeon|co_surgeon|assistant_surgeon|anesthesiologist|crna|scrub_tech|circulating_nurse|perfusionist|equipment_operator|primary_provider|consulting_provider|radiologist|pathologist|respiratory_therapist — promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the resource assignment. Tracks progression from initial request through confirmation, active use, and final release or cancellation. [ENUM-REF-CANDIDATE: requested|confirmed|in_use|completed|released|declined|cancelled|no_show — 8 candidates stripped; promote to reference product]',
    `billable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this resource assignment generates a billable charge. Used to determine which assignments flow to revenue cycle and claims processing.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for cancellation of this resource assignment. Supports root cause analysis of scheduling disruptions and resource availability issues.',
    `cancelled_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment was cancelled. Null if the assignment was not cancelled. Used for cancellation rate analysis and resource utilization metrics.',
    `charge_code` STRING COMMENT 'Charge Description Master (CDM) code or Current Procedural Terminology (CPT) code associated with this resource assignment for billing purposes. Links assignment to revenue capture.',
    `confirmation_datetime` TIMESTAMP COMMENT 'Date and time when the resource confirmed their assignment. Tracks confirmation lead time and supports compliance with staffing notification requirements.',
    `confirmation_status` STRING COMMENT 'Indicates whether the assigned resource has confirmed their availability and commitment to this assignment. Critical for surgical case staffing and high-acuity appointments.. Valid values are `pending|confirmed|declined|tentative|cancelled`',
    `conflict_description` STRING COMMENT 'Free-text description of the nature of the scheduling conflict, if one exists. Provides context for resolution and audit trail of scheduling issues.',
    `conflict_flag` BOOLEAN COMMENT 'Boolean indicator of whether this resource assignment has a scheduling conflict with another assignment or unavailability period. Triggers alerts for scheduling coordinators to resolve double-bookings.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment record was first created in the data platform. Audit timestamp for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling resource assignment record.',
    `credentialing_verification_datetime` TIMESTAMP COMMENT 'Date and time when credentialing verification was completed for this assignment. Documents compliance with pre-assignment credentialing checks.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the assigned resources credentials, licenses, and privileges have been verified as current and appropriate for this assignment. Critical for Joint Commission (TJC) compliance and risk management.',
    `duration_minutes` STRING COMMENT 'Planned or actual duration of the resource assignment in minutes. Calculated from start and end times or specified during scheduling for capacity planning.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling resource assignment record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling resource assignment record.',
    `equipment_asset_tag` STRING COMMENT 'Physical asset tag or serial number of the specific equipment unit assigned. Enables traceability for maintenance, sterilization, and recall management.',
    `equipment_reservation_status` STRING COMMENT 'Current status of equipment reservation for this assignment. Tracks equipment lifecycle from initial reservation through active use and return to inventory.. Valid values are `reserved|allocated|in_use|returned|unavailable`',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the assigned equipment. Supports compliance with manufacturer and regulatory maintenance schedules.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment record was most recently updated. Audit timestamp for tracking changes to assignment details, status, or metadata.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling resource assignment record.',
    `maintenance_clearance_flag` BOOLEAN COMMENT 'Boolean indicator of whether assigned equipment has passed required maintenance checks and is cleared for clinical use. Ensures equipment safety and regulatory compliance.',
    `no_show_flag` BOOLEAN COMMENT 'Boolean indicator of whether the assigned resource failed to appear for their scheduled assignment. Used for provider and staff attendance tracking and performance management.',
    `notes` STRING COMMENT 'The notes of the scheduling resource assignment record.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is the primary resource assignment for the appointment or case. Distinguishes the lead provider or primary room from supporting resources.',
    `privilege_code` STRING COMMENT 'Code representing the specific clinical privilege or authorization required and verified for this assignment. Links to the providers credentialed privileges for the procedure or service type.',
    `requested_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment was initially requested or created. Supports lead time analysis and scheduling workflow tracking.',
    `resource_type` STRING COMMENT 'Category of resource being assigned. Distinguishes between human resources (providers, staff, care team members) and physical resources (rooms, equipment).. Valid values are `provider|room|equipment|staff|care_team_member|anesthesia_resource`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment is scheduled to conclude. Used for capacity planning and resource turnover scheduling.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment begins. Represents when the provider, room, or equipment is scheduled to be engaged for this appointment or procedure.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this resource assignment in the source system. Enables traceability back to the originating Electronic Health Record (EHR) or scheduling system.',
    `resource_assignment_status` STRING COMMENT 'The resource assignment status value classifying the scheduling resource assignment record.',
    `sterilization_batch_number` STRING COMMENT 'Batch or lot number from the sterilization process for assigned equipment. Enables traceability in case of sterilization failures or Healthcare-Associated Infection (HAI) investigations.',
    `sterilization_clearance_flag` BOOLEAN COMMENT 'Boolean indicator of whether assigned equipment has passed sterilization and is cleared for use. Critical for infection control and patient safety in surgical and procedural settings.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_resource_assignment PRIMARY KEY(`resource_assignment_id`)
) COMMENT 'Resource assignments';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` (
    `waitlist_entry_id` BIGINT COMMENT 'Unique identifier for the waitlist entry record. Primary key.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Waitlist entries for care coordination visits are linked to active care plans requiring multidisciplinary follow-up. Critical for transitions of care management, readmission prevention, and complex ca',
    `care_site_id` BIGINT COMMENT 'Identifier for the care site or facility requested by the patient. Null if no specific facility preference. Links to facility master data.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Waitlist entries for authorization-required services track authorization status to prioritize patients with approved authorizations for scheduling. Care coordinators proactively obtain authorizations ',
    `employee_id` BIGINT COMMENT 'Identifier for the individual scheduler user assigned to work this entry. Null if not yet assigned to a specific person. Links to user master data.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Waitlist entries track plan-specific network restrictions, authorization requirements, and benefit limitations to match patients with appropriate appointment slots and providers when capacity becomes ',
    `insurance_coverage_id` BIGINT COMMENT 'Identifier for the patient insurance coverage to be used for the appointment. Links to insurance coverage master data.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient on the waitlist. Links to the patient master record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Waitlist management prioritizes patients based on payer authorization status and coverage verification. Schedulers check payer requirements before offering appointments from waitlist to ensure authori',
    `population_health_gap_id` BIGINT COMMENT 'Foreign key linking to quality.population_health_gap. Business justification: Waitlist management for care gaps is a real workflow—patients with identified HEDIS/Stars gaps are placed on waitlists for appropriate appointments. Care management teams prioritize waitlist outreach ',
    `clinician_id` BIGINT COMMENT 'Identifier for the specific provider requested by the patient or referring provider. Null if no specific provider preference. Links to provider master data.',
    `org_unit_id` BIGINT COMMENT 'Identifier for the specific department or clinic requested by the patient. Null if no specific department preference. Links to department master data.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Waitlist entries for specialty care are driven by specific clinical problems requiring intervention. Essential for specialty access tracking, care gap management, and prioritization of patients with h',
    `referral_order_id` BIGINT COMMENT 'Identifier for the clinical order that triggered this waitlist entry, if applicable. Null for non-order-based entries. Links to clinical order master data.',
    `appointment_type_id` BIGINT COMMENT 'Identifier for the type of appointment requested by the patient or ordering provider. Links to appointment type master data.',
    `scheduling_appointment_id` BIGINT COMMENT 'Identifier for the appointment that was successfully scheduled from this waitlist entry. Null if not yet scheduled. Links to scheduling appointment master data.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research subjects waitlisted for protocol-required procedures (imaging, surgery, specialty consults) must be tracked to enrollment records. Study coordinators manage waitlists for study-specific servi',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Waitlist visit reason ICD codes enable clinical prioritization, authorization requirement determination, specialty matching, and quality measure tracking. Critical for access management and care gap c',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before scheduling the appointment. True if authorization must be obtained.',
    `care_setting` STRING COMMENT 'Type of care setting required for the appointment: outpatient clinic, inpatient admission, emergency department, ambulatory surgery center, telehealth virtual visit, home health visit.. Valid values are `outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health`',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was first created in the system. Audit timestamp for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling waitlist entry record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling waitlist entry record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling waitlist entry record.',
    `entry_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the waitlist entry, used for patient communication and scheduling team reference.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the waitlist entry: active (awaiting action), offered (appointment offered to patient), accepted (patient accepted offer), expired (entry aged out or SLA missed), removed (manually removed from queue), pending (awaiting information or approval), in_progress (actively being worked by scheduling team), scheduled (appointment successfully scheduled), escalated (escalated due to aging or priority), closed (completed or resolved). [ENUM-REF-CANDIDATE: active|offered|accepted|expired|removed|pending|in_progress|scheduled|escalated|closed — 10 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Classification of the waitlist entry indicating the source or nature of the scheduling request: waitlist (patient-initiated or provider-requested appointment waitlist), referral_queue (unscheduled referral awaiting scheduling), order_based (pending order requiring appointment), recall (recall-driven request for follow-up), surgical_request (surgical scheduling request), work_queue (general scheduling department work item).. Valid values are `waitlist|referral_queue|order_based|recall|surgical_request|work_queue`',
    `escalation_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was escalated. Null if never escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this waitlist entry has been escalated due to aging, priority, or SLA breach. True if escalated for management attention.',
    `escalation_reason` STRING COMMENT 'Free-text or coded reason for escalation (e.g., SLA breach, high clinical priority, patient complaint, aging threshold exceeded).',
    `estimated_wait_time_days` STRING COMMENT 'Estimated number of days the patient will wait from queue entry to scheduled appointment, based on current capacity and demand forecasting.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter is required for the appointment. True if interpreter services must be arranged.',
    `language_preference` STRING COMMENT 'Patient preferred language for communication and care delivery. ISO 639-2 three-letter language code (e.g., eng for English, spa for Spanish).',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was last updated. Audit timestamp for record modification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling waitlist entry record.',
    `last_outreach_datetime` TIMESTAMP COMMENT 'Date and time of the most recent outreach attempt to the patient. Null if no outreach has been attempted.',
    `last_outreach_method` STRING COMMENT 'Method used for the most recent outreach attempt: phone call, email, SMS text, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `notes` STRING COMMENT 'Free-text notes and comments from scheduling staff regarding patient preferences, special requirements, barriers to scheduling, or other relevant information.',
    `outreach_attempt_count` STRING COMMENT 'Number of times the scheduling team has attempted to contact the patient to schedule the appointment. Used for tracking patient engagement and no-contact protocols.',
    `preferred_contact_channel` STRING COMMENT 'Patient preferred method of contact for scheduling outreach and appointment notifications: phone, email, SMS text message, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `preferred_days_of_week` STRING COMMENT 'Patient preference for days of the week for scheduling (e.g., Monday, Wednesday, Friday). Stored as comma-separated list or coded representation.',
    `preferred_time_of_day` STRING COMMENT 'Patient preference for time of day for scheduling: morning (before noon), afternoon (noon to 5pm), evening (after 5pm), any (no preference).. Valid values are `morning|afternoon|evening|any`',
    `priority_level` STRING COMMENT 'Clinical or operational priority assigned to the waitlist entry, determining urgency of scheduling action. Values align with clinical acuity and access standards. [ENUM-REF-CANDIDATE: routine|urgent|emergent|stat|high|medium|low — 7 candidates stripped; promote to reference product]',
    `queue_entry_datetime` TIMESTAMP COMMENT 'Date and time when the patient was added to the waitlist or scheduling queue. Used for aging calculations and first-in-first-out queue management.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Waitlist entries track consent status for procedure readiness. Scheduling teams verify required consents obtained before converting waitlist to scheduled appointment. Prevents delays, ensures regulato',
    `removal_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was removed from the queue without scheduling (e.g., patient declined, no longer needed, duplicate entry). Null if not removed.',
    `removal_reason` STRING COMMENT 'Free-text or coded reason for removing the entry from the waitlist without scheduling (e.g., patient declined, no longer clinically indicated, duplicate entry, patient deceased, scheduled elsewhere).',
    `scheduled_datetime` TIMESTAMP COMMENT 'Date and time when the appointment was successfully scheduled and the waitlist entry was resolved. Null if not yet scheduled.',
    `sla_target_datetime` TIMESTAMP COMMENT 'Target date and time by which the scheduling action should be completed per organizational or regulatory service level agreement. Used for compliance monitoring and escalation triggers.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this waitlist entry in the source system. Used for data lineage and reconciliation.',
    `specialty_required` STRING COMMENT 'Clinical specialty required for the appointment (e.g., Cardiology, Orthopedics, Primary Care). Used for routing to appropriate scheduling queues.',
    `waitlist_entry_status` STRING COMMENT 'The waitlist entry status value classifying the scheduling waitlist entry record.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible and willing to receive care via telehealth modality for this appointment request. True if telehealth is an acceptable option.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. True if transportation support is needed.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_reason` STRING COMMENT 'Free-text description of the clinical reason or chief complaint for the requested appointment.',
    `visit_reason_code` STRING COMMENT 'Coded representation of the visit reason using standard clinical terminology (e.g., SNOMED CT, ICD-10).',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Waitlist entries';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` (
    `appointment_status_history_id` BIGINT COMMENT 'Unique identifier for each appointment status transition record in the audit log. Primary key for the appointment status history table.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling appointment status history record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who triggered this status transition. May be a staff member, system user, or patient portal user. Used for accountability and audit trail.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key reference to the appointment that underwent this status transition. Links this status history record to the parent appointment in the scheduling_appointment table.',
    `tertiary_rescheduled_appointment_scheduling_appointment_id` BIGINT COMMENT 'Foreign key reference to the new appointment created when this appointment was rescheduled. Null if not rescheduled. Used to track rescheduling patterns and patient retention.',
    `advance_notice_hours` STRING COMMENT 'Number of hours between the cancellation timestamp and the originally scheduled appointment time. Used to determine if cancellation met policy requirements and to analyze cancellation lead time patterns.',
    `appointment_number` STRING COMMENT 'Business identifier for the appointment. Human-readable appointment confirmation number used for patient communication and operational reference.',
    `audit_required` BOOLEAN COMMENT 'Flag indicating whether this status transition requires additional audit review or documentation per compliance policy. True if audit required, False otherwise. Used for compliance monitoring.',
    `backfill_indicator` BOOLEAN COMMENT 'Flag indicating whether this no-show or cancellation slot was successfully backfilled with another patient. True if the slot was reused, False if it remained empty. Critical for revenue protection and capacity utilization analysis.',
    `comment` STRING COMMENT 'Free-text comment or note entered by staff regarding this status transition. Provides additional context not captured in structured fields. Used for operational review and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this status history record was first created in the data warehouse. Used for data lineage and audit trail. Distinct from transition_timestamp which is the business event time.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling appointment status history record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling appointment status history record.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of this status transition in USD. Positive for revenue-generating transitions, negative for lost revenue (no-shows, cancellations). Used for financial forecasting and no-show cost analysis.',
    `financial_impact_flag` BOOLEAN COMMENT 'Indicates whether this status transition has financial implications (e.g., no-show fee, late cancellation charge, lost revenue). True if financial impact exists, False otherwise. Used for revenue cycle reporting.',
    `hedis_measure_applicable` BOOLEAN COMMENT 'Indicates whether this appointment status transition impacts HEDIS access and availability measures. True if applicable to quality reporting, False otherwise. Used for NCQA quality measure compliance.',
    `hedis_measure_code` STRING COMMENT 'Specific HEDIS measure code that this status transition impacts (e.g., access measures, preventive care measures). Null if not applicable to HEDIS reporting.',
    `initiated_by_role` STRING COMMENT 'Role or job function of the user who triggered the transition (e.g., Scheduler, Nurse, Patient, System). Used for workflow analysis and training needs assessment.',
    `initiated_by_user_name` STRING COMMENT 'Name of the user who triggered this status transition. Human-readable identifier for operational review and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling appointment status history record.',
    `new_status` STRING COMMENT 'The appointment status after this transition. Captures the to-state in the status lifecycle. This is the current status as of this transition timestamp. [ENUM-REF-CANDIDATE: scheduled|confirmed|rescheduled|arrived|roomed|in_progress|completed|cancelled|no_show|pending|waitlisted — 11 candidates stripped; promote to reference product]',
    `no_show_penalty_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the no-show penalty or late cancellation fee charged to the patient. Null if no penalty was applied. Used for revenue tracking and policy effectiveness analysis.',
    `no_show_penalty_applied` BOOLEAN COMMENT 'Indicates whether a no-show penalty or fee was applied to the patient account as a result of this transition. True if penalty applied, False otherwise. Used for no-show policy enforcement tracking.',
    `notes` STRING COMMENT 'The notes of the scheduling appointment status history record.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when waitlist notifications were sent for this available slot. Null if no notifications were sent. Used to measure notification-to-booking conversion time.',
    `patient_contact_method` STRING COMMENT 'Method used to contact the patient regarding this status transition. Used for communication effectiveness analysis and patient preference tracking.. Valid values are `phone|email|sms|portal_message|mail|none`',
    `patient_contacted_flag` BOOLEAN COMMENT 'Indicates whether the patient was contacted regarding this status transition (e.g., confirmation call, cancellation notification, no-show follow-up). True if contact attempted, False otherwise.',
    `patient_response` STRING COMMENT 'Free-text capture of patient response or feedback regarding this status transition. Used for patient satisfaction analysis and service improvement.',
    `prior_status` STRING COMMENT 'The appointment status immediately before this transition occurred. Captures the from-state in the status lifecycle for audit trail and pattern analysis. [ENUM-REF-CANDIDATE: scheduled|confirmed|rescheduled|arrived|roomed|in_progress|completed|cancelled|no_show|pending|waitlisted — 11 candidates stripped; promote to reference product]',
    `quality_measure_impact` STRING COMMENT 'Classification of how this status transition impacts quality measures. Positive for completed visits, negative for no-shows affecting access measures, neutral for administrative changes.. Valid values are `positive|negative|neutral|not_applicable`',
    `reason_category` STRING COMMENT 'High-level classification of the transition reason. Groups granular reason codes into analytical categories for no-show and cancellation pattern tracking. [ENUM-REF-CANDIDATE: patient_request|provider_unavailable|facility_issue|insurance_issue|clinical_reason|administrative|weather|transportation|no_reason_given|other — 10 candidates stripped; promote to reference product]',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this status transition must be included in regulatory reporting (CMS, state health departments, accreditation bodies). True if reportable, False otherwise.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this status transition record in the source system. Used for data reconciliation and troubleshooting integration issues.',
    `appointment_status_history_status` STRING COMMENT 'The appointment status history status value classifying the scheduling appointment status history record.',
    `system_generated` BOOLEAN COMMENT 'Indicates whether this status transition was automatically generated by the system (e.g., auto no-show after appointment time) versus manually entered by staff. True if system-generated, False if manual.',
    `transition_reason_code` STRING COMMENT 'Coded reason for the status transition. Includes cancellation reason codes, no-show reason codes, and other transition justifications. Used for root cause analysis and no-show reduction programs.',
    `transition_reason_description` STRING COMMENT 'Free-text description or additional detail about why the status transition occurred. Supplements the reason code with context provided by staff or patient.',
    `transition_source` STRING COMMENT 'The system or channel through which the status transition was initiated. Distinguishes manual staff actions from automated system transitions and patient self-service actions. [ENUM-REF-CANDIDATE: manual|automated|patient_portal|ivr|mobile_app|kiosk|interface|batch_process — 8 candidates stripped; promote to reference product]',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time when this status transition occurred. Primary business event timestamp for this audit record. Used for no-show detection, cancellation pattern analysis, and operational throughput measurement.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waitlist_notification_sent` BOOLEAN COMMENT 'Indicates whether waitlisted patients were notified of this newly available slot following a cancellation or no-show. True if notification sent, False otherwise. Used for waitlist management effectiveness tracking.',
    `within_policy_window` BOOLEAN COMMENT 'Indicates whether the cancellation or status change occurred within the required advance notice window per organizational policy. True if within policy, False if late. Used for policy compliance reporting.',
    CONSTRAINT pk_appointment_status_history PRIMARY KEY(`appointment_status_history_id`)
) COMMENT 'Appointment status history';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` (
    `appointment_reminder_id` BIGINT COMMENT 'Unique identifier for the appointment reminder record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling appointment reminder record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reminder campaigns incur costs (platform fees, staff time) tracked by cost center. cost_per_reminder field signals financial tracking need. Supports patient engagement program cost management and no-s',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Appointment reminders include diagnosis-specific preparation instructions (fasting for diabetes, bowel prep for colonoscopy). Improves visit preparedness, reduces cancellations, and enhances patient e',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Appointment reminders sent via Direct Secure Messaging for care coordination (e.g., notifying PCPs of specialist appointments). CMS interoperability rules and ACO care coordination workflows require t',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient who received this reminder. Links to the patient demographics product.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Appointment reminders include payer-specific instructions such as bringing insurance card, verifying eligibility, or completing pre-authorization. Reminder templates and content vary by payer requirem',
    `reminder_template_id` BIGINT COMMENT 'Identifier for the message template used to generate the reminder content. References the template library in the source system.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key reference to the appointment for which this reminder was sent. Links to the scheduling_appointment product.',
    `actual_send_datetime` TIMESTAMP COMMENT 'The actual date and time when the reminder was sent by the messaging system. May differ from scheduled send time due to system delays or batch processing.',
    `appointment_date` DATE COMMENT 'The date of the appointment for which this reminder was sent. Denormalized from the scheduling_appointment product for reporting convenience.',
    `appointment_time` TIMESTAMP COMMENT 'The scheduled start time of the appointment for which this reminder was sent. Denormalized from the scheduling_appointment product for reporting convenience.',
    `attempt_number` STRING COMMENT 'The sequential attempt number for this reminder (e.g., 1 for first attempt, 2 for second attempt). Supports tracking of retry logic and escalation workflows.',
    `campaign_code` STRING COMMENT 'Identifier for the reminder campaign or program under which this reminder was sent (e.g., no-show reduction initiative, seasonal flu shot reminders). Supports program-level analytics.',
    `cost_per_reminder` DECIMAL(18,2) COMMENT 'The cost incurred for sending this reminder through the selected delivery channel (e.g., SMS carrier fees, IVR system costs). Supports cost analysis and Return on Investment (ROI) calculation for reminder programs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reminder record was first created in the source system. Supports audit trail and data lineage tracking.',
    `delivery_channel` STRING COMMENT 'The communication channel through which the reminder was sent (e.g., phone call, SMS text message, email, patient portal message, Interactive Voice Response (IVR), mobile app push notification).. Valid values are `phone|sms|email|patient_portal|ivr|push_notification`',
    `delivery_failure_reason` STRING COMMENT 'Detailed reason for delivery failure if the reminder was not successfully delivered (e.g., invalid phone number, email bounce, patient portal not activated, carrier rejection).',
    `delivery_status` STRING COMMENT 'The delivery status of the reminder message (e.g., sent, delivered, failed, bounced, undeliverable, pending, cancelled). Indicates whether the message successfully reached the patient. [ENUM-REF-CANDIDATE: sent|delivered|failed|bounced|undeliverable|pending|cancelled — 7 candidates stripped; promote to reference product]',
    `department_name` STRING COMMENT 'The name of the department where the appointment is scheduled. Denormalized for patient communication and reporting purposes.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling appointment reminder record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling appointment reminder record.',
    `facility_name` STRING COMMENT 'The name of the facility where the appointment is scheduled. Denormalized for patient communication and reporting purposes.',
    `language_code` STRING COMMENT 'The two-letter ISO 639-1 language code for the language in which the reminder was sent (e.g., en for English, es for Spanish). Supports multilingual patient communication.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reminder record was last modified in the source system. Supports change tracking and audit trail requirements.',
    `lead_time_days` STRING COMMENT 'The number of days before the appointment that this reminder was scheduled to be sent. Supports analysis of optimal reminder timing for no-show reduction.',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of reminder attempts configured for this appointment type or reminder workflow. Used to determine when to stop retry attempts.',
    `message_content` STRING COMMENT 'The full text content of the reminder message sent to the patient. May contain appointment details and instructions. Stored for audit and quality review purposes.',
    `mrn` STRING COMMENT 'The patients medical record number. Protected Health Information (PHI) under HIPAA.',
    `notes` STRING COMMENT 'The notes of the scheduling appointment reminder record.',
    `opt_out_datetime` TIMESTAMP COMMENT 'The date and time when the patient opted out of automated reminders, if applicable. Null if patient has not opted out.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted out of receiving automated reminders. True if patient has opted out, False otherwise. Supports patient communication preferences and regulatory compliance.',
    `patient_response` STRING COMMENT 'The patients response to the reminder, if any (e.g., confirmed attendance, cancelled appointment, requested reschedule, no response received, opted out of reminders).. Valid values are `confirmed|cancelled|rescheduled|no_response|opted_out`',
    `provider_name` STRING COMMENT 'The name of the provider for the appointment. Denormalized for patient communication and reporting purposes.',
    `recipient_email_address` STRING COMMENT 'The email address to which the reminder was sent, if delivery channel was email. Protected Health Information (PHI) under HIPAA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone_number` STRING COMMENT 'The phone number to which the reminder was sent, if delivery channel was phone or SMS. Protected Health Information (PHI) under HIPAA.',
    `reminder_type` STRING COMMENT 'The type or sequence of the reminder in the automated reminder workflow (e.g., initial, first reminder, second reminder, final reminder, confirmation request, pre-visit instructions).. Valid values are `initial|first_reminder|second_reminder|final_reminder|confirmation_request|pre_visit`',
    `response_channel` STRING COMMENT 'The channel through which the patient responded to the reminder (e.g., phone call, SMS reply, email reply, patient portal, IVR system, mobile app).. Valid values are `phone|sms|email|patient_portal|ivr|mobile_app`',
    `response_datetime` TIMESTAMP COMMENT 'The date and time when the patient responded to the reminder, if applicable. Null if no response was received.',
    `scheduled_send_datetime` TIMESTAMP COMMENT 'The date and time when the reminder was scheduled to be sent, based on the reminder lead time configuration and appointment date.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this reminder record in the source system. Supports data reconciliation and traceability back to the operational system.',
    `appointment_reminder_status` STRING COMMENT 'The appointment reminder status value classifying the scheduling appointment reminder record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_appointment_reminder PRIMARY KEY(`appointment_reminder_id`)
) COMMENT 'Appointment reminders';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` (
    `capacity_utilization_id` BIGINT COMMENT 'Primary key for capacity_utilization',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Capacity plans drive volume-based budget assumptions (target_visit_volume, target_case_volume). Linking enables budget-to-actual volume variance analysis, reforecasting, and operational budget managem',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where capacity is planned or measured.',
    `or_block_id` BIGINT COMMENT 'Reference to the OR block for which utilization is measured. Populated only when plan_type is or_block_utilization.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this capacity utilization record.',
    `schedulable_resource_id` BIGINT COMMENT 'Reference to the schedulable resource (provider, room, equipment) for which capacity is planned or measured.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or service line for which capacity is planned or measured.',
    `access_days` STRING COMMENT 'Average number of days from appointment request to scheduled appointment date, measuring patient access timeliness.',
    `actual_case_volume` STRING COMMENT 'Actual number of surgical or procedural cases performed during the period.',
    `actual_utilization_rate_pct` DECIMAL(18,2) COMMENT 'Actual utilization rate achieved as a percentage of available capacity.',
    `actual_visit_volume` STRING COMMENT 'Actual number of patient visits or appointments completed during the period.',
    `add_on_case_count` STRING COMMENT 'Number of add-on surgical cases scheduled outside of allocated block time during the period.',
    `available_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent staff or provider capacity available during the planning period.',
    `available_hours` DECIMAL(18,2) COMMENT 'Total hours available for scheduling during the planning period (provider time, room time, or equipment time).',
    `available_minutes` STRING COMMENT 'Total minutes available for scheduling during the planning period, used primarily for OR block time tracking.',
    `cancellation_count` STRING COMMENT 'Number of cancelled appointments or cases during the period.',
    `care_setting` STRING COMMENT 'Care setting context for the capacity plan: outpatient clinic, inpatient unit, emergency department, surgical suite, procedural area, or telehealth.. Valid values are `outpatient|inpatient|emergency|surgical|procedural|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity utilization record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling capacity utilization record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling capacity utilization record.',
    `first_case_on_time_start_flag` BOOLEAN COMMENT 'Indicates whether the first case of the day started on time. True if on time, False if delayed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity utilization record was last updated.',
    `no_show_count` STRING COMMENT 'Number of patient no-shows during the period, impacting actual utilization.',
    `notes` STRING COMMENT 'Free-text notes or comments about the capacity plan, utilization performance, or variance analysis.',
    `overbooking_count` STRING COMMENT 'Number of instances where capacity was overbooked beyond available slots or time.',
    `plan_status` STRING COMMENT 'Current status of the capacity plan: draft (in development), approved (ready for execution), active (currently in effect), completed (period ended), or cancelled.. Valid values are `draft|approved|active|completed|cancelled`',
    `plan_type` STRING COMMENT 'Type of capacity record: capacity planning for future periods, OR block utilization for surgical blocks, resource utilization for general scheduling resources, or variance analysis comparing planned vs actual.. Valid values are `capacity_planning|or_block_utilization|resource_utilization|variance_analysis`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning or measurement period for this capacity record.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning or measurement period for this capacity record.',
    `provider_npi` STRING COMMENT 'National Provider Identifier of the provider for whom capacity is planned or measured.. Valid values are `^[0-9]{10}$`',
    `reallocation_recommendation` STRING COMMENT 'Recommendation for capacity reallocation based on variance analysis (e.g., increase block time, reduce slots, shift resources).',
    `released_minutes` STRING COMMENT 'Minutes of OR block time released back to the pool for reallocation due to underutilization or cancellations.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total hours scheduled with appointments or cases during the period.',
    `scheduled_minutes` STRING COMMENT 'Total minutes scheduled with cases or appointments during the period.',
    `specialty_code` STRING COMMENT 'Medical specialty code for which capacity is planned (e.g., cardiology, orthopedics, general surgery).',
    `capacity_utilization_status` STRING COMMENT 'The capacity utilization status value classifying the scheduling capacity utilization record.',
    `target_case_volume` STRING COMMENT 'Planned number of surgical or procedural cases for the planning period.',
    `target_utilization_rate_pct` DECIMAL(18,2) COMMENT 'Target utilization rate as a percentage of available capacity (e.g., 85.00 represents 85% target utilization).',
    `target_visit_volume` STRING COMMENT 'Planned number of patient visits or appointments for the planning period.',
    `trend_indicator` STRING COMMENT 'Directional trend of utilization over time: increasing demand, decreasing demand, stable, or volatile patterns.. Valid values are `increasing|decreasing|stable|volatile`',
    `turnover_time_minutes` STRING COMMENT 'Average time in minutes between cases for room cleaning, setup, and preparation.',
    `utilized_hours` DECIMAL(18,2) COMMENT 'Actual hours used for patient care activities during the period.',
    `utilized_minutes` STRING COMMENT 'Actual minutes used for patient care activities during the period.',
    `variance_hours` DECIMAL(18,2) COMMENT 'Difference between actual and planned hours (actual minus planned).',
    `variance_utilization_pct` DECIMAL(18,2) COMMENT 'Difference between actual and target utilization rate as a percentage.',
    `variance_volume` STRING COMMENT 'Difference between actual and planned visit or case volume (actual minus planned).',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waitlist_volume` STRING COMMENT 'Number of patients on the waitlist for this resource or service during the period.',
    CONSTRAINT pk_capacity_utilization PRIMARY KEY(`capacity_utilization_id`)
) COMMENT 'Capacity utilization metrics';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` (
    `block_utilization_id` BIGINT COMMENT 'Unique identifier for the operating room block utilization record.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the OR block utilization occurred.',
    `clinician_id` BIGINT COMMENT 'Reference to the surgeon who owns the block, if block_owner_type is surgeon.',
    `employee_id` BIGINT COMMENT 'Reference to the user who released the unused block time.',
    `or_block_id` BIGINT COMMENT 'Reference to the allocated OR block schedule being measured for utilization.',
    `or_suite_id` BIGINT COMMENT 'Reference to the specific operating room suite where the block was utilized.',
    `service_id` BIGINT COMMENT 'Reference to the service line that owns the block, if block_owner_type is service.',
    `add_on_case_count` STRING COMMENT 'Total number of add-on cases (not originally scheduled in the block) that were performed during the block time.',
    `allocated_minutes` STRING COMMENT 'Total number of minutes allocated for the OR block on this date.',
    `average_turnover_minutes` DECIMAL(18,2) COMMENT 'Average turnover time between cases within this block, calculated as total turnover minutes divided by number of turnovers.',
    `block_overrun_minutes` STRING COMMENT 'Number of minutes the block ran beyond its allocated end time due to case overruns or delays.',
    `block_owner_type` STRING COMMENT 'The type of entity that owns or is allocated the OR block (surgeon, service line, department, specialty, shared pool, or unassigned).. Valid values are `surgeon|service|department|specialty|shared|unassigned`',
    `block_reallocation_risk_flag` BOOLEAN COMMENT 'Indicates whether this block is at risk for reallocation due to consistently low utilization (True) or not (False).',
    `block_status` STRING COMMENT 'Overall status of the block utilization for this date (utilized, partially utilized, unutilized, released to pool, or cancelled).. Valid values are `utilized|partially_utilized|unutilized|released|cancelled`',
    `cancelled_case_count` STRING COMMENT 'Total number of scheduled cases that were cancelled within the block time.',
    `completed_case_count` STRING COMMENT 'Total number of surgical cases that were completed during the block time.',
    `cost_center_code` STRING COMMENT 'The cost center code to which OR block time and associated costs are allocated for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the block utilization record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling block utilization record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling block utilization record.',
    `first_case_delay_minutes` STRING COMMENT 'Number of minutes the first case was delayed beyond the scheduled start time. Zero if started on time.',
    `first_case_on_time_start_flag` BOOLEAN COMMENT 'Indicates whether the first case of the day in this block started on time (True) or was delayed (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the block utilization record was last updated or modified.',
    `meets_utilization_threshold_flag` BOOLEAN COMMENT 'Indicates whether the block utilization met or exceeded the minimum utilization threshold required to retain the block allocation (True) or fell below threshold (False).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the block utilization, including reasons for low utilization, special circumstances, or operational issues.',
    `owner_specialty_code` STRING COMMENT 'The medical specialty code of the block owner (e.g., orthopedics, cardiology, general surgery).',
    `prime_time_flag` BOOLEAN COMMENT 'Indicates whether this block occurred during prime OR time (typically weekday daytime hours, True) or non-prime time (False).',
    `procedure_minutes` STRING COMMENT 'Total number of minutes spent on actual surgical procedures (wheels in to wheels out), excluding turnover time.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when unused block time was released back to the pool for reallocation.',
    `released_minutes` STRING COMMENT 'Number of minutes from the allocated block that were released back to the pool for use by other services or add-on cases.',
    `scheduled_case_count` STRING COMMENT 'Total number of surgical cases scheduled within the block time.',
    `scheduled_minutes` STRING COMMENT 'Total number of minutes scheduled for surgical cases within the block time.',
    `block_utilization_status` STRING COMMENT 'The block utilization status value classifying the scheduling block utilization record.',
    `target_utilization_percentage` DECIMAL(18,2) COMMENT 'The target utilization percentage threshold defined for this block owner or service line.',
    `turnover_minutes` STRING COMMENT 'Total number of minutes spent on room turnover between cases (wheels out to wheels in for next case).',
    `unutilized_minutes` STRING COMMENT 'Number of allocated minutes that were neither used nor released, representing idle OR time.',
    `used_minutes` STRING COMMENT 'Total number of minutes actually used for surgical procedures, including procedure time and turnover time.',
    `utilization_date` DATE COMMENT 'The calendar date on which the OR block utilization was measured.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of allocated block time that was actually used, calculated as (used_minutes / allocated_minutes) * 100.',
    `utilization_variance_percentage` DECIMAL(18,2) COMMENT 'Variance between actual utilization percentage and target utilization percentage (actual minus target).',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_block_utilization PRIMARY KEY(`block_utilization_id`)
) COMMENT 'Block utilization metrics';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` (
    `booking_rule_id` BIGINT COMMENT 'Primary key for booking_rule',
    `care_site_id` BIGINT COMMENT 'Reference to the specific facility or care site to which this rule applies. Null indicates the rule applies enterprise-wide across all facilities.',
    `clinician_id` BIGINT COMMENT 'Reference to the specific provider to whom this rule applies. Null indicates the rule applies to all providers or is provider-agnostic.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Booking rules implement compliance policies including authorization requirements, age restrictions, insurance eligibility, and referral mandates. Policy enforcement mechanism in scheduling systems.',
    `appointment_type_id` BIGINT COMMENT 'Reference to the specific appointment type to which this rule applies. Null indicates the rule applies to all appointment types.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this scheduling rule for activation. Null for draft or unapproved rules. Supports governance and accountability.',
    `superseded_rule_booking_rule_id` BIGINT COMMENT 'Reference to the previous version of this rule that was replaced. Null for initial rule versions. Maintains lineage for rule versioning and audit trail.',
    `org_unit_id` BIGINT COMMENT 'Reference to the specific department to which this rule applies. Null indicates the rule applies across all departments.',
    `applies_to_surgical_cases` BOOLEAN COMMENT 'Indicates whether this rule applies to surgical case scheduling in Epic OpTime. True enforces the rule for Operating Room (OR) scheduling, false exempts surgical cases.',
    `applies_to_telehealth` BOOLEAN COMMENT 'Indicates whether this rule applies to telehealth virtual appointments. True enforces the rule for telehealth visits, false exempts telehealth from this rule.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this scheduling rule was approved for activation. Null for draft or unapproved rules. Supports audit trail and compliance reporting.',
    `business_justification` STRING COMMENT 'Rationale for implementing this scheduling rule, including clinical, operational, financial, or regulatory drivers. Used for governance and audit purposes.',
    `care_setting` STRING COMMENT 'Type of care environment to which this rule applies. Null indicates the rule applies across all care settings.. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `conflict_rule_type` STRING COMMENT 'Type of scheduling conflict this rule prevents. Same day block prevents multiple appointments on the same day, same week block prevents appointments in the same week, concurrent block prevents overlapping appointments, sequential required enforces appointment ordering.. Valid values are `same_day_block|same_week_block|concurrent_block|sequential_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scheduling rule record was first created in the system. Supports audit trail and data lineage tracking.',
    `double_booking_allowed` BOOLEAN COMMENT 'Indicates whether multiple appointments can be scheduled in the same time slot for the same provider or resource. True permits double booking, false enforces single appointment per slot.',
    `effective_end_date` DATE COMMENT 'Date when the scheduling rule expires and ceases enforcement. Null indicates an open-ended rule with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date when the scheduling rule becomes active and begins enforcement in scheduling systems. Supports versioning and temporal validity of rule changes.',
    `enforcement_mode` STRING COMMENT 'Defines how strictly the rule is enforced in scheduling systems. Hard block prevents scheduling, soft warning allows override with acknowledgment, advisory provides guidance without enforcement.. Valid values are `hard_block|soft_warning|advisory`',
    `gender_restriction` STRING COMMENT 'Gender requirement for patients scheduling under this rule. Used for gender-specific procedures and services. Any indicates no gender restriction.. Valid values are `male|female|any`',
    `insurance_type_required` STRING COMMENT 'Specific insurance plan type or payer category required for scheduling under this rule. Null indicates no insurance restriction. Used to enforce payer-specific access rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this scheduling rule record was most recently updated. Supports change tracking and audit trail requirements.',
    `maximum_lead_time_days` STRING COMMENT 'Maximum number of days in advance that an appointment can be scheduled. Used to control booking horizon and prevent excessive future scheduling.',
    `maximum_patient_age_years` STRING COMMENT 'Maximum patient age in years permitted to schedule under this rule. Used to enforce age-appropriate care restrictions. Null indicates no maximum age limit.',
    `minimum_lead_time_days` STRING COMMENT 'Minimum number of days in advance that an appointment must be scheduled. Used to enforce advance booking requirements for procedures requiring preparation or authorization.',
    `minimum_patient_age_years` STRING COMMENT 'Minimum patient age in years required to schedule under this rule. Used to enforce age-appropriate care restrictions. Null indicates no minimum age requirement.',
    `notes` STRING COMMENT 'The notes of the scheduling booking rule record.',
    `overbooking_limit` STRING COMMENT 'Maximum number of appointments that can be scheduled beyond standard capacity for a given time slot. Used to manage no-show risk and optimize throughput. Null indicates no overbooking permitted.',
    `override_authority_level` STRING COMMENT 'Minimum user role or authority level required to override this rule during scheduling. Defines escalation hierarchy for exception handling.. Valid values are `staff|supervisor|physician|administrator|system`',
    `patient_class` STRING COMMENT 'Classification of patient visit type to which this rule applies. Null indicates the rule applies to all patient classes.. Valid values are `new|established|follow_up|consultation|referral`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this rule is mandated by external regulatory or accreditation requirements. True identifies rules that cannot be waived without compliance risk.',
    `required_pre_visit_orders` STRING COMMENT 'Comma-separated list of order types or procedure codes that must be completed before the appointment. Used to enforce prerequisite testing or preparation requirements.',
    `requires_prior_authorization` BOOLEAN COMMENT 'Indicates whether insurance prior authorization must be obtained before scheduling. True enforces authorization validation, false permits scheduling without authorization.',
    `requires_referral` BOOLEAN COMMENT 'Indicates whether a valid referral order is required before scheduling. True enforces referral validation, false permits direct scheduling.',
    `rule_category` STRING COMMENT 'Broad classification of the rule by business domain. Temporal rules govern timing, clinical rules enforce medical protocols, administrative rules manage workflow, financial rules ensure payment compliance, operational rules optimize resource use, and regulatory rules enforce compliance requirements.. Valid values are `temporal|clinical|administrative|financial|operational|regulatory`',
    `rule_code` STRING COMMENT 'Business-assigned unique code for the scheduling rule, used for reference in Epic Cadence and OpTime scheduling systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed business explanation of the scheduling rule, its purpose, and enforcement logic. Provides context for schedulers and system administrators.',
    `rule_name` STRING COMMENT 'Human-readable name of the scheduling rule for display and reporting purposes.',
    `rule_priority` STRING COMMENT 'Numeric priority ranking used to resolve conflicts when multiple rules apply to the same scheduling scenario. Lower numbers indicate higher priority. Rules with higher priority take precedence in enforcement.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the scheduling rule. Active rules are enforced in scheduling systems, inactive rules are retired, suspended rules are temporarily disabled, draft rules are under development, and pending approval rules await governance review.. Valid values are `active|inactive|suspended|draft|pending_approval`',
    `rule_type` STRING COMMENT 'Classification of the scheduling rule governing its purpose and enforcement logic. Lead time rules control advance booking windows, eligibility rules determine patient qualification, constraint rules enforce scheduling restrictions, prerequisite rules require prior conditions, conflict rules prevent incompatible bookings, and capacity rules manage overbooking limits.. Valid values are `lead_time|eligibility|constraint|prerequisite|conflict|capacity`',
    `same_day_booking_allowed` BOOLEAN COMMENT 'Indicates whether appointments can be scheduled on the same day as the request. True allows same-day scheduling, false requires advance booking per minimum lead time rules.',
    `self_scheduling_allowed` BOOLEAN COMMENT 'Indicates whether patients can book appointments directly through online portals without staff intervention. True permits patient self-service scheduling, false requires staff-assisted booking.',
    `specialty_code` STRING COMMENT 'Medical specialty to which this rule applies, using standard specialty taxonomy codes. Null indicates the rule is specialty-agnostic.',
    `booking_rule_status` STRING COMMENT 'The booking rule status value classifying the scheduling booking rule record.',
    `version_number` STRING COMMENT 'Sequential version number for this rule, incremented with each modification. Supports audit trail and change tracking for rule evolution.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_booking_rule PRIMARY KEY(`booking_rule_id`)
) COMMENT 'Booking rules';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` (
    `patient_preference_id` BIGINT COMMENT 'Unique identifier for the patient scheduling preference record. Primary key.',
    `care_site_id` BIGINT COMMENT 'The healthcare facility or care site the patient prefers for appointments. Supports location-based scheduling optimization.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom these scheduling preferences are recorded. Links to the patient master data.',
    `clinician_id` BIGINT COMMENT 'The provider the patient prefers to see for appointments. Used to prioritize provider matching in scheduling workflows.',
    `employee_id` BIGINT COMMENT 'The system user who last verified or updated the preference record. Supports audit trail and data stewardship.',
    `tertiary_patient_modified_by_user_employee_id` BIGINT COMMENT 'The system user who last modified this preference record. Supports audit trail and data stewardship.',
    `org_unit_id` BIGINT COMMENT 'The specific department within a facility that the patient prefers. Enables granular location matching in scheduling.',
    `accessibility_needs` STRING COMMENT 'Free-text description of any accessibility accommodations the patient requires (e.g., wheelchair access, hearing assistance, visual aids). Used to ensure appropriate facility and resource assignment.',
    `advance_notice_days` STRING COMMENT 'The minimum number of days advance notice the patient requires for appointment scheduling. Supports patient access planning and reduces no-shows.',
    `care_setting_preference` STRING COMMENT 'The patients preferred care setting for appointments. Supports care delivery model matching in scheduling.. Valid values are `outpatient|ambulatory|home|any`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this preference record was first created in the system. Supports audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'The date on which this preference record expires or is superseded. Null indicates an open-ended preference.',
    `effective_start_date` DATE COMMENT 'The date from which this preference record becomes active and is applied in scheduling workflows.',
    `gender_preference_provider` STRING COMMENT 'The patients preference for provider gender. Supports patient-centered care and cultural sensitivity in scheduling.. Valid values are `male|female|no_preference`',
    `group_visit_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is willing to participate in group medical appointments. Supports population health and chronic disease management programs.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether the patient requires interpreter services for appointments. Triggers resource allocation for language support.',
    `language_preference` STRING COMMENT 'The patients preferred language for communication and care delivery. ISO 639-1 two-letter language code (e.g., en, es, zh). Used to match interpreter services and multilingual providers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this preference record was last updated. Supports change tracking and audit trail.',
    `last_verified_date` DATE COMMENT 'The date on which the patient last confirmed or updated their scheduling preferences. Supports preference data quality and staleness monitoring.',
    `mrn` STRING COMMENT 'The patients medical record number as assigned by the healthcare organization. Used for patient identification and preference tracking across scheduling systems.',
    `notes` STRING COMMENT 'The notes of the scheduling patient preference record.',
    `opt_out_reminders_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted out of receiving appointment reminders. Honors patient communication preferences and regulatory requirements.',
    `preference_notes` STRING COMMENT 'Free-text notes providing additional context or special instructions related to the patients scheduling preferences. Used by scheduling staff to accommodate unique patient needs.',
    `preference_source` STRING COMMENT 'The channel or system through which the preference was captured. Supports data lineage and preference quality assessment.. Valid values are `patient_portal|call_center|registration|provider_entry|system_default`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record. Determines whether the preference is actively applied in scheduling logic.. Valid values are `active|inactive|expired|superseded`',
    `preference_type` STRING COMMENT 'Category of scheduling preference being captured. Classifies the preference to enable targeted matching in scheduling workflows.. Valid values are `provider|location|time|communication|access|general`',
    `preferred_contact_channel` STRING COMMENT 'The patients preferred method for appointment reminders and scheduling communications. Drives outreach strategy in Epic MyChart and Salesforce Health Cloud.. Valid values are `phone|email|sms|portal|mail|none`',
    `preferred_days_of_week` STRING COMMENT 'Comma-separated list of preferred days for appointments (e.g., Monday, Wednesday, Friday). Used to filter available slots in scheduling workflows.',
    `preferred_time_of_day` STRING COMMENT 'The time of day the patient prefers for appointments. Supports time-based slot matching and patient access optimization.. Valid values are `morning|afternoon|evening|any`',
    `preferred_visit_modality` STRING COMMENT 'The patients preferred modality for care delivery. Supports patient-centered scheduling and access optimization.. Valid values are `in_person|telehealth|phone|any`',
    `reminder_lead_time_days` STRING COMMENT 'The number of days before an appointment that the patient prefers to receive reminders. Customizes reminder campaigns to patient preferences.',
    `same_day_appointment_preference` STRING COMMENT 'The patients preference for same-day appointment availability. Guides urgent care and walk-in scheduling strategies.. Valid values are `preferred|acceptable|not_preferred`',
    `scheduling_priority_level` STRING COMMENT 'The priority level assigned to this patient for scheduling purposes. May reflect clinical urgency, care program enrollment, or VIP status.. Valid values are `routine|urgent|expedited|standard`',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this preference record in the source system. Enables traceability and reconciliation with upstream systems.',
    `specialty_preference` STRING COMMENT 'The medical specialty the patient prefers for care (e.g., cardiology, orthopedics). Used for specialty-specific scheduling workflows.',
    `patient_preference_status` STRING COMMENT 'The patient preference status value classifying the scheduling patient preference record.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is willing and able to participate in telehealth appointments. Used to offer virtual visit options in scheduling workflows.',
    `telehealth_preference` STRING COMMENT 'The patients preference level for telehealth versus in-person visits. Guides visit modality selection in scheduling.. Valid values are `preferred|acceptable|not_preferred|not_available`',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend appointments. Supports Social Determinants of Health (SDOH) interventions and access planning.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_patient_preference PRIMARY KEY(`patient_preference_id`)
) COMMENT 'Patient scheduling preferences';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` (
    `telehealth_session_id` BIGINT COMMENT 'Primary key for telehealth_session',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the scheduling telehealth session record.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider conducting the telehealth session.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient participating in the telehealth session.',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the parent appointment record in the scheduling system. Links this telehealth session to the broader appointment context.',
    `telehealth_authorization_id` BIGINT COMMENT 'Foreign key linking to provider.telehealth_authorization. Business justification: Cross-state telehealth sessions require state-specific authorizations per interstate compact rules and originating/distant site regulations. Links session to authorization covering the patients state',
    `telehealth_consent_id` BIGINT COMMENT 'Foreign key linking to consent.telehealth_consent. Business justification: Telehealth sessions require platform-specific consent per state regulations and interstate licensure compacts. Providers verify telehealth consent before session start. Required for CMS telehealth bil',
    `visit_id` BIGINT COMMENT 'Reference to the clinical visit or encounter associated with this telehealth session.',
    `actual_duration_minutes` STRING COMMENT 'Actual duration of the telehealth session in minutes, calculated from start to end time.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the telehealth session ended, as recorded by the platform or provider.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the telehealth session began, as recorded by the platform or provider.',
    `billing_eligible_flag` BOOLEAN COMMENT 'Indicates whether the telehealth session meets all requirements for billing and reimbursement. Based on completion status, duration, documentation, and payer rules.',
    `billing_modifier_code` STRING COMMENT 'CPT or HCPCS modifier code applied to the telehealth session for billing purposes (e.g., GT, 95, GQ). Indicates the service was delivered via telehealth.',
    `cancellation_datetime` TIMESTAMP COMMENT 'Date and time when the telehealth session was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancellation of the telehealth session. Used for operational analysis and patient access improvement.',
    `cancelled_by_role` STRING COMMENT 'Role of the person or system that initiated the cancellation of the telehealth session.. Valid values are `patient|provider|staff|system`',
    `connection_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall quality of the telehealth connection, typically on a scale of 0-100. Based on bandwidth, latency, and stability metrics.',
    `connection_status` STRING COMMENT 'Technical status of the network connection during the telehealth session. Used to track quality and troubleshoot issues.. Valid values are `connected|disconnected|poor_quality|reconnected|failed`',
    `consent_datetime` TIMESTAMP COMMENT 'Date and time when patient consent for telehealth services was obtained and documented.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent for telehealth services was obtained prior to or at the start of the session. Required for compliance and legal protection.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this telehealth session record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling telehealth session record.',
    `distant_site_code` STRING COMMENT 'Code identifying the location where the provider is physically located during the telehealth session. Required for certain telehealth billing scenarios.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling telehealth session record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling telehealth session record.',
    `interpreter_language` STRING COMMENT 'Language for which interpretation services were provided during the telehealth session, if applicable.',
    `interpreter_present_flag` BOOLEAN COMMENT 'Indicates whether an interpreter was actually present and participated in the telehealth session.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required for the telehealth session to facilitate communication between patient and provider.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this telehealth session record was most recently updated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling telehealth session record.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient failed to attend the scheduled telehealth session without prior cancellation.',
    `notes` STRING COMMENT 'The notes of the scheduling telehealth session record.',
    `originating_site_code` STRING COMMENT 'Code identifying the location where the patient is physically located during the telehealth session. Required for certain telehealth billing scenarios.',
    `patient_browser` STRING COMMENT 'Web browser used by the patient to access the telehealth session, if applicable. Used for technical support and compatibility tracking.',
    `patient_device_type` STRING COMMENT 'Type of device used by the patient to access the telehealth session. Helps identify technical support needs and access patterns.. Valid values are `desktop|laptop|tablet|smartphone|other`',
    `patient_operating_system` STRING COMMENT 'Operating system of the device used by the patient (e.g., iOS, Android, Windows, macOS). Used for troubleshooting and compatibility analysis.',
    `platform_name` STRING COMMENT 'Name of the telehealth platform or application used to conduct the session (e.g., Epic MyChart Video, Zoom for Healthcare, Doxy.me).',
    `platform_vendor` STRING COMMENT 'Vendor or manufacturer of the telehealth platform used for the session.',
    `provider_attestation_datetime` TIMESTAMP COMMENT 'Date and time when the provider attested to the completion of the telehealth session.',
    `provider_attestation_flag` BOOLEAN COMMENT 'Indicates whether the provider has attested to the completion and clinical validity of the telehealth session. Required for billing and compliance.',
    `provider_device_type` STRING COMMENT 'Type of device used by the provider to conduct the telehealth session.. Valid values are `desktop|laptop|tablet|smartphone|other`',
    `recording_enabled_flag` BOOLEAN COMMENT 'Indicates whether the telehealth session was recorded for clinical, educational, or quality purposes. Requires explicit patient consent.',
    `scheduled_duration_minutes` STRING COMMENT 'Planned duration of the telehealth session in minutes, based on appointment type and clinical requirements.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the telehealth session was scheduled to end.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the telehealth session was scheduled to begin.',
    `session_access_code` STRING COMMENT 'PIN or access code required to join the telehealth session. Used for additional security and patient verification.',
    `session_number` STRING COMMENT 'Human-readable business identifier for the telehealth session, used for tracking and reference purposes.',
    `session_status` STRING COMMENT 'Current lifecycle status of the telehealth session. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|no_show|technical_failure`',
    `session_type` STRING COMMENT 'Type of telehealth modality used for the session. Determines workflow, platform requirements, and billing rules.. Valid values are `video|phone|asynchronous|chat|remote_monitoring`',
    `session_url` STRING COMMENT 'Web link or URL provided to the patient and provider to access the telehealth session. Confidential to prevent unauthorized access.',
    `telehealth_session_status` STRING COMMENT 'The telehealth session status value classifying the scheduling telehealth session record.',
    `technical_issue_description` STRING COMMENT 'Free-text description of any technical issues encountered during the telehealth session, such as connectivity problems, audio/video quality issues, or platform errors.',
    `technical_issue_reported_flag` BOOLEAN COMMENT 'Indicates whether any technical issues were reported during or after the telehealth session that impacted quality or completion.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_telehealth_session PRIMARY KEY(`telehealth_session_id`)
) COMMENT 'Telehealth sessions';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` (
    `recall_list_id` BIGINT COMMENT 'Unique identifier for the recall list entry. Primary key for the recall list product.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Recall lists for care management visits are generated from care plans requiring periodic review and goal assessment. Essential for care plan monitoring, population health outreach, and chronic care ma',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the facility or clinic where the recall appointment should be scheduled.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the provider responsible for the recall. Typically the Primary Care Physician (PCP) or specialist managing the care gap.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall/outreach programs incur costs (staff, communications, outreach campaigns) tracked by cost center for quality program financial management, HEDIS cost analysis, and care gap closure program ROI.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient who is due for recall. Links to the patient master record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Recall diagnosis ICD codes required for HEDIS/Stars measure tracking, care gap identification, clinical basis validation, and quality program reporting. Essential for population health and value-based',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Recall outreach for preventive services requires current eligibility verification to confirm active coverage before scheduling. Population health teams verify eligibility during recall campaigns to av',
    `employee_id` BIGINT COMMENT 'Unique identifier for the care manager or population health coordinator assigned to manage this recall outreach.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Recall lists target plan-specific quality gaps and measure sets. Care gap closure campaigns are designed around plan contracts, quality incentives, and plan-specific measure numerator/denominator crit',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients active insurance coverage at the time the recall was generated. Used to determine coverage for preventive services and quality measure attribution.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Recall programs fulfill regulatory obligations including preventive care mandates, quality measure requirements, and care gap closure. CMS, HEDIS, and Star ratings requirement.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Recall campaigns are segmented by payer for quality measure reporting (HEDIS, Stars). Outreach prioritizes patients by payer-specific measure gaps and authorization requirements for preventive service',
    `population_health_gap_id` BIGINT COMMENT 'Foreign key linking to quality.population_health_gap. Business justification: Recall lists ARE care gap registries in many systems. Recalls are generated from identified gaps (mammography due, A1C overdue). Linking recall entries to gaps enables gap closure tracking and quality',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Recall lists are generated for chronic problems requiring periodic monitoring (diabetes, hypertension, CHF). Core to population health management, chronic care management billing, and quality measure ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Recall procedure CPT codes enable service-based recall tracking, gap closure evidence validation, and quality measure numerator determination. Critical for preventive care scheduling and quality repor',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Recall lists track patients due for repeat preventive procedures (colonoscopy, mammography) based on prior procedure dates and intervals. Critical for preventive screening compliance and HEDIS/Star qu',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the scheduled appointment that fulfills this recall. Links to the scheduling appointment product when the recall is successfully scheduled.',
    `aco_attributed` BOOLEAN COMMENT 'Indicates whether the patient is attributed to an Accountable Care Organization (ACO) for quality measure reporting and shared savings programs.',
    `appointment_scheduled_date` DATE COMMENT 'Date when the recall appointment was successfully scheduled.',
    `cancellation_date` DATE COMMENT 'Date when the recall was cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason why the recall was cancelled (e.g., patient deceased, patient transferred care, service completed elsewhere, no longer clinically indicated).',
    `care_gap_registry_code` BIGINT COMMENT 'Reference to the care gap registry entry that triggered this recall. Links to population health management and quality measure tracking systems.',
    `clinical_basis` STRING COMMENT 'Clinical justification for the recall, including relevant diagnosis codes, procedure history, or risk factors that necessitate follow-up care.',
    `cms_quality_program` STRING COMMENT 'CMS quality program associated with this recall (e.g., MIPS, MSSP, Value-Based Purchasing, Hospital Quality Reporting).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall list entry was first created in the system.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling recall list record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling recall list record.',
    `gap_closure_evidence` STRING COMMENT 'Documentation or reference to clinical evidence that the care gap was closed (e.g., lab result, procedure note, immunization record).',
    `hedis_measure_code` STRING COMMENT 'HEDIS quality measure code associated with this recall (e.g., BCS for Breast Cancer Screening, COL for Colorectal Cancer Screening, CDC for Comprehensive Diabetes Care).',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether the patient requires interpreter services for the recall appointment.',
    `language_preference` STRING COMMENT 'Patients preferred language for communication. Used to ensure culturally appropriate outreach materials and interpreter services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall list entry was last updated or modified.',
    `last_outreach_date` DATE COMMENT 'Date of the most recent outreach attempt to the patient for this recall.',
    `last_outreach_method` STRING COMMENT 'Method used for the most recent outreach attempt (phone, mail, patient portal, text message, email, in-person).. Valid values are `phone|mail|patient_portal|text_message|email|in_person`',
    `last_service_date` DATE COMMENT 'The date of the last completed service or appointment that established the baseline for calculating the recall date.',
    `mrn` STRING COMMENT 'The unique medical record number assigned to the patient by the healthcare organization. Protected Health Information (PHI) under HIPAA.',
    `notes` STRING COMMENT 'The notes of the scheduling recall list record.',
    `outreach_attempt_count` STRING COMMENT 'Number of outreach attempts made to contact the patient for recall scheduling (phone calls, letters, patient portal messages, text messages).',
    `patient_response` STRING COMMENT 'Patient response to the recall outreach (no response, agreed to schedule, declined, requested callback, wrong contact information, deceased).. Valid values are `no_response|agreed_to_schedule|declined|requested_callback|wrong_contact_info|deceased`',
    `patient_response_date` DATE COMMENT 'Date when the patient responded to the recall outreach.',
    `priority_level` STRING COMMENT 'Priority level assigned to the recall based on clinical urgency, risk stratification, and quality measure deadlines (routine, high, urgent, critical).. Valid values are `routine|high|urgent|critical`',
    `quality_measure_numerator_eligible` BOOLEAN COMMENT 'Indicates whether completing this recall would make the patient eligible for the numerator of the associated quality measure.',
    `recall_category` STRING COMMENT 'High-level category of the recall to support population health segmentation and reporting (preventive care, chronic disease management, post-procedure surveillance, care gap closure, immunization, screening, wellness). [ENUM-REF-CANDIDATE: preventive_care|chronic_disease_management|post_procedure_surveillance|care_gap_closure|immunization|screening|wellness — 7 candidates stripped; promote to reference product]',
    `recall_completion_date` DATE COMMENT 'Date when the recall was completed (patient attended the appointment and received the service).',
    `recall_expiration_date` DATE COMMENT 'Date after which the recall is considered expired and may be closed or escalated. Typically set based on quality measure reporting deadlines or clinical urgency.',
    `recall_interval_months` STRING COMMENT 'The standard recall interval in months for this type of service or condition (e.g., 12 months for annual wellness visit, 6 months for diabetes A1C, 24 months for colonoscopy follow-up).',
    `recall_reason` STRING COMMENT 'Free-text description of the clinical reason for the recall (e.g., annual wellness visit, mammography screening, diabetes A1C follow-up, post-surgical follow-up).',
    `recall_reason_code` STRING COMMENT 'Standardized code representing the recall reason. May use SNOMED CT, LOINC, or internal coding system to classify the type of recall.',
    `recall_status` STRING COMMENT 'Current status of the recall entry in the workflow (pending, outreach in progress, scheduled, completed, cancelled, expired, patient declined). [ENUM-REF-CANDIDATE: pending|outreach_in_progress|scheduled|completed|cancelled|expired|patient_declined — 7 candidates stripped; promote to reference product]',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this recall entry in the source system. Used for data reconciliation and lineage tracking.',
    `star_measure_applicable` BOOLEAN COMMENT 'Indicates whether this recall is applicable to Medicare STAR quality ratings for Medicare Advantage plans.',
    `recall_list_status` STRING COMMENT 'The recall list status value classifying the scheduling recall list record.',
    `target_recall_date` DATE COMMENT 'The target date by which the patient should be recalled for the follow-up appointment or service. Calculated based on clinical guidelines and recall interval.',
    `transportation_assistance_needed` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the recall appointment. Supports Social Determinants of Health (SDOH) interventions.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_recall_list PRIMARY KEY(`recall_list_id`)
) COMMENT 'Recall lists';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` (
    `provider_availability_id` BIGINT COMMENT 'Unique identifier for the provider availability record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the provider availability applies.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider whose availability is being recorded. Links to the provider master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who requested or created this availability record.',
    `provider_employee_id` BIGINT COMMENT 'Unique identifier for the provider employee within the scheduling provider availability record.',
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource within the scheduling provider availability record.',
    `schedule_template_id` BIGINT COMMENT 'Identifier of the schedule template that this availability record modifies or overrides, if applicable.',
    `tertiary_provider_cancelled_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who cancelled this availability record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or service line where the provider is available.',
    `accepts_new_patients` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is accepting new patient appointments during this availability period.',
    `accepts_new_patients_flag` BOOLEAN COMMENT 'The accepts new patients flag of the scheduling provider availability record.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `availability_status` STRING COMMENT 'Current status of the availability record in its lifecycle.. Valid values are `active|cancelled|pending|expired`',
    `availability_type` STRING COMMENT 'The type of availability record: scheduled (normal working hours), on_call (available for urgent calls), blocked (time blocked for non-clinical work), vacation (time off), cme (Continuing Medical Education), administrative (administrative duties).. Valid values are `scheduled|on_call|blocked|vacation|cme|administrative`',
    `booked_appointments` STRING COMMENT 'The current count of appointments already booked during this availability period. Used for capacity management.',
    `cancellation_reason` STRING COMMENT 'Free-text description of why this availability record was cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `care_setting` STRING COMMENT 'The care setting or service location where the provider is available: inpatient, outpatient, emergency department, surgical suite, telehealth, or home health.. Valid values are `inpatient|outpatient|emergency|surgical|telehealth|home_health`',
    `coverage_area` STRING COMMENT 'Geographic or organizational coverage area for on-call availability. Examples: entire hospital, specific units, regional coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credentialing_status` STRING COMMENT 'The credentialing status of the provider at the facility during this availability period. Must be active for scheduling.. Valid values are `active|pending|expired|suspended`',
    `day_of_week` STRING COMMENT 'The day of week of the scheduling provider availability record.',
    `duration_minutes` STRING COMMENT 'The total duration of the availability period in minutes, calculated from start to end datetime.',
    `effective_end_date` DATE COMMENT 'The date when this availability record expires and is no longer valid for scheduling. Null indicates no expiration. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date when this availability record becomes effective for scheduling purposes. Format: yyyy-MM-dd.',
    `end_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period ends. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `end_time` TIMESTAMP COMMENT 'Timestamp capturing the end time associated with the scheduling provider availability record.',
    `insurance_type_accepted` STRING COMMENT 'Comma-separated list of insurance types or payer categories accepted during this availability period. Examples: Medicare, Medicaid, Commercial, Self-Pay.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `location_code` STRING COMMENT 'The location code value classifying the scheduling provider availability record.',
    `max_appointments` STRING COMMENT 'The maximum number of appointments that can be scheduled during this availability period. Null indicates no specific limit.',
    `notes` STRING COMMENT 'Free-text notes or comments about this availability record. May include special instructions, constraints, or context.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS to uniquely identify the healthcare provider.. Valid values are `^[0-9]{10}$`',
    `on_call_type` STRING COMMENT 'The type of on-call availability when availability_type is on_call: primary (first responder), backup (secondary coverage), home (available from home), hospital (on-site coverage).. Valid values are `primary|backup|home|hospital`',
    `overbooking_allowed` BOOLEAN COMMENT 'Boolean indicator (True/False) whether overbooking beyond max_appointments is permitted during this availability period.',
    `overbooking_limit` STRING COMMENT 'The maximum number of overbooked appointments allowed beyond the standard max_appointments capacity.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that identifies whether this availability record is an exception or override to the providers standard schedule template.',
    `patient_class` STRING COMMENT 'The patient classification or visit type that this availability supports.. Valid values are `inpatient|outpatient|observation|emergency|surgical|same_day`',
    `priority_level` STRING COMMENT 'The priority level of appointments that can be scheduled during this availability period.. Valid values are `routine|urgent|emergency`',
    `privilege_code` STRING COMMENT 'The clinical privilege code or category that the provider holds at this facility, defining the scope of services they can provide.',
    `provider_npi` STRING COMMENT 'The provider npi of the scheduling provider availability record.',
    `recurrence_end_date` DATE COMMENT 'The date when a recurring availability pattern ends. Null for one-time availability records. Format: yyyy-MM-dd.',
    `recurrence_pattern` STRING COMMENT 'Indicates whether this availability record is a one-time event or part of a recurring pattern.. Valid values are `once|daily|weekly|biweekly|monthly`',
    `remaining_capacity` STRING COMMENT 'The number of additional appointments that can still be scheduled during this availability period, calculated as max_appointments minus booked_appointments.',
    `session_type` STRING COMMENT 'The session type value classifying the scheduling provider availability record.',
    `slot_duration_minutes` DECIMAL(18,2) COMMENT 'The slot duration minutes of the scheduling provider availability record.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this availability record in the source system.',
    `specialty_code` STRING COMMENT 'The medical specialty or service line code for which the provider is available during this period.',
    `start_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period begins. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `start_time` TIMESTAMP COMMENT 'Timestamp capturing the start time associated with the scheduling provider availability record.',
    `telehealth_enabled` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is available for telehealth appointments during this period.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'The telehealth enabled flag of the scheduling provider availability record.',
    `unavailability_reason` STRING COMMENT 'Free-text description of the reason for unavailability when availability_type is blocked, vacation, cme, or administrative. Examples: conference attendance, personal leave, training, committee meeting.',
    `unavailability_reason_code` STRING COMMENT 'Standardized code representing the reason for unavailability. Used for reporting and analytics.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_provider_availability PRIMARY KEY(`provider_availability_id`)
) COMMENT 'Provider availability';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` (
    `surgical_case_team_id` BIGINT COMMENT 'Unique identifier for the surgical case team assignment record. Primary key for this entity.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the scheduling surgical case team record.',
    `credential_id` BIGINT COMMENT 'Unique identifier for the credential within the scheduling surgical case team record.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who verified the team members credentials and privileges for this case.',
    `privileging_id` BIGINT COMMENT 'Unique identifier for the privileging within the scheduling surgical case team record.',
    `surgical_case_id` BIGINT COMMENT 'Reference to the surgical case for which this team member is assigned. Links to the surgical_case product.',
    `surgical_employee_id` BIGINT COMMENT 'Unique identifier for the surgical employee within the scheduling surgical case team record.',
    `tertiary_surgical_cancelled_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who cancelled this team member assignment.',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Surgical team members require procedure-specific training verification including scrub technique, equipment operation, and specialty certifications. Joint Commission and medical staff bylaws requireme',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time when the team member completed their participation in the surgical case. Used for time tracking and billing.',
    `actual_end_time` TIMESTAMP COMMENT 'Timestamp capturing the actual end time associated with the scheduling surgical case team record.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time when the team member began their participation in the surgical case. Used for time tracking and billing.',
    `actual_start_time` TIMESTAMP COMMENT 'Timestamp capturing the actual start time associated with the scheduling surgical case team record.',
    `anesthesiologist_npi` STRING COMMENT 'National Provider Identifier of the anesthesiologist or CRNA (Certified Registered Nurse Anesthetist) assigned to the case. Used for anesthesia billing and quality tracking. [Moved from surgical_case: This attribute represents the anesthesiologist clinician-case relationship. In the M:N model, this becomes a record in surgical_case_team with team_role_code=ANESTHESIOLOGIST or CRNA. The current model cannot represent cases with multiple anesthesia providers or CRNA+anesthesiologist teams.]. Valid values are `^[0-9]{10}$`',
    `assignment_datetime` STRING COMMENT 'Timestamp capturing the assignment datetime associated with the scheduling surgical case team record.',
    `assignment_notes` STRING COMMENT 'Free-text notes regarding this team member assignment. May include special requirements, preferences, or coordination details.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking of this team member assignment relative to other assignments for the same case. Lower numbers indicate higher priority. Used for scheduling conflict resolution.',
    `assignment_status` STRING COMMENT 'Current status of the team member assignment. Tracks the lifecycle from scheduling through completion or cancellation.. Valid values are `scheduled|confirmed|in_progress|completed|cancelled|no_show`',
    `assisting_surgeon_npi` STRING COMMENT 'National Provider Identifier of the assisting surgeon, if applicable. Used for billing assistant surgeon charges and documenting surgical team composition. [Moved from surgical_case: This attribute represents another specific clinician-case relationship (the assisting surgeon role). In the M:N model, this becomes a record in surgical_case_team with team_role_code=ASSISTING_SURGEON. The current model artificially limits cases to one assisting surgeon.]. Valid values are `^[0-9]{10}$`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this team members participation is billable to the patient or payer. True if billable, False if non-billable (e.g., resident supervision, observation).',
    `billing_modifier_code` STRING COMMENT 'CPT or HCPCS modifier code applied to this team members billing for the surgical case. Used to indicate special circumstances (e.g., assistant surgeon, co-surgeon, teaching physician).',
    `board_certification_status` STRING COMMENT 'Current status of the team members board certification in their specialty. Used for quality reporting and credentialing.. Valid values are `certified|not_certified|expired|pending`',
    `call_status` STRING COMMENT 'Indicates whether the team member is scheduled, on-call, backup, or responding to an emergency for this case. Used for staffing and scheduling analytics.. Valid values are `scheduled|on_call|backup|emergency`',
    `cancellation_datetime` TIMESTAMP COMMENT 'The date and time when this team member assignment was cancelled. Null if assignment was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason why this team member assignment was cancelled. May include provider unavailability, case cancellation, or scheduling changes.',
    `confirmation_datetime` TIMESTAMP COMMENT 'The date and time when the team member confirmed their participation in the surgical case.',
    `confirmation_status` STRING COMMENT 'Status indicating whether the team member has confirmed their availability and commitment to participate in this surgical case.. Valid values are `pending|confirmed|declined|tentative`',
    `conflict_description` STRING COMMENT 'Detailed description of any scheduling conflict identified for this team member assignment. Includes conflicting case number or appointment details.',
    `conflict_flag` BOOLEAN COMMENT 'Indicates whether this team member assignment has a scheduling conflict with another commitment. True if conflict exists, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this team member assignment record was first created in the system. Used for audit trail and data lineage.',
    `credentialing_verification_datetime` TIMESTAMP COMMENT 'The date and time when the team members credentials and privileges were verified for this surgical case.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Indicates whether the team members credentials and privileges have been verified for this specific surgical case. True if verified, False if not verified or pending.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this team member assignment record was last modified. Used for audit trail and change tracking.',
    `license_number` STRING COMMENT 'The professional license number of the team member. Required for regulatory compliance and credentialing verification.',
    `license_state` STRING COMMENT 'Two-letter state code where the team members professional license was issued. Must match the facilitys state or have reciprocity agreement.. Valid values are `^[A-Z]{2}$`',
    `notes` STRING COMMENT 'The notes of the scheduling surgical case team record.',
    `participation_duration_minutes` STRING COMMENT 'Total duration in minutes of the team members actual participation in the surgical case. Calculated from actual start and end times.',
    `primary_flag` BOOLEAN COMMENT 'The primary flag of the scheduling surgical case team record.',
    `primary_role_flag` BOOLEAN COMMENT 'Indicates whether this team member holds the primary responsibility for their role category (e.g., primary surgeon vs. assisting surgeon). True if primary, False if secondary or assisting.',
    `primary_surgeon_name` STRING COMMENT 'Full name of the primary surgeon. Used for operational communication, patient information, and surgical schedule displays. [Moved from surgical_case: Denormalized display attribute derived from the primary surgeon relationship. Should be removed as it can be derived from the surgical_case_team association joined to clinician.]',
    `primary_surgeon_npi` STRING COMMENT 'National Provider Identifier of the primary surgeon responsible for the surgical case. Ten-digit unique identifier assigned by CMS. Used for credentialing, billing, and quality reporting. [Moved from surgical_case: This attribute represents one specific clinician-case relationship (the primary surgeon role). In the M:N model, this becomes a record in surgical_case_team with team_role_code=PRIMARY_SURGEON. Storing it as a single attribute on surgical_case violates normalization and prevents tracking multiple surgeons or role changes.]. Valid values are `^[0-9]{10}$`',
    `privilege_code` STRING COMMENT 'Code representing the specific clinical privilege that authorizes this team member to perform their role in this surgical case. Links to the providers credentialing and privileging records.',
    `privilege_verified_flag` BOOLEAN COMMENT 'The privilege verified flag of the scheduling surgical case team record.',
    `provider_npi` STRING COMMENT 'The provider npi of the scheduling surgical case team record.',
    `quality_measure_applicable_flag` BOOLEAN COMMENT 'Indicates whether this team member assignment is subject to quality measurement or reporting requirements. True if applicable, False otherwise.',
    `relief_flag` BOOLEAN COMMENT 'The relief flag of the scheduling surgical case team record.',
    `replacement_team_member_npi` STRING COMMENT 'The NPI of the replacement team member if this assignment was substituted. Used to track last-minute staffing changes.. Valid values are `^[0-9]{10}$`',
    `requested_datetime` TIMESTAMP COMMENT 'The date and time when this team member was requested for assignment to the surgical case.',
    `role_code` STRING COMMENT 'The role code value classifying the scheduling surgical case team record.',
    `role_status` STRING COMMENT 'The role status value classifying the scheduling surgical case team record.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The date and time when the team member is scheduled to complete their participation in the surgical case.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The date and time when the team member is scheduled to begin their participation in the surgical case.',
    `scrub_time_minutes` STRING COMMENT 'Time in minutes spent by the team member in surgical scrub preparation. Applicable to scrubbed team members (surgeons, scrub techs).',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this team member assignment in the source system. Used for data lineage and reconciliation.',
    `specialty_code` STRING COMMENT 'Code representing the medical specialty or clinical discipline of the team member (e.g., orthopedic surgery, cardiothoracic surgery, anesthesiology).',
    `supervising_provider_npi` STRING COMMENT 'The NPI of the attending physician or supervising provider if this team member is a resident, fellow, or student. Required for teaching case billing compliance.. Valid values are `^[0-9]{10}$`',
    `teaching_case_flag` BOOLEAN COMMENT 'Indicates whether this is a teaching case with resident or student participation under supervision. True if teaching case, False otherwise. Impacts billing and documentation requirements.',
    `team_member_name` STRING COMMENT 'Full legal name of the care team member assigned to this surgical case. Used for case documentation and credentialing verification.',
    `team_member_npi` STRING COMMENT 'The 10-digit National Provider Identifier for the team member assigned to this surgical case. Required for billing and credentialing verification.. Valid values are `^[0-9]{10}$`',
    `team_role` STRING COMMENT 'The team role of the scheduling surgical case team record.',
    `team_role_code` STRING COMMENT 'Standardized code representing the role of the team member in the surgical case. Values: SURGEON (primary surgeon), CO_SURGEON (assisting surgeon), ANESTHESIOLOGIST (physician anesthesiologist), CRNA (Certified Registered Nurse Anesthetist), SCRUB_TECH (scrub technician), CIRCULATING_NURSE (circulating nurse). [ENUM-REF-CANDIDATE: SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE|PERFUSIONIST|FIRST_ASSIST|SURGICAL_RESIDENT|ANESTHESIA_RESIDENT|STUDENT_NURSE — promote to reference product]. Valid values are `SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE`',
    `team_role_description` STRING COMMENT 'Human-readable description of the team members role and responsibilities during the surgical case.',
    `time_in_room_minutes` STRING COMMENT 'Total time in minutes that the team member spent in the operating room for this case. Used for efficiency and utilization analysis.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_surgical_case_team PRIMARY KEY(`surgical_case_team_id`)
) COMMENT 'Surgical case team';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` (
    `booking_queue_id` BIGINT COMMENT 'Primary key for booking_queue',
    `appointment_type_id` BIGINT COMMENT 'Unique identifier for the booking appointment type within the scheduling booking queue record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the booking clinician within the scheduling booking queue record.',
    `booking_requested_appointment_type_id` BIGINT COMMENT 'Reference to the type of appointment being requested. Links to appointment type reference data for scheduling parameters.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the booking workforce org unit within the scheduling booking queue record.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the appointment is requested. Links to facility master data.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Scheduling queues track authorization requirements for pending appointments. Queue processors verify authorization status before booking, linking authorization records to ensure services are approved ',
    `clinical_order_id` BIGINT COMMENT 'Reference to the clinical order that generated this scheduling request. Links to order management system for order-based queue entries.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient requiring scheduling. Links to the patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Booking queue entries include diagnosis information for centralized scheduling triage, specialty routing, and urgency determination. Essential for access management and appropriate specialty assignmen',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Booking queues verify plan-specific network restrictions, benefit requirements, and authorization criteria before scheduling. Queue assignment logic routes patients to in-network providers based on pl',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients active insurance coverage for this appointment. Used for eligibility verification and authorization checks.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the scheduling booking queue record.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Booking queues prioritize patients by payer authorization status and track payer-specific scheduling requirements. Queue aging and escalation rules vary by payer timely filing limits and authorization',
    `primary_booking_clinician_id` BIGINT COMMENT 'Reference to the provider who initiated the scheduling request or referral. Links to provider master data.',
    `employee_id` BIGINT COMMENT 'Reference to the individual scheduler assigned to work this queue entry. May be null if not yet assigned to a specific person.',
    `primary_booking_requested_department_workforce_org_unit_id` BIGINT COMMENT 'Reference to the specific department or clinic within the facility where the appointment is requested.',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the appointment that was created to fulfill this queue entry. Populated when queue status transitions to scheduled.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research subjects queued for protocol-required appointments must link to enrollment records for visit window tracking and protocol compliance. Centralized scheduling teams process research appointment',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Booking queue visit reason ICD codes enable clinical triage, authorization requirement determination, specialty routing, and SLA prioritization. Essential for centralized scheduling operations and acc',
    `waitlist_entry_id` BIGINT COMMENT 'Unique identifier for the waitlist entry within the scheduling booking queue record.',
    `aging_days` STRING COMMENT 'Number of calendar days the queue entry has been open since queue entry datetime. Used for aging reports and escalation triggers.',
    `assigned_to_user_name` STRING COMMENT 'The assigned to user name of the scheduling booking queue record.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before scheduling. Blocks scheduling until authorization is obtained.',
    `care_setting` STRING COMMENT 'The care delivery setting where the appointment will take place. Determines scheduling rules and resource requirements.. Valid values are `outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the queue entry record was first created in the database. Used for audit trail and data lineage.',
    `current_depth` STRING COMMENT 'The current depth of the scheduling booking queue record.',
    `enqueued_timestamp` TIMESTAMP COMMENT 'The enqueued timestamp of the scheduling booking queue record.',
    `escalation_datetime` TIMESTAMP COMMENT 'The date and time when the queue entry was escalated. Null if never escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this queue entry has been escalated due to Service Level Agreement (SLA) breach, clinical urgency, or patient complaint.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the queue entry was escalated. Documents clinical, operational, or patient satisfaction concerns.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter is required for the appointment. Triggers interpreter scheduling and resource allocation.',
    `language_preference` STRING COMMENT 'The patients preferred language for communication and care delivery. ISO 639-1 two-letter language code or full language name.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the queue entry record was last updated. Used for audit trail and change tracking.',
    `last_outreach_datetime` TIMESTAMP COMMENT 'The date and time of the most recent outreach attempt to the patient. Used for follow-up scheduling and compliance tracking.',
    `last_outreach_method` STRING COMMENT 'The communication channel used for the most recent patient outreach attempt. Informs next-best-action for follow-up.. Valid values are `phone|email|sms|patient_portal|mail`',
    `mrn` STRING COMMENT 'The unique medical record number assigned to the patient by the healthcare organization. Protected Health Information (PHI) under HIPAA.',
    `notes` STRING COMMENT 'Free-text notes and comments added by scheduling staff during queue processing. Documents special instructions, patient requests, or workflow issues.',
    `outreach_attempt_count` STRING COMMENT 'Number of times scheduling staff have attempted to contact the patient to schedule the appointment. Used for tracking patient engagement.',
    `preferred_contact_channel` STRING COMMENT 'The patients preferred method of communication for scheduling coordination. Captured from patient preferences or registration data.. Valid values are `phone|email|sms|patient_portal|mail`',
    `preferred_days_of_week` STRING COMMENT 'Comma-separated list of days of the week the patient prefers for appointments (e.g., Monday, Wednesday, Friday). Used for slot matching.',
    `preferred_time_of_day` STRING COMMENT 'The time of day the patient prefers for appointments. Used to optimize patient satisfaction and reduce no-shows.. Valid values are `morning|afternoon|evening|any`',
    `priority_level` STRING COMMENT 'Clinical or operational priority assigned to the scheduling request. Determines urgency and Service Level Agreement (SLA) targets.. Valid values are `stat|urgent|routine|elective`',
    `processed_timestamp` TIMESTAMP COMMENT 'The processed timestamp of the scheduling booking queue record.',
    `queue_code` STRING COMMENT 'The queue code value classifying the scheduling booking queue record.',
    `queue_entry_datetime` TIMESTAMP COMMENT 'The date and time when the scheduling request was added to the queue. Used for aging calculations and Service Level Agreement (SLA) tracking.',
    `queue_name` STRING COMMENT 'The queue name of the scheduling booking queue record.',
    `queue_number` STRING COMMENT 'Human-readable business identifier for the queue entry. Used for tracking and reference by scheduling staff.',
    `queue_position` STRING COMMENT 'The queue position of the scheduling booking queue record.',
    `queue_status` STRING COMMENT 'Current lifecycle status of the queue entry. Tracks progression through the scheduling workflow from initial entry to resolution.. Valid values are `pending|in_progress|scheduled|escalated|closed|cancelled`',
    `queue_type` STRING COMMENT 'Classification of the scheduling queue entry by source or purpose. Determines workflow routing and handling procedures.. Valid values are `referral|order_based|recall|surgical_request|follow_up|new_patient`',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Booking queues track consent status as scheduling prerequisite. Scheduling staff verify consent obtained before finalizing appointment. Prevents booking procedures without required informed consent, s',
    `removal_datetime` TIMESTAMP COMMENT 'The date and time when the queue entry was removed from the active queue (scheduled, cancelled, or closed). Used for queue throughput metrics.',
    `removal_reason` STRING COMMENT 'Free-text explanation of why the queue entry was removed or closed. Documents resolution outcome or cancellation rationale.',
    `routing_rule` STRING COMMENT 'The routing rule of the scheduling booking queue record.',
    `scheduled_datetime` TIMESTAMP COMMENT 'The date and time when the appointment was successfully scheduled and the queue entry was resolved. Used for cycle time reporting.',
    `sla_target_datetime` TIMESTAMP COMMENT 'The target date and time by which the scheduling request must be resolved to meet Service Level Agreement (SLA) commitments. Calculated based on priority and queue entry time.',
    `sla_target_hours` STRING COMMENT 'The sla target hours of the scheduling booking queue record.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling booking queue record.',
    `specialty_code` STRING COMMENT 'The specialty code value classifying the scheduling booking queue record.',
    `specialty_required` STRING COMMENT 'Medical specialty or subspecialty required for the appointment. Used for provider matching and resource allocation.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the appointment type and patient circumstances allow for telehealth delivery. Used for virtual visit scheduling options.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. May trigger coordination with transportation services.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_reason` STRING COMMENT 'Free-text description of the reason for the appointment or clinical indication. Captured from referral or order documentation.',
    `visit_reason_code` STRING COMMENT 'Standardized code representing the reason for visit. May use ICD-10 (International Classification of Diseases 10th Revision), CPT (Current Procedural Terminology), or internal reason codes.',
    `wait_time_minutes` STRING COMMENT 'The wait time minutes of the scheduling booking queue record.',
    CONSTRAINT pk_booking_queue PRIMARY KEY(`booking_queue_id`)
) COMMENT 'Booking queue';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` (
    `equipment_reservation_id` BIGINT COMMENT 'Unique identifier for the equipment reservation record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the equipment is reserved and the procedure will take place. Links to facility master data.',
    `clinician_id` BIGINT COMMENT 'Reference to the physician or clinical provider who requested the equipment reservation. Links to provider master data.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the specific equipment asset being reserved. Links to the schedulable resource or equipment master record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Equipment reservations reference capital assets requiring depreciation tracking, utilization-based ROI analysis, and capital planning. Links reservation usage to asset financial records for equipment ',
    `or_suite_id` BIGINT COMMENT 'Reference to the specific operating room or procedure suite where the equipment will be used. Links to room master data.',
    `employee_id` BIGINT COMMENT 'Reference to the system user who confirmed the equipment reservation. Links to user or staff master data for audit trail.',
    `procedure_event_id` BIGINT COMMENT 'Reference to the specific procedure event requiring this equipment. May link to non-surgical procedures such as interventional radiology or cardiac catheterization.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Reservable equipment includes supply-chain-managed portable devices, instruments, and consumable kits tracked as material master items (not fixed assets). Enables unified asset tracking, maintenance s',
    `resource_assignment_id` BIGINT COMMENT 'Unique identifier for the resource assignment within the scheduling equipment reservation record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the scheduling equipment reservation record.',
    `scheduling_appointment_id` BIGINT COMMENT 'Reference to the outpatient appointment requiring this equipment. Used when specialized equipment is needed for clinic-based procedures.',
    `surgical_case_id` BIGINT COMMENT 'Reference to the surgical case for which this equipment is reserved. Links to the surgical case scheduling record in OpTime or equivalent surgical scheduling system.',
    `tertiary_equipment_requested_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who created the equipment reservation request. Links to user or staff master data for audit trail.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical department or service line requesting the equipment. Links to organizational unit master data.',
    `actual_duration_minutes` STRING COMMENT 'Actual duration the equipment was in use, measured in minutes. Calculated from actual start to actual end times for utilization analysis.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the equipment was released from use. Marks the true end of equipment utilization for the case or procedure.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the equipment was deployed and in-use began. Captures real-world utilization for performance tracking and billing.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the equipment usage is billable to the patient or payer. Used for revenue cycle management and charge capture.',
    `cancellation_datetime` TIMESTAMP COMMENT 'Date and time when the equipment reservation was cancelled. Used for utilization analysis and no-show tracking.',
    `cancellation_reason` STRING COMMENT 'Detailed explanation of why the equipment reservation was cancelled. Supports root cause analysis and process improvement.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code representing the category of cancellation reason. Enables structured analysis of cancellation patterns.',
    `cancelled_datetime` TIMESTAMP COMMENT 'Timestamp capturing the cancelled datetime associated with the scheduling equipment reservation record.',
    `charge_code` STRING COMMENT 'Revenue code or charge code associated with the equipment usage. Links to the Charge Description Master (CDM) for billing.',
    `confirmation_datetime` TIMESTAMP COMMENT 'Date and time when the equipment reservation was confirmed by the equipment management or scheduling team.',
    `confirmation_status` STRING COMMENT 'Status of the reservation confirmation process. Tracks whether the equipment availability has been verified and confirmed by the equipment management team.. Valid values are `pending|confirmed|declined|expired`',
    `conflict_description` STRING COMMENT 'Detailed description of the scheduling conflict, including overlapping reservations or maintenance windows. Provides context for conflict resolution.',
    `conflict_flag` BOOLEAN COMMENT 'Indicates whether this reservation has a scheduling conflict with another reservation or maintenance window. Triggers manual review and resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this equipment reservation record was first created in the database. Used for audit trail and data lineage.',
    `duration_minutes` STRING COMMENT 'Planned duration of the equipment reservation in minutes. Calculated from scheduled start to scheduled end times.',
    `equipment_asset_tag` STRING COMMENT 'Physical asset tag identifier affixed to the equipment unit. Used for tracking and inventory management of the specific device instance.',
    `equipment_type` STRING COMMENT 'Category of specialized medical equipment being reserved. Defines the class of device required for the procedure. [ENUM-REF-CANDIDATE: c-arm|surgical_robot|laser|perfusion_pump|specialized_or_table|microscope|endoscopy_tower|lithotripsy|cryotherapy|ultrasound|fluoroscopy — 11 candidates stripped; promote to reference product]',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance or inspection performed on the equipment. Used to verify equipment readiness and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this equipment reservation record was last updated. Used for audit trail and change tracking.',
    `maintenance_clearance_flag` BOOLEAN COMMENT 'Indicates whether the equipment has passed all required maintenance checks and is cleared for clinical use. Ensures patient safety and device reliability.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the equipment reservation. Captures additional context not covered by structured fields.',
    `procedure_code` STRING COMMENT 'Primary procedure code for the case or appointment requiring this equipment. Typically a CPT or ICD-10-PCS code identifying the clinical intervention.',
    `procedure_description` STRING COMMENT 'Human-readable description of the procedure or surgical case requiring the equipment. Provides clinical context for the reservation.',
    `requested_datetime` TIMESTAMP COMMENT 'Date and time when the equipment reservation was initially requested. Marks the beginning of the reservation lifecycle for lead time analysis.',
    `requesting_provider_npi` STRING COMMENT 'National Provider Identifier of the physician or clinical provider requesting the equipment. Ten-digit unique identifier assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `reservation_number` STRING COMMENT 'Human-readable business identifier for the equipment reservation. Externally visible tracking number used by clinical and operational staff.',
    `reservation_priority` STRING COMMENT 'Clinical priority level of the equipment reservation. Determines scheduling precedence and conflict resolution rules.. Valid values are `routine|urgent|emergent|elective|stat`',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the equipment reservation. Tracks the reservation from initial request through completion or cancellation. [ENUM-REF-CANDIDATE: requested|pending_approval|confirmed|in_use|released|cancelled|conflict|on_hold — 8 candidates stripped; promote to reference product]',
    `reservation_type` STRING COMMENT 'The reservation type value classifying the scheduling equipment reservation record.',
    `reserved_end_datetime` STRING COMMENT 'Timestamp capturing the reserved end datetime associated with the scheduling equipment reservation record.',
    `reserved_start_datetime` STRING COMMENT 'Timestamp capturing the reserved start datetime associated with the scheduling equipment reservation record.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the equipment reservation ends. Marks the conclusion of the reserved time block including any required turnover time.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the equipment reservation begins. Marks the start of the reserved time block for equipment availability.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling equipment reservation record.',
    `specialty_code` STRING COMMENT 'Medical specialty code associated with the procedure requiring this equipment. Used for equipment allocation and utilization analysis by service line.',
    `sterilization_batch_number` STRING COMMENT 'Batch or lot number from the sterilization cycle applied to this equipment. Used for infection control tracking and recall management.',
    `sterilization_clearance_datetime` TIMESTAMP COMMENT 'Date and time when the equipment was cleared as sterile and available for use. Critical for infection prevention and equipment readiness.',
    `sterilization_clearance_flag` BOOLEAN COMMENT 'The sterilization clearance flag of the scheduling equipment reservation record.',
    `sterilization_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment requires sterilization before or after use. Critical for infection control and equipment availability planning.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_equipment_reservation PRIMARY KEY(`equipment_reservation_id`)
) COMMENT 'Equipment reservations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` (
    `case_material_usage_id` BIGINT COMMENT 'Unique surrogate identifier for each surgical case material usage transaction record. Primary key for the association.',
    `cdm_entry_id` BIGINT COMMENT 'Unique identifier for the cdm entry within the scheduling case material usage record.',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical or OR staff member who documented this material usage in the perioperative system. Used for accountability and audit compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master record identifying the specific supply item, implant, or consumable used in this case.',
    `surgical_bom_id` BIGINT COMMENT 'Unique identifier for the surgical bom within the scheduling case material usage record.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to the surgical case during which this material was consumed. Establishes the clinical and temporal context for material usage.',
    `udi_record_id` BIGINT COMMENT 'Unique identifier for the udi record within the scheduling case material usage record.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this material usage is billable to the patient, payer, or included in the case bundled payment. Drives charge capture and revenue cycle workflows.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The charge amount of the scheduling case material usage record.',
    `charge_captured_flag` BOOLEAN COMMENT 'The charge captured flag of the scheduling case material usage record.',
    `charge_code` STRING COMMENT 'Revenue code, CPT code, or HCPCS code used for billing this material item to the payer. Links supply usage to charge master and claim generation workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling case material usage record.',
    `implant_flag` BOOLEAN COMMENT 'Indicates whether this material item was implanted in the patient during the surgical case. Triggers mandatory UDI documentation, patient implant registry updates, and enhanced traceability requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling case material usage record.',
    `lot_number` STRING COMMENT 'Manufacturers lot or batch number for the material item used in this case. Required for traceability, recall management, and quality control. Mandatory for implantable devices and sterile supplies.',
    `material_code` STRING COMMENT 'The material code value classifying the scheduling case material usage record.',
    `material_description` STRING COMMENT 'The material description of the scheduling case material usage record.',
    `quantity_used` DECIMAL(18,2) COMMENT 'Numeric quantity of the material item consumed during the surgical case, expressed in the materials stocking unit of measure. Used for inventory depletion, cost calculation, and utilization analytics.',
    `quantity_wasted` STRING COMMENT 'The quantity wasted of the scheduling case material usage record.',
    `serial_number` STRING COMMENT 'Unique serial number for the specific material item instance used in this case. Required for FDA UDI compliance for implantable devices. Enables patient-level device tracking and recall notification.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling case material usage record.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the scheduling case material usage record.',
    `udi_device_identifier` STRING COMMENT 'The udi device identifier of the scheduling case material usage record.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Actual cost per unit of the material item at the time of case consumption. Captured from contract pricing or catalog pricing at time of use. Used for case-level cost accounting and margin analysis.',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the scheduling case material usage record.',
    `usage_timestamp` TIMESTAMP COMMENT 'Date and time when the material item was documented as used or implanted during the surgical case. Used for intraoperative timeline reconstruction and audit trails.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waste_flag` BOOLEAN COMMENT 'Indicates whether this material was opened/prepared for the case but not used (wasted). Used for waste reduction analytics, cost variance analysis, and supply chain optimization.',
    CONSTRAINT pk_case_material_usage PRIMARY KEY(`case_material_usage_id`)
) COMMENT 'Case material usage';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` (
    `appointment_prior_auth_requirement_id` BIGINT COMMENT 'Unique identifier for this appointment type prior authorization requirement record. Primary key.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to the appointment type that is subject to prior authorization requirements',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the cpt code within the scheduling appointment prior auth requirement record.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan within the scheduling appointment prior auth requirement record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the scheduling appointment prior auth requirement record.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to the payer-specific prior authorization rule that applies to this appointment type',
    `scheduling_appointment_id` BIGINT COMMENT 'Unique identifier for the scheduling appointment within the scheduling appointment prior auth requirement record.',
    `appointment_prior_auth_requirement_status` STRING COMMENT 'Current lifecycle status of this appointment type prior authorization requirement: active (in effect), inactive (not enforced), pending (scheduled to activate), superseded (replaced by newer rule).',
    `auth_required_flag` BOOLEAN COMMENT 'The auth required flag of the scheduling appointment prior auth requirement record.',
    `authorization_number` STRING COMMENT 'The authorization number of the scheduling appointment prior auth requirement record.',
    `authorization_required_flag` BOOLEAN COMMENT 'The authorization required flag of the scheduling appointment prior auth requirement record.',
    `authorization_status` STRING COMMENT 'The authorization status value classifying the scheduling appointment prior auth requirement record.',
    `clinical_criteria_reference` STRING COMMENT 'Reference to the clinical guideline, medical policy, or evidence-based criteria document that applies to prior authorization for this appointment type under this payer rule. May be appointment-type-specific criteria. Sourced from detection phase relationship data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this appointment type prior authorization requirement record was created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the scheduling appointment prior auth requirement record.',
    `denial_reason` STRING COMMENT 'The denial reason of the scheduling appointment prior auth requirement record.',
    `diagnosis_icd_code` STRING COMMENT 'The diagnosis icd code value classifying the scheduling appointment prior auth requirement record.',
    `effective_date` DATE COMMENT 'Date on which this prior authorization requirement becomes active for this appointment type under this payer rule. Sourced from detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the scheduling appointment prior auth requirement record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the scheduling appointment prior auth requirement record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the scheduling appointment prior auth requirement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling appointment prior auth requirement record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this appointment type prior authorization requirement record was last modified.',
    `notes` STRING COMMENT 'The notes of the scheduling appointment prior auth requirement record.',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the scheduling appointment prior auth requirement record.',
    `procedure_cpt_code` STRING COMMENT 'The procedure cpt code value classifying the scheduling appointment prior auth requirement record.',
    `requirement_status` STRING COMMENT 'The requirement status value classifying the scheduling appointment prior auth requirement record.',
    `requires_prior_authorization` BOOLEAN COMMENT 'Indicates whether this appointment type requires prior authorization from the payer before scheduling. Supports revenue cycle compliance and denial prevention. [Moved from appointment_type: This boolean flag on appointment_type is too coarse-grained. Prior authorization requirements are payer-specific and time-bound, not universal to the appointment type. The flag should be replaced by a query against this association to determine if PA is required for a given appointment type, payer, and date combination.]',
    `service_category` STRING COMMENT 'The service category of the scheduling appointment prior auth requirement record.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling appointment prior auth requirement record.',
    `submission_datetime` TIMESTAMP COMMENT 'Timestamp capturing the submission datetime associated with the scheduling appointment prior auth requirement record.',
    `submission_method` STRING COMMENT 'Allowed method(s) for submitting the prior authorization request for this appointment type under this payer rule: portal, fax, phone, EDI 278, or multiple. May be appointment-type-specific override of base rule submission method. Sourced from detection phase relationship data.',
    `termination_date` DATE COMMENT 'Date on which this prior authorization requirement is no longer active for this appointment type under this payer rule. Null indicates ongoing requirement. Sourced from detection phase relationship data.',
    `turnaround_time_hours` STRING COMMENT 'Standard turnaround time in hours for the payer to respond to a prior authorization request for this appointment type. May differ from the base rule turnaround time if appointment-specific SLAs exist. Sourced from detection phase relationship data.',
    `units_authorized` STRING COMMENT 'The units authorized of the scheduling appointment prior auth requirement record.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_appointment_prior_auth_requirement PRIMARY KEY(`appointment_prior_auth_requirement_id`)
) COMMENT 'Appointment prior auth requirements';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` (
    `reminder_template_id` BIGINT COMMENT 'Primary key for reminder_template',
    `appointment_type_id` BIGINT COMMENT 'Reference to the specific appointment type or visit category that this reminder template is designed to support.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or location where this reminder template is used for appointment scheduling.',
    `compliance_policy_id` BIGINT COMMENT 'Unique identifier for the compliance policy within the scheduling reminder template record.',
    `message_template_id` BIGINT COMMENT 'Unique identifier for the message template within the scheduling reminder template record.',
    `parent_reminder_template_id` BIGINT COMMENT 'Self-referencing FK on reminder_template (parent_reminder_template_id)',
    `primary_superseded_by_reminder_template_id` BIGINT COMMENT 'Unique identifier for the primary superseded by reminder template within the scheduling reminder template record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the clinical or administrative department that owns and manages this reminder template.',
    `reminder_workforce_org_unit_id` BIGINT COMMENT 'Unique identifier for the reminder workforce org unit within the scheduling reminder template record.',
    `specialty_id` BIGINT COMMENT 'Reference to the medical specialty or service line for which this reminder template is configured.',
    `active_flag` BOOLEAN COMMENT 'The active flag of the scheduling reminder template record.',
    `approval_status` STRING COMMENT 'The approval status value classifying the scheduling reminder template record.',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this reminder template for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this reminder template was approved for production use.',
    `cancellation_instructions` STRING COMMENT 'Text instructions provided to the patient on how to cancel or reschedule the appointment, including contact information and deadlines.',
    `confirmation_deadline_hours` STRING COMMENT 'Number of hours before the appointment by which the patient must confirm, used for capacity planning and waitlist management.',
    `contact_email` STRING COMMENT 'Email address provided in the reminder for patients to contact the scheduling department or care team regarding their appointment.',
    `contact_phone` STRING COMMENT 'Phone number provided in the reminder for patients to call with questions, confirmations, or cancellations related to their appointment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reminder template record was first created in the system.',
    `delivery_channel` STRING COMMENT 'Communication channel through which the reminder is delivered to the patient or responsible party.',
    `effective_end_date` DATE COMMENT 'Date when this reminder template is no longer active and should not be used for new appointments. Null indicates no end date.',
    `effective_start_date` DATE COMMENT 'Date when this reminder template becomes active and available for use in scheduling workflows.',
    `include_copay_estimate` BOOLEAN COMMENT 'Indicates whether the reminder should include an estimated copay or out-of-pocket cost for the appointment.',
    `include_insurance_reminder` BOOLEAN COMMENT 'Indicates whether the reminder should include instructions to bring insurance cards and verify coverage before the appointment.',
    `include_provider_info` BOOLEAN COMMENT 'Indicates whether the reminder message should include provider name, credentials, and contact information.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this template is the default reminder template for its associated appointment type, specialty, or department.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the reminder message content.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling reminder template record.',
    `lead_time_days` STRING COMMENT 'The lead time days of the scheduling reminder template record.',
    `location_details` STRING COMMENT 'Detailed information about the appointment location including building name, floor, department, parking instructions, and check-in procedures.',
    `max_attempts_allowed` STRING COMMENT 'The max attempts allowed of the scheduling reminder template record.',
    `max_send_attempts` STRING COMMENT 'Maximum number of times the system should attempt to deliver the reminder if initial delivery fails.',
    `message_body` STRING COMMENT 'Full text content of the reminder message, including placeholders for dynamic data such as patient name, appointment date, location, and provider.',
    `message_subject` STRING COMMENT 'Subject line or title of the reminder message, used primarily for email and portal notifications.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this reminder template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this reminder template record was last modified in the system.',
    `notes` STRING COMMENT 'Administrative notes or comments about the reminder template, including usage guidelines, change history, or special considerations.',
    `opt_out_enabled_flag` BOOLEAN COMMENT 'The opt out enabled flag of the scheduling reminder template record.',
    `preparation_instructions` STRING COMMENT 'Clinical or administrative instructions for patient preparation before the appointment, such as fasting requirements, medication holds, or documentation to bring.',
    `priority_level` STRING COMMENT 'Priority classification of the reminder indicating urgency and importance for delivery and patient response.',
    `reminder_type` STRING COMMENT 'The reminder type value classifying the scheduling reminder template record.',
    `requires_confirmation` BOOLEAN COMMENT 'Indicates whether the reminder requires the patient to confirm or respond to the appointment notification.',
    `retry_interval_minutes` STRING COMMENT 'Number of minutes to wait between retry attempts if reminder delivery fails.',
    `send_time_preference` STRING COMMENT 'Preferred time of day (HH:MM format) when the reminder should be sent, respecting patient communication preferences and operational hours.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling reminder template record.',
    `reminder_template_status` STRING COMMENT 'Current lifecycle status of the reminder template indicating whether it is available for use in scheduling workflows.',
    `template_code` STRING COMMENT 'Unique business code or identifier for the reminder template, used for system integration and external reference.',
    `template_name` STRING COMMENT 'Human-readable name of the reminder template used for identification and selection in scheduling workflows.',
    `template_status` STRING COMMENT 'The template status value classifying the scheduling reminder template record.',
    `template_type` STRING COMMENT 'Classification of the reminder template based on the type of appointment or care event it supports.',
    `trigger_timing_days` STRING COMMENT 'Number of days before the scheduled appointment when the reminder should be sent. Negative values indicate days after the appointment.',
    `trigger_timing_hours` STRING COMMENT 'Number of hours before the scheduled appointment when the reminder should be sent, used for same-day or precise timing requirements.',
    `version_number` STRING COMMENT 'Version number of the reminder template, incremented when content or configuration is updated to maintain audit trail and change history.',
    `vibe_mutation_applied` STRING COMMENT 'Added by VIBE mutation to ensure model change',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this reminder template record.',
    CONSTRAINT pk_reminder_template PRIMARY KEY(`reminder_template_id`)
) COMMENT 'Reminder templates';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` (
    `scheduling_appointment_id` BIGINT COMMENT 'Primary key for the scheduling appointment record.',
    `appointment_type_id` BIGINT COMMENT 'FK to appointment type.',
    `care_site_id` BIGINT COMMENT 'FK to the care site where the appointment occurs.',
    `demographics_id` BIGINT COMMENT 'FK to patient demographics.',
    `encounter_authorization_id` BIGINT COMMENT 'FK to prior authorization for this appointment.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the scheduling scheduling appointment record.',
    `open_slot_id` BIGINT COMMENT 'Unique identifier for the open slot within the scheduling scheduling appointment record.',
    `referral_order_id` BIGINT COMMENT 'Unique identifier for the referral order within the scheduling scheduling appointment record.',
    `room_id` BIGINT COMMENT 'Unique identifier for the room within the scheduling scheduling appointment record.',
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource within the scheduling scheduling appointment record.',
    `clinician_id` BIGINT COMMENT 'FK to the assigned clinician.',
    `scheduling_provider_clinician_id` BIGINT COMMENT 'Unique identifier for the scheduling provider clinician within the scheduling scheduling appointment record.',
    `visit_id` BIGINT COMMENT 'FK to the resulting encounter visit.',
    `absorbed_from_appointment_flag` BOOLEAN COMMENT 'The absorbed from appointment flag of the scheduling scheduling appointment record.',
    `appointment_number` STRING COMMENT 'Human-readable appointment reference number.',
    `appointment_scope` STRING COMMENT 'The appointment scope of the scheduling scheduling appointment record.',
    `appointment_status` STRING COMMENT 'Current status of the appointment (scheduled, cancelled, completed, no-show).',
    `booking_channel` STRING COMMENT 'Channel through which the appointment was booked.',
    `booking_timestamp` TIMESTAMP COMMENT 'Timestamp when the appointment was booked.',
    `cancellation_reason` STRING COMMENT 'Reason for appointment cancellation.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Timestamp when the appointment was cancelled.',
    `care_setting` STRING COMMENT 'The care setting of the scheduling scheduling appointment record.',
    `check_in_datetime` STRING COMMENT 'Timestamp capturing the check in datetime associated with the scheduling scheduling appointment record.',
    `check_in_timestamp` TIMESTAMP COMMENT 'The check in timestamp of the scheduling scheduling appointment record.',
    `check_out_datetime` STRING COMMENT 'Timestamp capturing the check out datetime associated with the scheduling scheduling appointment record.',
    `check_out_timestamp` TIMESTAMP COMMENT 'The check out timestamp of the scheduling scheduling appointment record.',
    `confirmation_status` STRING COMMENT 'The confirmation status value classifying the scheduling scheduling appointment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `duration_minutes` STRING COMMENT 'Duration of the appointment in minutes.',
    `insurance_verification_status` STRING COMMENT 'Status of insurance eligibility verification.',
    `interpreter_required_flag` BOOLEAN COMMENT 'The interpreter required flag of the scheduling scheduling appointment record.',
    `is_telehealth` BOOLEAN COMMENT 'Boolean flag indicating the is telehealth status of the scheduling scheduling appointment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling scheduling appointment record.',
    `mrn` STRING COMMENT 'The mrn of the scheduling scheduling appointment record.',
    `mvm_ecm_reconciled_flag` BOOLEAN COMMENT 'The mvm ecm reconciled flag of the scheduling scheduling appointment record.',
    `mvm_source_names` STRING COMMENT 'scheduling.appointment aligned to scheduling.scheduling_appointment',
    `no_show_flag` BOOLEAN COMMENT 'Indicates patient did not attend the appointment.',
    `notes` STRING COMMENT 'The notes of the scheduling scheduling appointment record.',
    `reason_for_visit` STRING COMMENT 'The reason for visit of the scheduling scheduling appointment record.',
    `scheduled_date` DATE COMMENT 'Date the appointment is scheduled.',
    `scheduled_end_datetime` STRING COMMENT 'Timestamp capturing the scheduled end datetime associated with the scheduling scheduling appointment record.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Scheduled end timestamp.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'The scheduled end timestamp of the scheduling scheduling appointment record.',
    `scheduled_start_datetime` STRING COMMENT 'Timestamp capturing the scheduled start datetime associated with the scheduling scheduling appointment record.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Scheduled start timestamp.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The scheduled start timestamp of the scheduling scheduling appointment record.',
    `self_scheduled_flag` BOOLEAN COMMENT 'The self scheduled flag of the scheduling scheduling appointment record.',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the scheduling scheduling appointment record.',
    `ssot_canonical_reference` STRING COMMENT 'SSOT canonical: radiology.radiology_appointment (duplicate reconciled to canonical)',
    `telehealth_flag` BOOLEAN COMMENT 'The telehealth flag of the scheduling scheduling appointment record.',
    `telehealth_platform` STRING COMMENT 'Platform used for telehealth visit.',
    `telehealth_session_url` STRING COMMENT 'URL for the telehealth session.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last updated timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the scheduling scheduling appointment record.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'The vibe mutation flag of the scheduling scheduling appointment record.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_modality` STRING COMMENT 'Mode of visit: in-person, telehealth, phone.',
    `visit_reason` STRING COMMENT 'Patient-stated reason for the visit.',
    `visit_reason_code` STRING COMMENT 'The visit reason code value classifying the scheduling scheduling appointment record.',
    CONSTRAINT pk_scheduling_appointment PRIMARY KEY(`scheduling_appointment_id`)
) COMMENT 'Canonical scheduling appointment record (ECM superset of MVM scheduling.appointment). Tracks all appointment lifecycle events including telehealth, cancellation, and insurance verification.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_substitute_for_resource_assignment_id` FOREIGN KEY (`substitute_for_resource_assignment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_tertiary_rescheduled_appointment_scheduling_appointment_id` FOREIGN KEY (`tertiary_rescheduled_appointment_scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_reminder_template_id` FOREIGN KEY (`reminder_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`reminder_template`(`reminder_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_superseded_rule_booking_rule_id` FOREIGN KEY (`superseded_rule_booking_rule_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`booking_rule`(`booking_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_booking_requested_appointment_type_id` FOREIGN KEY (`booking_requested_appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_waitlist_entry_id` FOREIGN KEY (`waitlist_entry_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`waitlist_entry`(`waitlist_entry_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_resource_assignment_id` FOREIGN KEY (`resource_assignment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_parent_reminder_template_id` FOREIGN KEY (`parent_reminder_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`reminder_template`(`reminder_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_primary_superseded_by_reminder_template_id` FOREIGN KEY (`primary_superseded_by_reminder_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`reminder_template`(`reminder_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('pii_domain' = 'scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_configuration' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `board_certification_id` SET TAGS ('pii_business_glossary_term' = 'Board Certification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cdm_entry_id` SET TAGS ('pii_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_self_scheduling` SET TAGS ('pii_business_glossary_term' = 'Self Scheduling Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_business_glossary_term' = 'Telehealth Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('pii_business_glossary_term' = 'Billing Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_business_glossary_term' = 'Cancellation Notice Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_category` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `default_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_description` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `equipment_required` SET TAGS ('pii_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `maximum_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Maximum Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `minimum_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Minimum Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `no_show_penalty_applies` SET TAGS ('pii_business_glossary_term' = 'No Show Penalty Applies');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `preparation_instructions` SET TAGS ('pii_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `quality_measure_applicable` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Reminder Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_interpreter` SET TAGS ('pii_business_glossary_term' = 'Requires Interpreter');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_referral` SET TAGS ('pii_business_glossary_term' = 'Requires Referral');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `room_type_required` SET TAGS ('pii_business_glossary_term' = 'Room Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_malpractice` SET TAGS ('pii_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_practice_expense` SET TAGS ('pii_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_work` SET TAGS ('pii_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `staff_roles_required` SET TAGS ('pii_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `visit_type_code` SET TAGS ('pii_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `waitlist_eligible` SET TAGS ('pii_business_glossary_term' = 'Waitlist Eligible');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_configuration' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_capacity' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedule_template_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedulable_resource_id` SET TAGS ('pii_business_glossary_term' = 'Schedulable Resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `tertiary_schedule_approved_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `tertiary_schedule_approved_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `tertiary_schedule_approved_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `appointment_type_code` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `auto_confirm_flag` SET TAGS ('pii_business_glossary_term' = 'Auto Confirm');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `buffer_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Buffer Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `day_of_week` SET TAGS ('pii_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `insurance_type_accepted` SET TAGS ('pii_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `max_slots_per_session` SET TAGS ('pii_business_glossary_term' = 'Max Slots Per Session');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `no_show_tracking_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'No Show Tracking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Overbooking Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_limit` SET TAGS ('pii_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_rule` SET TAGS ('pii_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Reminder Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_lead_time_hours` SET TAGS ('pii_business_glossary_term' = 'Reminder Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `service_type_code` SET TAGS ('pii_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Session Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_end_time` SET TAGS ('pii_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_start_time` SET TAGS ('pii_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Slot Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('pii_business_glossary_term' = 'Template Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('pii_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Waitlist Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_capacity' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_availability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `open_slot_id` SET TAGS ('pii_business_glossary_term' = 'Open Slot ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedule_template_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Template');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `appointment_type_eligibility` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_reason` SET TAGS ('pii_business_glossary_term' = 'Block Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('pii_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `comment` SET TAGS ('pii_business_glossary_term' = 'Comment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('pii_business_glossary_term' = 'Hold Expiration Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_reason` SET TAGS ('pii_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('pii_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('pii_business_glossary_term' = 'Insurance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `last_modified_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_business_glossary_term' = 'Max Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_cutoff_hours` SET TAGS ('pii_business_glossary_term' = 'Online Booking Cutoff Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Online Booking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `overbook_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Overbook Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('pii_business_glossary_term' = 'Patient Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_category` SET TAGS ('pii_business_glossary_term' = 'Slot Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Slot Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Slot End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_business_glossary_term' = 'Slot Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Slot Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('pii_business_glossary_term' = 'Slot Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_type` SET TAGS ('pii_business_glossary_term' = 'Slot Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Waitlist Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_surgery' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_perioperative' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `capital_project_id` SET TAGS ('pii_business_glossary_term' = 'Capital Project');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'OR Suite');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Pre-Op Diagnosis ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Primary Procedure CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `privileging_id` SET TAGS ('pii_business_glossary_term' = 'Privileging');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Event');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `research_study_id` SET TAGS ('pii_business_glossary_term' = 'Research Study');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `surgical_bom_id` SET TAGS ('pii_business_glossary_term' = 'Surgical BOM');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_business_glossary_term' = 'Treatment Consent');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Actual Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_end_time` SET TAGS ('pii_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_start_time` SET TAGS ('pii_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `add_on_case_indicator` SET TAGS ('pii_business_glossary_term' = 'Add-On Case');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('pii_business_glossary_term' = 'ASA Classification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_business_glossary_term' = 'Block Owner NPI');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_time_indicator` SET TAGS ('pii_business_glossary_term' = 'Block Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_status` SET TAGS ('pii_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('pii_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Consent Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `equipment_requirements` SET TAGS ('pii_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `facility_code` SET TAGS ('pii_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `implant_required` SET TAGS ('pii_business_glossary_term' = 'Implant Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('pii_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'MRN');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_business_glossary_term' = 'Post-Op Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_business_glossary_term' = 'Requires Blood Products');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_icu_bed` SET TAGS ('pii_business_glossary_term' = 'Requires ICU Bed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_end_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_start_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary Procedure Codes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `secondary_procedure_codes` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `service_line` SET TAGS ('pii_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `site_marked_indicator` SET TAGS ('pii_business_glossary_term' = 'Site Marked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `timeout_completed_indicator` SET TAGS ('pii_business_glossary_term' = 'Timeout Completed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('pii_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_surgery' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_capacity' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `or_block_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Owner Surgeon ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `contract_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Suite ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `service_id` SET TAGS ('pii_business_glossary_term' = 'Owner Service ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Target Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Owner Department ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_overbooking` SET TAGS ('pii_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_sharing` SET TAGS ('pii_business_glossary_term' = 'Allows Sharing Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `anesthesia_type_required` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Block Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_end_time` SET TAGS ('pii_business_glossary_term' = 'Block End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_business_glossary_term' = 'Block Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_number` SET TAGS ('pii_business_glossary_term' = 'Block Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('pii_business_glossary_term' = 'Block Owner Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('pii_value_regex' = 'service|surgeon|specialty|department|open');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_start_time` SET TAGS ('pii_business_glossary_term' = 'Block Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('pii_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('pii_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('pii_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary|open|flex|call');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `day_of_week` SET TAGS ('pii_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `equipment_set_required` SET TAGS ('pii_business_glossary_term' = 'Equipment Set Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `minimum_utilization_threshold_pct` SET TAGS ('pii_business_glossary_term' = 'Minimum Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `owner_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Owner Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `priority_rank` SET TAGS ('pii_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `recurring_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurring Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Release Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_hours` SET TAGS ('pii_business_glossary_term' = 'Release Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('pii_business_glossary_term' = 'Release Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('pii_value_regex' = 'days_before|hours_before|no_release|manual');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `staff_roles_required` SET TAGS ('pii_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `target_utilization_threshold_pct` SET TAGS ('pii_business_glossary_term' = 'Target Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_resource' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_capacity' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `schedulable_resource_id` SET TAGS ('pii_business_glossary_term' = 'Schedulable Resource Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('pii_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `allows_overbooking` SET TAGS ('pii_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `building` SET TAGS ('pii_business_glossary_term' = 'Building Name or Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'active|pending|expired|suspended|revoked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Default Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `floor` SET TAGS ('pii_business_glossary_term' = 'Floor Number or Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_end` SET TAGS ('pii_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_start` SET TAGS ('pii_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `minimum_turnover_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Minimum Turnover Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `overbooking_limit` SET TAGS ('pii_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `provider_type` SET TAGS ('pii_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_code` SET TAGS ('pii_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('pii_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('pii_value_regex' = 'provider|room|equipment|care_team');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_business_glossary_term' = 'Room Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('pii_business_glossary_term' = 'Room Configuration Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_constraints` SET TAGS ('pii_business_glossary_term' = 'Scheduling Constraints');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('pii_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('pii_value_regex' = 'active|inactive|maintenance|reserved|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_cycle_required` SET TAGS ('pii_business_glossary_term' = 'Sterilization Cycle Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Sterilization Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `unit` SET TAGS ('pii_business_glossary_term' = 'Unit or Wing');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_resource' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_assignment' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Resource Assignment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Staff Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `study_visit_id` SET TAGS ('pii_business_glossary_term' = 'Study Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `substitute_for_resource_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Substitute For Resource Assignment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `tertiary_resource_requested_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requested By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `tertiary_resource_requested_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `tertiary_resource_requested_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('pii_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('pii_value_regex' = 'routine|urgent|emergent|elective|stat');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('pii_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `charge_code` SET TAGS ('pii_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_datetime` SET TAGS ('pii_business_glossary_term' = 'Confirmation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('pii_value_regex' = 'pending|confirmed|declined|tentative|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_description` SET TAGS ('pii_business_glossary_term' = 'Conflict Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_flag` SET TAGS ('pii_business_glossary_term' = 'Conflict Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_tag` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('pii_business_glossary_term' = 'Equipment Reservation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('pii_value_regex' = 'reserved|allocated|in_use|returned|unavailable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_modified_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `maintenance_clearance_flag` SET TAGS ('pii_business_glossary_term' = 'Maintenance Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `no_show_flag` SET TAGS ('pii_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `privilege_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `requested_datetime` SET TAGS ('pii_business_glossary_term' = 'Requested Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('pii_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('pii_value_regex' = 'provider|room|equipment|staff|care_team_member|anesthesia_resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_batch_number` SET TAGS ('pii_business_glossary_term' = 'Sterilization Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_clearance_flag` SET TAGS ('pii_business_glossary_term' = 'Sterilization Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_waitlist' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_access' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `waitlist_entry_id` SET TAGS ('pii_business_glossary_term' = 'Waitlist Entry Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Requested Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Scheduler User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_business_glossary_term' = 'Population Health Gap Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Requested Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Requested Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `referral_order_id` SET TAGS ('pii_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduled Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_number` SET TAGS ('pii_business_glossary_term' = 'Waitlist Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('pii_business_glossary_term' = 'Waitlist Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('pii_value_regex' = 'waitlist|referral_queue|order_based|recall|surgical_request|work_queue');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_datetime` SET TAGS ('pii_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_reason` SET TAGS ('pii_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `estimated_wait_time_days` SET TAGS ('pii_business_glossary_term' = 'Estimated Wait Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_modified_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Waitlist Entry Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `outreach_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_days_of_week` SET TAGS ('pii_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `queue_entry_datetime` SET TAGS ('pii_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_datetime` SET TAGS ('pii_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('pii_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduled_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `sla_target_datetime` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_required` SET TAGS ('pii_business_glossary_term' = 'Specialty Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('pii_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason` SET TAGS ('pii_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason_code` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_history' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `appointment_status_history_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Status History ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `tertiary_rescheduled_appointment_scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Rescheduled Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `advance_notice_hours` SET TAGS ('pii_business_glossary_term' = 'Advance Notice Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `appointment_number` SET TAGS ('pii_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `audit_required` SET TAGS ('pii_business_glossary_term' = 'Audit Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `backfill_indicator` SET TAGS ('pii_business_glossary_term' = 'Backfill Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `comment` SET TAGS ('pii_business_glossary_term' = 'Status Transition Comment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('pii_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `financial_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `hedis_measure_applicable` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Measure Applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `hedis_measure_code` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_role` SET TAGS ('pii_business_glossary_term' = 'Initiated By User Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_business_glossary_term' = 'Initiated By User Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `initiated_by_user_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `new_status` SET TAGS ('pii_business_glossary_term' = 'New Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `no_show_penalty_amount` SET TAGS ('pii_business_glossary_term' = 'No-Show Penalty Amount');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `no_show_penalty_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `no_show_penalty_applied` SET TAGS ('pii_business_glossary_term' = 'No-Show Penalty Applied');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Waitlist Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `patient_contact_method` SET TAGS ('pii_business_glossary_term' = 'Patient Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `patient_contact_method` SET TAGS ('pii_value_regex' = 'phone|email|sms|portal_message|mail|none');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `patient_contacted_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Contacted Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `patient_response` SET TAGS ('pii_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `prior_status` SET TAGS ('pii_business_glossary_term' = 'Prior Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `quality_measure_impact` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Impact');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `quality_measure_impact` SET TAGS ('pii_value_regex' = 'positive|negative|neutral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `reason_category` SET TAGS ('pii_business_glossary_term' = 'Transition Reason Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `regulatory_reportable` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reportable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `system_generated` SET TAGS ('pii_business_glossary_term' = 'System Generated Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('pii_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('pii_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `transition_source` SET TAGS ('pii_business_glossary_term' = 'Status Transition Source');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `waitlist_notification_sent` SET TAGS ('pii_business_glossary_term' = 'Waitlist Notification Sent Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_status_history` ALTER COLUMN `within_policy_window` SET TAGS ('pii_business_glossary_term' = 'Within Policy Window Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_communication' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_reminder' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_reminder_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Reminder Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `direct_message_id` SET TAGS ('pii_business_glossary_term' = 'Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `reminder_template_id` SET TAGS ('pii_business_glossary_term' = 'Reminder Template Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `actual_send_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Send Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_date` SET TAGS ('pii_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_time` SET TAGS ('pii_business_glossary_term' = 'Appointment Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `attempt_number` SET TAGS ('pii_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `campaign_code` SET TAGS ('pii_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `cost_per_reminder` SET TAGS ('pii_business_glossary_term' = 'Cost Per Reminder');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `cost_per_reminder` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_channel` SET TAGS ('pii_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_channel` SET TAGS ('pii_value_regex' = 'phone|sms|email|patient_portal|ivr|push_notification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_failure_reason` SET TAGS ('pii_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `language_code` SET TAGS ('pii_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `max_attempts_allowed` SET TAGS ('pii_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `message_content` SET TAGS ('pii_business_glossary_term' = 'Message Content');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `message_content` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `opt_out_datetime` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('pii_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('pii_value_regex' = 'confirmed|cancelled|rescheduled|no_response|opted_out');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `provider_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `reminder_type` SET TAGS ('pii_business_glossary_term' = 'Reminder Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `reminder_type` SET TAGS ('pii_value_regex' = 'initial|first_reminder|second_reminder|final_reminder|confirmation_request|pre_visit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_channel` SET TAGS ('pii_business_glossary_term' = 'Response Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_channel` SET TAGS ('pii_value_regex' = 'phone|sms|email|patient_portal|ivr|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_datetime` SET TAGS ('pii_business_glossary_term' = 'Response Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `scheduled_send_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Send Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_analytics' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_capacity' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Utilization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `or_block_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `schedulable_resource_id` SET TAGS ('pii_business_glossary_term' = 'Schedulable Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `access_days` SET TAGS ('pii_business_glossary_term' = 'Access Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `actual_case_volume` SET TAGS ('pii_business_glossary_term' = 'Actual Case Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `actual_utilization_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Actual Utilization Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `actual_visit_volume` SET TAGS ('pii_business_glossary_term' = 'Actual Visit Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `add_on_case_count` SET TAGS ('pii_business_glossary_term' = 'Add-On Case Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `available_fte` SET TAGS ('pii_business_glossary_term' = 'Available Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `available_hours` SET TAGS ('pii_business_glossary_term' = 'Available Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `available_minutes` SET TAGS ('pii_business_glossary_term' = 'Available Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_business_glossary_term' = 'Cancellation Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `cancellation_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'outpatient|inpatient|emergency|surgical|procedural|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `first_case_on_time_start_flag` SET TAGS ('pii_business_glossary_term' = 'First Case On-Time Start Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `no_show_count` SET TAGS ('pii_business_glossary_term' = 'No-Show Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `overbooking_count` SET TAGS ('pii_business_glossary_term' = 'Overbooking Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|completed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'capacity_planning|or_block_utilization|resource_utilization|variance_analysis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `planning_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `planning_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `reallocation_recommendation` SET TAGS ('pii_business_glossary_term' = 'Reallocation Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `released_minutes` SET TAGS ('pii_business_glossary_term' = 'Released Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `scheduled_hours` SET TAGS ('pii_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `scheduled_minutes` SET TAGS ('pii_business_glossary_term' = 'Scheduled Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `capacity_utilization_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `target_case_volume` SET TAGS ('pii_business_glossary_term' = 'Target Case Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `target_utilization_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Target Utilization Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `target_visit_volume` SET TAGS ('pii_business_glossary_term' = 'Target Visit Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `trend_indicator` SET TAGS ('pii_business_glossary_term' = 'Trend Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `trend_indicator` SET TAGS ('pii_value_regex' = 'increasing|decreasing|stable|volatile');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `turnover_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Turnover Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `utilized_hours` SET TAGS ('pii_business_glossary_term' = 'Utilized Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `utilized_minutes` SET TAGS ('pii_business_glossary_term' = 'Utilized Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `variance_hours` SET TAGS ('pii_business_glossary_term' = 'Variance Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `variance_utilization_pct` SET TAGS ('pii_business_glossary_term' = 'Variance Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `variance_volume` SET TAGS ('pii_business_glossary_term' = 'Variance Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`capacity_utilization` ALTER COLUMN `waitlist_volume` SET TAGS ('pii_business_glossary_term' = 'Waitlist Volume');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_analytics' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_surgery' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_utilization_id` SET TAGS ('pii_business_glossary_term' = 'Block Utilization ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Owner Surgeon ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Released By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `or_block_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Suite ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `service_id` SET TAGS ('pii_business_glossary_term' = 'Owner Service ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `add_on_case_count` SET TAGS ('pii_business_glossary_term' = 'Add-On Case Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `allocated_minutes` SET TAGS ('pii_business_glossary_term' = 'Allocated Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `average_turnover_minutes` SET TAGS ('pii_business_glossary_term' = 'Average Turnover Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_overrun_minutes` SET TAGS ('pii_business_glossary_term' = 'Block Overrun Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_owner_type` SET TAGS ('pii_business_glossary_term' = 'Block Owner Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_owner_type` SET TAGS ('pii_value_regex' = 'surgeon|service|department|specialty|shared|unassigned');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_reallocation_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Block Reallocation Risk Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_status` SET TAGS ('pii_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `block_status` SET TAGS ('pii_value_regex' = 'utilized|partially_utilized|unutilized|released|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_business_glossary_term' = 'Cancelled Case Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cancelled_case_count` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `completed_case_count` SET TAGS ('pii_business_glossary_term' = 'Completed Case Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `first_case_delay_minutes` SET TAGS ('pii_business_glossary_term' = 'First Case Delay Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `first_case_on_time_start_flag` SET TAGS ('pii_business_glossary_term' = 'First Case On-Time Start Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `meets_utilization_threshold_flag` SET TAGS ('pii_business_glossary_term' = 'Meets Utilization Threshold Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `owner_specialty_code` SET TAGS ('pii_business_glossary_term' = 'Owner Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `prime_time_flag` SET TAGS ('pii_business_glossary_term' = 'Prime Time Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_business_glossary_term' = 'Procedure Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `procedure_minutes` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `release_timestamp` SET TAGS ('pii_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `released_minutes` SET TAGS ('pii_business_glossary_term' = 'Released Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `scheduled_case_count` SET TAGS ('pii_business_glossary_term' = 'Scheduled Case Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `scheduled_minutes` SET TAGS ('pii_business_glossary_term' = 'Scheduled Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `target_utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Target Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `turnover_minutes` SET TAGS ('pii_business_glossary_term' = 'Turnover Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `unutilized_minutes` SET TAGS ('pii_business_glossary_term' = 'Unutilized Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `used_minutes` SET TAGS ('pii_business_glossary_term' = 'Used Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `utilization_date` SET TAGS ('pii_business_glossary_term' = 'Utilization Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `utilization_percentage` SET TAGS ('pii_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `utilization_variance_percentage` SET TAGS ('pii_business_glossary_term' = 'Utilization Variance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`block_utilization` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_configuration' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_rules' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `booking_rule_id` SET TAGS ('pii_business_glossary_term' = 'Booking Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `compliance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `superseded_rule_booking_rule_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Rule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_surgical_cases` SET TAGS ('pii_business_glossary_term' = 'Applies to Surgical Cases Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_business_glossary_term' = 'Applies to Telehealth Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `applies_to_telehealth` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `conflict_rule_type` SET TAGS ('pii_business_glossary_term' = 'Conflict Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `conflict_rule_type` SET TAGS ('pii_value_regex' = 'same_day_block|same_week_block|concurrent_block|sequential_required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `double_booking_allowed` SET TAGS ('pii_business_glossary_term' = 'Double Booking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `enforcement_mode` SET TAGS ('pii_business_glossary_term' = 'Enforcement Mode');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `enforcement_mode` SET TAGS ('pii_value_regex' = 'hard_block|soft_warning|advisory');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_value_regex' = 'male|female|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `gender_restriction` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `insurance_type_required` SET TAGS ('pii_business_glossary_term' = 'Insurance Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `maximum_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Maximum Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `maximum_patient_age_years` SET TAGS ('pii_business_glossary_term' = 'Maximum Patient Age Years');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `minimum_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Minimum Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `minimum_patient_age_years` SET TAGS ('pii_business_glossary_term' = 'Minimum Patient Age Years');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `overbooking_limit` SET TAGS ('pii_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `override_authority_level` SET TAGS ('pii_business_glossary_term' = 'Override Authority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `override_authority_level` SET TAGS ('pii_value_regex' = 'staff|supervisor|physician|administrator|system');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `patient_class` SET TAGS ('pii_value_regex' = 'new|established|follow_up|consultation|referral');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `required_pre_visit_orders` SET TAGS ('pii_business_glossary_term' = 'Required Pre-Visit Orders');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `requires_prior_authorization` SET TAGS ('pii_business_glossary_term' = 'Requires Prior Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `requires_referral` SET TAGS ('pii_business_glossary_term' = 'Requires Referral Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_category` SET TAGS ('pii_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_category` SET TAGS ('pii_value_regex' = 'temporal|clinical|administrative|financial|operational|regulatory');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_description` SET TAGS ('pii_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_priority` SET TAGS ('pii_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|draft|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `rule_type` SET TAGS ('pii_value_regex' = 'lead_time|eligibility|constraint|prerequisite|conflict|capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `same_day_booking_allowed` SET TAGS ('pii_business_glossary_term' = 'Same Day Booking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `self_scheduling_allowed` SET TAGS ('pii_business_glossary_term' = 'Self Scheduling Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_rule` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_patient' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_preference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `patient_preference_id` SET TAGS ('pii_business_glossary_term' = 'Patient Preference Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `tertiary_patient_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `tertiary_patient_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `tertiary_patient_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `accessibility_needs` SET TAGS ('pii_business_glossary_term' = 'Accessibility Needs');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `accessibility_needs` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `advance_notice_days` SET TAGS ('pii_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_business_glossary_term' = 'Care Setting Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_value_regex' = 'outpatient|ambulatory|home|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `care_setting_preference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `gender_preference_provider` SET TAGS ('pii_business_glossary_term' = 'Gender Preference for Provider');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `gender_preference_provider` SET TAGS ('pii_value_regex' = 'male|female|no_preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `gender_preference_provider` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `gender_preference_provider` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `group_visit_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Group Visit Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `opt_out_reminders_flag` SET TAGS ('pii_business_glossary_term' = 'Opt Out Reminders Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_notes` SET TAGS ('pii_business_glossary_term' = 'Preference Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_source` SET TAGS ('pii_business_glossary_term' = 'Preference Source');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_source` SET TAGS ('pii_value_regex' = 'patient_portal|call_center|registration|provider_entry|system_default');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_status` SET TAGS ('pii_business_glossary_term' = 'Preference Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_status` SET TAGS ('pii_value_regex' = 'active|inactive|expired|superseded');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_type` SET TAGS ('pii_business_glossary_term' = 'Preference Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preference_type` SET TAGS ('pii_value_regex' = 'provider|location|time|communication|access|general');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_value_regex' = 'phone|email|sms|portal|mail|none');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_days_of_week` SET TAGS ('pii_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_visit_modality` SET TAGS ('pii_business_glossary_term' = 'Preferred Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `preferred_visit_modality` SET TAGS ('pii_value_regex' = 'in_person|telehealth|phone|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Reminder Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `same_day_appointment_preference` SET TAGS ('pii_business_glossary_term' = 'Same Day Appointment Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `same_day_appointment_preference` SET TAGS ('pii_value_regex' = 'preferred|acceptable|not_preferred');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `scheduling_priority_level` SET TAGS ('pii_business_glossary_term' = 'Scheduling Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `scheduling_priority_level` SET TAGS ('pii_value_regex' = 'routine|urgent|expedited|standard');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `specialty_preference` SET TAGS ('pii_business_glossary_term' = 'Specialty Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_business_glossary_term' = 'Telehealth Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_value_regex' = 'preferred|acceptable|not_preferred|not_available');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `telehealth_preference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('pii_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`patient_preference` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_telehealth' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_virtual' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Telehealth Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_authorization_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_business_glossary_term' = 'Telehealth Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_consent_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Billing Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_modifier_code` SET TAGS ('pii_business_glossary_term' = 'Billing Modifier Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_business_glossary_term' = 'Cancelled By Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_value_regex' = 'patient|provider|staff|system');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_quality_score` SET TAGS ('pii_business_glossary_term' = 'Connection Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('pii_business_glossary_term' = 'Technical Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('pii_value_regex' = 'connected|disconnected|poor_quality|reconnected|failed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_datetime` SET TAGS ('pii_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_obtained_flag` SET TAGS ('pii_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `distant_site_code` SET TAGS ('pii_business_glossary_term' = 'Distant Site Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_language` SET TAGS ('pii_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_present_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `last_modified_datetime` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `no_show_flag` SET TAGS ('pii_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_business_glossary_term' = 'Originating Site Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_browser` SET TAGS ('pii_business_glossary_term' = 'Patient Web Browser');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('pii_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('pii_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_business_glossary_term' = 'Patient Operating System');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_vendor` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform Vendor');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_datetime` SET TAGS ('pii_business_glossary_term' = 'Provider Attestation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('pii_business_glossary_term' = 'Provider Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('pii_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `recording_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Recording Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Scheduled Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Access Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_number` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('pii_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show|technical_failure');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('pii_value_regex' = 'video|phone|asynchronous|chat|remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_description` SET TAGS ('pii_business_glossary_term' = 'Technical Issue Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_reported_flag` SET TAGS ('pii_business_glossary_term' = 'Technical Issue Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_recall' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_outreach' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_list_id` SET TAGS ('pii_business_glossary_term' = 'Recall List Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `care_plan_id` SET TAGS ('pii_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `icd_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `eligibility_id` SET TAGS ('pii_business_glossary_term' = 'Claim Eligibility Verification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Care Manager Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_business_glossary_term' = 'Population Health Gap Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `population_health_gap_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `problem_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduled Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `aco_attributed` SET TAGS ('pii_business_glossary_term' = 'Accountable Care Organization (ACO) Attributed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `appointment_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Appointment Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `care_gap_registry_code` SET TAGS ('pii_business_glossary_term' = 'Care Gap Registry Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_business_glossary_term' = 'Clinical Basis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `clinical_basis` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `cms_quality_program` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Quality Program');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `gap_closure_evidence` SET TAGS ('pii_business_glossary_term' = 'Gap Closure Evidence');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `hedis_measure_code` SET TAGS ('pii_business_glossary_term' = 'Healthcare Effectiveness Data and Information Set (HEDIS) Measure Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `interpreter_required` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `last_outreach_date` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_value_regex' = 'phone|mail|patient_portal|text_message|email|in_person');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `last_service_date` SET TAGS ('pii_business_glossary_term' = 'Last Service Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `outreach_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `patient_response` SET TAGS ('pii_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `patient_response` SET TAGS ('pii_value_regex' = 'no_response|agreed_to_schedule|declined|requested_callback|wrong_contact_info|deceased');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `patient_response_date` SET TAGS ('pii_business_glossary_term' = 'Patient Response Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'routine|high|urgent|critical');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `quality_measure_numerator_eligible` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Numerator Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_category` SET TAGS ('pii_business_glossary_term' = 'Recall Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_completion_date` SET TAGS ('pii_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Recall Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_interval_months` SET TAGS ('pii_business_glossary_term' = 'Recall Interval in Months');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_reason` SET TAGS ('pii_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_reason_code` SET TAGS ('pii_business_glossary_term' = 'Recall Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `recall_status` SET TAGS ('pii_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `star_measure_applicable` SET TAGS ('pii_business_glossary_term' = 'STAR Measure Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `target_recall_date` SET TAGS ('pii_business_glossary_term' = 'Target Recall Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `transportation_assistance_needed` SET TAGS ('pii_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`recall_list` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_subdomain' = 'capacity_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_provider' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_availability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_availability_id` SET TAGS ('pii_business_glossary_term' = 'Provider Availability ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `schedule_template_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `tertiary_provider_cancelled_by_user_employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('pii_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('pii_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('pii_value_regex' = 'active|cancelled|pending|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('pii_business_glossary_term' = 'Availability Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('pii_value_regex' = 'scheduled|on_call|blocked|vacation|cme|administrative');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `booked_appointments` SET TAGS ('pii_business_glossary_term' = 'Booked Appointments Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `coverage_area` SET TAGS ('pii_business_glossary_term' = 'Coverage Area');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('pii_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('pii_value_regex' = 'active|pending|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `end_datetime` SET TAGS ('pii_business_glossary_term' = 'Availability End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('pii_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `max_appointments` SET TAGS ('pii_business_glossary_term' = 'Maximum Appointments');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('pii_business_glossary_term' = 'On-Call Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('pii_value_regex' = 'primary|backup|home|hospital');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_allowed` SET TAGS ('pii_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_limit` SET TAGS ('pii_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `override_flag` SET TAGS ('pii_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('pii_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('pii_value_regex' = 'inpatient|outpatient|observation|emergency|surgical|same_day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `privilege_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_end_date` SET TAGS ('pii_business_glossary_term' = 'Recurrence End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('pii_value_regex' = 'once|daily|weekly|biweekly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `start_datetime` SET TAGS ('pii_business_glossary_term' = 'Availability Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason` SET TAGS ('pii_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason_code` SET TAGS ('pii_business_glossary_term' = 'Unavailability Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_surgery' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_team' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_case_team_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Team ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `tertiary_surgical_cancelled_by_user_employee_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `training_completion_id` SET TAGS ('pii_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_business_glossary_term' = 'Anesthesiologist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `anesthesiologist_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_priority` SET TAGS ('pii_business_glossary_term' = 'Assignment Priority Rank');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'scheduled|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_business_glossary_term' = 'Assisting Surgeon National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `assisting_surgeon_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `billing_modifier_code` SET TAGS ('pii_business_glossary_term' = 'Billing Modifier Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `board_certification_status` SET TAGS ('pii_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `board_certification_status` SET TAGS ('pii_value_regex' = 'certified|not_certified|expired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `call_status` SET TAGS ('pii_business_glossary_term' = 'Call Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `call_status` SET TAGS ('pii_value_regex' = 'scheduled|on_call|backup|emergency');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_datetime` SET TAGS ('pii_business_glossary_term' = 'Confirmation Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_status` SET TAGS ('pii_value_regex' = 'pending|confirmed|declined|tentative');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `conflict_description` SET TAGS ('pii_business_glossary_term' = 'Conflict Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `conflict_flag` SET TAGS ('pii_business_glossary_term' = 'Scheduling Conflict Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verification Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_business_glossary_term' = 'License State Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `participation_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Participation Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_role_flag` SET TAGS ('pii_business_glossary_term' = 'Primary Role Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_business_glossary_term' = 'Primary Surgeon Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_business_glossary_term' = 'Primary Surgeon National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `privilege_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `quality_measure_applicable_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_business_glossary_term' = 'Replacement Team Member National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `requested_datetime` SET TAGS ('pii_business_glossary_term' = 'Requested Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `scrub_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Scrub Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Medical Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Supervising Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `teaching_case_flag` SET TAGS ('pii_business_glossary_term' = 'Teaching Case Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_business_glossary_term' = 'Team Member Full Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_code` SET TAGS ('pii_business_glossary_term' = 'Team Role Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_code` SET TAGS ('pii_value_regex' = 'SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_description` SET TAGS ('pii_business_glossary_term' = 'Team Role Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `time_in_room_minutes` SET TAGS ('pii_business_glossary_term' = 'Time In Operating Room (OR) Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case_team` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_queue' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_workflow' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `booking_queue_id` SET TAGS ('pii_business_glossary_term' = 'Booking Queue Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `booking_requested_appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Requested Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `diagnosis_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `insurance_coverage_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `primary_booking_clinician_id` SET TAGS ('pii_business_glossary_term' = 'Referring Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Scheduler User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `primary_booking_requested_department_workforce_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Requested Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduled Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `subject_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `aging_days` SET TAGS ('pii_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `assigned_to_user_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `authorization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_value_regex' = 'outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `escalation_datetime` SET TAGS ('pii_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `escalation_reason` SET TAGS ('pii_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `interpreter_required_flag` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `language_preference` SET TAGS ('pii_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `last_outreach_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `last_outreach_method` SET TAGS ('pii_value_regex' = 'phone|email|sms|patient_portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Queue Entry Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `outreach_attempt_count` SET TAGS ('pii_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_value_regex' = 'phone|email|sms|patient_portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `preferred_days_of_week` SET TAGS ('pii_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `preferred_time_of_day` SET TAGS ('pii_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'stat|urgent|routine|elective');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_entry_datetime` SET TAGS ('pii_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_number` SET TAGS ('pii_business_glossary_term' = 'Queue Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_status` SET TAGS ('pii_business_glossary_term' = 'Queue Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|scheduled|escalated|closed|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_type` SET TAGS ('pii_business_glossary_term' = 'Queue Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `queue_type` SET TAGS ('pii_value_regex' = 'referral|order_based|recall|surgical_request|follow_up|new_patient');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `record_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `removal_datetime` SET TAGS ('pii_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `removal_reason` SET TAGS ('pii_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `routing_rule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `scheduled_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `sla_target_datetime` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `specialty_required` SET TAGS ('pii_business_glossary_term' = 'Specialty Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('pii_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `visit_reason` SET TAGS ('pii_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`booking_queue` ALTER COLUMN `visit_reason_code` SET TAGS ('pii_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_equipment' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_resource' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `equipment_reservation_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Reservation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Requesting Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `fixed_asset_id` SET TAGS ('pii_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'Operating Room (OR) Suite Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Confirmed By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_business_glossary_term' = 'Procedure Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_event_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Reserved Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `tertiary_equipment_requested_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requested By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `tertiary_equipment_requested_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `tertiary_equipment_requested_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `actual_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancellation_reason_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `cancelled_datetime` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `charge_code` SET TAGS ('pii_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `confirmation_datetime` SET TAGS ('pii_business_glossary_term' = 'Confirmation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `confirmation_status` SET TAGS ('pii_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `confirmation_status` SET TAGS ('pii_value_regex' = 'pending|confirmed|declined|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `conflict_description` SET TAGS ('pii_business_glossary_term' = 'Conflict Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `conflict_flag` SET TAGS ('pii_business_glossary_term' = 'Reservation Conflict Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Reservation Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `equipment_asset_tag` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset Tag Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `equipment_type` SET TAGS ('pii_business_glossary_term' = 'Equipment Type Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `maintenance_clearance_flag` SET TAGS ('pii_business_glossary_term' = 'Maintenance Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Reservation Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_business_glossary_term' = 'Procedure Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `procedure_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requested_datetime` SET TAGS ('pii_business_glossary_term' = 'Requested Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_business_glossary_term' = 'Requesting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `reservation_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Reservation Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `reservation_priority` SET TAGS ('pii_business_glossary_term' = 'Reservation Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `reservation_priority` SET TAGS ('pii_value_regex' = 'routine|urgent|emergent|elective|stat');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `reservation_status` SET TAGS ('pii_business_glossary_term' = 'Reservation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `specialty_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `sterilization_batch_number` SET TAGS ('pii_business_glossary_term' = 'Sterilization Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `sterilization_clearance_datetime` SET TAGS ('pii_business_glossary_term' = 'Sterilization Clearance Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `sterilization_required_flag` SET TAGS ('pii_business_glossary_term' = 'Sterilization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`equipment_reservation` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_subdomain' = 'surgical_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_association_edges' = 'scheduling.surgical_case,supply.material_master');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_surgery' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_supply' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `case_material_usage_id` SET TAGS ('pii_business_glossary_term' = 'Case Material Usage Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Documented By User');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Case Material Usage - Material Master Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `surgical_case_id` SET TAGS ('pii_business_glossary_term' = 'Case Material Usage - Surgical Case Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `charge_code` SET TAGS ('pii_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `implant_flag` SET TAGS ('pii_business_glossary_term' = 'Implant Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `quantity_used` SET TAGS ('pii_business_glossary_term' = 'Quantity Used');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `usage_timestamp` SET TAGS ('pii_business_glossary_term' = 'Usage Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`case_material_usage` ALTER COLUMN `waste_flag` SET TAGS ('pii_business_glossary_term' = 'Waste Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_association_edges' = 'scheduling.appointment_type,insurance.prior_auth_rule');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_authorization' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `appointment_prior_auth_requirement_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Prior Auth Requirement ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Prior Auth Requirement - Appointment Type Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Prior Auth Requirement - Prior Auth Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `appointment_prior_auth_requirement_status` SET TAGS ('pii_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Reference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Created Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `diagnosis_icd_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `procedure_cpt_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `requires_prior_authorization` SET TAGS ('pii_business_glossary_term' = 'Requires Prior Authorization Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'PA Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Requirement Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `turnaround_time_hours` SET TAGS ('pii_business_glossary_term' = 'PA Turnaround Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_prior_auth_requirement` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_subdomain' = 'patient_engagement');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_scheduling' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_communication' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_template' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `reminder_template_id` SET TAGS ('pii_business_glossary_term' = 'Reminder Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `parent_reminder_template_id` SET TAGS ('pii_business_glossary_term' = 'Parent Reminder Template Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `parent_reminder_template_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `specialty_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_business_glossary_term' = 'Cancellation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `cancellation_instructions` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_business_glossary_term' = 'Confirmation Deadline Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `confirmation_deadline_hours` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `delivery_channel` SET TAGS ('pii_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `include_copay_estimate` SET TAGS ('pii_business_glossary_term' = 'Include Copay Estimate');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `include_insurance_reminder` SET TAGS ('pii_business_glossary_term' = 'Include Insurance Reminder');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `include_provider_info` SET TAGS ('pii_business_glossary_term' = 'Include Provider Info');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `location_details` SET TAGS ('pii_business_glossary_term' = 'Location Details');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `max_send_attempts` SET TAGS ('pii_business_glossary_term' = 'Max Send Attempts');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `message_body` SET TAGS ('pii_business_glossary_term' = 'Message Body');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `message_subject` SET TAGS ('pii_business_glossary_term' = 'Message Subject');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `preparation_instructions` SET TAGS ('pii_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `requires_confirmation` SET TAGS ('pii_business_glossary_term' = 'Requires Confirmation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `retry_interval_minutes` SET TAGS ('pii_business_glossary_term' = 'Retry Interval Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `send_time_preference` SET TAGS ('pii_business_glossary_term' = 'Send Time Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `reminder_template_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `template_type` SET TAGS ('pii_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `trigger_timing_days` SET TAGS ('pii_business_glossary_term' = 'Trigger Timing Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `trigger_timing_hours` SET TAGS ('pii_business_glossary_term' = 'Trigger Timing Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`reminder_template` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_subdomain' = 'appointment_booking');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_mvm_alias' = 'scheduling.appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_role' = 'canonical');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot' = 'primary');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_pair' = 'radiology.radiology_appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_distinct_document' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_note' = 'distinct_domain_scope_not_duplicate');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_duplicate_of' = 'radiology.radiology_appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_resolution' = 'designate_ssot');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_canonical' = 'radiology.radiology_appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ssot_pair_winner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_duplicate_of' = 'radiology.radiology_appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_mvm_ecm_reconciled' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('pii_ecm_superset' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('pii_business_glossary_term' = 'Scheduling Appointment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('pii_business_glossary_term' = 'Appointment Type Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Demographics Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `demographics_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `encounter_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_number` SET TAGS ('pii_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_scope` SET TAGS ('pii_discriminator' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_status` SET TAGS ('pii_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `booking_channel` SET TAGS ('pii_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('pii_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('pii_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `is_telehealth` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_business_glossary_term' = 'scheduling.appointment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mvm_source_names` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('pii_business_glossary_term' = 'No Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_business_glossary_term' = 'Telehealth Session URL');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_modality` SET TAGS ('pii_business_glossary_term' = 'Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_reason` SET TAGS ('pii_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_reason` SET TAGS ('pii_phi' = 'true');
