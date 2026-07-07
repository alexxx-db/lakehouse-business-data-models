-- Schema for Domain: volunteer | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`volunteer` COMMENT 'Systems of record: UNV Unified Volunteering Platform, V-System (volunteer management), bespoke INGO VMS platforms. Covers volunteer lifecycle from application through deployment and recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` (
    `volunteer_id` BIGINT COMMENT 'Primary key',
    `constituent_id` BIGINT COMMENT 'FK to donor constituent',
    `sanctions_screening_id` BIGINT COMMENT 'FK to compliance sanctions screening',
    `safeguarding_policy_acknowledgment_id` BIGINT COMMENT 'FK to safeguarding policy acknowledgment',
    `volunteer_training_completion_id` BIGINT COMMENT 'FK to safeguarding training completion',
    `address_line_1` STRING COMMENT 'Attribute capturing the address line 1 information for the volunteer entity.',
    `address_line_2` STRING COMMENT 'Attribute capturing the address line 2 information for the volunteer entity.',
    `availability_hours_per_week` DECIMAL(18,2) COMMENT 'Hours available per week',
    `availability_status` STRING COMMENT 'Current availability status',
    `background_check_date` DATE COMMENT 'Date of background check',
    `background_check_status` STRING COMMENT 'Status of background check',
    `certifications` STRING COMMENT 'Certifications held',
    `city` STRING COMMENT 'Attribute capturing the city information for the volunteer entity.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `date_of_birth` DATE COMMENT 'Attribute capturing the date of birth information for the volunteer entity.',
    `email_address` STRING COMMENT 'Attribute capturing the email address information for the volunteer entity.',
    `emergency_contact_name` STRING COMMENT 'Human-readable name or label for the emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Attribute capturing the emergency contact phone information for the volunteer entity.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship to emergency contact',
    `external_volunteer_code` STRING COMMENT 'External system volunteer code',
    `first_name` STRING COMMENT 'Human-readable name or label for the first.',
    `first_volunteer_date` DATE COMMENT 'Date of first volunteering',
    `gender` STRING COMMENT 'Attribute capturing the gender information for the volunteer entity.',
    `geographic_base` STRING COMMENT 'Geographic base location',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_name` STRING COMMENT 'Human-readable name or label for the last.',
    `last_volunteer_date` DATE COMMENT 'Date of last volunteering',
    `middle_name` STRING COMMENT 'Human-readable name or label for the middle.',
    `mobile_number` STRING COMMENT 'Mobile phone number',
    `nationality` STRING COMMENT 'Attribute capturing the nationality information for the volunteer entity.',
    `notes` STRING COMMENT 'General notes',
    `onboarding_completion_date` DATE COMMENT 'Date onboarding completed',
    `onboarding_status` STRING COMMENT 'Current status indicator for the onboarding workflow state.',
    `phone_number` STRING COMMENT 'Count or number of phone items associated with this record.',
    `postal_code` STRING COMMENT 'Standardized code representing the postal classification or category.',
    `preferred_name` STRING COMMENT 'Human-readable name or label for the preferred.',
    `primary_language` STRING COMMENT 'Attribute capturing the primary language information for the volunteer entity.',
    `recognition_level` STRING COMMENT 'Recognition level achieved',
    `secondary_languages` STRING COMMENT 'Attribute capturing the secondary languages information for the volunteer entity.',
    `skills` STRING COMMENT 'Attribute capturing the skills information for the volunteer entity.',
    `state_province` STRING COMMENT 'State or province',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the total volunteer hours information for the volunteer entity.',
    `volunteer_type` STRING COMMENT 'Type of volunteer',
    `willing_to_travel` BOOLEAN COMMENT 'Willingness to travel',
    CONSTRAINT pk_volunteer PRIMARY KEY(`volunteer_id`)
) COMMENT 'Core volunteer entity capturing personal details, availability, skills, and onboarding status Systems-of-record: UNV VMAM (Volunteer Management Application), Salesforce Volunteers. Framework: UN Volunteer Conditions of Service / ILO Decent Work.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`application` (
    `application_id` BIGINT COMMENT 'Primary key',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `partner_org_id` BIGINT COMMENT 'FK to partner org',
    `psea_policy_id` BIGINT COMMENT 'FK to PSEA policy',
    `role_id` BIGINT COMMENT 'FK to volunteer role',
    `sanctions_screening_id` BIGINT COMMENT 'FK to sanctions screening',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `application_date` DATE COMMENT 'Date of application',
    `application_number` STRING COMMENT 'Count or number of application items associated with this record.',
    `application_status` STRING COMMENT 'Current status indicator for the application workflow state.',
    `background_check_completed_date` DATE COMMENT 'Background check completion date',
    `background_check_outcome` STRING COMMENT 'Attribute capturing the background check outcome information for the application entity.',
    `background_check_required` BOOLEAN COMMENT 'Whether background check is required',
    `background_check_status` STRING COMMENT 'Current status indicator for the background check workflow state.',
    `code_of_conduct_signed` BOOLEAN COMMENT 'Whether code of conduct was signed',
    `commitment_duration_months` STRING COMMENT 'Commitment duration in months',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `decision_date` DATE COMMENT 'Date and time when the decision event occurred for this application.',
    `decision_made_by` STRING COMMENT 'Person who made decision',
    `decision_status` STRING COMMENT 'Current status indicator for the decision workflow state.',
    `emergency_contact_provided` BOOLEAN COMMENT 'Whether emergency contact was provided',
    `hours_per_week` DECIMAL(18,2) COMMENT 'Hours per week offered',
    `interview_completed_date` DATE COMMENT 'Interview completion date',
    `interview_notes` STRING COMMENT 'Attribute capturing the interview notes information for the application entity.',
    `interview_outcome` STRING COMMENT 'Attribute capturing the interview outcome information for the application entity.',
    `interview_required` BOOLEAN COMMENT 'Whether interview is required',
    `interview_scheduled_date` DATE COMMENT 'Date and time when the interview scheduled event occurred for this application.',
    `languages_spoken` STRING COMMENT 'Attribute capturing the languages spoken information for the application entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `motivation_statement` STRING COMMENT 'Attribute capturing the motivation statement information for the application entity.',
    `onboarding_completed_date` DATE COMMENT 'Onboarding completion date',
    `onboarding_start_date` DATE COMMENT 'Date and time when the onboarding start event occurred for this application.',
    `onboarding_status` STRING COMMENT 'Current status indicator for the onboarding workflow state.',
    `orientation_completed` BOOLEAN COMMENT 'Whether orientation was completed',
    `preferred_start_date` DATE COMMENT 'Date and time when the preferred start event occurred for this application.',
    `previous_volunteer_experience` STRING COMMENT 'Attribute capturing the previous volunteer experience information for the application entity.',
    `recruitment_channel` STRING COMMENT 'Attribute capturing the recruitment channel information for the application entity.',
    `reference_check_completed_date` DATE COMMENT 'Reference check completion date',
    `reference_check_status` STRING COMMENT 'Current status indicator for the reference check workflow state.',
    `rejection_reason` STRING COMMENT 'Attribute capturing the rejection reason information for the application entity.',
    `safeguarding_policy_acknowledged` BOOLEAN COMMENT 'Whether safeguarding policy was acknowledged',
    `screening_completed_date` DATE COMMENT 'Screening completion date',
    `screening_status` STRING COMMENT 'Current status indicator for the screening workflow state.',
    `skills_offered` STRING COMMENT 'Attribute capturing the skills offered information for the application entity.',
    `training_completed` BOOLEAN COMMENT 'Whether training was completed',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Volunteer application tracking from submission through screening, interview, and onboarding';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the role record.',
    `training_program_id` BIGINT COMMENT 'Reference identifier linking to the associated required safeguarding training program entity.',
    `background_check_required` BOOLEAN COMMENT 'Attribute capturing the background check required information for the role entity.',
    `role_code` STRING COMMENT 'Standardized code representing the role classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this role.',
    `deployment_context` STRING COMMENT 'Attribute capturing the deployment context information for the role entity.',
    `role_description` STRING COMMENT 'Detailed textual description providing context about the role.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this role.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this role.',
    `estimated_time_commitment_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the estimated time commitment hours information for the role entity.',
    `functional_area` STRING COMMENT 'Attribute capturing the functional area information for the role entity.',
    `insurance_coverage_required` BOOLEAN COMMENT 'Attribute capturing the insurance coverage required information for the role entity.',
    `language_requirements` STRING COMMENT 'Attribute capturing the language requirements information for the role entity.',
    `last_modified_by` STRING COMMENT 'Reference to the user or entity that performed the last modified action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this role.',
    `maximum_concurrent_assignments` STRING COMMENT 'Attribute capturing the maximum concurrent assignments information for the role entity.',
    `minimum_age_requirement` STRING COMMENT 'Attribute capturing the minimum age requirement information for the role entity.',
    `minimum_certification_requirements` STRING COMMENT 'Attribute capturing the minimum certification requirements information for the role entity.',
    `physical_demands` STRING COMMENT 'Attribute capturing the physical demands information for the role entity.',
    `preferred_skills` STRING COMMENT 'Attribute capturing the preferred skills information for the role entity.',
    `recognition_program_eligible` BOOLEAN COMMENT 'Attribute capturing the recognition program eligible information for the role entity.',
    `remote_work_eligible` BOOLEAN COMMENT 'Attribute capturing the remote work eligible information for the role entity.',
    `reporting_requirements` STRING COMMENT 'Attribute capturing the reporting requirements information for the role entity.',
    `required_skills` STRING COMMENT 'Attribute capturing the required skills information for the role entity.',
    `risk_level` STRING COMMENT 'Attribute capturing the risk level information for the role entity.',
    `role_status` STRING COMMENT 'Current status indicator for the role workflow state.',
    `role_type` STRING COMMENT 'Classification type categorizing the role for this record.',
    `safeguarding_training_required` BOOLEAN COMMENT 'Attribute capturing the safeguarding training required information for the role entity.',
    `stipend_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the stipend quantity or measurement.',
    `stipend_currency_code` STRING COMMENT 'Standardized code representing the stipend currency classification or category.',
    `stipend_eligible` BOOLEAN COMMENT 'Attribute capturing the stipend eligible information for the role entity.',
    `supervision_level` STRING COMMENT 'Attribute capturing the supervision level information for the role entity.',
    `time_commitment_unit` STRING COMMENT 'Attribute capturing the time commitment unit information for the role entity.',
    `title` STRING COMMENT 'Attribute capturing the title information for the role entity.',
    `travel_required` BOOLEAN COMMENT 'Attribute capturing the travel required information for the role entity.',
    `typical_assignment_duration_days` STRING COMMENT 'Attribute capturing the typical assignment duration days information for the role entity.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Volunteer role definitions including requirements, time commitments, and eligibility criteria';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` (
    `volunteer_deployment_id` BIGINT COMMENT 'Primary key',
    `award_id` BIGINT COMMENT 'FK to grant award',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `field_team_id` BIGINT COMMENT 'FK to field team',
    `finance_fund_id` BIGINT COMMENT 'FK to finance fund',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `it_asset_id` BIGINT COMMENT 'FK to IT asset',
    `meal_plan_id` BIGINT COMMENT 'FK to MEAL plan',
    `partner_org_id` BIGINT COMMENT 'FK to partner org',
    `partnership_agreement_id` BIGINT COMMENT 'FK to partnership agreement',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `registrant_id` BIGINT COMMENT 'FK to registrant',
    `role_id` BIGINT COMMENT 'FK to volunteer role',
    `risk_assessment_id` BIGINT COMMENT 'FK to safeguarding risk assessment',
    `staff_member_id` BIGINT COMMENT 'FK to staff member',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `volunteer_team_id` BIGINT COMMENT 'FK to volunteer team',
    `warehouse_id` BIGINT COMMENT 'FK to warehouse',
    `actual_end_date` DATE COMMENT 'Date and time when the actual end event occurred for this volunteer deployment.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual hours worked',
    `actual_start_date` DATE COMMENT 'Date and time when the actual start event occurred for this volunteer deployment.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deployment_number` STRING COMMENT 'Count or number of deployment items associated with this record.',
    `deployment_status` STRING COMMENT 'Current status indicator for the deployment workflow state.',
    `deployment_type` STRING COMMENT 'Classification type categorizing the deployment for this record.',
    `end_date` DATE COMMENT 'Planned end date',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'Attribute capturing the fte equivalent information for the volunteer deployment entity.',
    `hours_contributed` DECIMAL(18,2) COMMENT 'Attribute capturing the hours contributed information for the volunteer deployment entity.',
    `location_name` STRING COMMENT 'Human-readable name or label for the location.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the volunteer deployment entity.',
    `orientation_completed_date` DATE COMMENT 'Orientation completion date',
    `orientation_completed_flag` BOOLEAN COMMENT 'Whether orientation was completed',
    `performance_rating` DECIMAL(18,2) COMMENT 'Attribute capturing the performance rating information for the volunteer deployment entity.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the planned hours information for the volunteer deployment entity.',
    `priority` STRING COMMENT 'Attribute capturing the priority information for the volunteer deployment entity.',
    `recognition_awarded_flag` BOOLEAN COMMENT 'Whether recognition was awarded',
    `region` STRING COMMENT 'Attribute capturing the region information for the volunteer deployment entity.',
    `remote_deployment_flag` BOOLEAN COMMENT 'Whether deployment is remote',
    `role` STRING COMMENT 'Role description',
    `security_clearance_level` STRING COMMENT 'Attribute capturing the security clearance level information for the volunteer deployment entity.',
    `source_system_code` STRING COMMENT 'Standardized code representing the source system classification or category.',
    `special_conditions` STRING COMMENT 'Attribute capturing the special conditions information for the volunteer deployment entity.',
    `start_date` DATE COMMENT 'Planned start date',
    `volunteer_deployment_status` STRING COMMENT 'Current status indicator for the volunteer deployment workflow state.',
    `withdrawal_date` DATE COMMENT 'Date and time when the withdrawal event occurred for this volunteer deployment.',
    `withdrawal_reason` STRING COMMENT 'Attribute capturing the withdrawal reason information for the volunteer deployment entity.',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_volunteer_deployment PRIMARY KEY(`volunteer_deployment_id`)
) COMMENT 'Tracks volunteer deployments to field sites, programs, and partner organizations';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` (
    `hour_log_id` BIGINT COMMENT 'Primary key',
    `component_id` BIGINT COMMENT 'FK to program component',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `distribution_event_id` BIGINT COMMENT 'FK to distribution event',
    `distribution_order_id` BIGINT COMMENT 'FK to distribution order',
    `field_deployment_id` BIGINT COMMENT 'FK to field deployment',
    `finance_fund_id` BIGINT COMMENT 'FK to finance fund',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `indicator_id` BIGINT COMMENT 'FK to MEL indicator',
    `mobile_health_outreach_id` BIGINT COMMENT 'FK to mobile health outreach',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `registrant_id` BIGINT COMMENT 'FK to registrant',
    `role_id` BIGINT COMMENT 'FK to volunteer role',
    `schedule_id` BIGINT COMMENT 'FK to schedule',
    `staff_member_id` BIGINT COMMENT 'FK to staff member',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `warehouse_id` BIGINT COMMENT 'FK to warehouse',
    `wash_intervention_id` BIGINT COMMENT 'FK to WASH intervention',
    `activity_description` STRING COMMENT 'Detailed textual description providing context about the activity.',
    `activity_type` STRING COMMENT 'Classification type categorizing the activity for this record.',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval event occurred for this hour log.',
    `audit_trail_reference` STRING COMMENT 'Attribute capturing the audit trail reference information for the hour log entity.',
    `beneficiary_count` STRING COMMENT 'Number of beneficiaries served',
    `cost_center` DECIMAL(18,2) COMMENT 'Cost center code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `device_code` STRING COMMENT 'Standardized code representing the device classification or category.',
    `donor_report_eligible` BOOLEAN COMMENT 'Whether eligible for donor reporting',
    `end_time` TIMESTAMP COMMENT 'Attribute capturing the end time information for the hour log entity.',
    `fair_market_value_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the fair market value rate information for the hour log entity.',
    `grant_allocation_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant allocation classification or category.',
    `hours_claimed` DECIMAL(18,2) COMMENT 'Attribute capturing the hours claimed information for the hour log entity.',
    `hours_verified` DECIMAL(18,2) COMMENT 'Attribute capturing the hours verified information for the hour log entity.',
    `in_kind_value` DECIMAL(18,2) COMMENT 'In-kind value',
    `is_group_activity` BOOLEAN COMMENT 'Whether group activity',
    `is_overtime` BOOLEAN COMMENT 'Whether overtime',
    `is_virtual` BOOLEAN COMMENT 'Whether virtual',
    `latitude` DECIMAL(18,2) COMMENT 'Attribute capturing the latitude information for the hour log entity.',
    `location_name` STRING COMMENT 'Human-readable name or label for the location.',
    `log_date` DATE COMMENT 'Date and time when the log event occurred for this hour log.',
    `longitude` DECIMAL(18,2) COMMENT 'Attribute capturing the longitude information for the hour log entity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the hour log entity.',
    `recognition_milestone_triggered` BOOLEAN COMMENT 'Whether recognition milestone was triggered',
    `rejection_reason` STRING COMMENT 'Attribute capturing the rejection reason information for the hour log entity.',
    `start_time` TIMESTAMP COMMENT 'Attribute capturing the start time information for the hour log entity.',
    `submission_method` STRING COMMENT 'Attribute capturing the submission method information for the hour log entity.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the submitted event occurred for this hour log.',
    `verification_method` STRING COMMENT 'Attribute capturing the verification method information for the hour log entity.',
    CONSTRAINT pk_hour_log PRIMARY KEY(`hour_log_id`)
) COMMENT 'Records volunteer hours worked including activity details, verification, and in-kind valuation';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the schedule record.',
    `distribution_event_id` BIGINT COMMENT 'Reference identifier linking to the associated distribution event entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `project_site_id` BIGINT COMMENT 'Reference identifier linking to the associated project site entity.',
    `role_id` BIGINT COMMENT 'Reference identifier linking to the associated role entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `volunteer_deployment_id` BIGINT COMMENT 'Reference identifier linking to the associated volunteer deployment entity.',
    `volunteer_id` BIGINT COMMENT 'Reference identifier linking to the associated volunteer entity.',
    `warehouse_id` BIGINT COMMENT 'Reference identifier linking to the associated warehouse entity.',
    `activity_description` STRING COMMENT 'Detailed textual description providing context about the activity.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the actual hours information for the schedule entity.',
    `assigned_volunteer_count` STRING COMMENT 'Count or number of assigned volunteer items associated with this record.',
    `attendance_status` STRING COMMENT 'Current status indicator for the attendance workflow state.',
    `cancellation_reason` STRING COMMENT 'Attribute capturing the cancellation reason information for the schedule entity.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the cancelled event occurred for this schedule.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the check in event occurred for this schedule.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the check out event occurred for this schedule.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the confirmed event occurred for this schedule.',
    `conflict_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the conflict condition applies.',
    `conflict_reason` STRING COMMENT 'Attribute capturing the conflict reason information for the schedule entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this schedule.',
    `location_address` STRING COMMENT 'Attribute capturing the location address information for the schedule entity.',
    `location_city` STRING COMMENT 'Attribute capturing the location city information for the schedule entity.',
    `location_country_code` STRING COMMENT 'Standardized code representing the location country classification or category.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Attribute capturing the location latitude information for the schedule entity.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Attribute capturing the location longitude information for the schedule entity.',
    `location_name` STRING COMMENT 'Human-readable name or label for the location.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this schedule.',
    `schedule_name` STRING COMMENT 'Human-readable name or label for the schedule.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the schedule entity.',
    `override_approved` BOOLEAN COMMENT 'Attribute capturing the override approved information for the schedule entity.',
    `override_reason` STRING COMMENT 'Attribute capturing the override reason information for the schedule entity.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the planned hours information for the schedule entity.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the published event occurred for this schedule.',
    `recurrence_end_date` DATE COMMENT 'Date and time when the recurrence end event occurred for this schedule.',
    `recurrence_pattern` STRING COMMENT 'Attribute capturing the recurrence pattern information for the schedule entity.',
    `required_volunteer_count` STRING COMMENT 'Count or number of required volunteer items associated with this record.',
    `schedule_number` STRING COMMENT 'Count or number of schedule items associated with this record.',
    `schedule_status` STRING COMMENT 'Current status indicator for the schedule workflow state.',
    `schedule_type` STRING COMMENT 'Classification type categorizing the schedule for this record.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Date and time when the shift end event occurred for this schedule.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Date and time when the shift start event occurred for this schedule.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Volunteer scheduling including shifts, recurrence patterns, and attendance tracking';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the training record.',
    `commodity_id` BIGINT COMMENT 'Reference identifier linking to the associated commodity entity.',
    `governance_policy_id` BIGINT COMMENT 'Reference identifier linking to the associated governance policy entity.',
    `partner_org_id` BIGINT COMMENT 'Reference identifier linking to the associated partner org entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `accrediting_body` STRING COMMENT 'Attribute capturing the accrediting body information for the training entity.',
    `assessment_method` STRING COMMENT 'Attribute capturing the assessment method information for the training entity.',
    `available_languages` STRING COMMENT 'Attribute capturing the available languages information for the training entity.',
    `training_category` STRING COMMENT 'Attribute capturing the training category information for the training entity.',
    `certification_awarded` STRING COMMENT 'Attribute capturing the certification awarded information for the training entity.',
    `certification_validity_months` STRING COMMENT 'Attribute capturing the certification validity months information for the training entity.',
    `chs_standard_alignment` STRING COMMENT 'Attribute capturing the chs standard alignment information for the training entity.',
    `training_code` STRING COMMENT 'Standardized code representing the training classification or category.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Attribute capturing the cost per participant information for the training entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this training.',
    `delivery_modality` STRING COMMENT 'Attribute capturing the delivery modality information for the training entity.',
    `training_description` STRING COMMENT 'Detailed textual description providing context about the training.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the duration hours information for the training entity.',
    `effective_from_date` DATE COMMENT 'Date and time when the effective from event occurred for this training.',
    `effective_until_date` DATE COMMENT 'Date and time when the effective until event occurred for this training.',
    `facilitator_name` STRING COMMENT 'Human-readable name or label for the facilitator.',
    `funding_source` STRING COMMENT 'Attribute capturing the funding source information for the training entity.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mandatory.',
    `language` STRING COMMENT 'Attribute capturing the language information for the training entity.',
    `last_review_date` DATE COMMENT 'Date and time when the last review event occurred for this training.',
    `mandatory_for_roles` STRING COMMENT 'Attribute capturing the mandatory for roles information for the training entity.',
    `materials_url` STRING COMMENT 'Attribute capturing the materials url information for the training entity.',
    `max_participants` STRING COMMENT 'Attribute capturing the max participants information for the training entity.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this training.',
    `next_review_date` DATE COMMENT 'Date and time when the next review event occurred for this training.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Attribute capturing the passing score percentage information for the training entity.',
    `prerequisites` STRING COMMENT 'Attribute capturing the prerequisites information for the training entity.',
    `sdg_alignment` STRING COMMENT 'Attribute capturing the sdg alignment information for the training entity.',
    `sphere_standard_alignment` STRING COMMENT 'Attribute capturing the sphere standard alignment information for the training entity.',
    `target_audience` STRING COMMENT 'Attribute capturing the target audience information for the training entity.',
    `title` STRING COMMENT 'Attribute capturing the title information for the training entity.',
    `training_status` STRING COMMENT 'Current status indicator for the training workflow state.',
    `version` STRING COMMENT 'Attribute capturing the version information for the training entity.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Training programs available for volunteers including content, delivery, and certification details';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Primary key',
    `chs_self_assessment_id` BIGINT COMMENT 'FK to CHS self assessment',
    `obligation_id` BIGINT COMMENT 'FK to compliance obligation',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `finance_fund_id` BIGINT COMMENT 'FK to finance fund',
    `staff_member_id` BIGINT COMMENT 'FK to instructor staff member',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `partner_org_id` BIGINT COMMENT 'FK to partner org',
    `training_id` BIGINT COMMENT 'FK to training',
    `user_account_id` BIGINT COMMENT 'FK to user account',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `assessment_attempts` TIMESTAMP COMMENT 'Attribute capturing the assessment attempts information for the training enrollment entity.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Attribute capturing the assessment score information for the training enrollment entity.',
    `certificate_expiry_date` DATE COMMENT 'Date and time when the certificate expiry event occurred for this training enrollment.',
    `certificate_issue_date` DATE COMMENT 'Date and time when the certificate issue event occurred for this training enrollment.',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `certification_issued_flag` BOOLEAN COMMENT 'Whether certification was issued',
    `compliance_training_category` STRING COMMENT 'Attribute capturing the compliance training category information for the training enrollment entity.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Attribute capturing the continuing education credits information for the training enrollment entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `enrollment_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the enrollment cost information for the training enrollment entity.',
    `enrollment_currency_code` STRING COMMENT 'Standardized code representing the enrollment currency classification or category.',
    `enrollment_date` DATE COMMENT 'Date and time when the enrollment event occurred for this training enrollment.',
    `enrollment_number` STRING COMMENT 'Count or number of enrollment items associated with this record.',
    `enrollment_source` STRING COMMENT 'Attribute capturing the enrollment source information for the training enrollment entity.',
    `enrollment_status` STRING COMMENT 'Current status indicator for the enrollment workflow state.',
    `feedback_comments` DECIMAL(18,2) COMMENT 'Attribute capturing the feedback comments information for the training enrollment entity.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Attribute capturing the feedback rating information for the training enrollment entity.',
    `funding_source` STRING COMMENT 'Attribute capturing the funding source information for the training enrollment entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `mandatory_training_flag` BOOLEAN COMMENT 'Whether mandatory training',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the training enrollment entity.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Attribute capturing the passing score threshold information for the training enrollment entity.',
    `recertification_due_date` DATE COMMENT 'Date and time when the recertification due event occurred for this training enrollment.',
    `recertification_required_flag` BOOLEAN COMMENT 'Whether recertification is required',
    `training_completion_date` DATE COMMENT 'Date and time when the training completion event occurred for this training enrollment.',
    `training_delivery_mode` STRING COMMENT 'Attribute capturing the training delivery mode information for the training enrollment entity.',
    `training_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the training hours information for the training enrollment entity.',
    `training_language` STRING COMMENT 'Attribute capturing the training language information for the training enrollment entity.',
    `training_location` STRING COMMENT 'Attribute capturing the training location information for the training enrollment entity.',
    `training_start_date` DATE COMMENT 'Date and time when the training start event occurred for this training enrollment.',
    `training_withdrawal_date` DATE COMMENT 'Date and time when the training withdrawal event occurred for this training enrollment.',
    `withdrawal_reason` STRING COMMENT 'Attribute capturing the withdrawal reason information for the training enrollment entity.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Tracks volunteer enrollment in training programs including progress, assessment, and certification';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`certification` (
    `certification_id` BIGINT COMMENT 'Primary key',
    `commodity_id` BIGINT COMMENT 'FK to commodity',
    `governance_policy_id` BIGINT COMMENT 'FK to governance policy',
    `staff_member_id` BIGINT COMMENT 'FK to verifying staff member',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `accreditation_body` STRING COMMENT 'Attribute capturing the accreditation body information for the certification entity.',
    `assessment_passing_score` DECIMAL(18,2) COMMENT 'Attribute capturing the assessment passing score information for the certification entity.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Attribute capturing the assessment score information for the certification entity.',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `certification_type` STRING COMMENT 'Classification type categorizing the certification for this record.',
    `compliance_category` STRING COMMENT 'Attribute capturing the compliance category information for the certification entity.',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the continuing education hours information for the certification entity.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the cost quantity or measurement.',
    `cost_currency` DECIMAL(18,2) COMMENT 'Attribute capturing the cost currency information for the certification entity.',
    `country_of_issue` STRING COMMENT 'Attribute capturing the country of issue information for the certification entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deployment_eligible` BOOLEAN COMMENT 'Whether deployment eligible',
    `evidence_document_reference` STRING COMMENT 'Attribute capturing the evidence document reference information for the certification entity.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this certification.',
    `issue_date` DATE COMMENT 'Date and time when the issue event occurred for this certification.',
    `issuing_body` STRING COMMENT 'Attribute capturing the issuing body information for the certification entity.',
    `language_of_certification` STRING COMMENT 'Attribute capturing the language of certification information for the certification entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_verified_date` DATE COMMENT 'Date and time when the last verified event occurred for this certification.',
    `mandatory_for_role` BOOLEAN COMMENT 'Whether mandatory for role',
    `certification_name` STRING COMMENT 'Human-readable name or label for the certification.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the certification entity.',
    `proficiency_level` STRING COMMENT 'Attribute capturing the proficiency level information for the certification entity.',
    `recognized_by_organization` BOOLEAN COMMENT 'Whether recognized by organization',
    `reimbursed_by_organization` BOOLEAN COMMENT 'Whether reimbursed by organization',
    `renewal_frequency_months` STRING COMMENT 'Renewal frequency in months',
    `renewal_required` BOOLEAN COMMENT 'Whether renewal is required',
    `skill_category` STRING COMMENT 'Attribute capturing the skill category information for the certification entity.',
    `skill_name` STRING COMMENT 'Human-readable name or label for the skill.',
    `training_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the training hours information for the certification entity.',
    `verification_status` STRING COMMENT 'Current status indicator for the verification workflow state.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Volunteer certifications including issuing body, validity, and verification status';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`recognition` (
    `recognition_id` BIGINT COMMENT 'Primary key',
    `constituent_id` BIGINT COMMENT 'FK to constituent',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `staff_member_id` BIGINT COMMENT 'FK to nominator staff member',
    `recognition_staff_member_id` BIGINT COMMENT 'FK to staff member',
    `volunteer_deployment_id` BIGINT COMMENT 'FK to volunteer deployment',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this recognition.',
    `award_date` DATE COMMENT 'Date and time when the award event occurred for this recognition.',
    `award_description` STRING COMMENT 'Detailed textual description providing context about the award.',
    `award_title` STRING COMMENT 'Attribute capturing the award title information for the recognition entity.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Whether certificate was issued',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `channel` STRING COMMENT 'Attribute capturing the channel information for the recognition entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `hours_milestone_threshold` STRING COMMENT 'Attribute capturing the hours milestone threshold information for the recognition entity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `monetary_value` DECIMAL(18,2) COMMENT 'Numeric value representing the monetary quantity or measurement.',
    `nomination_date` DATE COMMENT 'Date and time when the nomination event occurred for this recognition.',
    `nominator_type` STRING COMMENT 'Classification type categorizing the nominator for this record.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the recognition entity.',
    `public_acknowledgment_flag` BOOLEAN COMMENT 'Whether public acknowledgment',
    `recognition_number` STRING COMMENT 'Count or number of recognition items associated with this record.',
    `recognition_status` STRING COMMENT 'Current status indicator for the recognition workflow state.',
    `recognition_type` STRING COMMENT 'Classification type categorizing the recognition for this record.',
    `skills_category` STRING COMMENT 'Attribute capturing the skills category information for the recognition entity.',
    CONSTRAINT pk_recognition PRIMARY KEY(`recognition_id`)
) COMMENT 'Volunteer recognition and awards tracking';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` (
    `volunteer_team_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `finance_fund_id` BIGINT COMMENT 'FK to finance fund',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `volunteer_id` BIGINT COMMENT 'FK to lead volunteer',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `staff_member_id` BIGINT COMMENT 'FK to staff member',
    `beneficiaries_served_count` STRING COMMENT 'Count or number of beneficiaries served items associated with this record.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'Attribute capturing the budget allocation information for the volunteer team entity.',
    `communication_channel` STRING COMMENT 'Attribute capturing the communication channel information for the volunteer team entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `current_member_count` STRING COMMENT 'Count or number of current member items associated with this record.',
    `dissolution_date` DATE COMMENT 'Date and time when the dissolution event occurred for this volunteer team.',
    `equipment_assigned` STRING COMMENT 'Attribute capturing the equipment assigned information for the volunteer team entity.',
    `formation_date` DATE COMMENT 'Date and time when the formation event occurred for this volunteer team.',
    `geographic_area` STRING COMMENT 'Attribute capturing the geographic area information for the volunteer team entity.',
    `last_modified_by` STRING COMMENT 'Reference to the user or entity that performed the last modified action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `last_performance_review_date` DATE COMMENT 'Date and time when the last performance review event occurred for this volunteer team.',
    `meeting_frequency` STRING COMMENT 'Attribute capturing the meeting frequency information for the volunteer team entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the volunteer team entity.',
    `operational_hours` STRING COMMENT 'Attribute capturing the operational hours information for the volunteer team entity.',
    `performance_rating` STRING COMMENT 'Attribute capturing the performance rating information for the volunteer team entity.',
    `primary_language` STRING COMMENT 'Attribute capturing the primary language information for the volunteer team entity.',
    `recognition_awards_count` STRING COMMENT 'Count or number of recognition awards items associated with this record.',
    `required_certifications` STRING COMMENT 'Attribute capturing the required certifications information for the volunteer team entity.',
    `safety_incidents_count` STRING COMMENT 'Count or number of safety incidents items associated with this record.',
    `secondary_languages` STRING COMMENT 'Attribute capturing the secondary languages information for the volunteer team entity.',
    `target_member_count` STRING COMMENT 'Count or number of target member items associated with this record.',
    `team_code` STRING COMMENT 'Standardized code representing the team classification or category.',
    `team_name` STRING COMMENT 'Human-readable name or label for the team.',
    `team_type` STRING COMMENT 'Classification type categorizing the team for this record.',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the total volunteer hours information for the volunteer team entity.',
    `training_completion_required` BOOLEAN COMMENT 'Whether training completion is required',
    `volunteer_team_status` STRING COMMENT 'Current status indicator for the volunteer team workflow state.',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_volunteer_team PRIMARY KEY(`volunteer_team_id`)
) COMMENT 'Volunteer teams organized for specific programs, sites, or activities';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` (
    `incident_report_id` BIGINT COMMENT 'Primary key',
    `registrant_id` BIGINT COMMENT 'FK to affected registrant',
    `compliance_incident_id` BIGINT COMMENT 'FK to compliance incident',
    `component_id` BIGINT COMMENT 'FK to program component',
    `corrective_action_plan_id` BIGINT COMMENT 'FK to corrective action plan',
    `crisis_communication_id` BIGINT COMMENT 'FK to crisis communication',
    `distribution_event_id` BIGINT COMMENT 'FK to distribution event',
    `field_deployment_id` BIGINT COMMENT 'FK to field deployment',
    `it_incident_id` BIGINT COMMENT 'FK to IT incident',
    `staff_member_id` BIGINT COMMENT 'FK to primary incident staff member',
    `volunteer_id` BIGINT COMMENT 'FK to primary incident volunteer',
    `safeguarding_incident_id` BIGINT COMMENT 'FK to safeguarding incident',
    `schedule_id` BIGINT COMMENT 'FK to schedule',
    `security_incident_id` BIGINT COMMENT 'FK to security incident',
    `volunteer_team_id` BIGINT COMMENT 'FK to volunteer team',
    `warehouse_id` BIGINT COMMENT 'FK to warehouse',
    `confidentiality_level` STRING COMMENT 'Attribute capturing the confidentiality level information for the incident report entity.',
    `corrective_actions` STRING COMMENT 'Attribute capturing the corrective actions information for the incident report entity.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `immediate_response_actions` STRING COMMENT 'Attribute capturing the immediate response actions information for the incident report entity.',
    `incident_date` DATE COMMENT 'Date and time when the incident event occurred for this incident report.',
    `incident_description` STRING COMMENT 'Detailed textual description providing context about the incident.',
    `incident_location` STRING COMMENT 'Attribute capturing the incident location information for the incident report entity.',
    `incident_number` STRING COMMENT 'Count or number of incident items associated with this record.',
    `incident_report_status` STRING COMMENT 'Current status indicator for the incident report workflow state.',
    `incident_time` TIMESTAMP COMMENT 'Attribute capturing the incident time information for the incident report entity.',
    `incident_type` STRING COMMENT 'Classification type categorizing the incident for this record.',
    `injury_type` STRING COMMENT 'Classification type categorizing the injury for this record.',
    `insurance_claim_filed` BOOLEAN COMMENT 'Whether insurance claim was filed',
    `insurance_claim_number` STRING COMMENT 'Count or number of insurance claim items associated with this record.',
    `investigation_completion_date` DATE COMMENT 'Date and time when the investigation completion event occurred for this incident report.',
    `investigation_findings` STRING COMMENT 'Attribute capturing the investigation findings information for the incident report entity.',
    `investigation_required` BOOLEAN COMMENT 'Whether investigation is required',
    `investigation_start_date` DATE COMMENT 'Date and time when the investigation start event occurred for this incident report.',
    `investigation_status` STRING COMMENT 'Current status indicator for the investigation workflow state.',
    `latitude` DECIMAL(18,2) COMMENT 'Attribute capturing the latitude information for the incident report entity.',
    `longitude` DECIMAL(18,2) COMMENT 'Attribute capturing the longitude information for the incident report entity.',
    `medical_attention_required` TIMESTAMP COMMENT 'Whether medical attention was required',
    `medical_facility_name` STRING COMMENT 'Human-readable name or label for the medical facility.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `police_report_filed` BOOLEAN COMMENT 'Whether police report was filed',
    `police_report_number` STRING COMMENT 'Count or number of police report items associated with this record.',
    `referral_to_support_services` STRING COMMENT 'Attribute capturing the referral to support services information for the incident report entity.',
    `report_date` DATE COMMENT 'Date and time when the report event occurred for this incident report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the report event occurred for this incident report.',
    `resolution_date` DATE COMMENT 'Date and time when the resolution event occurred for this incident report.',
    `resolution_outcome` STRING COMMENT 'Attribute capturing the resolution outcome information for the incident report entity.',
    `severity_level` STRING COMMENT 'Attribute capturing the severity level information for the incident report entity.',
    `witness_count` STRING COMMENT 'Count or number of witness items associated with this record.',
    CONSTRAINT pk_incident_report PRIMARY KEY(`incident_report_id`)
) COMMENT 'Volunteer incident reports including safety, security, and safeguarding incidents';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`feedback` (
    `feedback_id` DECIMAL(18,2) COMMENT 'Unique identifier for the feedback record.',
    `assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated assessment entity.',
    `data_collection_tool_id` BIGINT COMMENT 'Reference identifier linking to the associated data collection tool entity.',
    `distribution_event_id` BIGINT COMMENT 'Reference identifier linking to the associated distribution event entity.',
    `field_deployment_id` BIGINT COMMENT 'Reference identifier linking to the associated field deployment entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated follow up assigned to staff member entity.',
    `internal_review_id` BIGINT COMMENT 'Reference identifier linking to the associated internal review entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `project_site_id` BIGINT COMMENT 'Reference identifier linking to the associated project site entity.',
    `registrant_id` BIGINT COMMENT 'Reference identifier linking to the associated registrant entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `training_enrollment_id` BIGINT COMMENT 'Reference identifier linking to the associated training enrollment entity.',
    `volunteer_id` BIGINT COMMENT 'Reference identifier linking to the associated volunteer entity.',
    `areas_for_improvement` STRING COMMENT 'Attribute capturing the areas for improvement information for the feedback entity.',
    `channel` STRING COMMENT 'Attribute capturing the channel information for the feedback entity.',
    `communication_rating` STRING COMMENT 'Attribute capturing the communication rating information for the feedback entity.',
    `consent_to_follow_up` BOOLEAN COMMENT 'Attribute capturing the consent to follow up information for the feedback entity.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this feedback.',
    `data_source` STRING COMMENT 'Attribute capturing the data source information for the feedback entity.',
    `escalation_required` BOOLEAN COMMENT 'Attribute capturing the escalation required information for the feedback entity.',
    `feedback_type` DECIMAL(18,2) COMMENT 'Classification type categorizing the feedback for this record.',
    `follow_up_assigned_to` STRING COMMENT 'Attribute capturing the follow up assigned to information for the feedback entity.',
    `follow_up_completed_date` DATE COMMENT 'Date and time when the follow up completed event occurred for this feedback.',
    `follow_up_notes` STRING COMMENT 'Attribute capturing the follow up notes information for the feedback entity.',
    `follow_up_status` STRING COMMENT 'Current status indicator for the follow up workflow state.',
    `impact_perception_rating` STRING COMMENT 'Attribute capturing the impact perception rating information for the feedback entity.',
    `is_anonymous` BOOLEAN COMMENT 'Boolean indicator specifying whether the record anonymous.',
    `is_sensitive` BOOLEAN COMMENT 'Boolean indicator specifying whether the record sensitive.',
    `language_code` STRING COMMENT 'Standardized code representing the language classification or category.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this feedback.',
    `net_promoter_score` STRING COMMENT 'Attribute capturing the net promoter score information for the feedback entity.',
    `overall_satisfaction_rating` STRING COMMENT 'Attribute capturing the overall satisfaction rating information for the feedback entity.',
    `qualitative_comments` STRING COMMENT 'Attribute capturing the qualitative comments information for the feedback entity.',
    `rating_scale_max` STRING COMMENT 'Attribute capturing the rating scale max information for the feedback entity.',
    `record_status` STRING COMMENT 'Current status indicator for the record workflow state.',
    `response_sent_date` DATE COMMENT 'Date and time when the response sent event occurred for this feedback.',
    `safety_rating` STRING COMMENT 'Attribute capturing the safety rating information for the feedback entity.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Attribute capturing the sentiment score information for the feedback entity.',
    `strengths_noted` STRING COMMENT 'Attribute capturing the strengths noted information for the feedback entity.',
    `submission_date` DATE COMMENT 'Date and time when the submission event occurred for this feedback.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the submission event occurred for this feedback.',
    `suggestions` STRING COMMENT 'Attribute capturing the suggestions information for the feedback entity.',
    `supervision_rating` STRING COMMENT 'Attribute capturing the supervision rating information for the feedback entity.',
    `support_quality_rating` STRING COMMENT 'Attribute capturing the support quality rating information for the feedback entity.',
    `survey_version` STRING COMMENT 'Attribute capturing the survey version information for the feedback entity.',
    `training_quality_rating` STRING COMMENT 'Attribute capturing the training quality rating information for the feedback entity.',
    `would_volunteer_again` BOOLEAN COMMENT 'Attribute capturing the would volunteer again information for the feedback entity.',
    CONSTRAINT pk_feedback PRIMARY KEY(`feedback_id`)
) COMMENT 'Volunteer feedback and satisfaction surveys';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`stipend` (
    `stipend_id` BIGINT COMMENT 'Primary key',
    `staff_member_id` BIGINT COMMENT 'FK to approving staff member',
    `award_id` BIGINT COMMENT 'FK to award',
    `budget_line_id` BIGINT COMMENT 'FK to budget line',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `donor_fund_id` BIGINT COMMENT 'FK to donor fund',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `intervention_id` BIGINT COMMENT 'FK to intervention',
    `project_site_id` BIGINT COMMENT 'FK to project site',
    `regulatory_filing_id` BIGINT COMMENT 'FK to regulatory filing',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `warehouse_id` BIGINT COMMENT 'FK to warehouse',
    `amount` DECIMAL(18,2) COMMENT 'Stipend amount',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `approved_date` DATE COMMENT 'Date and time when the approved event occurred for this stipend.',
    `bank_account_number` STRING COMMENT 'Count or number of bank account items associated with this record.',
    `bank_branch_code` STRING COMMENT 'Standardized code representing the bank branch classification or category.',
    `bank_name` STRING COMMENT 'Human-readable name or label for the bank.',
    `compliance_check_status` STRING COMMENT 'Current status indicator for the compliance check workflow state.',
    `compliance_notes` STRING COMMENT 'Attribute capturing the compliance notes information for the stipend entity.',
    `cost_category` DECIMAL(18,2) COMMENT 'Attribute capturing the cost category information for the stipend entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `disbursement_date` DATE COMMENT 'Date and time when the disbursement event occurred for this stipend.',
    `disbursement_reference` STRING COMMENT 'Attribute capturing the disbursement reference information for the stipend entity.',
    `donor_reportable_flag` BOOLEAN COMMENT 'Whether donor reportable',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the exchange rate information for the stipend entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the stipend entity.',
    `in_kind_description` STRING COMMENT 'In-kind description',
    `justification` STRING COMMENT 'Attribute capturing the justification information for the stipend entity.',
    `mobile_money_number` STRING COMMENT 'Count or number of mobile money items associated with this record.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the stipend entity.',
    `payment_frequency` DECIMAL(18,2) COMMENT 'Attribute capturing the payment frequency information for the stipend entity.',
    `payment_method` DECIMAL(18,2) COMMENT 'Attribute capturing the payment method information for the stipend entity.',
    `payment_period_end_date` DECIMAL(18,2) COMMENT 'Date and time when the payment period end event occurred for this stipend.',
    `payment_period_start_date` DECIMAL(18,2) COMMENT 'Date and time when the payment period start event occurred for this stipend.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the reporting currency quantity or measurement.',
    `reporting_period` STRING COMMENT 'Attribute capturing the reporting period information for the stipend entity.',
    `stipend_number` STRING COMMENT 'Count or number of stipend items associated with this record.',
    `stipend_type` STRING COMMENT 'Classification type categorizing the stipend for this record.',
    `tax_form_type` STRING COMMENT 'Classification type categorizing the tax form for this record.',
    `tax_reportable_flag` BOOLEAN COMMENT 'Whether tax reportable',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_stipend PRIMARY KEY(`stipend_id`)
) COMMENT 'Volunteer stipend payments and financial support tracking';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`consent` (
    `consent_id` BIGINT COMMENT 'Unique identifier for the consent record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `donor_requirement_id` BIGINT COMMENT 'Reference identifier linking to the associated donor requirement entity.',
    `field_deployment_id` BIGINT COMMENT 'Reference identifier linking to the associated field deployment entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `superseded_consent_id` BIGINT COMMENT 'Reference identifier linking to the associated superseded consent entity.',
    `volunteer_id` BIGINT COMMENT 'Reference identifier linking to the associated volunteer entity.',
    `audit_trail_reference` STRING COMMENT 'Attribute capturing the audit trail reference information for the consent entity.',
    `confirmation_sent` BOOLEAN COMMENT 'Attribute capturing the confirmation sent information for the consent entity.',
    `confirmation_sent_date` DATE COMMENT 'Date and time when the confirmation sent event occurred for this consent.',
    `consent_date` DATE COMMENT 'Date and time when the consent event occurred for this consent.',
    `consent_number` STRING COMMENT 'Count or number of consent items associated with this record.',
    `consent_status` STRING COMMENT 'Current status indicator for the consent workflow state.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent event occurred for this consent.',
    `consent_type` STRING COMMENT 'Classification type categorizing the consent for this record.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this consent.',
    `device_identifier` STRING COMMENT 'Attribute capturing the device identifier information for the consent entity.',
    `document_reference` STRING COMMENT 'Attribute capturing the document reference information for the consent entity.',
    `donor_due_diligence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the donor due diligence condition applies.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this consent.',
    `granting_method` DECIMAL(18,2) COMMENT 'Attribute capturing the granting method information for the consent entity.',
    `guardian_name` STRING COMMENT 'Human-readable name or label for the guardian.',
    `guardian_relationship` STRING COMMENT 'Attribute capturing the guardian relationship information for the consent entity.',
    `ip_address` STRING COMMENT 'Attribute capturing the ip address information for the consent entity.',
    `language_code` STRING COMMENT 'Standardized code representing the language classification or category.',
    `legal_basis` STRING COMMENT 'Attribute capturing the legal basis information for the consent entity.',
    `minor_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the minor consent condition applies.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this consent.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the consent entity.',
    `retention_period_months` STRING COMMENT 'Attribute capturing the retention period months information for the consent entity.',
    `safeguarding_category` STRING COMMENT 'Attribute capturing the safeguarding category information for the consent entity.',
    `scope` STRING COMMENT 'Attribute capturing the scope information for the consent entity.',
    `source_system_code` STRING COMMENT 'Standardized code representing the source system classification or category.',
    `version` STRING COMMENT 'Attribute capturing the version information for the consent entity.',
    `withdrawal_date` DATE COMMENT 'Date and time when the withdrawal event occurred for this consent.',
    `withdrawal_method` STRING COMMENT 'Attribute capturing the withdrawal method information for the consent entity.',
    `withdrawal_reason` STRING COMMENT 'Attribute capturing the withdrawal reason information for the consent entity.',
    `witness_name` STRING COMMENT 'Human-readable name or label for the witness.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Volunteer consent records for data processing, imagery, and participation';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` (
    `volunteer_redeployment_id` BIGINT COMMENT 'Primary key',
    `staff_member_id` BIGINT COMMENT 'FK to approving staff member',
    `primary_volunteer_deployment_id` BIGINT COMMENT 'FK to original volunteer deployment',
    `volunteer_deployment_id` BIGINT COMMENT 'FK to new deployment',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this volunteer redeployment.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `handover_completed_flag` BOOLEAN COMMENT 'Whether handover was completed',
    `handover_date` DATE COMMENT 'Date and time when the handover event occurred for this volunteer redeployment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `redeployment_date` DATE COMMENT 'Date of redeployment',
    `redeployment_reason` STRING COMMENT 'Reason for redeployment',
    `redeployment_status` STRING COMMENT 'Status of redeployment',
    `transition_notes` STRING COMMENT 'Attribute capturing the transition notes information for the volunteer redeployment entity.',
    CONSTRAINT pk_volunteer_redeployment PRIMARY KEY(`volunteer_redeployment_id`)
) COMMENT 'Tracks redeployment of volunteers from one deployment to another, capturing transition details and rationale';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` (
    `volunteer_training_completion_id` BIGINT COMMENT 'Primary key',
    `staff_member_id` BIGINT COMMENT 'FK to staff member',
    `training_program_id` BIGINT COMMENT 'FK to training program',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `assessment_score_percentage` DECIMAL(18,2) COMMENT 'Attribute capturing the assessment score percentage information for the volunteer training completion entity.',
    `attempts_count` STRING COMMENT 'Count or number of attempts items associated with this record.',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `completion_date` DATE COMMENT 'Date and time when the completion event occurred for this volunteer training completion.',
    `completion_status` STRING COMMENT 'Current status indicator for the completion workflow state.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `enrollment_date` DATE COMMENT 'Date and time when the enrollment event occurred for this volunteer training completion.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this volunteer training completion.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this volunteer training completion.',
    `mandatory_flag` BOOLEAN COMMENT 'Whether mandatory',
    `training_completion_code` BIGINT COMMENT 'Standardized code representing the training completion classification or category.',
    `waiver_reason` STRING COMMENT 'Attribute capturing the waiver reason information for the volunteer training completion entity.',
    CONSTRAINT pk_volunteer_training_completion PRIMARY KEY(`volunteer_training_completion_id`)
) COMMENT 'Records volunteer completion of safeguarding and mandatory training programs';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` (
    `volunteer_policy_acknowledgment_id` BIGINT COMMENT 'Primary key',
    `psea_policy_id` BIGINT COMMENT 'FK to PSEA policy',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `acknowledged_by_name` STRING COMMENT 'Human-readable name or label for the acknowledged by.',
    `acknowledgment_date` DATE COMMENT 'Date and time when the acknowledgment event occurred for this volunteer policy acknowledgment.',
    `acknowledgment_method` STRING COMMENT 'Attribute capturing the acknowledgment method information for the volunteer policy acknowledgment entity.',
    `acknowledgment_status` STRING COMMENT 'Current status indicator for the acknowledgment workflow state.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `digital_signature` STRING COMMENT 'Attribute capturing the digital signature information for the volunteer policy acknowledgment entity.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this volunteer policy acknowledgment.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the volunteer policy acknowledgment entity.',
    `policy_acknowledgment_code` BIGINT COMMENT 'Standardized code representing the policy acknowledgment classification or category.',
    `policy_version_number` STRING COMMENT 'Count or number of policy version items associated with this record.',
    `training_completion_flag` BOOLEAN COMMENT 'Whether training was completed',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this volunteer policy acknowledgment.',
    `witness_name` STRING COMMENT 'Human-readable name or label for the witness.',
    CONSTRAINT pk_volunteer_policy_acknowledgment PRIMARY KEY(`volunteer_policy_acknowledgment_id`)
) COMMENT 'Records volunteer acknowledgment of organizational policies including PSEA and safeguarding';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` (
    `tool_authorization_id` BIGINT COMMENT 'Primary key',
    `staff_member_id` BIGINT COMMENT 'FK to authorizing staff member',
    `data_collection_tool_id` BIGINT COMMENT 'FK to data collection tool',
    `volunteer_id` BIGINT COMMENT 'FK to volunteer',
    `authorization_date` DATE COMMENT 'Date and time when the authorization event occurred for this tool authorization.',
    `authorization_expiry_date` DATE COMMENT 'Date and time when the authorization expiry event occurred for this tool authorization.',
    `certification_status` STRING COMMENT 'Current status indicator for the certification workflow state.',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `deployment_count` STRING COMMENT 'Count or number of deployment items associated with this record.',
    `last_refresher_training_date` DATE COMMENT 'Date and time when the last refresher training event occurred for this tool authorization.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the tool authorization entity.',
    `proficiency_level` STRING COMMENT 'Attribute capturing the proficiency level information for the tool authorization entity.',
    `training_completion_date` DATE COMMENT 'Date and time when the training completion event occurred for this tool authorization.',
    `updated_at` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_tool_authorization PRIMARY KEY(`tool_authorization_id`)
) COMMENT 'Tracks volunteer authorization to use specific data collection tools and systems';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` (
    `volunteer_deployment2_id` BIGINT COMMENT 'Primary key for the volunteer redeployment record.',
    `country_office_id` BIGINT COMMENT 'FK to the country office managing this redeployment.',
    `intervention_id` BIGINT COMMENT 'FK to the program intervention this redeployment supports.',
    `primary_volunteer_deployment_id` BIGINT COMMENT 'FK to the original volunteer deployment that this redeployment extends or follows.',
    `project_site_id` BIGINT COMMENT 'FK to the project site where the redeployment takes place.',
    `role_id` BIGINT COMMENT 'FK to the role assigned in this redeployment.',
    `staff_member_id` BIGINT COMMENT 'FK to the staff member supervising this redeployment.',
    `volunteer_deployment_id` BIGINT COMMENT 'FK to the original volunteer_deployment record being extended or transferred',
    `volunteer_id` BIGINT COMMENT 'FK to the volunteer being redeployed.',
    `volunteer_team_id` BIGINT COMMENT 'FK to the volunteer team for this redeployment.',
    `actual_end_date` DATE COMMENT 'Actual date the volunteer completed or left the redeployment assignment.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total actual volunteer hours logged during this redeployment.',
    `actual_start_date` DATE COMMENT 'Actual date the volunteer began the redeployment assignment.',
    `approval_date` DATE COMMENT 'Date the redeployment was approved.',
    `approval_status` STRING COMMENT 'Status of redeployment approval (Pending, Approved, Rejected)',
    `approved_by` STRING COMMENT 'Name or ID of the person who approved the redeployment.',
    `approving_manager_name` STRING COMMENT 'Name of the manager who approved the redeployment',
    `briefing_completed_date` DATE COMMENT 'Date the redeployment briefing was completed',
    `continuity_flag` BOOLEAN COMMENT 'Indicates whether this redeployment is a direct continuation without a gap.',
    `country_code` STRING COMMENT 'ISO country code for the redeployment location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redeployment record was created.',
    `effective_end_date` DATE COMMENT 'Planned end date of the new deployment assignment',
    `effective_start_date` DATE COMMENT 'Start date of the new deployment assignment',
    `end_date` DATE COMMENT 'Planned or actual end date of the redeployment.',
    `gap_days` STRING COMMENT 'Number of days between the end of the previous deployment and the start of this redeployment.',
    `handover_completed_flag` BOOLEAN COMMENT 'Whether a formal handover from the previous deployment was completed.',
    `handover_date` DATE COMMENT 'Date the handover from the previous deployment was completed.',
    `location_name` STRING COMMENT 'Name of the location where the redeployment takes place.',
    `modified_by` STRING COMMENT 'User who last modified this redeployment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redeployment record was last modified.',
    `new_site_name` STRING COMMENT 'Name of the new deployment site or duty station',
    `notes` STRING COMMENT 'Free-text notes about this redeployment.',
    `orientation_completed_date` DATE COMMENT 'Date orientation was completed for this redeployment.',
    `orientation_completed_flag` BOOLEAN COMMENT 'Whether the volunteer completed orientation for the new assignment.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance rating for this redeployment assignment.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Total planned volunteer hours for this redeployment.',
    `previous_deployment_performance_rating` DECIMAL(18,2) COMMENT 'Performance rating from the preceding deployment that informed this redeployment decision.',
    `priority` STRING COMMENT 'Priority level of the redeployment request (e.g., critical, high, medium, low).',
    `redeployment_notes` STRING COMMENT 'Free-text notes on the redeployment decision and context',
    `redeployment_number` STRING COMMENT 'Unique business identifier for this redeployment record.',
    `redeployment_reason` STRING COMMENT 'Reason for the redeployment (e.g., emergency surge, skill match, volunteer request, program expansion).',
    `redeployment_status` STRING COMMENT 'Current status of the redeployment (e.g., proposed, approved, active, completed, cancelled).',
    `redeployment_type` STRING COMMENT 'Type of redeployment (e.g., lateral transfer, promotion, emergency surge, extension).',
    `region` STRING COMMENT 'Geographic region of the redeployment.',
    `remote_deployment_flag` BOOLEAN COMMENT 'Indicates whether this redeployment is conducted remotely.',
    `security_clearance_level` STRING COMMENT 'Required security clearance level for this redeployment assignment.',
    `security_clearance_verified_flag` BOOLEAN COMMENT 'Whether security clearance was re-verified for new location',
    `skills_match_score` DECIMAL(18,2) COMMENT 'Score indicating how well the volunteers skills match the redeployment requirements.',
    `special_conditions` STRING COMMENT 'Any special conditions or accommodations for this redeployment.',
    `start_date` DATE COMMENT 'Planned or actual start date of the redeployment.',
    `transfer_date` DATE COMMENT 'Date the volunteer is transferred to the new deployment',
    `travel_arranged_flag` BOOLEAN COMMENT 'Whether travel logistics have been arranged',
    `withdrawal_date` DATE COMMENT 'Date the volunteer withdrew from or was withdrawn from this redeployment.',
    `withdrawal_reason` STRING COMMENT 'Reason for withdrawal from the redeployment.',
    `created_by` STRING COMMENT 'User who created this redeployment record.',
    CONSTRAINT pk_volunteer_deployment2 PRIMARY KEY(`volunteer_deployment2_id`)
) COMMENT 'Records volunteer redeployments and transfers between deployment assignments, tracking approval workflow, handover status, and logistics for continuity of volunteer service.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_volunteer_training_completion_id` FOREIGN KEY (`volunteer_training_completion_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion`(`volunteer_training_completion_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training`(`training_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_training_enrollment_id` FOREIGN KEY (`training_enrollment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_superseded_consent_id` FOREIGN KEY (`superseded_consent_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`consent`(`consent_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ADD CONSTRAINT `fk_volunteer_volunteer_redeployment_primary_volunteer_deployment_id` FOREIGN KEY (`primary_volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ADD CONSTRAINT `fk_volunteer_volunteer_redeployment_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ADD CONSTRAINT `fk_volunteer_volunteer_redeployment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ADD CONSTRAINT `fk_volunteer_volunteer_training_completion_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ADD CONSTRAINT `fk_volunteer_volunteer_policy_acknowledgment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ADD CONSTRAINT `fk_volunteer_tool_authorization_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ADD CONSTRAINT `fk_volunteer_volunteer_deployment2_primary_volunteer_deployment_id` FOREIGN KEY (`primary_volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ADD CONSTRAINT `fk_volunteer_volunteer_deployment2_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ADD CONSTRAINT `fk_volunteer_volunteer_deployment2_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ADD CONSTRAINT `fk_volunteer_volunteer_deployment2_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ADD CONSTRAINT `fk_volunteer_volunteer_deployment2_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('pii_domain' = 'volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('pii_column_comment_framework' = 'UNV + ILO');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `mobile_health_outreach_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `mobile_health_outreach_id` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_city` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_country_code` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('pii_subdomain' = 'learning_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('pii_subdomain' = 'learning_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('pii_subdomain' = 'learning_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` SET TAGS ('pii_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` SET TAGS ('pii_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` SET TAGS ('pii_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `registrant_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_account_number` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `mobile_money_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `mobile_money_number` SET TAGS ('pii_type' = 'phone');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `witness_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `witness_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('pii_subdomain' = 'learning_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('pii_association_edges' = 'volunteer.volunteer,safeguarding.training_program');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('pii_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('pii_association_edges' = 'volunteer.volunteer,safeguarding.psea_policy');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `acknowledged_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `acknowledged_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('pii_type' = 'signature');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('pii_subdomain' = 'learning_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('pii_association_edges' = 'mel.data_collection_tool,volunteer.volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` SET TAGS ('pii_subdomain' = 'deployment_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `volunteer_deployment2_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Redeployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `country_office_id` SET TAGS ('pii_business_glossary_term' = 'Country Office');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `primary_volunteer_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Original Deployment Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `project_site_id` SET TAGS ('pii_business_glossary_term' = 'Project Site');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `role_id` SET TAGS ('pii_business_glossary_term' = 'Redeployment Role');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Supervising Staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `volunteer_team_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Team');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `actual_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `approving_manager_name` SET TAGS ('pii_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `approving_manager_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `continuity_flag` SET TAGS ('pii_business_glossary_term' = 'Continuity Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Redeployment End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `gap_days` SET TAGS ('pii_business_glossary_term' = 'Gap Days');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `handover_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Handover Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `handover_date` SET TAGS ('pii_business_glossary_term' = 'Handover Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `new_site_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `orientation_completed_date` SET TAGS ('pii_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `orientation_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Orientation Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Current Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `planned_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `previous_deployment_performance_rating` SET TAGS ('pii_business_glossary_term' = 'Previous Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `redeployment_number` SET TAGS ('pii_business_glossary_term' = 'Redeployment Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `redeployment_reason` SET TAGS ('pii_business_glossary_term' = 'Redeployment Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `redeployment_status` SET TAGS ('pii_business_glossary_term' = 'Redeployment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `redeployment_type` SET TAGS ('pii_business_glossary_term' = 'Redeployment Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `remote_deployment_flag` SET TAGS ('pii_business_glossary_term' = 'Remote Deployment Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `skills_match_score` SET TAGS ('pii_business_glossary_term' = 'Skills Match Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `special_conditions` SET TAGS ('pii_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Redeployment Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `withdrawal_date` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `withdrawal_reason` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment2` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
