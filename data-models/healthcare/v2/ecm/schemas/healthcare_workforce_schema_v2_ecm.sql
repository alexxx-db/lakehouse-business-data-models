-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`workforce` COMMENT 'Healthcare workforce and human capital management. Owns employees, physicians, contract staff, FTE (Full-Time Equivalent) tracking, credentialing, privileging, competency assessments, CME (Continuing Medical Education), shift scheduling, time and attendance, payroll, benefits, talent management, and OSHA compliance. Integrates with Workday HCM and Symplr credentialing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce employee record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce employee record.',
    `manager_employee_id` BIGINT COMMENT 'Unique identifier for the manager employee within the workforce employee record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the workforce employee record.',
    `position_id` BIGINT COMMENT 'Unique identifier for the position within the workforce employee record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce employee record.',
    `date_of_birth` DATE COMMENT 'The date of birth of the workforce employee record.',
    `department_code` STRING COMMENT 'The department code value classifying the workforce employee record.',
    `email_address` STRING COMMENT 'The email address of the workforce employee record.',
    `employee_number` STRING COMMENT 'The employee number of the workforce employee record.',
    `employment_status` STRING COMMENT 'The employment status value classifying the workforce employee record.',
    `employment_type` STRING COMMENT 'The employment type value classifying the workforce employee record.',
    `first_name` STRING COMMENT 'The first name of the workforce employee record.',
    `flsa_status` STRING COMMENT 'The flsa status value classifying the workforce employee record.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The fte percentage of the workforce employee record.',
    `gender` STRING COMMENT 'The gender of the workforce employee record.',
    `hire_date` DATE COMMENT 'Timestamp capturing the hire date associated with the workforce employee record.',
    `home_address_line1` STRING COMMENT 'The home address line1 of the workforce employee record.',
    `home_city` STRING COMMENT 'The home city of the workforce employee record.',
    `home_postal_code` STRING COMMENT 'The home postal code value classifying the workforce employee record.',
    `home_state` STRING COMMENT 'The home state of the workforce employee record.',
    `is_clinical` BOOLEAN COMMENT 'Boolean flag indicating the is clinical status of the workforce employee record.',
    `job_title` STRING COMMENT 'The job title of the workforce employee record.',
    `last_name` STRING COMMENT 'The last name of the workforce employee record.',
    `license_number` STRING COMMENT 'The license number of the workforce employee record.',
    `license_state` STRING COMMENT 'The license state of the workforce employee record.',
    `middle_name` STRING COMMENT 'The middle name of the workforce employee record.',
    `npi` STRING COMMENT 'The npi of the workforce employee record.',
    `pay_grade` STRING COMMENT 'The pay grade of the workforce employee record.',
    `personal_phone` STRING COMMENT 'The personal phone of the workforce employee record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the workforce employee record.',
    `ssn_last4` STRING COMMENT 'The ssn last4 of the workforce employee record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the workforce employee record.',
    `termination_reason` STRING COMMENT 'The termination reason of the workforce employee record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce employee record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `work_phone` STRING COMMENT 'The work phone of the workforce employee record.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core employee master record linking workforce identity to clinical roles, positions, and credentialing status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record',
    `care_site_id` BIGINT COMMENT 'FK to the facility care site where this position is located',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the workforce position record.',
    `job_profile_id` BIGINT COMMENT 'FK to the job profile defining role requirements',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the position org unit within the workforce position record.',
    `primary_position_department_workforce_org_unit_id` BIGINT COMMENT 'FK to the organizational unit representing the department',
    `reports_to_position_id` BIGINT COMMENT 'Self-referential FK to the supervisory position',
    `tertiary_position_workforce_org_unit_id` BIGINT COMMENT 'FK to the primary organizational unit for this position',
    `approved_by` STRING COMMENT 'Name of person who approved the position creation',
    `approved_date` DATE COMMENT 'Date the position was approved',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Budgeted full-time equivalent allocation for this position',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'Continuing medical education hours required annually',
    `position_code` STRING COMMENT 'Unique business code identifying the position',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was created',
    `effective_date` DATE COMMENT 'Date the position becomes effective',
    `employment_category` STRING COMMENT 'Category of employment (full-time, part-time, PRN, per diem)',
    `employment_type` STRING COMMENT 'The employment type value classifying the workforce position record.',
    `end_date` DATE COMMENT 'Date the position is closed or inactivated',
    `filled_fte` DECIMAL(18,2) COMMENT 'The filled fte of the workforce position record.',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification (exempt/non-exempt)',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Actual FTE allocation for the position',
    `headcount_count` STRING COMMENT 'Number of headcount slots this position represents',
    `is_clinical` BOOLEAN COMMENT 'Whether this position involves direct clinical care',
    `is_critical_role` BOOLEAN COMMENT 'Whether this is a critical/hard-to-fill role',
    `is_management` BOOLEAN COMMENT 'Whether this is a management/leadership position',
    `is_provider` BOOLEAN COMMENT 'Whether this position is a licensed provider role',
    `is_union_eligible` BOOLEAN COMMENT 'Whether this position is eligible for union membership',
    `is_vacant` BOOLEAN COMMENT 'Boolean flag indicating the is vacant status of the workforce position record.',
    `job_family` STRING COMMENT 'Job family grouping (nursing, allied health, administrative)',
    `location_type` STRING COMMENT 'Type of work location (on-site, remote, hybrid)',
    `max_pay_rate` DECIMAL(18,2) COMMENT 'The max pay rate of the workforce position record.',
    `min_pay_rate` DECIMAL(18,2) COMMENT 'The min pay rate of the workforce position record.',
    `minimum_experience_years` STRING COMMENT 'Minimum years of experience required',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `on_call_required` BOOLEAN COMMENT 'Whether on-call coverage is required',
    `osha_job_hazard_category` STRING COMMENT 'OSHA job hazard classification for workplace safety',
    `patient_facing` BOOLEAN COMMENT 'Whether this position involves direct patient interaction',
    `pay_grade` STRING COMMENT 'Compensation pay grade level',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum salary/hourly rate for this position',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint salary/hourly rate for compensation benchmarking',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum salary/hourly rate for this position',
    `position_number` STRING COMMENT 'The position number of the workforce position record.',
    `position_status` STRING COMMENT 'Current status (open, filled, frozen, closed)',
    `position_title` STRING COMMENT 'The position title of the workforce position record.',
    `position_type` STRING COMMENT 'Type of position (regular, temporary, contract, traveler)',
    `required_certification` STRING COMMENT 'Professional certification required (BLS, ACLS, etc.)',
    `required_education_level` STRING COMMENT 'Minimum education level required (BSN, MD, etc.)',
    `required_license_type` STRING COMMENT 'Professional license type required (RN, MD, PA, etc.)',
    `shift_type` STRING COMMENT 'Primary shift assignment (day, evening, night, rotating)',
    `source_system_code` STRING COMMENT 'Identifier of the source HR system',
    `source_system_position_code` STRING COMMENT 'Position identifier in the source system',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard weekly hours for this position',
    `telehealth_eligible` BOOLEAN COMMENT 'Whether this position can perform telehealth services',
    `title` STRING COMMENT 'Official title of the position',
    `union_code` STRING COMMENT 'Union bargaining unit code if applicable',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to the position record',
    `vacancy_reason` STRING COMMENT 'Reason for current vacancy (resignation, retirement, new position)',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `weekend_rotation_required` BOOLEAN COMMENT 'Whether weekend rotation is required for this position',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Position master defining authorized roles, budgeted FTE, reporting structure, and job requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile within the workforce job profile record.',
    `certification_required_flag` BOOLEAN COMMENT 'The certification required flag of the workforce job profile record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce job profile record.',
    `job_profile_description` STRING COMMENT 'The job profile description of the workforce job profile record.',
    `eeo_category` STRING COMMENT 'The eeo category of the workforce job profile record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce job profile record.',
    `flsa_status` STRING COMMENT 'The flsa status value classifying the workforce job profile record.',
    `is_clinical` BOOLEAN COMMENT 'Boolean flag indicating the is clinical status of the workforce job profile record.',
    `is_management` BOOLEAN COMMENT 'Boolean flag indicating the is management status of the workforce job profile record.',
    `job_category` STRING COMMENT 'The job category of the workforce job profile record.',
    `job_code` STRING COMMENT 'The job code value classifying the workforce job profile record.',
    `job_family` STRING COMMENT 'The job family of the workforce job profile record.',
    `job_level` STRING COMMENT 'The job level of the workforce job profile record.',
    `job_title` STRING COMMENT 'The job title of the workforce job profile record.',
    `license_required_flag` BOOLEAN COMMENT 'The license required flag of the workforce job profile record.',
    `minimum_education` STRING COMMENT 'The minimum education of the workforce job profile record.',
    `minimum_experience_years` STRING COMMENT 'The minimum experience years of the workforce job profile record.',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'The pay grade max of the workforce job profile record.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'The pay grade min of the workforce job profile record.',
    `retirement_date` DATE COMMENT 'Timestamp capturing the retirement date associated with the workforce job profile record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce job profile record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Job profile template defining competencies, education, licensure, and pay range for a role.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` (
    `employment_competency_id` BIGINT COMMENT 'Unique identifier for the employment competency within the workforce employment competency record.',
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile within the workforce employment competency record.',
    `assessment_frequency_months` STRING COMMENT 'The assessment frequency months of the workforce employment competency record.',
    `competency_category` STRING COMMENT 'The competency category of the workforce employment competency record.',
    `competency_code` STRING COMMENT 'The competency code value classifying the workforce employment competency record.',
    `competency_name` STRING COMMENT 'The competency name of the workforce employment competency record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce employment competency record.',
    `employment_competency_description` STRING COMMENT 'The employment competency description of the workforce employment competency record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce employment competency record.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating the is mandatory status of the workforce employment competency record.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'The regulatory requirement flag of the workforce employment competency record.',
    `required_proficiency_level` STRING COMMENT 'The required proficiency level of the workforce employment competency record.',
    `retirement_date` DATE COMMENT 'Timestamp capturing the retirement date associated with the workforce employment competency record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce employment competency record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_employment_competency PRIMARY KEY(`employment_competency_id`)
) COMMENT 'Master record for the full credentialing and privileging lifecycle of healthcare workforce members. Covers professional credentials (medical licenses, DEA registrations, board certifications, nursing licenses, allied health certifications, advanced practice credentials), clinical privileges (facility-specific procedure and clinical activity authorizations granted by Medical Staff), and credentialing/re-credentialing applications. For credentials: issuing authority, license number, issue/expiration dates, renewal status, primary source verification status. For privileges: privilege category, procedure/service type, facility, granting date, privilege status (active, provisional, suspended, revoked), Medical Staff committee approval. For applications: application type (initial, reappointment), submission date, verification steps, committee review dates, approval/denial decision, effective dates. Integrates with Symplr credentialing and Medical Staff Office workflows. SSOT for all workforce credentialing, privileging, and verification data.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` (
    `competency_assessment_id` BIGINT COMMENT 'Unique identifier for the competency assessment within the workforce competency assessment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the competency assessor employee within the workforce competency assessment record.',
    `competency_employee_id` BIGINT COMMENT 'Unique identifier for the competency employee within the workforce competency assessment record.',
    `employment_competency_id` BIGINT COMMENT 'Unique identifier for the employment competency within the workforce competency assessment record.',
    `assessment_date` DATE COMMENT 'Timestamp capturing the assessment date associated with the workforce competency assessment record.',
    `assessment_method` STRING COMMENT 'The assessment method of the workforce competency assessment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce competency assessment record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the workforce competency assessment record.',
    `notes` STRING COMMENT 'The notes of the workforce competency assessment record.',
    `pass_fail_status` STRING COMMENT 'The pass fail status value classifying the workforce competency assessment record.',
    `proficiency_level` STRING COMMENT 'The proficiency level of the workforce competency assessment record.',
    `remediation_required_flag` BOOLEAN COMMENT 'The remediation required flag of the workforce competency assessment record.',
    `score` DECIMAL(18,2) COMMENT 'The score of the workforce competency assessment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce competency assessment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_competency_assessment PRIMARY KEY(`competency_assessment_id`)
) COMMENT 'Records of competency evaluations, occupational health immunizations, and health screenings for clinical and non-clinical staff. Captures assessment type (competency, immunization, health screening), competency domain or vaccine/test type, assessment method (observation, written, simulation, administration), assessor, date, score/result, pass/fail outcome, remediation plan, and next-due date. For immunizations: vaccine type (influenza, hepatitis B, MMR, varicella, Tdap, COVID-19), lot number, administration date, declination reason. For health screenings: TB testing (PPD/IGRA), N95 fit testing, results. SSOT for all occupational health compliance and workforce competency data. Supports TJC and CMS staffing competency and infection control compliance standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record',
    `care_site_id` BIGINT COMMENT 'FK to the facility where the shift occurs',
    `clinician_id` BIGINT COMMENT 'FK to the clinician assigned to this shift',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for labor cost allocation',
    `position_id` BIGINT COMMENT 'FK to the position being staffed',
    `employee_id` BIGINT COMMENT 'FK to the employee assigned to this shift',
    `shift_employee_id` BIGINT COMMENT 'Unique identifier for the shift employee within the workforce shift schedule record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the shift org unit within the workforce shift schedule record.',
    `shift_workforce_org_unit_id` BIGINT COMMENT 'FK to the organizational unit owning this schedule',
    `swap_source_schedule_id` BIGINT COMMENT 'Self-referential FK to the original shift in a swap scenario',
    `unit_id` BIGINT COMMENT 'FK to the nursing/clinical unit for this shift',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual end datetime of the shift',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total actual hours worked during the shift',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual start datetime of the shift',
    `acuity_level` STRING COMMENT 'Patient acuity level on the unit during this shift',
    `agency_name` STRING COMMENT 'Name of staffing agency if agency staff',
    `approval_datetime` TIMESTAMP COMMENT 'Datetime when the shift was approved by manager',
    `assignment_status` STRING COMMENT 'Status of the shift assignment (assigned, confirmed, no-show)',
    `break_minutes` STRING COMMENT 'Total break time in minutes during the shift',
    `cancellation_reason` STRING COMMENT 'Reason for shift cancellation if applicable',
    `care_setting` STRING COMMENT 'Clinical care setting (ICU, ED, med-surg, OR)',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the shift record was created',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce shift schedule record.',
    `floated_to_unit` STRING COMMENT 'The floated to unit of the workforce shift schedule record.',
    `fte_value` DECIMAL(18,2) COMMENT 'FTE value this shift represents',
    `is_agency_staff` BOOLEAN COMMENT 'Whether the shift is filled by agency/travel staff',
    `is_charge_role` BOOLEAN COMMENT 'Whether the employee is serving as charge nurse/lead',
    `is_float` BOOLEAN COMMENT 'Boolean flag indicating the is float status of the workforce shift schedule record.',
    `is_float_assignment` BOOLEAN COMMENT 'Whether this is a float pool assignment to another unit',
    `is_holiday` BOOLEAN COMMENT 'Whether this shift falls on a recognized holiday',
    `is_mandatory_overtime` BOOLEAN COMMENT 'Whether this shift is mandatory overtime',
    `is_on_call` BOOLEAN COMMENT 'Boolean flag indicating the is on call status of the workforce shift schedule record.',
    `is_overtime` BOOLEAN COMMENT 'Boolean flag indicating the is overtime status of the workforce shift schedule record.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Timestamp of last modification to this shift record',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `nurse_to_patient_ratio` DECIMAL(18,2) COMMENT 'Nurse-to-patient staffing ratio during this shift',
    `on_call_response_minutes` STRING COMMENT 'Required response time in minutes for on-call shifts',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during this shift',
    `patient_census` STRING COMMENT 'Patient census count on the unit during this shift',
    `pay_code` STRING COMMENT 'Payroll pay code (regular, OT, holiday, callback)',
    `published_datetime` TIMESTAMP COMMENT 'Datetime when the schedule was published to staff',
    `published_flag` BOOLEAN COMMENT 'The published flag of the workforce shift schedule record.',
    `required_fte_coverage` DECIMAL(18,2) COMMENT 'Required FTE coverage level for this shift period',
    `schedule_notes` STRING COMMENT 'Free-text notes about the shift assignment',
    `schedule_number` STRING COMMENT 'Business identifier for the schedule period',
    `schedule_period_end_date` DATE COMMENT 'End date of the scheduling period',
    `schedule_period_start_date` DATE COMMENT 'Start date of the scheduling period',
    `schedule_status` STRING COMMENT 'Status of the schedule (draft, published, finalized)',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned end datetime of the shift',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total planned hours for this shift',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start datetime of the shift',
    `shift_category` STRING COMMENT 'Category of shift (regular, overtime, on-call, callback)',
    `shift_date` DATE COMMENT 'Calendar date of the shift',
    `shift_end_timestamp` TIMESTAMP COMMENT 'The shift end timestamp of the workforce shift schedule record.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'The shift start timestamp of the workforce shift schedule record.',
    `shift_status` STRING COMMENT 'The shift status value classifying the workforce shift schedule record.',
    `shift_type` STRING COMMENT 'Type of shift (day, evening, night, split)',
    `skill_level_required` STRING COMMENT 'Minimum skill/competency level required for this shift',
    `source_system_code` STRING COMMENT 'Identifier of the scheduling source system',
    `source_system_record_code` STRING COMMENT 'Record identifier in the source scheduling system',
    `swap_approved_by` STRING COMMENT 'Manager who approved the shift swap',
    `swap_approved_datetime` TIMESTAMP COMMENT 'Datetime when the shift swap was approved',
    `swap_requested` BOOLEAN COMMENT 'The swap requested of the workforce shift schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce shift schedule record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Planned work schedules and individual shift assignments for clinical and non-clinical staff across all care settings (inpatient units, ED, ICU, OR, outpatient clinics). Captures schedule period, unit/department, shift type (day, evening, night, on-call), required FTE coverage, and schedule status. Includes individual employee shift assignments: assigned employee, role, scheduled start/end datetime, assignment status (scheduled, confirmed, swapped, cancelled), float/agency designation, and actual vs. scheduled hours for variance analysis and overtime tracking. SSOT for all workforce scheduling data. Supports nurse-to-patient ratio compliance and operational staffing planning. Integrates with Workday HCM scheduling modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` (
    `time_attendance_id` BIGINT COMMENT 'Unique identifier for the time and attendance record',
    `care_site_id` BIGINT COMMENT 'FK to the facility where time was worked',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to the GL account for labor cost posting',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for labor cost allocation',
    `fiscal_period_id` BIGINT COMMENT 'FK to the fiscal period for financial reporting',
    `payroll_run_id` BIGINT COMMENT 'FK to the payroll run that processed this time entry',
    `position_id` BIGINT COMMENT 'FK to the position the employee worked under',
    `employee_id` BIGINT COMMENT 'FK to the employee who worked the time',
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule within the workforce time attendance record.',
    `time_employee_id` BIGINT COMMENT 'Unique identifier for the time employee within the workforce time attendance record.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit',
    `approval_status` STRING COMMENT 'Status of time entry approval (pending, approved, rejected)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the time entry was approved',
    `approved_by` STRING COMMENT 'Name of manager who approved the time entry',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'Base hourly pay rate for the employee',
    `benefits_deduction` DECIMAL(18,2) COMMENT 'Benefits deduction amount for this pay period',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Bonus or incentive pay amount',
    `callback_hours` DECIMAL(18,2) COMMENT 'Hours worked on callback from on-call status',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Timestamp when employee clocked in',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Timestamp when employee clocked out',
    `correction_reason` STRING COMMENT 'Reason for time entry correction if modified',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created',
    `differential_rate` DECIMAL(18,2) COMMENT 'The differential rate of the workforce time attendance record.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'The double time hours of the workforce time attendance record.',
    `exception_flag` BOOLEAN COMMENT 'The exception flag of the workforce time attendance record.',
    `exception_reason` STRING COMMENT 'The exception reason of the workforce time attendance record.',
    `flsa_compliance_flag` BOOLEAN COMMENT 'Whether this entry complies with FLSA regulations',
    `flsa_exempt` BOOLEAN COMMENT 'Whether the employee is FLSA exempt for this period',
    `fte_percentage` DECIMAL(18,2) COMMENT 'FTE percentage for this pay period',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Court-ordered garnishment deduction amount',
    `gl_account_code` STRING COMMENT 'General ledger account code for labor posting',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross pay amount before deductions',
    `holiday_hours` DECIMAL(18,2) COMMENT 'Hours worked on recognized holidays',
    `is_approved` BOOLEAN COMMENT 'Boolean flag indicating the is approved status of the workforce time attendance record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `leave_type` STRING COMMENT 'Type of leave if applicable (PTO, sick, FMLA, bereavement)',
    `meal_break_minutes` STRING COMMENT 'Total meal break time in minutes',
    `missed_punch_count` STRING COMMENT 'Number of missed clock punches requiring correction',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Net pay amount after all deductions',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Hours spent on-call during this period',
    `osha_incident_related` BOOLEAN COMMENT 'Whether time is related to an OSHA workplace incident',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total overtime pay amount',
    `pay_period_end_date` DATE COMMENT 'End date of the pay period',
    `pay_period_start_date` DATE COMMENT 'Start date of the pay period',
    `pay_type` STRING COMMENT 'Type of pay (regular, overtime, holiday, differential)',
    `payment_method` STRING COMMENT 'Method of payment (direct deposit, check)',
    `payroll_run_date` DATE COMMENT 'Date the payroll was processed',
    `payroll_run_status` STRING COMMENT 'Status of the payroll run (pending, processed, voided)',
    `pto_hours` DECIMAL(18,2) COMMENT 'The pto hours of the workforce time attendance record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'The regular hours of the workforce time attendance record.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Number of regular (non-overtime) hours worked',
    `shift_date` DATE COMMENT 'Calendar date of the shift worked',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional pay for evening/night/weekend shifts',
    `shift_type` STRING COMMENT 'Type of shift worked (day, evening, night)',
    `source_system_code` STRING COMMENT 'Identifier of the timekeeping source system',
    `time_entry_type` STRING COMMENT 'Type of time entry (clock, manual, system-generated)',
    `timekeeper_corrected` BOOLEAN COMMENT 'Whether the entry was corrected by a timekeeper',
    `total_pay` DECIMAL(18,2) COMMENT 'The total pay of the workforce time attendance record.',
    `total_tax_deduction` DECIMAL(18,2) COMMENT 'Total tax withholding amount',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce time attendance record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `work_date` DATE COMMENT 'Timestamp capturing the work date associated with the workforce time attendance record.',
    `worked_hours` DECIMAL(18,2) COMMENT 'The worked hours of the workforce time attendance record.',
    CONSTRAINT pk_time_attendance PRIMARY KEY(`time_attendance_id`)
) COMMENT 'Time, attendance, and payroll processing records for all employees. Captures clock-in/clock-out events, total hours worked, overtime hours, missed punches, meal break deductions, pay period totals, approval status, and timekeeper corrections. Includes complete payroll processing: gross pay, net pay, base salary/hourly rate, shift differentials, overtime pay, bonuses, deductions (taxes, benefits, garnishments), pay period dates, payroll run status, payment method (direct deposit, check), and GL cost center allocation. Tracks FLSA compliance flags and supports labor cost allocation by cost center and department. SSOT for all workforce time tracking and payroll data. Sourced from Workday HCM Time Tracking and Payroll modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment within the workforce benefit enrollment record.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan within the workforce benefit enrollment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce benefit enrollment record.',
    `coverage_level` STRING COMMENT 'The coverage level of the workforce benefit enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce benefit enrollment record.',
    `dependents_covered_count` STRING COMMENT 'The dependents covered count of the workforce benefit enrollment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce benefit enrollment record.',
    `election_date` DATE COMMENT 'Timestamp capturing the election date associated with the workforce benefit enrollment record.',
    `employee_contribution` DECIMAL(18,2) COMMENT 'The employee contribution of the workforce benefit enrollment record.',
    `employer_contribution` DECIMAL(18,2) COMMENT 'The employer contribution of the workforce benefit enrollment record.',
    `enrollment_status` STRING COMMENT 'The enrollment status value classifying the workforce benefit enrollment record.',
    `life_event_type` STRING COMMENT 'The life event type value classifying the workforce benefit enrollment record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the workforce benefit enrollment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce benefit enrollment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment records capturing elected benefit plans (medical, dental, vision, life insurance, disability, FSA, HSA, 403(b)/401(k) retirement), coverage tier (employee only, employee+spouse, family), enrollment effective date, termination date, and annual election amounts. Tracks open enrollment events and qualifying life event changes. Sourced from Workday HCM Benefits module.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request within the workforce leave request record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approver employee within the workforce leave request record.',
    `leave_employee_id` BIGINT COMMENT 'Unique identifier for the leave employee within the workforce leave request record.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp of the workforce leave request record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce leave request record.',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the workforce leave request record.',
    `fmla_case_number` STRING COMMENT 'The fmla case number of the workforce leave request record.',
    `is_fmla_eligible` BOOLEAN COMMENT 'Boolean flag indicating the is fmla eligible status of the workforce leave request record.',
    `is_paid` BOOLEAN COMMENT 'Boolean flag indicating the is paid status of the workforce leave request record.',
    `leave_reason` STRING COMMENT 'The leave reason of the workforce leave request record.',
    `leave_status` STRING COMMENT 'The leave status value classifying the workforce leave request record.',
    `leave_type` STRING COMMENT 'The leave type value classifying the workforce leave request record.',
    `notes` STRING COMMENT 'The notes of the workforce leave request record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the workforce leave request record.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The submitted timestamp of the workforce leave request record.',
    `total_hours` DECIMAL(18,2) COMMENT 'The total hours of the workforce leave request record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce leave request record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave of absence requests and approved leave records, including FMLA (Family and Medical Leave Act), personal leave, military leave (USERRA), workers compensation leave, bereavement, and PTO. Captures leave type, requested start/end dates, approved dates, intermittent leave tracking, FMLA eligibility determination, and return-to-work status. Sourced from Workday HCM Absence Management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review within the workforce performance review record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the performance employee within the workforce performance review record.',
    `review_template_id` BIGINT COMMENT 'Unique identifier for the review template within the workforce performance review record.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier for the reviewer employee within the workforce performance review record.',
    `completed_date` DATE COMMENT 'Timestamp capturing the completed date associated with the workforce performance review record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce performance review record.',
    `development_areas` STRING COMMENT 'The development areas of the workforce performance review record.',
    `employee_comments` STRING COMMENT 'The employee comments of the workforce performance review record.',
    `goals_met_count` STRING COMMENT 'The goals met count of the workforce performance review record.',
    `goals_total_count` STRING COMMENT 'The goals total count of the workforce performance review record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the workforce performance review record.',
    `overall_rating` DECIMAL(18,2) COMMENT 'The overall rating of the workforce performance review record.',
    `rating_scale` STRING COMMENT 'The rating scale of the workforce performance review record.',
    `review_period_end` DATE COMMENT 'The review period end of the workforce performance review record.',
    `review_period_start` DATE COMMENT 'The review period start of the workforce performance review record.',
    `review_status` STRING COMMENT 'The review status value classifying the workforce performance review record.',
    `review_type` STRING COMMENT 'The review type value classifying the workforce performance review record.',
    `strengths_summary` STRING COMMENT 'The strengths summary of the workforce performance review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce performance review record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Comprehensive employee performance management, talent development, and conduct records. Captures performance evaluation cycles (annual, mid-year, probationary), overall ratings, goal achievement, competency ratings, manager feedback, self-assessments, development goals, and review completion status. Includes talent profile data: education history, skills inventory, career interests, mobility preferences, mentorship participation, succession plan inclusion, and high-potential designation. Encompasses progressive discipline records: verbal/written warnings, performance improvement plans (PIPs), suspensions, terminations for cause, policy violations, appeal status, and resolution outcomes. Supports merit increases, promotion eligibility, internal mobility, succession management, workforce planning, and HR compliance documentation. SSOT for all employee performance, talent, and disciplinary data. Sourced from Workday HCM Talent Management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` (
    `recruitment_id` BIGINT COMMENT 'Unique identifier for the recruitment record',
    `applicant_id` BIGINT COMMENT 'FK to the applicant record',
    `care_site_id` BIGINT COMMENT 'FK to the hiring facility',
    `job_profile_id` BIGINT COMMENT 'FK to the job profile being recruited for',
    `position_id` BIGINT COMMENT 'FK to the position being filled',
    `employee_id` BIGINT COMMENT 'FK to the recruiter employee',
    `recruitment_hiring_manager_employee_id` BIGINT COMMENT 'Unique identifier for the recruitment hiring manager employee within the workforce recruitment record.',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit with the opening',
    `actual_start_date` DATE COMMENT 'Actual start date of the new hire',
    `applicant_count` STRING COMMENT 'The applicant count of the workforce recruitment record.',
    `applicant_email` STRING COMMENT 'Email address of the applicant',
    `applicant_phone` STRING COMMENT 'Phone number of the applicant',
    `application_date` DATE COMMENT 'Date the application was submitted',
    `background_check_date` DATE COMMENT 'Date background check was completed',
    `background_check_status` STRING COMMENT 'Status of background check (pending, clear, flagged)',
    `badge_issued` BOOLEAN COMMENT 'Whether employee badge has been issued',
    `close_date` DATE COMMENT 'Timestamp capturing the close date associated with the workforce recruitment record.',
    `cost_per_hire` DECIMAL(18,2) COMMENT 'Total recruitment cost for this hire',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recruitment record was created',
    `credentialing_initiated` BOOLEAN COMMENT 'Whether credentialing process has been initiated for clinical hires',
    `drug_screen_status` STRING COMMENT 'Status of pre-employment drug screening',
    `employment_type` STRING COMMENT 'Type of employment (full-time, part-time, PRN)',
    `fire_safety_training_completed` BOOLEAN COMMENT 'Whether fire safety training is completed',
    `fte_value` DECIMAL(18,2) COMMENT 'FTE value of the position being recruited',
    `hipaa_training_completed` BOOLEAN COMMENT 'Whether HIPAA privacy training is completed',
    `hire_date` DATE COMMENT 'Official hire date',
    `hire_decision` STRING COMMENT 'Final hiring decision (hire, no-hire, hold)',
    `i9_completion_date` DATE COMMENT 'Date I-9 employment verification was completed',
    `i9_verification_status` STRING COMMENT 'Status of I-9 employment eligibility verification',
    `infection_control_training_completed` BOOLEAN COMMENT 'Whether infection control training is completed',
    `interview_count` STRING COMMENT 'The interview count of the workforce recruitment record.',
    `interview_date` DATE COMMENT 'Date of the most recent interview',
    `interview_stage` STRING COMMENT 'Current interview stage (phone screen, panel, peer)',
    `is_clinical_position` BOOLEAN COMMENT 'Whether the position is a clinical role',
    `license_verified` BOOLEAN COMMENT 'Whether professional license has been verified',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `number_of_openings` STRING COMMENT 'The number of openings of the workforce recruitment record.',
    `offer_accepted_date` DATE COMMENT 'Date the offer was accepted',
    `offer_count` STRING COMMENT 'The offer count of the workforce recruitment record.',
    `offer_date` DATE COMMENT 'Date the employment offer was extended',
    `offer_status` STRING COMMENT 'Status of the offer (pending, accepted, declined, rescinded)',
    `offered_salary` DECIMAL(18,2) COMMENT 'Annual salary or hourly rate offered',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Whether OIG exclusion list was checked',
    `onboarding_completion_date` DATE COMMENT 'Date all onboarding tasks were completed',
    `onboarding_status` STRING COMMENT 'Overall onboarding status (not started, in progress, complete)',
    `onboarding_target_completion_date` DATE COMMENT 'Target date for onboarding completion',
    `open_date` DATE COMMENT 'Timestamp capturing the open date associated with the workforce recruitment record.',
    `orientation_completion_date` DATE COMMENT 'Date orientation was completed',
    `orientation_status` STRING COMMENT 'Status of new employee orientation',
    `pay_grade` STRING COMMENT 'Pay grade level for the position',
    `pipeline_stage` STRING COMMENT 'Current stage in the recruitment pipeline',
    `policy_acknowledgment_completed` BOOLEAN COMMENT 'Whether all policy acknowledgments are signed',
    `posting_date` DATE COMMENT 'Date the job was posted externally',
    `recruiter_name` STRING COMMENT 'The recruiter name of the workforce recruitment record.',
    `reference_check_status` STRING COMMENT 'Status of professional reference checks',
    `relocation_assistance_amount` DECIMAL(18,2) COMMENT 'Relocation assistance amount offered',
    `required_license_type` STRING COMMENT 'Professional license type required for the role',
    `requisition_number` STRING COMMENT 'Unique requisition number for the job opening',
    `requisition_open_date` DATE COMMENT 'Date the requisition was opened',
    `requisition_status` STRING COMMENT 'Status of the requisition (open, filled, cancelled)',
    `signing_bonus_amount` DECIMAL(18,2) COMMENT 'Signing bonus amount offered',
    `source_channel` STRING COMMENT 'The source channel of the workforce recruitment record.',
    `source_of_hire` STRING COMMENT 'Recruitment source (job board, referral, agency, internal)',
    `system_access_provisioned` BOOLEAN COMMENT 'Whether IT system access has been provisioned',
    `target_fill_date` DATE COMMENT 'Timestamp capturing the target fill date associated with the workforce recruitment record.',
    `target_start_date` DATE COMMENT 'Target start date for the new hire',
    `time_to_fill_days` STRING COMMENT 'Number of days from requisition open to hire',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to the recruitment record',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `workday_candidate_code` STRING COMMENT 'Candidate identifier in Workday HRIS',
    CONSTRAINT pk_recruitment PRIMARY KEY(`recruitment_id`)
) COMMENT 'End-to-end recruitment and onboarding lifecycle from job requisition through productive employee. Captures requisition details, posting channels, applicant pipeline, interview stages, offer details, background check status, pre-employment screening results, and hire decision. Includes complete onboarding process: I-9 verification, orientation attendance, policy acknowledgments, system access provisioning, required training completions (HIPAA, infection control, fire safety), badge issuance, department-specific orientation, onboarding start date, target completion date, and task-level completion status. Tracks time-to-fill, source of hire, cost per hire, recruiter assignment. Links to authorized positions for headcount control. SSOT for all hiring and onboarding data. Sourced from Workday HCM Recruiting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` (
    `osha_incident_id` BIGINT COMMENT 'Unique identifier for the osha incident within the workforce osha incident record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce osha incident record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce osha incident record.',
    `body_part_affected` STRING COMMENT 'The body part affected of the workforce osha incident record.',
    `corrective_action` STRING COMMENT 'The corrective action of the workforce osha incident record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce osha incident record.',
    `incident_date` DATE COMMENT 'Timestamp capturing the incident date associated with the workforce osha incident record.',
    `incident_number` STRING COMMENT 'The incident number of the workforce osha incident record.',
    `incident_time` TIMESTAMP COMMENT 'Timestamp capturing the incident time associated with the workforce osha incident record.',
    `incident_type` STRING COMMENT 'The incident type value classifying the workforce osha incident record.',
    `injury_type` STRING COMMENT 'The injury type value classifying the workforce osha incident record.',
    `is_recordable` BOOLEAN COMMENT 'Boolean flag indicating the is recordable status of the workforce osha incident record.',
    `location_description` STRING COMMENT 'The location description of the workforce osha incident record.',
    `lost_workdays` STRING COMMENT 'The lost workdays of the workforce osha incident record.',
    `osha_form_300_logged_flag` BOOLEAN COMMENT 'The osha form 300 logged flag of the workforce osha incident record.',
    `restricted_workdays` STRING COMMENT 'The restricted workdays of the workforce osha incident record.',
    `return_to_work_date` DATE COMMENT 'Timestamp capturing the return to work date associated with the workforce osha incident record.',
    `root_cause` STRING COMMENT 'The root cause of the workforce osha incident record.',
    `severity_level` STRING COMMENT 'The severity level of the workforce osha incident record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce osha incident record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `workers_comp_claim_number` STRING COMMENT 'The workers comp claim number of the workforce osha incident record.',
    CONSTRAINT pk_osha_incident PRIMARY KEY(`osha_incident_id`)
) COMMENT 'OSHA-recordable workplace injury, illness, and near-miss incident records for healthcare employees. Captures incident date/time, employee involved, incident type (needlestick, musculoskeletal, exposure, slip/fall), body part affected, injury severity, OSHA recordability determination, days away from work, restricted duty days, root cause analysis, corrective actions, and OSHA 300/300A log entries. Supports OSHA compliance reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` (
    `fte_budget_id` BIGINT COMMENT 'Unique identifier for the fte budget within the workforce fte budget record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the workforce fte budget record.',
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile within the workforce fte budget record.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the workforce fte budget record.',
    `actual_fte` DECIMAL(18,2) COMMENT 'The actual fte of the workforce fte budget record.',
    `actual_salary_amount` DECIMAL(18,2) COMMENT 'The actual salary amount of the workforce fte budget record.',
    `agency_fte` DECIMAL(18,2) COMMENT 'The agency fte of the workforce fte budget record.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The budgeted fte of the workforce fte budget record.',
    `budgeted_salary_amount` DECIMAL(18,2) COMMENT 'The budgeted salary amount of the workforce fte budget record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce fte budget record.',
    `fiscal_period` STRING COMMENT 'The fiscal period of the workforce fte budget record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the workforce fte budget record.',
    `overtime_hours_budget` DECIMAL(18,2) COMMENT 'The overtime hours budget of the workforce fte budget record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce fte budget record.',
    `vacancy_count` STRING COMMENT 'The vacancy count of the workforce fte budget record.',
    `variance_fte` DECIMAL(18,2) COMMENT 'The variance fte of the workforce fte budget record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_fte_budget PRIMARY KEY(`fte_budget_id`)
) COMMENT 'Authorized FTE (Full-Time Equivalent) budget allocations by department, cost center, and fiscal period. Captures budgeted FTE count by job family and pay type (productive, non-productive, overtime), actual FTE utilization, variance analysis, budget approval status, and labor cost per adjusted patient day. Supports workforce financial planning, labor cost management, productivity benchmarking, and staffing ratio compliance. Integrates with SAP S/4HANA CO and Workday HCM.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit within the workforce org unit record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce org unit record.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the workforce org unit record.',
    `parent_org_unit_id` BIGINT COMMENT 'Unique identifier for the parent org unit within the workforce org unit record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the manager employee within the workforce org unit record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce org unit record.',
    `deactivation_date` DATE COMMENT 'Timestamp capturing the deactivation date associated with the workforce org unit record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce org unit record.',
    `headcount` STRING COMMENT 'The headcount of the workforce org unit record.',
    `hierarchy_level` STRING COMMENT 'The hierarchy level of the workforce org unit record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the workforce org unit record.',
    `unit_code` STRING COMMENT 'The unit code value classifying the workforce org unit record.',
    `unit_name` STRING COMMENT 'The unit name of the workforce org unit record.',
    `unit_status` STRING COMMENT 'The unit status value classifying the workforce org unit record.',
    `unit_type` STRING COMMENT 'The unit type value classifying the workforce org unit record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce org unit record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for the healthcare workforce, defining departments, divisions, service lines, and cost centers as managed in Workday HCM. Captures org unit name, org unit type (department, division, service line), parent org unit, effective dates, cost center code, facility association, and management hierarchy. Serves as the workforce-specific organizational structure distinct from the facility domains physical structure.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` (
    `clinical_privilege_id` BIGINT COMMENT 'Unique identifier for the clinical privilege within the workforce clinical privilege record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce clinical privilege record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the workforce clinical privilege record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce clinical privilege record.',
    `cases_performed` STRING COMMENT 'The cases performed of the workforce clinical privilege record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce clinical privilege record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the workforce clinical privilege record.',
    `granted_date` DATE COMMENT 'Timestamp capturing the granted date associated with the workforce clinical privilege record.',
    `minimum_cases_required` STRING COMMENT 'The minimum cases required of the workforce clinical privilege record.',
    `notes` STRING COMMENT 'The notes of the workforce clinical privilege record.',
    `privilege_category` STRING COMMENT 'The privilege category of the workforce clinical privilege record.',
    `privilege_code` STRING COMMENT 'The privilege code value classifying the workforce clinical privilege record.',
    `privilege_name` STRING COMMENT 'The privilege name of the workforce clinical privilege record.',
    `privilege_status` STRING COMMENT 'The privilege status value classifying the workforce clinical privilege record.',
    `proctoring_completed_flag` BOOLEAN COMMENT 'The proctoring completed flag of the workforce clinical privilege record.',
    `proctoring_required_flag` BOOLEAN COMMENT 'The proctoring required flag of the workforce clinical privilege record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce clinical privilege record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_clinical_privilege PRIMARY KEY(`clinical_privilege_id`)
) COMMENT 'This association product represents the credentialing relationship between healthcare workforce members and specific CPT procedures they are authorized to perform. It captures the medical staff services offices privilege granting, competency assessment, and ongoing professional practice evaluation. Each record links one employee (clinician) to one CPT code with privilege-specific attributes including grant/expiration dates, competency level, volume requirements, and supervision needs. This is the operational foundation of medical staff credentialing and delineation of privileges.. Existence Justification: Clinical privileges represent the operational credentialing relationship where healthcare providers (physicians, nurses, allied health) are granted authority to perform specific procedures (CPT codes). In real-world medical staff services operations, a single surgeon holds privileges for 20-200 different CPT codes (e.g., appendectomy, cholecystectomy, hernia repair), and each CPT code has 50+ credentialed clinicians across the health system. The medical staff services office actively manages these privileges with grant/expiration dates, competency assessments, volume requirements, and supervision rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` (
    `channel_support_assignment_id` BIGINT COMMENT 'Unique identifier for the channel support assignment within the workforce channel support assignment record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce channel support assignment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce channel support assignment record.',
    `assignment_status` STRING COMMENT 'The assignment status value classifying the workforce channel support assignment record.',
    `channel_type` STRING COMMENT 'The channel type value classifying the workforce channel support assignment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce channel support assignment record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce channel support assignment record.',
    `languages_supported` STRING COMMENT 'The languages supported of the workforce channel support assignment record.',
    `max_concurrent_sessions` STRING COMMENT 'The max concurrent sessions of the workforce channel support assignment record.',
    `schedule_preference` STRING COMMENT 'The schedule preference of the workforce channel support assignment record.',
    `skill_level` STRING COMMENT 'The skill level of the workforce channel support assignment record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the workforce channel support assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce channel support assignment record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_channel_support_assignment PRIMARY KEY(`channel_support_assignment_id`)
) COMMENT 'This association product represents the operational support assignment between healthcare IT workforce members and interface channels. It captures the tiered support structure (primary, backup, escalation), on-call rotation schedules, and assignment lifecycle for incident management and workforce scheduling. Each record links one employee to one interface channel with role-specific attributes that exist only in the context of this support relationship.. Existence Justification: Healthcare IT operations require multi-tiered support coverage for interface channels (HL7 feeds, FHIR endpoints, Direct messaging). A single interface channel has multiple support staff assigned in different roles (primary, backup, escalation), and a single IT workforce member supports multiple interface channels across different systems. Organizations actively manage these assignments for on-call rotations, incident escalation paths, and workforce scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` (
    `position_procedure_authorization_id` BIGINT COMMENT 'Unique identifier for the procedure authorization record',
    `cpt_code_id` BIGINT COMMENT 'FK to the CPT procedure code authorized',
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile within the workforce position procedure authorization record.',
    `position_id` BIGINT COMMENT 'FK to the position authorized to perform the procedure',
    `age_restriction` STRING COMMENT 'Patient age restrictions for this authorization (e.g., adult only, pediatric)',
    `authorization_level` STRING COMMENT 'Level of authorization (independent, supervised, assist)',
    `authorization_status` STRING COMMENT 'Current status (active, suspended, revoked, pending)',
    `cases_performed_count` STRING COMMENT 'Number of cases performed under this authorization',
    `competency_required` BOOLEAN COMMENT 'The competency required of the workforce position procedure authorization record.',
    `competency_validation_frequency` STRING COMMENT 'How often competency must be revalidated (annual, biennial)',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the authorization was created',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce position procedure authorization record.',
    `credentialing_committee_approval_date` DATE COMMENT 'Date the credentialing committee approved the authorization',
    `effective_date` DATE COMMENT 'Date the authorization becomes effective',
    `expiration_date` DATE COMMENT 'Date the authorization expires',
    `last_competency_validation_date` DATE COMMENT 'Date of most recent competency validation',
    `minimum_cases_required` STRING COMMENT 'Minimum number of cases required for competency',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `notes` STRING COMMENT 'Additional notes about the authorization',
    `procedure_code` STRING COMMENT 'The procedure code value classifying the workforce position procedure authorization record.',
    `procedure_name` STRING COMMENT 'The procedure name of the workforce position procedure authorization record.',
    `regulatory_basis` STRING COMMENT 'The regulatory basis of the workforce position procedure authorization record.',
    `requires_supervision` BOOLEAN COMMENT 'The requires supervision of the workforce position procedure authorization record.',
    `risk_category` STRING COMMENT 'Risk category of the procedure (low, medium, high)',
    `scope_of_practice` STRING COMMENT 'The scope of practice of the workforce position procedure authorization record.',
    `setting_restriction` STRING COMMENT 'Care setting restrictions (inpatient only, OR only)',
    `source_system_code` STRING COMMENT 'Identifier of the source credentialing system',
    `supervision_requirement` STRING COMMENT 'Type of supervision required (direct, general, none)',
    `training_description` STRING COMMENT 'Description of required training for this procedure',
    `training_required` BOOLEAN COMMENT 'Whether additional training is required',
    `updated_date` TIMESTAMP COMMENT 'Timestamp of last update to the authorization',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce position procedure authorization record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `volume_expectation` STRING COMMENT 'Expected annual procedure volume',
    `created_by` STRING COMMENT 'User who created the authorization record',
    CONSTRAINT pk_position_procedure_authorization PRIMARY KEY(`position_procedure_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between workforce positions and CPT procedure codes. It captures which procedures each position type is credentialed and authorized to perform, including supervision requirements, volume expectations, and training prerequisites. Each record links one position to one CPT code with authorization-specific attributes that exist only in the context of this relationship. Supports competency management, credentialing workflows, and clinical privilege tracking.. Existence Justification: In healthcare workforce management, positions are authorized to perform multiple CPT procedures based on credentials, training, and clinical privileges, and each CPT procedure can be performed by multiple position types with varying authorization levels. The business actively manages position-procedure authorizations as part of credentialing workflows, competency frameworks, and clinical privilege management. This is an operational relationship tracked in medical staff services and HR systems, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan within the workforce benefit plan record.',
    `carrier_name` STRING COMMENT 'The carrier name of the workforce benefit plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce benefit plan record.',
    `benefit_plan_description` STRING COMMENT 'The benefit plan description of the workforce benefit plan record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce benefit plan record.',
    `eligibility_waiting_days` STRING COMMENT 'The eligibility waiting days of the workforce benefit plan record.',
    `employee_contribution_pct` DECIMAL(18,2) COMMENT 'The employee contribution pct of the workforce benefit plan record.',
    `employer_contribution_pct` DECIMAL(18,2) COMMENT 'The employer contribution pct of the workforce benefit plan record.',
    `plan_category` STRING COMMENT 'The plan category of the workforce benefit plan record.',
    `plan_code` STRING COMMENT 'The plan code value classifying the workforce benefit plan record.',
    `plan_name` STRING COMMENT 'The plan name of the workforce benefit plan record.',
    `plan_status` STRING COMMENT 'The plan status value classifying the workforce benefit plan record.',
    `plan_type` STRING COMMENT 'The plan type value classifying the workforce benefit plan record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the workforce benefit plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce benefit plan record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`education_program` (
    `education_program_id` BIGINT COMMENT 'Unique identifier for the education program within the workforce education program record.',
    `employee_id` BIGINT COMMENT 'The employee id ref of the workforce education program record.',
    `ce_credits` DECIMAL(18,2) COMMENT 'The ce credits of the workforce education program record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce education program record.',
    `delivery_method` STRING COMMENT 'The delivery method of the workforce education program record.',
    `education_program_description` STRING COMMENT 'The education program description of the workforce education program record.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The duration hours of the workforce education program record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce education program record.',
    `frequency_requirement` STRING COMMENT 'The frequency requirement of the workforce education program record.',
    `mandatory_flag` BOOLEAN COMMENT 'The mandatory flag of the workforce education program record.',
    `program_code` STRING COMMENT 'The program code value classifying the workforce education program record.',
    `program_name` STRING COMMENT 'The program name of the workforce education program record.',
    `program_status` STRING COMMENT 'The program status value classifying the workforce education program record.',
    `program_type` STRING COMMENT 'The program type value classifying the workforce education program record.',
    `retirement_date` DATE COMMENT 'Timestamp capturing the retirement date associated with the workforce education program record.',
    `target_audience` STRING COMMENT 'The target audience of the workforce education program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce education program record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_education_program PRIMARY KEY(`education_program_id`)
) COMMENT 'Master reference table for education_program. Referenced by education_program_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Unique identifier for the review template',
    `org_unit_id` BIGINT COMMENT 'FK to the organizational unit this template applies to',
    `employee_id` BIGINT COMMENT 'FK to the employee who approved the template',
    `review_employee_id` BIGINT COMMENT 'FK to the employee who owns/created the template',
    `superseded_review_template_id` BIGINT COMMENT 'Self-referential FK to the previous version of this template',
    `allows_peer_review` BOOLEAN COMMENT 'Whether the template includes peer review components',
    `allows_self_assessment` BOOLEAN COMMENT 'Whether the template includes self-assessment',
    `applicable_role_type` STRING COMMENT 'Role types this template applies to (clinical, administrative, leadership)',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the template was approved',
    `archived_date` DATE COMMENT 'Date the template was archived',
    `archived_reason` STRING COMMENT 'Reason the template was archived',
    `average_completion_time_minutes` STRING COMMENT 'Average time in minutes to complete a review using this template',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'CME credit hours awarded for completing this review',
    `cme_eligible` BOOLEAN COMMENT 'Whether completing this review earns CME credits',
    `competency_section_count` STRING COMMENT 'The competency section count of the workforce review template record.',
    `compliance_framework` STRING COMMENT 'Regulatory compliance framework (Joint Commission, CMS, OSHA)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template was created',
    `credentialing_required` BOOLEAN COMMENT 'Whether this review is part of credentialing requirements',
    `review_template_description` STRING COMMENT 'Detailed description of the review template purpose',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce review template record.',
    `effective_end_date` DATE COMMENT 'Date the template is no longer in effect',
    `effective_start_date` DATE COMMENT 'Date the template becomes effective',
    `end_date` DATE COMMENT 'Timestamp capturing the end date associated with the workforce review template record.',
    `escalation_days_after_due` STRING COMMENT 'Days after due date before escalation is triggered',
    `goal_section_included` BOOLEAN COMMENT 'The goal section included of the workforce review template record.',
    `instructions` STRING COMMENT 'Instructions for completing the review',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the workforce review template record.',
    `is_mandatory` BOOLEAN COMMENT 'Whether this review is mandatory for applicable roles',
    `job_family` STRING COMMENT 'The job family of the workforce review template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification',
    `last_review_date` DATE COMMENT 'Date the template itself was last reviewed',
    `max_rating` DECIMAL(18,2) COMMENT 'The max rating of the workforce review template record.',
    `maximum_score` DECIMAL(18,2) COMMENT 'Maximum possible score on this review',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the review',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `next_review_date` DATE COMMENT 'Date the template is next due for review/update',
    `notification_days_before_due` STRING COMMENT 'Days before due date to send reminder notification',
    `question_count` STRING COMMENT 'Total number of questions/items in the template',
    `rating_scale` STRING COMMENT 'The rating scale of the workforce review template record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Whether this template satisfies a regulatory requirement',
    `requires_employee_acknowledgment` BOOLEAN COMMENT 'Whether employee must acknowledge the review results',
    `requires_manager_approval` BOOLEAN COMMENT 'Whether manager approval is required to finalize',
    `review_category` STRING COMMENT 'Category of review (annual, probationary, competency, peer)',
    `review_frequency` STRING COMMENT 'How often the review should be conducted (annual, semi-annual, quarterly)',
    `review_period_days` STRING COMMENT 'Number of days the review period covers',
    `review_type` STRING COMMENT 'The review type value classifying the workforce review template record.',
    `scoring_method` STRING COMMENT 'Method used for scoring (numeric, Likert, pass/fail)',
    `section_count` STRING COMMENT 'Number of sections in the review template',
    `source_system_code` STRING COMMENT 'Identifier of the source HR system',
    `review_template_status` STRING COMMENT 'Current status of the template (draft, active, archived)',
    `supports_development_plan` BOOLEAN COMMENT 'Whether the review generates a development plan',
    `template_code` STRING COMMENT 'Unique business code for the template',
    `template_name` STRING COMMENT 'Human-readable name of the review template',
    `template_type` STRING COMMENT 'Type of template (performance, competency, 360, clinical)',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce review template record.',
    `usage_count` STRING COMMENT 'Number of times this template has been used',
    `version_number` STRING COMMENT 'Version number of the template',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `weight_total` DECIMAL(18,2) COMMENT 'Total weight of all scoring sections (should sum to 100)',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Master reference table for review_template. Referenced by review_template_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique identifier for the applicant within the workforce applicant record.',
    `position_id` BIGINT COMMENT 'Unique identifier for the position within the workforce applicant record.',
    `application_date` DATE COMMENT 'Timestamp capturing the application date associated with the workforce applicant record.',
    `application_status` STRING COMMENT 'The application status value classifying the workforce applicant record.',
    `background_check_status` STRING COMMENT 'The background check status value classifying the workforce applicant record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce applicant record.',
    `email_address` STRING COMMENT 'The email address of the workforce applicant record.',
    `first_name` STRING COMMENT 'The first name of the workforce applicant record.',
    `highest_education` STRING COMMENT 'The highest education of the workforce applicant record.',
    `last_name` STRING COMMENT 'The last name of the workforce applicant record.',
    `license_verified_flag` BOOLEAN COMMENT 'The license verified flag of the workforce applicant record.',
    `offer_date` DATE COMMENT 'Timestamp capturing the offer date associated with the workforce applicant record.',
    `offer_status` STRING COMMENT 'The offer status value classifying the workforce applicant record.',
    `phone_number` STRING COMMENT 'The phone number of the workforce applicant record.',
    `rejection_reason` STRING COMMENT 'The rejection reason of the workforce applicant record.',
    `resume_url` STRING COMMENT 'The resume url of the workforce applicant record.',
    `source_channel` STRING COMMENT 'The source channel of the workforce applicant record.',
    `start_date` DATE COMMENT 'Timestamp capturing the start date associated with the workforce applicant record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce applicant record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    `years_experience` STRING COMMENT 'The years experience of the workforce applicant record.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master reference table for applicant. Referenced by applicant_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll run within the workforce payroll run record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the workforce payroll run record.',
    `payroll_calendar_id` BIGINT COMMENT 'Unique identifier for the payroll calendar within the workforce payroll run record.',
    `approved_by` STRING COMMENT 'The approved by of the workforce payroll run record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce payroll run record.',
    `employee_count` STRING COMMENT 'The employee count of the workforce payroll run record.',
    `pay_date` DATE COMMENT 'Timestamp capturing the pay date associated with the workforce payroll run record.',
    `period_end_date` DATE COMMENT 'Timestamp capturing the period end date associated with the workforce payroll run record.',
    `period_start_date` DATE COMMENT 'Timestamp capturing the period start date associated with the workforce payroll run record.',
    `processed_timestamp` TIMESTAMP COMMENT 'The processed timestamp of the workforce payroll run record.',
    `run_status` STRING COMMENT 'The run status value classifying the workforce payroll run record.',
    `run_type` STRING COMMENT 'The run type value classifying the workforce payroll run record.',
    `total_deductions` DECIMAL(18,2) COMMENT 'The total deductions of the workforce payroll run record.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'The total employer taxes of the workforce payroll run record.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'The total gross pay of the workforce payroll run record.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'The total net pay of the workforce payroll run record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce payroll run record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Unique identifier for the payroll calendar within the workforce payroll calendar record.',
    `approval_due_date` DATE COMMENT 'Timestamp capturing the approval due date associated with the workforce payroll calendar record.',
    `calendar_name` STRING COMMENT 'The calendar name of the workforce payroll calendar record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce payroll calendar record.',
    `fiscal_year` STRING COMMENT 'The fiscal year of the workforce payroll calendar record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the workforce payroll calendar record.',
    `pay_date` DATE COMMENT 'Timestamp capturing the pay date associated with the workforce payroll calendar record.',
    `pay_frequency` STRING COMMENT 'The pay frequency of the workforce payroll calendar record.',
    `period_end_date` DATE COMMENT 'Timestamp capturing the period end date associated with the workforce payroll calendar record.',
    `period_number` STRING COMMENT 'The period number of the workforce payroll calendar record.',
    `period_start_date` DATE COMMENT 'Timestamp capturing the period start date associated with the workforce payroll calendar record.',
    `timesheet_due_date` DATE COMMENT 'Timestamp capturing the timesheet due date associated with the workforce payroll calendar record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce payroll calendar record.',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Master reference table for payroll_calendar. Referenced by payroll_calendar_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` (
    `workforce_provider_network_participation_id` BIGINT COMMENT 'Unique identifier for the workforce provider network participation within the workforce workforce provider network participation record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the workforce workforce provider network participation record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the workforce workforce provider network participation record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer within the workforce workforce provider network participation record.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network within the workforce workforce provider network participation record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the workforce workforce provider network participation record.',
    `credentialing_expiration_date` DATE COMMENT 'Timestamp capturing the credentialing expiration date associated with the workforce workforce provider network participation record.',
    `credentialing_status` STRING COMMENT 'The credentialing status value classifying the workforce workforce provider network participation record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the workforce workforce provider network participation record.',
    `is_accepting_patients` BOOLEAN COMMENT 'Boolean flag indicating the is accepting patients status of the workforce workforce provider network participation record.',
    `mutator_applied_flag` BOOLEAN COMMENT 'Flag set by mutator to indicate modification',
    `network_tier` STRING COMMENT 'The network tier of the workforce workforce provider network participation record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the workforce workforce provider network participation record.',
    `participation_type` STRING COMMENT 'The participation type value classifying the workforce workforce provider network participation record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the workforce workforce provider network participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce workforce provider network participation record.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure a change',
    `vibe_structure_marker` STRING COMMENT 'Structure enforcement marker for 22-domain/541-product superset.',
    CONSTRAINT pk_workforce_provider_network_participation PRIMARY KEY(`workforce_provider_network_participation_id`)
) COMMENT 'Records for workforce provider network participation within the workforce domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_primary_position_department_workforce_org_unit_id` FOREIGN KEY (`primary_position_department_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_tertiary_position_workforce_org_unit_id` FOREIGN KEY (`tertiary_position_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_competency_employee_id` FOREIGN KEY (`competency_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_employment_competency_id` FOREIGN KEY (`employment_competency_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employment_competency`(`employment_competency_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_shift_employee_id` FOREIGN KEY (`shift_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_shift_workforce_org_unit_id` FOREIGN KEY (`shift_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_swap_source_schedule_id` FOREIGN KEY (`swap_source_schedule_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_time_employee_id` FOREIGN KEY (`time_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_leave_employee_id` FOREIGN KEY (`leave_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_recruitment_hiring_manager_employee_id` FOREIGN KEY (`recruitment_hiring_manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_review_employee_id` FOREIGN KEY (`review_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_superseded_review_template_id` FOREIGN KEY (`superseded_review_template_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_hr' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_workforce' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `is_clinical` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `ssn_last4` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_hr' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_workforce' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_position_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Job Profile');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `primary_position_department_workforce_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('pii_business_glossary_term' = 'Reports To Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `tertiary_position_workforce_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Position Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `budgeted_fte` SET TAGS ('pii_business_glossary_term' = 'Budgeted FTE');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `cme_hours_required` SET TAGS ('pii_business_glossary_term' = 'CME Hours Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('pii_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `employment_category` SET TAGS ('pii_business_glossary_term' = 'Employment Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('pii_business_glossary_term' = 'FLSA Classification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('pii_business_glossary_term' = 'FTE Allocation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `headcount_count` SET TAGS ('pii_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_business_glossary_term' = 'Is Clinical');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_critical_role` SET TAGS ('pii_business_glossary_term' = 'Is Critical Role');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_management` SET TAGS ('pii_business_glossary_term' = 'Is Management');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_provider` SET TAGS ('pii_business_glossary_term' = 'Is Provider');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_union_eligible` SET TAGS ('pii_business_glossary_term' = 'Is Union Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('pii_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('pii_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `on_call_required` SET TAGS ('pii_business_glossary_term' = 'On Call Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `osha_job_hazard_category` SET TAGS ('pii_business_glossary_term' = 'OSHA Hazard Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `patient_facing` SET TAGS ('pii_business_glossary_term' = 'Patient Facing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('pii_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_max` SET TAGS ('pii_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_midpoint` SET TAGS ('pii_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_min` SET TAGS ('pii_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('pii_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_certification` SET TAGS ('pii_business_glossary_term' = 'Required Certification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('pii_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_license_type` SET TAGS ('pii_business_glossary_term' = 'Required License Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `source_system_position_code` SET TAGS ('pii_business_glossary_term' = 'Source System Position Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('pii_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_business_glossary_term' = 'Telehealth Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `telehealth_eligible` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('pii_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `weekend_rotation_required` SET TAGS ('pii_business_glossary_term' = 'Weekend Rotation Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_hr' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_workforce' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_job_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `is_clinical` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Shift Schedule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `clinician_id` SET TAGS ('pii_business_glossary_term' = 'Clinician');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Employee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_workforce_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_source_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Swap Source Schedule');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_source_schedule_id` SET TAGS ('pii_relationship_role' = 'swap_source');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_source_schedule_id` SET TAGS ('pii_renamed_from' = 'swap_source_schedule_id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual End');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('pii_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Actual Start');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `approval_datetime` SET TAGS ('pii_business_glossary_term' = 'Approval Datetime');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_minutes` SET TAGS ('pii_business_glossary_term' = 'Break Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_datetime` SET TAGS ('pii_business_glossary_term' = 'Created Datetime');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `fte_value` SET TAGS ('pii_business_glossary_term' = 'FTE Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_agency_staff` SET TAGS ('pii_business_glossary_term' = 'Is Agency Staff');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_charge_role` SET TAGS ('pii_business_glossary_term' = 'Is Charge Role');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_float_assignment` SET TAGS ('pii_business_glossary_term' = 'Is Float Assignment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_holiday` SET TAGS ('pii_business_glossary_term' = 'Is Holiday');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_mandatory_overtime` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory Overtime');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `last_updated_datetime` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_business_glossary_term' = 'Nurse to Patient Ratio');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `on_call_response_minutes` SET TAGS ('pii_business_glossary_term' = 'On Call Response Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `patient_census` SET TAGS ('pii_business_glossary_term' = 'Patient Census');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `pay_code` SET TAGS ('pii_business_glossary_term' = 'Pay Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `published_datetime` SET TAGS ('pii_business_glossary_term' = 'Published Datetime');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `required_fte_coverage` SET TAGS ('pii_business_glossary_term' = 'Required FTE Coverage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('pii_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_number` SET TAGS ('pii_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Schedule Period End');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Schedule Period Start');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('pii_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled End');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_hours` SET TAGS ('pii_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_category` SET TAGS ('pii_business_glossary_term' = 'Shift Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_date` SET TAGS ('pii_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `skill_level_required` SET TAGS ('pii_business_glossary_term' = 'Skill Level Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_approved_by` SET TAGS ('pii_business_glossary_term' = 'Swap Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_approved_datetime` SET TAGS ('pii_business_glossary_term' = 'Swap Approved Datetime');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_attendance_id` SET TAGS ('pii_business_glossary_term' = 'Time Attendance Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `base_pay_rate` SET TAGS ('pii_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `benefits_deduction` SET TAGS ('pii_business_glossary_term' = 'Benefits Deduction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `bonus_amount` SET TAGS ('pii_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `callback_hours` SET TAGS ('pii_business_glossary_term' = 'Callback Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock In');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock Out');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `correction_reason` SET TAGS ('pii_business_glossary_term' = 'Correction Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `flsa_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'FLSA Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `flsa_exempt` SET TAGS ('pii_business_glossary_term' = 'FLSA Exempt');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `fte_percentage` SET TAGS ('pii_business_glossary_term' = 'FTE Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `garnishment_deduction` SET TAGS ('pii_business_glossary_term' = 'Garnishment Deduction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Pay');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `holiday_hours` SET TAGS ('pii_business_glossary_term' = 'Holiday Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `leave_type` SET TAGS ('pii_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `meal_break_minutes` SET TAGS ('pii_business_glossary_term' = 'Meal Break Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `missed_punch_count` SET TAGS ('pii_business_glossary_term' = 'Missed Punch Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Net Pay');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `on_call_hours` SET TAGS ('pii_business_glossary_term' = 'On Call Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `osha_incident_related` SET TAGS ('pii_business_glossary_term' = 'OSHA Incident Related');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `overtime_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Overtime Pay');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period End');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period Start');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_type` SET TAGS ('pii_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `regular_hours_worked` SET TAGS ('pii_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_date` SET TAGS ('pii_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_differential_amount` SET TAGS ('pii_business_glossary_term' = 'Shift Differential');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('pii_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `timekeeper_corrected` SET TAGS ('pii_business_glossary_term' = 'Timekeeper Corrected');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `total_tax_deduction` SET TAGS ('pii_business_glossary_term' = 'Total Tax Deduction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_subdomain' = 'benefits_leave');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_subdomain' = 'benefits_leave');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_id` SET TAGS ('pii_business_glossary_term' = 'Recruitment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_id` SET TAGS ('pii_business_glossary_term' = 'Applicant');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Job Profile');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Recruiter');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_business_glossary_term' = 'Applicant Email');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_business_glossary_term' = 'Applicant Phone');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `background_check_date` SET TAGS ('pii_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `background_check_status` SET TAGS ('pii_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `badge_issued` SET TAGS ('pii_business_glossary_term' = 'Badge Issued');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `cost_per_hire` SET TAGS ('pii_business_glossary_term' = 'Cost Per Hire');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `credentialing_initiated` SET TAGS ('pii_business_glossary_term' = 'Credentialing Initiated');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `drug_screen_status` SET TAGS ('pii_business_glossary_term' = 'Drug Screen Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `fire_safety_training_completed` SET TAGS ('pii_business_glossary_term' = 'Fire Safety Training');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `fte_value` SET TAGS ('pii_business_glossary_term' = 'FTE Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hipaa_training_completed` SET TAGS ('pii_business_glossary_term' = 'HIPAA Training');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hire_decision` SET TAGS ('pii_business_glossary_term' = 'Hire Decision');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `i9_completion_date` SET TAGS ('pii_business_glossary_term' = 'I-9 Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `i9_verification_status` SET TAGS ('pii_business_glossary_term' = 'I-9 Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `infection_control_training_completed` SET TAGS ('pii_business_glossary_term' = 'Infection Control Training');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_date` SET TAGS ('pii_business_glossary_term' = 'Interview Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_stage` SET TAGS ('pii_business_glossary_term' = 'Interview Stage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_business_glossary_term' = 'Is Clinical Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `license_verified` SET TAGS ('pii_business_glossary_term' = 'License Verified');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_accepted_date` SET TAGS ('pii_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_date` SET TAGS ('pii_business_glossary_term' = 'Offer Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_status` SET TAGS ('pii_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('pii_business_glossary_term' = 'Offered Salary');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('pii_business_glossary_term' = 'OIG Exclusion Checked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_completion_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_status` SET TAGS ('pii_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_target_completion_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Target Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `orientation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `orientation_status` SET TAGS ('pii_business_glossary_term' = 'Orientation Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `pay_grade` SET TAGS ('pii_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `pipeline_stage` SET TAGS ('pii_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `policy_acknowledgment_completed` SET TAGS ('pii_business_glossary_term' = 'Policy Acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruiter_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `reference_check_status` SET TAGS ('pii_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('pii_business_glossary_term' = 'Relocation Assistance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `required_license_type` SET TAGS ('pii_business_glossary_term' = 'Required License Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_open_date` SET TAGS ('pii_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_status` SET TAGS ('pii_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `signing_bonus_amount` SET TAGS ('pii_business_glossary_term' = 'Signing Bonus');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `source_of_hire` SET TAGS ('pii_business_glossary_term' = 'Source of Hire');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `system_access_provisioned` SET TAGS ('pii_business_glossary_term' = 'System Access Provisioned');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `target_start_date` SET TAGS ('pii_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `time_to_fill_days` SET TAGS ('pii_business_glossary_term' = 'Time to Fill Days');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `workday_candidate_code` SET TAGS ('pii_business_glossary_term' = 'Workday Candidate Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_subdomain' = 'benefits_leave');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `deactivation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_subdomain' = 'clinical_authorization');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_association_edges' = 'workforce.employee,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_subdomain' = 'clinical_authorization');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_association_edges' = 'workforce.employee,interoperability.interface_channel');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_subdomain' = 'clinical_authorization');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_association_edges' = 'workforce.position,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Position Procedure Authorization ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `authorization_level` SET TAGS ('pii_business_glossary_term' = 'Authorization Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `cases_performed_count` SET TAGS ('pii_business_glossary_term' = 'Cases Performed Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `competency_validation_frequency` SET TAGS ('pii_business_glossary_term' = 'Competency Validation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `credentialing_committee_approval_date` SET TAGS ('pii_business_glossary_term' = 'Committee Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `last_competency_validation_date` SET TAGS ('pii_business_glossary_term' = 'Last Competency Validation Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `minimum_cases_required` SET TAGS ('pii_business_glossary_term' = 'Minimum Cases Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `procedure_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_business_glossary_term' = 'Setting Restriction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `setting_restriction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `supervision_requirement` SET TAGS ('pii_business_glossary_term' = 'Supervision Requirement');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `training_description` SET TAGS ('pii_business_glossary_term' = 'Training Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `training_required` SET TAGS ('pii_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `updated_date` SET TAGS ('pii_business_glossary_term' = 'Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `volume_expectation` SET TAGS ('pii_business_glossary_term' = 'Volume Expectation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_subdomain' = 'benefits_leave');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_waiting_days` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `employee_id` SET TAGS ('pii_relationship' = 'fix_siloed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `employee_id` SET TAGS ('pii_created_by' = 'create_link');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_id` SET TAGS ('pii_business_glossary_term' = 'Review Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_employee_id` SET TAGS ('pii_business_glossary_term' = 'Template Owner Employee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `superseded_review_template_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Template');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `allows_peer_review` SET TAGS ('pii_business_glossary_term' = 'Allows Peer Review');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `allows_self_assessment` SET TAGS ('pii_business_glossary_term' = 'Allows Self Assessment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `applicable_role_type` SET TAGS ('pii_business_glossary_term' = 'Applicable Role Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `archived_date` SET TAGS ('pii_business_glossary_term' = 'Archived Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `archived_reason` SET TAGS ('pii_business_glossary_term' = 'Archived Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `average_completion_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Average Completion Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `cme_credit_hours` SET TAGS ('pii_business_glossary_term' = 'CME Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `cme_eligible` SET TAGS ('pii_business_glossary_term' = 'CME Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `credentialing_required` SET TAGS ('pii_business_glossary_term' = 'Credentialing Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `escalation_days_after_due` SET TAGS ('pii_business_glossary_term' = 'Escalation Days After Due');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `instructions` SET TAGS ('pii_business_glossary_term' = 'Instructions');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `max_rating` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `maximum_score` SET TAGS ('pii_business_glossary_term' = 'Maximum Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `minimum_passing_score` SET TAGS ('pii_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `notification_days_before_due` SET TAGS ('pii_business_glossary_term' = 'Notification Days Before Due');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `question_count` SET TAGS ('pii_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `requires_employee_acknowledgment` SET TAGS ('pii_business_glossary_term' = 'Requires Employee Acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `requires_manager_approval` SET TAGS ('pii_business_glossary_term' = 'Requires Manager Approval');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_category` SET TAGS ('pii_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_period_days` SET TAGS ('pii_business_glossary_term' = 'Review Period Days');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `scoring_method` SET TAGS ('pii_business_glossary_term' = 'Scoring Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `section_count` SET TAGS ('pii_business_glossary_term' = 'Section Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `supports_development_plan` SET TAGS ('pii_business_glossary_term' = 'Supports Development Plan');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_type` SET TAGS ('pii_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `usage_count` SET TAGS ('pii_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `weight_total` SET TAGS ('pii_business_glossary_term' = 'Weight Total');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `approved_by` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_subdomain' = 'clinical_authorization');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `is_accepting_patients` SET TAGS ('pii_mask_non_prod' = 'true');
