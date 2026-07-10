-- Schema for Domain: scheduling | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-02 08:58:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`scheduling` COMMENT 'Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` (
    `appointment_type_id` BIGINT COMMENT 'Unique identifier',
    `cdm_entry_id` BIGINT COMMENT 'Charge master entry',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Scheduling systems must surface prior authorization requirements at booking time. Linking appointment_type to the governing prior_auth_rule enables real-time PA checks during scheduling, preventing cl',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Appointment types are specialty-specific (cardiology new patient vs. orthopedic follow-up). specialty_id FK enables appointment type management by specialty and payer contract validation for prior aut',
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
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: schedule_template currently stores appointment_type_code as a denormalized STRING. Adding a proper FK to appointment_type normalizes this reference, enabling joins to retrieve duration, billing class,',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Schedule templates are created per facility to reflect site-specific scheduling rules (slot durations, overbooking policies). org_provider_id FK enables multi-site template management and facility-lev',
    `schedulable_resource_id` BIGINT COMMENT 'Schedulable resource',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Schedule templates are built per specialty (cardiology vs. orthopedics have different slot durations and overbooking rules). specialty_id FK enables template management by specialty and network adequa',
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
    `schedule_template_status` STRING COMMENT 'The schedule template status value classifying the scheduling schedule template record.',
    `service_type_code` STRING COMMENT 'The service type code value classifying the scheduling schedule template record.',
    `session_duration_minutes` STRING COMMENT 'The session duration minutes of the scheduling schedule template record.',
    `session_end_time` TIMESTAMP COMMENT 'Timestamp capturing the session end time associated with the scheduling schedule template record.',
    `session_start_time` TIMESTAMP COMMENT 'Timestamp capturing the session start time associated with the scheduling schedule template record.',
    `slot_duration_minutes` STRING COMMENT 'The slot duration minutes of the scheduling schedule template record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the scheduling schedule template record.',
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
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the scheduling open slot record.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: An open slot is a specific time window on a specific schedulable resource (provider, room, or equipment). While open_slot links to schedule_template (which in turn links to schedulable_resource), the ',
    `schedule_template_id` BIGINT COMMENT 'Schedule template',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Open slots are published by specialty for patient self-scheduling and network adequacy monitoring. specialty_id FK enables slot availability reporting by specialty, a standard operational and regulato',
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
    `open_slot_status` STRING COMMENT 'The open slot status value classifying the scheduling open slot record.',
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
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Waitlist enabled',
    CONSTRAINT pk_open_slot PRIMARY KEY(`open_slot_id`)
) COMMENT 'Available appointment slots generated from schedule templates and block time.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` (
    `surgical_case_id` BIGINT COMMENT 'Unique identifier',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Surgical billing requires assigning a CDM entry to each surgical case at scheduling time for OR facility fee pre-authorization and charge capture. OR billing teams use this link to validate facility f',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: Surgical informed consent is a Joint Commission and CMS regulatory requirement. surgical_case has consent_obtained_indicator and consent_timestamp but no FK to the consent document record. This link e',
    `diagnosis_id` BIGINT COMMENT 'Unique identifier for the diagnosis within the scheduling surgical case record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Surgical pre-authorization, benefit verification, and cost estimation require the specific health plan, not just the payer. surgical_case already has payer_id but health plan determines copay/coinsura',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Surgical scheduling requires patient identity linkage for pre-op verification, surgical safety checklists, and Joint Commission compliance. A domain expert expects every surgical case to reference the',
    `or_block_id` BIGINT COMMENT 'Foreign key linking to scheduling.or_block. Business justification: A surgical case is scheduled within an OR block time allocation. surgical_case has block_time_indicator (BOOLEAN) and block_owner_npi (STRING) indicating block time usage, but no FK to the actual or_b',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Surgical cases occur at a specific facility. org_provider_id FK enables surgical volume reporting per facility, required for credentialing, privileging reviews, and CMS quality reporting. facility_cod',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the scheduling surgical case record.',
    `privileging_id` BIGINT COMMENT 'Privileging',
    `registration_event_id` BIGINT COMMENT 'Foreign key linking to patient.registration_event. Business justification: Pre-surgical hospital admission requires a registration event capturing admission type, financial class, and consent. Linking surgical_case to registration_event supports surgical admission workflows,',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: A surgical case is performed in a specific OR room, which is a schedulable_resource. surgical_case has facility_code (STRING) but no FK to the specific OR room resource. This FK enables OR room utiliz',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Surgical cases are categorized by specialty for OR utilization, credentialing case volume tracking, and quality reporting. specialty_id FK enables direct specialty-level surgical volume analysis. spec',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the scheduling surgical case record.',
    `actual_duration_minutes` STRING COMMENT 'The actual duration minutes of the scheduling surgical case record.',
    `actual_end_time` TIMESTAMP COMMENT 'Timestamp capturing the actual end time associated with the scheduling surgical case record.',
    `actual_start_time` TIMESTAMP COMMENT 'Timestamp capturing the actual start time associated with the scheduling surgical case record.',
    `add_on_case_indicator` BOOLEAN COMMENT 'The add on case indicator of the scheduling surgical case record.',
    `anesthesia_type` STRING COMMENT 'The anesthesia type value classifying the scheduling surgical case record.',
    `asa_classification` STRING COMMENT 'The asa classification of the scheduling surgical case record.',
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
    `implant_required` BOOLEAN COMMENT 'The implant required of the scheduling surgical case record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the scheduling surgical case record.',
    `laterality` STRING COMMENT 'The laterality of the scheduling surgical case record.',
    `notes` STRING COMMENT 'The notes of the scheduling surgical case record.',
    `patient_class` STRING COMMENT 'The patient class of the scheduling surgical case record.',
    `post_op_diagnosis` STRING COMMENT 'The post op diagnosis of the scheduling surgical case record.',
    `record_number` BIGINT COMMENT 'Consent record',
    `requires_blood_products` BOOLEAN COMMENT 'The requires blood products of the scheduling surgical case record.',
    `requires_icu_bed` BOOLEAN COMMENT 'The requires icu bed of the scheduling surgical case record.',
    `scheduled_date` DATE COMMENT 'Timestamp capturing the scheduled date associated with the scheduling surgical case record.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled end time associated with the scheduling surgical case record.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Timestamp capturing the scheduled start time associated with the scheduling surgical case record.',
    `service_line` STRING COMMENT 'The service line of the scheduling surgical case record.',
    `site_marked_indicator` BOOLEAN COMMENT 'The site marked indicator of the scheduling surgical case record.',
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
    `clinician_id` BIGINT COMMENT 'Identifier of the individual surgeon who owns the block, if block_owner_type is surgeon. References provider master data.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: OR blocks are allocated at a specific facility. org_provider_id FK enables block utilization reporting per hospital, required for surgical capacity planning and facility-level OR management. No existi',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: An OR block is fundamentally a time reservation on a specific OR room or suite, which is a schedulable_resource. or_block currently has no FK to the resource it reserves — it only has clinician_id (th',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: OR blocks are allocated by specialty (orthopedic block time, cardiac block time). specialty_id FK enables block utilization analysis by specialty, a standard surgical operations and credentialing repo',
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
    `or_block_status` STRING COMMENT 'The or block status value classifying the scheduling or block record.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority of this block when multiple blocks overlap or compete for the same OR suite. Lower numbers indicate higher priority.',
    `recurring_pattern` STRING COMMENT 'Pattern describing how the block recurs over time (e.g., every week, every other week, first Monday of month). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|first_week|second_week|third_week|fourth_week|custom — 8 candidates stripped; promote to reference product]',
    `release_lead_time_days` STRING COMMENT 'Number of days before the block date that unused time must be released, if release_rule_type is days_before.',
    `release_lead_time_hours` STRING COMMENT 'Number of hours before the block start time that unused time must be released, if release_rule_type is hours_before.',
    `release_rule_type` STRING COMMENT 'Type of rule governing when unused block time is released back to the general pool for other surgeons or services to use.. Valid values are `days_before|hours_before|no_release|manual`',
    `staff_roles_required` STRING COMMENT 'Comma-separated list of staff roles or specialties required to support cases in this block (e.g., scrub nurse, circulating nurse, surgical tech, perfusionist).',
    `suspension_reason` STRING COMMENT 'Reason why the block was suspended or temporarily inactivated (e.g., low utilization, surgeon leave, facility maintenance).',
    `target_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Target percentage of block time utilization that the owner is expected to achieve for optimal OR capacity management.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_or_block PRIMARY KEY(`or_block_id`)
) COMMENT 'Operating room block time allocations';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` (
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource. Primary key for the schedulable resource entity.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Schedulable resources (rooms, equipment, staff) belong to a specific facility. org_provider_id FK enables facility-level resource inventory, scheduling capacity reporting, and accreditation compliance',
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
    `schedulable_resource_status` STRING COMMENT 'The schedulable resource status value classifying the scheduling schedulable resource record.',
    `scheduling_constraints` STRING COMMENT 'Free-text description of any special scheduling rules, restrictions, or constraints that apply to this resource (e.g., only available for specific appointment types, requires advance booking, limited to certain patient populations).',
    `scheduling_status` STRING COMMENT 'Current availability status of the resource for scheduling purposes. Active resources are available for scheduling; inactive resources are temporarily unavailable; maintenance resources are undergoing service; reserved resources are held for specific purposes; retired resources are permanently removed from service.. Valid values are `active|inactive|maintenance|reserved|retired`',
    `specialty_code` STRING COMMENT 'Medical specialty or service line associated with the resource. For providers, this is their clinical specialty; for rooms and equipment, the specialty they support (e.g., cardiology, orthopedics, radiology).',
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
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider (physician, surgeon, specialist) assigned to this appointment or case. Populated when resource_type is provider.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key reference to the specific procedure or service being performed. Links to the procedure master for clinical and billing context.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: resource_assignment records the assignment of a specific resource to a surgical case or visit. It has resource_type (STRING) and equipment_asset_tag (STRING) but no FK to the schedulable_resource bein',
    `substitute_for_resource_assignment_id` BIGINT COMMENT 'Foreign key reference to another resource assignment that this assignment is substituting for. Used when a resource is replaced due to unavailability, conflict, or last-minute changes.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key reference to the surgical case record when the assignment is for an Operating Room (OR) procedure. Null for non-surgical appointments.',
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
    `resource_assignment_status` STRING COMMENT 'The resource assignment status value classifying the scheduling resource assignment record.',
    `resource_type` STRING COMMENT 'Category of resource being assigned. Distinguishes between human resources (providers, staff, care team members) and physical resources (rooms, equipment).. Valid values are `provider|room|equipment|staff|care_team_member|anesthesia_resource`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment is scheduled to conclude. Used for capacity planning and resource turnover scheduling.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment begins. Represents when the provider, room, or equipment is scheduled to be engaged for this appointment or procedure.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this resource assignment in the source system. Enables traceability back to the originating Electronic Health Record (EHR) or scheduling system.',
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
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Waitlist entries for authorization-required services track authorization status to prioritize patients with approved authorizations for scheduling. Care coordinators proactively obtain authorizations ',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Waitlist entries are created when a clinical order (imaging, procedure, therapy) cannot be immediately scheduled. Linking waitlist_entry to clinical_order enables order-to-schedule gap reporting, SLA ',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Waitlist prioritization and specialty routing are clinically driven by the patients diagnosis. Utilization management, access-to-care reporting, and payer prior-authorization workflows require linkin',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to insurance.eligibility_span. Business justification: Insurance eligibility can lapse during extended waitlist periods. When a slot opens, the scheduling system must verify the patients eligibility_span is still active before confirming the appointment.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_appointment. Business justification: When a waitlisted patient is booked for a radiology exam, the waitlist_entry must reference the fulfilling radiology_appointment to close the entry, track SLA compliance, and report waitlist-to-appoin',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Waitlist entries track plan-specific network restrictions, authorization requirements, and benefit limitations to match patients with appropriate appointment slots and providers when capacity becomes ',
    `insurance_coverage_id` BIGINT COMMENT 'Identifier for the patient insurance coverage to be used for the appointment. Links to insurance coverage master data.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient on the waitlist. Links to the patient master record.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: When a waitlist patient is converted to a scheduled appointment, the waitlist_entry should reference the specific open_slot that was booked. waitlist_entry has scheduled_datetime (TIMESTAMP) but no FK',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Waitlist entries are facility-specific — patients wait for appointments at a specific hospital or clinic. org_provider_id FK enables facility-level waitlist management, capacity planning, and access-t',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Waitlist management prioritizes patients based on payer authorization status and coverage verification. Schedulers check payer requirements before offering appointments from waitlist to ensure authori',
    `clinician_id` BIGINT COMMENT 'Identifier for the specific provider requested by the patient or referring provider. Null if no specific provider preference. Links to provider master data.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Waitlist entries for specialty care are driven by specific clinical problems requiring intervention. Essential for specialty access tracking, care gap management, and prioritization of patients with h',
    `referral_order_id` BIGINT COMMENT 'Identifier for the clinical order that triggered this waitlist entry, if applicable. Null for non-order-based entries. Links to clinical order master data.',
    `appointment_type_id` BIGINT COMMENT 'Identifier for the type of appointment requested by the patient or ordering provider. Links to appointment type master data.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Waitlist management requires matching patients to available specialists. specialty_id FK enables waitlist-to-provider matching reports and network adequacy gap analysis by specialty. specialty_require',
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
    `sla_target_datetime` TIMESTAMP COMMENT 'Target date and time by which the scheduling action should be completed per organizational or regulatory service level agreement. Used for compliance monitoring and escalation triggers.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this waitlist entry in the source system. Used for data lineage and reconciliation.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible and willing to receive care via telehealth modality for this appointment request. True if telehealth is an acceptable option.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. True if transportation support is needed.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    `visit_reason` STRING COMMENT 'Free-text description of the clinical reason or chief complaint for the requested appointment.',
    `visit_reason_code` STRING COMMENT 'Coded representation of the visit reason using standard clinical terminology (e.g., SNOMED CT, ICD-10).',
    `waitlist_entry_status` STRING COMMENT 'The waitlist entry status value classifying the scheduling waitlist entry record.',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Waitlist entries';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` (
    `telehealth_session_id` BIGINT COMMENT 'Primary key for telehealth_session',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: A telehealth session is a specific type of scheduled appointment and must reference the appointment_type that governs it. The appointment_type defines duration, billing characteristics (billing_class,',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider conducting the telehealth session.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: Telehealth consent is a regulatory requirement under CMS and state telehealth laws. telehealth_session has consent_obtained_flag and consent_datetime but no FK to the consent document. This link enabl',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Telehealth reimbursement eligibility, billing modifiers, and originating/distant site codes are health-plan-specific. CMS and state parity law compliance requires knowing the governing health plan per',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient participating in the telehealth session.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: A telehealth session is booked into a specific open slot in the providers schedule. telehealth_session has scheduled_start_datetime and scheduled_end_datetime but no FK to the open_slot from which it',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Telehealth billing requires identifying the distant site (provider organization) for CMS reimbursement compliance. org_provider_id FK enables telehealth billing compliance reporting and site-level uti',
    `portal_account_id` BIGINT COMMENT 'Foreign key linking to patient.portal_account. Business justification: Telehealth sessions are initiated through the patient portal. Linking telehealth_session to portal_account supports digital health engagement reporting, session initiation audit trails, and two-factor',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Telehealth sessions are frequently initiated from referral orders. Linking telehealth_session to referral_order enables referral loop closure tracking, authorization reconciliation, and care coordinat',
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
    `technical_issue_description` STRING COMMENT 'Free-text description of any technical issues encountered during the telehealth session, such as connectivity problems, audio/video quality issues, or platform errors.',
    `technical_issue_reported_flag` BOOLEAN COMMENT 'Indicates whether any technical issues were reported during or after the telehealth session that impacted quality or completion.',
    `telehealth_session_status` STRING COMMENT 'The telehealth session status value classifying the scheduling telehealth session record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutator to satisfy target entity touch',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Added by VIBE mutator to ensure model change.',
    `vibe_structure_marker` STRING COMMENT 'Marks product as part of the required ECM structure.',
    CONSTRAINT pk_telehealth_session PRIMARY KEY(`telehealth_session_id`)
) COMMENT 'Telehealth sessions';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` (
    `provider_availability_id` BIGINT COMMENT 'Unique identifier for the provider availability record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider whose availability is being recorded. Links to the provider master data.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Provider availability is location-specific; org_provider_id FK enables availability reporting per facility for network adequacy compliance and multi-site scheduling management. location_code is a deno',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: In HMO and ACO models, provider availability blocks are network-specific — a provider may have separate availability windows for in-network vs. out-of-network patients. Scheduling systems filter avail',
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource within the scheduling provider availability record.',
    `schedule_template_id` BIGINT COMMENT 'Identifier of the schedule template that this availability record modifies or overrides, if applicable.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Availability is published by specialty for patient matching and network adequacy reporting. specialty_id FK enables direct specialty-availability analysis required for payer network adequacy filings. ',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_substitute_for_resource_assignment_id` FOREIGN KEY (`substitute_for_resource_assignment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'CDM Entry');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_self_scheduling` SET TAGS ('dbx_business_glossary_term' = 'Self Scheduling Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_business_glossary_term' = 'Billing Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_category` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `default_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_description` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `maximum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `minimum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `no_show_penalty_applies` SET TAGS ('dbx_business_glossary_term' = 'No Show Penalty Applies');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `quality_measure_applicable` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_interpreter` SET TAGS ('dbx_business_glossary_term' = 'Requires Interpreter');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_referral` SET TAGS ('dbx_business_glossary_term' = 'Requires Referral');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `room_type_required` SET TAGS ('dbx_business_glossary_term' = 'Room Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'RVU Malpractice');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'RVU Practice Expense');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'RVU Work');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `waitlist_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Eligible');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `auto_confirm_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Confirm');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `buffer_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Buffer Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `max_slots_per_session` SET TAGS ('dbx_business_glossary_term' = 'Max Slots Per Session');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `no_show_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Tracking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider NPI');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `appointment_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Max Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Cutoff Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `overbook_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbook Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_category` SET TAGS ('dbx_business_glossary_term' = 'Slot Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_business_glossary_term' = 'Slot Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Or Block Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `add_on_case_indicator` SET TAGS ('dbx_business_glossary_term' = 'Add-On Case');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'ASA Classification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Block Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `implant_required` SET TAGS ('dbx_business_glossary_term' = 'Implant Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Laterality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Post-Op Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_business_glossary_term' = 'Requires Blood Products');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_icu_bed` SET TAGS ('dbx_business_glossary_term' = 'Requires ICU Bed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `site_marked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Site Marked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `timeout_completed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Timeout Completed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Surgeon ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_sharing` SET TAGS ('dbx_business_glossary_term' = 'Allows Sharing Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `anesthesia_type_required` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_end_time` SET TAGS ('dbx_business_glossary_term' = 'Block End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_number` SET TAGS ('dbx_business_glossary_term' = 'Block Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_value_regex' = 'service|surgeon|specialty|department|open');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_start_time` SET TAGS ('dbx_business_glossary_term' = 'Block Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|open|flex|call');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `equipment_set_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Set Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `minimum_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `recurring_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurring Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Release Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_value_regex' = 'days_before|hours_before|no_release|manual');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `target_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `building` SET TAGS ('dbx_business_glossary_term' = 'Building Name or Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `floor` SET TAGS ('dbx_business_glossary_term' = 'Floor Number or Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `minimum_turnover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Turnover Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|care_team');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('dbx_business_glossary_term' = 'Room Configuration Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_constraints` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraints');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|reserved|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_cycle_required` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Cycle Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Unit or Wing');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Assignment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `substitute_for_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute For Resource Assignment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective|stat');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|tentative|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Reservation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_value_regex' = 'reserved|allocated|in_use|returned|unavailable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `maintenance_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `requested_datetime` SET TAGS ('dbx_business_glossary_term' = 'Requested Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|staff|care_team_member|anesthesia_resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_applied` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `waitlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Radiology Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'waitlist|referral_queue|order_based|recall|surgical_request|work_queue');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `estimated_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `queue_entry_datetime` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `sla_target_datetime` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Modifier Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_value_regex' = 'patient|provider|staff|system');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Connection Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'connected|disconnected|poor_quality|reconnected|failed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `distant_site_code` SET TAGS ('dbx_business_glossary_term' = 'Distant Site Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Site Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_browser` SET TAGS ('dbx_business_glossary_term' = 'Patient Web Browser');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_business_glossary_term' = 'Patient Operating System');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_vendor` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform Vendor');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `recording_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Recording Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Access Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show|technical_failure');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'video|phone|asynchronous|chat|remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Availability ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|pending|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'scheduled|on_call|blocked|vacation|cme|administrative');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `booked_appointments` SET TAGS ('dbx_business_glossary_term' = 'Booked Appointments Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `coverage_area` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `max_appointments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointments');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_business_glossary_term' = 'On-Call Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_value_regex' = 'primary|backup|home|hospital');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|surgical|same_day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_npi` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recurrence End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'once|daily|weekly|biweekly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutation marker');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `vibe_mutation_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
