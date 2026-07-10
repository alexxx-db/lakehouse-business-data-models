-- Schema for Domain: workforce | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`workforce` COMMENT 'Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for each employee.',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: The employee table currently stores department as a free-text STRING column, which is a denormalization anti-pattern. The workforce domain has a dedicated department master table with department_id as',
    `unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_work_location_unit_id` BIGINT COMMENT 'Specific work site (e.g., kitchen, dining area) within the restaurant.',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: An employee holds a specific authorized position within the restaurant organization. This FK normalizes the employee-to-position relationship, enabling direct joins for role-based reporting, schedulin',
    `address_line1` STRING COMMENT 'Primary street address of the employees residence.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `bank_account_number` STRING COMMENT 'Bank account number used for direct deposit of payroll.',
    `city` STRING COMMENT 'City of the employees residence.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the employees residence. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN — 8 candidates stripped; promote to reference product]',
    `date_of_birth` DATE COMMENT 'Birth date of the employee, used for age‑based compliance and benefits.',
    `email` STRING COMMENT 'Primary email address used for employee communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization.. Valid values are `active|inactive|terminated|on_leave|retired`',
    `employment_type` STRING COMMENT 'Classification of employment relationship (Full‑Time, Part‑Time, Contractor).. Valid values are `fte|pte|contractor`',
    `first_name` STRING COMMENT 'Legal first name of the employee.',
    `full_name` STRING COMMENT 'Concatenated first and last name for display purposes.',
    `hire_date` DATE COMMENT 'Date the employee started employment with the company.',
    `labor_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the employees role.',
    `last_name` STRING COMMENT 'Legal last name of the employee.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime pay.',
    `pay_grade` STRING COMMENT 'Internal pay grade code used for compensation planning.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the employees residence.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `role_classification` STRING COMMENT 'Primary functional area where the employee works: Back‑of‑House, Front‑of‑House, Administrative, Support.. Valid values are `boh|foh|admin|support`',
    `salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount before bonuses or overtime.',
    `salary_currency` STRING COMMENT 'Three‑letter ISO currency code for the salary amount.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `servsafe_certified` BOOLEAN COMMENT 'Indicates whether the employee holds a valid ServSafe food safety certification.',
    `servsafe_expiration_date` DATE COMMENT 'Expiration date of the employees ServSafe certification.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern assigned to the employee.. Valid values are `morning|evening|night|flex|rotating`',
    `state` STRING COMMENT 'State or province of the employees residence.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identification number (e.g., SSN, SIN).',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `union_member` BOOLEAN COMMENT 'True if the employee is a member of a labor union.',
    `work_schedule_type` STRING COMMENT 'Scheduling model applied to the employee.. Valid values are `fixed|flex|rotating`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for every restaurant employee across company-owned and franchised locations. Captures full employee lifecycle data including personal details, employment type (FTE/PTE), BOH/FOH role classification, hire date, termination date, employment status, pay grade, home restaurant assignment, Workday HCM employee ID, declared availability windows (preferred dayparts, max weekly hours, blackout dates, cross-location availability), and current benefit enrollment summary. Single source of truth for workforce identity and worker profile across the enterprise.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'System-generated unique identifier for the job position.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Multi-brand restaurant enterprises create positions dedicated to specific loyalty programs (e.g., Loyalty Program Coordinator — Program X). This FK enables labor cost attribution by loyalty program ',
    `reports_to_position_id` BIGINT COMMENT 'Identifier of the supervisory position to which this role reports.',
    `unit_id` BIGINT COMMENT 'add column department_id (BIGINT) with FK to workforce.department.department_id - positions must belong to a department for org structure',
    `classification` STRING COMMENT 'Primary classification indicating whether the role is Back‑of‑House (BOH), Front‑of‑House (FOH), or Support.. Valid values are `BOH|FOH|Support`',
    `position_code` STRING COMMENT 'Business identifier code used to reference the position in HR and scheduling systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created.',
    `position_description` STRING COMMENT 'Detailed description of duties, responsibilities, and scope of the position.',
    `effective_end_date` DATE COMMENT 'Date when the position is retired or no longer available (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active for hiring.',
    `flsa_exempt` BOOLEAN COMMENT 'True if the position is exempt from Fair Labor Standards Act overtime rules.',
    `fte_equivalency` DECIMAL(18,2) COMMENT 'Full‑time equivalent factor used for labor forecasting (e.g., 1.0 = full‑time, 0.5 = half‑time).',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Base hourly compensation for hourly‑paid positions.',
    `is_manager` BOOLEAN COMMENT 'True if the position includes managerial responsibilities.',
    `labor_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for this position.',
    `position_level` STRING COMMENT 'Career level of the position within the organization hierarchy.. Valid values are `Entry|Mid|Senior|Lead`',
    `minimum_age` STRING COMMENT 'Minimum legal age required to be eligible for the position.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for overtime pay.',
    `pay_band` STRING COMMENT 'Compensation band used for salary or hourly rate determination.. Valid values are `A|B|C|D|E`',
    `position_status` STRING COMMENT 'Current lifecycle status of the position.. Valid values are `Active|Inactive|Archived`',
    `required_certifications` STRING COMMENT 'Comma‑separated list of mandatory certifications (e.g., ServSafe, Food Handler).',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience required for the position.',
    `salary_max` DECIMAL(18,2) COMMENT 'Upper bound of the annual salary range for salaried positions.',
    `salary_min` DECIMAL(18,2) COMMENT 'Lower bound of the annual salary range for salaried positions.',
    `shift_type` STRING COMMENT 'Typical shift pattern associated with the position.. Valid values are `Day|Night|Flex|Split`',
    `title` STRING COMMENT 'Human‑readable name of the job position (e.g., Crew Member, Shift Lead).',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for union representation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Defines authorized job positions within the restaurant organization, including role title (e.g., Crew Member, Shift Lead, Kitchen Manager, FOH Supervisor), BOH/FOH classification, pay band, FLSA exemption status, required certifications (e.g., ServSafe), FTE equivalency factor, and whether the position is eligible for overtime. Serves as the job catalog for workforce planning and scheduling.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique identifier for the shift record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who scheduled the shift.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Shifts are assigned to specific kitchen stations (grill, prep, expo). The existing plain-text station column is a denormalization of kitchen_station. A proper FK enables station-level labor cost rep',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Each shift is worked in a specific authorized position (e.g., Crew Member, Shift Lead, BOH Cook). The shift table currently stores station (STRING) but has no FK to the canonical position record. Addi',
    `primary_shift_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the shift.',
    `unit_id` BIGINT COMMENT 'Restaurant location where the shift occurs.',
    `actual_end` TIMESTAMP COMMENT 'Actual clock‑out timestamp recorded for the shift.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual worked hours for the shift (excluding breaks).',
    `actual_start` TIMESTAMP COMMENT 'Actual clock‑in timestamp recorded for the shift.',
    `break_duration_minutes` STRING COMMENT 'Total break time in minutes allocated for the shift.',
    `shift_code` STRING COMMENT 'Human‑readable code for the shift (e.g., SHIFT20230915-001).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift record was created.',
    `daypart` STRING COMMENT 'Part of the day the shift is scheduled for.. Valid values are `breakfast|lunch|dinner|late_night`',
    `is_deleted` BOOLEAN COMMENT 'Flag indicating soft deletion of the shift record.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for the shift (rate multiplied by actual hours).',
    `labor_percentage` DECIMAL(18,2) COMMENT 'Labor cost expressed as a percentage of projected sales for the shift.',
    `labor_rate_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the labor rate.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Pay rate per hour for the employee on this shift.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the shift.',
    `on_call_flag` BOOLEAN COMMENT 'Indicates if the shift is an on‑call assignment.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates if the shift includes overtime hours.',
    `scheduled_end` TIMESTAMP COMMENT 'Planned end timestamp of the shift.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Planned shift duration in hours (excluding breaks).',
    `scheduled_start` TIMESTAMP COMMENT 'Planned start timestamp of the shift.',
    `shift_date` DATE COMMENT 'Calendar date of the shift (derived from scheduled_start).',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `shift_type` STRING COMMENT 'Classification of the shift (e.g., regular, overtime, on‑call, training).. Valid values are `regular|overtime|on_call|training`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift record.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each labor schedule.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `schedule_manager_employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit for which the schedule is created.',
    `shift_id` BIGINT COMMENT 'add column shift_id (BIGINT) with FK to workforce.shift.shift_id - schedules should reference the shifts they contain',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule was formally approved by the manager.',
    `approved_by` STRING COMMENT 'Display name of the manager who approved the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was first created in the system.',
    `daypart_schedule_notes` STRING COMMENT 'Optional comments or special instructions for each daypart (e.g., event staffing, overtime alerts).',
    `fte_evening` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the evening shift (e.g., 16:00‑22:00).',
    `fte_midday` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the midday shift (e.g., 12:00‑16:00).',
    `fte_morning` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the morning shift (e.g., 06:00‑12:00).',
    `fte_night` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the night shift (e.g., 22:00‑02:00).',
    `fte_total` DECIMAL(18,2) COMMENT 'Sum of planned FTEs across all dayparts for the schedule period.',
    `labor_pct_evening` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the evening shift.',
    `labor_pct_midday` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the midday shift.',
    `labor_pct_morning` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the morning shift.',
    `labor_pct_night` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the night shift.',
    `labor_percentage` DECIMAL(18,2) COMMENT 'Target labor cost expressed as a percentage of projected sales for the period.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the schedule.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the schedule.',
    `schedule_number` STRING COMMENT 'Human‑readable schedule code assigned by the scheduling system (e.g., SCHED‑2024‑W15).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule: draft (editable), published (visible to staff), or locked (finalized).. Valid values are `draft|published|locked`',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Aggregate number of labor hours planned across all dayparts and positions for the schedule period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the schedule.',
    `version` STRING COMMENT 'Incremental version of the schedule used for audit and rollback purposes.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Weekly or period-level labor schedule published for a restaurant location, representing the planned staffing plan across all dayparts. Captures schedule period (start/end dates), restaurant unit, total scheduled hours, scheduled Labor%, FTE count by daypart, publication status (draft/published/locked), and the manager who approved the schedule. Links to individual shifts for granular staffing detail.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique surrogate key for the time entry record.',
    `payroll_record_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_record. Business justification: Time entries are the source data that payroll records aggregate. Linking time_entry.payroll_record_id to payroll_record creates a direct audit trail from individual clock-in/out events to the period p',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the time entry.',
    `shift_id` BIGINT COMMENT 'Identifier of the scheduled shift associated with this time entry.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Time entries capture actual clock-in/out events per role. The time_entry table stores job_role as a STRING, which duplicates the canonical position definition. Adding time_position_id normalizes this ',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the work was performed.',
    `approved_by_manager` BOOLEAN COMMENT 'True when a manager has approved the time entry.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the entry was approved by a manager.',
    `break_flag` BOOLEAN COMMENT 'True if a break was taken during the shift.',
    `break_minutes` STRING COMMENT 'Total minutes taken for breaks during the shift.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked in.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked out.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the time entry record was first created.',
    `entry_number` STRING COMMENT 'Human‑readable unique code for the time entry.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Monetary cost of the labor for this entry (total_hours * labor_rate).',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate applicable to the employee for this entry (in local currency).',
    `missed_punch_flag` BOOLEAN COMMENT 'True if the employee missed a clock‑in or clock‑out punch.',
    `notes` STRING COMMENT 'Optional free‑form comments or remarks about the time entry.',
    `overtime_flag` BOOLEAN COMMENT 'True if any overtime hours were recorded.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked.',
    `pay_code` STRING COMMENT 'Payroll code indicating the type of pay (regular, overtime, sick leave, etc.).. Valid values are `REG|OT|SL|VAC|OTHER`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of non‑overtime hours worked.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time of the shift according to the schedule.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time of the shift according to the schedule.',
    `time_entry_status` STRING COMMENT 'Current lifecycle status of the time entry.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `time_entry_type` STRING COMMENT 'Method by which the time entry was recorded.. Valid values are `clock_in_out|manual|adjustment`',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of hours (including overtime and breaks) recorded for the entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the time entry.',
    `work_date` DATE COMMENT 'Calendar date on which the shift occurred.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Captures actual clock-in and clock-out events for each employee per shift, sourced from Workday HCM time tracking or POS-integrated time clocks. Records regular hours, overtime hours, break time, missed punch flags, and manager approval status. Foundation for payroll processing, Labor% calculation, and compliance with FLSA/OSHA labor regulations.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'System-generated unique identifier for the payroll record.',
    `department_id` BIGINT COMMENT 'Identifier of the internal department (e.g., FOH, BOH) for cost allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the payroll pertains.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee works.',
    `benefit_deduction` DECIMAL(18,2) COMMENT 'Sum of employee benefit contributions deducted.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Monetary value of any bonus paid.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Monetary value of commission earned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `employee_address` STRING COMMENT 'Mailing address of the employee.',
    `employee_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `full_time|part_time|seasonal|contractor`',
    `fiscal_period` STRING COMMENT 'Period number within the fiscal year (e.g., Q1, Q2).',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions.',
    `is_bonus` BOOLEAN COMMENT 'Indicates whether the payroll includes a bonus component.',
    `job_title` STRING COMMENT 'Official job title or position held by the employee.',
    `labor_percent` DECIMAL(18,2) COMMENT 'Labor cost as a percentage of sales for the period.',
    `net_pay` DECIMAL(18,2) COMMENT 'Take‑home earnings after all deductions.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the payroll record.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Hourly rate applied to overtime hours.',
    `pay_date` DATE COMMENT 'Date on which the net amount is disbursed to the employee.',
    `pay_period_end` DATE COMMENT 'Last calendar day of the payroll period.',
    `pay_period_start` DATE COMMENT 'First calendar day of the payroll period.',
    `pay_rate` DECIMAL(18,2) COMMENT 'Standard hourly or salary rate for the employee.',
    `payroll_date` TIMESTAMP COMMENT 'Exact time the payroll was run in the source system.',
    `payroll_number` STRING COMMENT 'Human‑readable payroll reference number assigned by the payroll system.',
    `payroll_record_status` STRING COMMENT 'Current processing state of the payroll record.. Valid values are `processed|pending|error|cancelled`',
    `payroll_type` STRING COMMENT 'Nature of compensation for the period.. Valid values are `salary|hourly|commission|bonus`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total non‑overtime hours worked.',
    `tax_withheld` DECIMAL(18,2) COMMENT 'Total tax amount deducted from gross pay.',
    `tax_year` STRING COMMENT 'Fiscal year applicable for tax reporting.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Tips declared by the employee for the period.',
    `union_member_flag` BOOLEAN COMMENT 'True if the employee is a union member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payroll record.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Period-level payroll summary for each employee, capturing gross pay, net pay, regular hours paid, overtime hours paid, tips declared, deductions (benefits, taxes, garnishments), pay period dates, and payroll run status. Sourced from Workday HCM payroll module. Serves as the authoritative payroll transaction record for finance integration and Labor% reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'System-generated unique identifier for the certification record.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Brand standards mandate specific certifications (ServSafe, food handler, allergen training). Linking certification to the requiring brand_standard enables compliance gap analysis — identifying employe',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds this certification.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Certifications (ServSafe, food handler cards, allergen training) are required for specific authorized positions. The certification table stores related_role as a STRING, which is a denormalized refere',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - certifications should be trackable at the unit level for compliance reporting',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|revoked|pending`',
    `certification_type` STRING COMMENT 'Category of certification required for foodservice operations.. Valid values are `food_handler|manager|allergen|haccp|alcohol|osha`',
    `certification_code` STRING COMMENT 'Business identifier or code assigned to the certification by the issuing body.',
    `compliance_status` STRING COMMENT 'Regulatory compliance assessment of the certification.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the scanned certification document stored in the document repository.',
    `expiration_date` DATE COMMENT 'Date the certification expires and must be renewed.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the certification is required for the employees role.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification.. Valid values are `NRA_ServSafe|Local_Health_Department|OSHA|Other`',
    `last_verified_date` DATE COMMENT 'Date when the certification was last validated by internal audit.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., ServSafe Food Handler).',
    `notes` STRING COMMENT 'Free‑form notes regarding the certification (e.g., special conditions, comments).',
    `renewal_notice_date` DATE COMMENT 'Date a renewal reminder is sent to the employee.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification must be renewed before expiration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Single source of truth for all employee learning credentials, training completions, and regulatory certifications required for foodservice operations. Covers external certifications (ServSafe Food Handler, ServSafe Manager, allergen awareness, HACCP, alcohol service permits, OSHA safety) and internal training completions (new hire orientation, food safety modules, POS/KDS operation, BOH/FOH SOPs, LTO product training, management development). Captures credential type, issuing body (NRA ServSafe, local health department, internal L&D), delivery method (in-person, e-learning, OJT), issue/completion date, expiration date, assessment score, trainer/facilitator, and compliance status. Critical for food safety regulatory compliance, health department inspections, scheduling eligibility validation, and employee development tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'System-generated unique identifier for each training completion record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: Completing a training program often results in earning a certification (e.g., completing ServSafe training → ServSafe certification). The training_completion table has certification_required (BOOLEAN)',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Regulatory compliance requires employees to be trained on the specific HACCP plan version in effect. This FK links training completions to the exact HACCP plan covered, enabling plan-version-specific ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: New menu item rollout requires BOH staff training on specific recipes (prep method, cook temps, HACCP CCPs). Linking training_completion to recipe enables tracking which employees are certified on eac',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift associated with the training session.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the training was completed.',
    `assessment_max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for the assessment.',
    `assessment_passed` BOOLEAN COMMENT 'Indicates whether the employee passed the assessment (true) or not (false).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved by the employee on the training assessment.',
    `certification_expiration_date` DATE COMMENT 'Date when the certification earned from this training expires, if applicable.',
    `certification_required` BOOLEAN COMMENT 'True if the training results in a required certification for the employee.',
    `completion_number` STRING COMMENT 'Business-assigned code for the training completion event.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the employee finished the training.',
    `compliance_status` STRING COMMENT 'Indicates whether the training satisfies regulatory or internal compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training completion record was first created in the system.',
    `daypart` STRING COMMENT 'Daypart during which the training took place.. Valid values are `breakfast|lunch|dinner|late_night`',
    `delivery_method` STRING COMMENT 'Method used to deliver the training to the employee.. Valid values are `in_person|e_learning|on_the_job`',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or comments.',
    `required_for_role` STRING COMMENT 'Job role(s) for which this training is mandatory (e.g., cook, manager).',
    `trainer_name` STRING COMMENT 'Full name of the trainer or facilitator.',
    `training_category` STRING COMMENT 'More specific category or module within the training type.',
    `training_completion_status` STRING COMMENT 'Current lifecycle status of the training completion record.. Valid values are `completed|in_progress|failed|cancelled`',
    `training_duration_minutes` STRING COMMENT 'Total length of the training session in minutes.',
    `training_type` STRING COMMENT 'Broad classification of the training content.. Valid values are `safety|operations|customer_service|leadership`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training completion record.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Records completion of training programs by employees, including new hire orientation, food safety modules, POS operation, KDS usage, BOH/FOH SOPs, LTO product training, and management development programs. Captures training program name, delivery method (in-person, e-learning, OJT), completion date, assessment score, and trainer/facilitator. Supports compliance tracking and performance development.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `parent_department_id` BIGINT COMMENT 'Identifier of the immediate parent department in the organizational hierarchy.',
    `address_line1` STRING COMMENT 'Primary street address of the department.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Square‑footage occupied by the department.',
    `average_service_time_minutes` STRING COMMENT 'Average time in minutes to complete a core service task for the department.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the department (in USD).',
    `city` STRING COMMENT 'City in which the department is situated.',
    `classification` STRING COMMENT 'Higher‑level classification used for reporting and cost allocation.',
    `closing_date` DATE COMMENT 'Date the department was closed (null if still operating).',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier used for financial reporting.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the department is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was first created in the system.',
    `department_status` STRING COMMENT 'Current lifecycle status of the department.',
    `department_type` STRING COMMENT 'Categorizes the department by its functional area.',
    `department_description` STRING COMMENT 'Free‑form text describing the departments purpose and responsibilities.',
    `effective_from` DATE COMMENT 'Date when the department became operational.',
    `effective_until` DATE COMMENT 'Date when the department ceased operation (null if still active).',
    `email` STRING COMMENT 'Primary email address for department communications.',
    `floor_number` STRING COMMENT 'Physical floor on which the department is located.',
    `headcount` STRING COMMENT 'Number of full‑time equivalent staff assigned to the department.',
    `is_franchise` BOOLEAN COMMENT 'True if the department belongs to a franchised unit.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this department is the primary unit for its location.',
    `department_name` STRING COMMENT 'Human‑readable name of the department.',
    `opening_date` DATE COMMENT 'Date the department first opened for business.',
    `operational_hours` STRING COMMENT 'Standard daily operating hours expressed as HH:MM‑HH:MM.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the department.',
    `postal_code` STRING COMMENT 'Postal code for the departments address.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region.',
    `service_level` STRING COMMENT 'Level of service the department is expected to deliver.',
    `shift_schedule` STRING COMMENT 'Primary shift schedule pattern used by the department.',
    `turnover_rate` DECIMAL(18,2) COMMENT 'Annual percentage of staff turnover in the department.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the department record.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_primary_shift_employee_id` FOREIGN KEY (`primary_shift_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_manager_employee_id` FOREIGN KEY (`schedule_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_work_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Manager Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Employee Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Employee Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Bank Account Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Employee City');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Employee Country Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Employment Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|on_leave|retired');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Employment Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'fte|pte|contractor');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Full Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `labor_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Target Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Employee Pay Grade');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `role_classification` SET TAGS ('dbx_business_glossary_term' = 'Employee Role Classification');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `role_classification` SET TAGS ('dbx_value_regex' = 'boh|foh|admin|support');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Base Salary Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Employee Salary Currency');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `servsafe_certified` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `servsafe_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Certification Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Employee Shift Pattern');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'morning|evening|night|flex|rotating');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Employee State/Province');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Employee Tax Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|flex|rotating');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Position Classification');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'BOH|FOH|Support');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `flsa_exempt` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exempt Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `fte_equivalency` SET TAGS ('dbx_business_glossary_term' = 'FTE Equivalency Factor');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `is_manager` SET TAGS ('dbx_business_glossary_term' = 'Managerial Role Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `labor_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_level` SET TAGS ('dbx_value_regex' = 'Entry|Mid|Senior|Lead');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `pay_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Band');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `pay_band` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Archived');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'Day|Night|Flex|Split');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By User ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock‑Out Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Worked Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock‑In Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `labor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `labor_rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `labor_rate_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On‑Call Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|training');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approver Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approver Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved By');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `daypart_schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `fte_evening` SET TAGS ('dbx_business_glossary_term' = 'Evening FTE');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `fte_midday` SET TAGS ('dbx_business_glossary_term' = 'Midday FTE');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `fte_morning` SET TAGS ('dbx_business_glossary_term' = 'Morning FTE');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `fte_night` SET TAGS ('dbx_business_glossary_term' = 'Night FTE');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `fte_total` SET TAGS ('dbx_business_glossary_term' = 'Total Full‑Time Equivalent (FTE)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `labor_pct_evening` SET TAGS ('dbx_business_glossary_term' = 'Evening Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `labor_pct_midday` SET TAGS ('dbx_business_glossary_term' = 'Midday Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `labor_pct_morning` SET TAGS ('dbx_business_glossary_term' = 'Morning Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `labor_pct_night` SET TAGS ('dbx_business_glossary_term' = 'Night Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `labor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage (Labor% of Sales)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|locked');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Labor Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID (TEID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (SHIFT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Time Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `approved_by_manager` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Indicator (MGR_APPROVED)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `break_flag` SET TAGS ('dbx_business_glossary_term' = 'Break Indicator (BRK_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Minutes (BRK_MIN)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑In Timestamp (CI_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑Out Timestamp (CO_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number (TE_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LABOR_COST)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (LABOR_RATE)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `missed_punch_flag` SET TAGS ('dbx_business_glossary_term' = 'Missed Punch Indicator (MISSED_PUNCH)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE_TEXT)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Indicator (OT_FLAG)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours (OT_HRS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code (PAY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_value_regex' = 'REG|OT|SL|VAC|OTHER');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours (REG_HRS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End (SCH_END_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start (SCH_START_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status (TE_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type (TE_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'clock_in_out|manual|adjustment');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked (TOT_HRS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date (WORK_DT)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction` SET TAGS ('dbx_business_glossary_term' = 'Benefit Deduction Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Address');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `is_bonus` SET TAGS ('dbx_business_glossary_term' = 'Bonus Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Execution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_value_regex' = 'processed|pending|error|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|bonus');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Required For Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'food_handler|manager|allergen|haccp|alcohol|osha');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_value_regex' = 'NRA_ServSafe|Local_Health_Department|OSHA|Other');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Earned Certification Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `assessment_max_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Assessment Score (Points)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `assessment_passed` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passed Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score (Points)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status of Training');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart of Training (Breakfast, Lunch, etc.)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method (In-Person, E-Learning, On-The-Job)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|on_the_job');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes on Training Completion');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `required_for_role` SET TAGS ('dbx_business_glossary_term' = 'Required Role for Training');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Full Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type (Safety, Operations, etc.)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'safety|operations|customer_service|leadership');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `average_service_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Service Time Minutes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `is_franchise` SET TAGS ('dbx_business_glossary_term' = 'Is Franchise');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `turnover_rate` SET TAGS ('dbx_business_glossary_term' = 'Turnover Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
