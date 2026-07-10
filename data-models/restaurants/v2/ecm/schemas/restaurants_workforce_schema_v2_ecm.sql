-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`workforce` COMMENT 'Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for each employee.',
    `payroll_group_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_group. Business justification: Every employee belongs to a payroll group that governs pay frequency, currency, tax rules, and default benefit plan. The employee table has no payroll_group_id FK today, forcing downstream systems to ',
    `unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_work_location_unit_id` BIGINT COMMENT 'Specific work site (e.g., kitchen, dining area) within the restaurant.',
    `facility_id` BIGINT COMMENT 'Specific work site (e.g., kitchen, dining area) within the restaurant.',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `address_line1` STRING COMMENT 'Primary street address of the employees residence.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `bank_account_number` STRING COMMENT 'Bank account number used for direct deposit of payroll.',
    `city` STRING COMMENT 'City of the employees residence.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the employees residence. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN — 8 candidates stripped; promote to reference product]',
    `date_of_birth` DATE COMMENT 'Birth date of the employee, used for age‑based compliance and benefits.',
    `department` STRING COMMENT 'Organizational department or functional group.',
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
    `workforce_department_id` BIGINT COMMENT 'add column department_id (BIGINT) with FK to workforce.department.department_id - positions must belong to a department for org structure',
    `reports_to_position_id` BIGINT COMMENT 'Identifier of the supervisory position to which this role reports.',
    `classification` STRING COMMENT 'Primary classification indicating whether the role is Back‑of‑House (BOH), Front‑of‑House (FOH), or Support.. Valid values are `BOH|FOH|Support`',
    `position_code` STRING COMMENT 'Business identifier code used to reference the position in HR and scheduling systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created.',
    `department` STRING COMMENT 'Organizational department to which the position belongs (e.g., Kitchen, Service, Maintenance).',
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
    `primary_shift_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the shift.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Each shift is worked in a specific authorized position (e.g., Crew Member, Shift Lead, BOH Cook). The shift table currently stores station (STRING) but has no FK to the canonical position record. Addi',
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
    `station` STRING COMMENT 'Work station or area assigned to the employee (Back‑of‑House, Front‑of‑House, etc.).. Valid values are `BOH|FOH|drive_thru|delivery`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift record.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each labor schedule.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `schedule_manager_employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit for which the schedule is created.',
    `schedule_unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit for which the schedule is created.',
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
    `time_employee_id` BIGINT COMMENT 'Identifier of the manager who performed the approval.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` (
    `labor_forecast_id` BIGINT COMMENT 'Unique identifier for the labor forecast record. _canonical_skip_reason: Entity does not fit standard role categories; treated as OTHER.',
    `financial_period_id` BIGINT COMMENT 'add column financial_period_id (BIGINT) with FK to finance.financial_period.financial_period_id - labor forecasts need temporal boundaries',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which the labor forecast is generated.',
    `labor_unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which the labor forecast is generated.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence level (0‑100) of the forecast output.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the day for which labor is forecasted.. Valid values are `breakfast|lunch|dinner|late_night`',
    `expected_adt` STRING COMMENT 'Projected average daily transaction count for the forecast period.',
    `expected_atc` STRING COMMENT 'Projected average number of items per transaction for the forecast period.',
    `forecast_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was initially created.',
    `forecast_date` DATE COMMENT 'The calendar date for which the labor forecast applies.',
    `forecast_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the forecast record.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total labor cost (in currency) for the forecast period.',
    `labor_forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record.. Valid values are `pending|active|completed|cancelled`',
    `lto_flag` BOOLEAN COMMENT 'Indicates whether a Limited Time Offer (LTO) is scheduled for the forecast period.',
    `model_version` STRING COMMENT 'Version identifier of the forecasting model used to generate the forecast.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the forecast.',
    `projected_cover_count` STRING COMMENT 'Estimated number of guests (covers) expected for the forecast period.',
    `projected_fte_boh` DECIMAL(18,2) COMMENT 'Forecasted full‑time equivalent staff needed for back‑of‑house operations.',
    `projected_fte_foh` DECIMAL(18,2) COMMENT 'Forecasted full‑time equivalent staff needed for front‑of‑house operations.',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'Projected labor cost as a percentage of total sales for the forecast period.',
    `projected_throughput` STRING COMMENT 'Estimated number of transactions/orders expected during the forecast period.',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether a planned promotion or marketing campaign is active during the forecast period.',
    `scenario` STRING COMMENT 'Scenario used for the forecast (e.g., baseline, optimistic, pessimistic).. Valid values are `baseline|optimistic|pessimistic`',
    `week_number` STRING COMMENT 'ISO week number of the forecast date.',
    `year` STRING COMMENT 'Four‑digit year of the forecast date.',
    CONSTRAINT pk_labor_forecast PRIMARY KEY(`labor_forecast_id`)
) COMMENT 'Projected labor demand by restaurant, daypart, and week based on historical transaction volume (ADT/ATC), seasonal patterns, and planned promotions or LTOs. Captures forecasted cover count, expected throughput, recommended FTE count by BOH/FOH, projected Labor%, and the forecasting model version used. Drives Planday schedule generation and labor budget alignment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'System-generated unique identifier for the payroll record.',
    `cost_center_id` BIGINT COMMENT 'Financial cost‑center to which payroll costs are charged.',
    `department_id` BIGINT COMMENT 'Identifier of the internal department (e.g., FOH, BOH) for cost allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the payroll pertains.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee works.',
    `payroll_group_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_group. Business justification: Payroll records belong to a payroll group that governs pay frequency, currency, and tax rules. The payroll_record table currently stores pay_group as a STRING, which is a denormalized reference to the',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run batch that generated this record.',
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
    `other_deductions` DECIMAL(18,2) COMMENT 'Miscellaneous deductions such as garnishments.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` (
    `recruitment_id` BIGINT COMMENT 'System-generated unique identifier for the recruitment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the hire.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant or site where the role is located.',
    `primary_recruitment_employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the hire.',
    `unit_id` BIGINT COMMENT 'FK to restaurant.unit',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Recruitment requisitions are opened to fill authorized positions. The recruitment table stores position_title as a STRING, duplicating the canonical position definition. Adding recruiting_position_id ',
    `workforce_department_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_department. Business justification: Recruitment requisitions are opened for a specific department. The recruitment table stores department as a STRING, which is a denormalized reference to the workforce_department master. Adding recruit',
    `applicant_count` STRING COMMENT 'Total number of applicants received.',
    `budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for recruitment advertising and agency fees.',
    `closing_date` DATE COMMENT 'Date the requisition was closed to new applications.',
    `compliance_status` STRING COMMENT 'Indicates whether the recruitment process meets internal and regulatory compliance (e.g., equal‑opportunity reporting).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recruitment record was first created.',
    `employment_type` STRING COMMENT 'Classification of employment relationship for the role.. Valid values are `full-time|part-time|seasonal|contract|intern|temporary`',
    `interview_stage_count` STRING COMMENT 'Number of interview stages defined for the requisition.',
    `job_level` STRING COMMENT 'Organizational level of the position.. Valid values are `entry|associate|manager|director|executive`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recruitment record.',
    `location_name` STRING COMMENT 'Human‑readable name of the restaurant or site.',
    `notes` STRING COMMENT 'Free‑form notes captured by recruiters or hiring managers.',
    `offers_accepted` STRING COMMENT 'Count of offers that were accepted by candidates.',
    `offers_extended` STRING COMMENT 'Count of job offers that have been extended.',
    `posting_channel` STRING COMMENT 'Channel used to publish the job opening.. Valid values are `internal|job_board|recruiter|social|referral|agency`',
    `posting_date` DATE COMMENT 'Date the job was first posted.',
    `recruitment_status` STRING COMMENT 'Current lifecycle status of the recruitment process.. Valid values are `open|closed|on_hold|cancelled|filled`',
    `required_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ServSafe) required for the role.',
    `required_education_level` STRING COMMENT 'Minimum education level required for the position.. Valid values are `high_school|associate|bachelor|master|doctorate`',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience required.',
    `requisition_number` STRING COMMENT 'External reference number assigned to the job requisition.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the advertised salary range (USD).',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the advertised salary range (USD).',
    `source_of_candidate` STRING COMMENT 'Origin of the candidate pool for this requisition.. Valid values are `internal|referral|agency|online|walk-in`',
    `target_headcount` STRING COMMENT 'Number of hires planned for this requisition.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from posting to hire acceptance.',
    CONSTRAINT pk_recruitment PRIMARY KEY(`recruitment_id`)
) COMMENT 'Tracks the full recruiting lifecycle for open positions across restaurant locations, including job requisition details, posting channels, candidate information (demographics, source, experience, availability), interview stages, offer status, and time-to-fill metrics. Captures both the requisition workflow and candidate pipeline in a single record per applicant-requisition combination. Sourced from Workday HCM Recruiting module. Supports NRO staffing ramp-up planning, turnover backfill management, diversity hiring tracking, and talent pipeline analytics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` (
    `onboarding_id` BIGINT COMMENT 'Unique system-generated identifier for the onboarding process instance.',
    `scheduling_template_id` BIGINT COMMENT 'Foreign key linking to workforce.scheduling_template. Business justification: During onboarding, new employees are assigned a default scheduling template that governs their initial shift patterns (daypart, shift length, FTE target). Linking onboarding.default_scheduling_templat',
    `workforce_department_id` BIGINT COMMENT 'Identifier of the department (e.g., FOH, BOH, HR) the employee belongs to.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the colleague assigned to mentor the new hire.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee will work.',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the manager who signs off on onboarding completion.',
    `payroll_group_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_group. Business justification: During onboarding, new employees are assigned to a payroll group that determines their pay frequency, benefit eligibility, and tax withholding setup. Capturing payroll_group_id on the onboarding recor',
    `position_id` BIGINT COMMENT 'Identifier of the specific job role (e.g., Shift Lead, Server, Cook).',
    `primary_onboarding_assigned_buddy_employee_id` BIGINT COMMENT 'Employee identifier of the colleague assigned to mentor the new hire.',
    `tertiary_onboarding_manager_employee_id` BIGINT COMMENT 'Identifier of the manager who signs off on onboarding completion.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee will work.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of completed onboarding tasks (0.00 – 100.00).',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the onboarding process was completed or terminated.',
    `food_handler_card_date` TIMESTAMP COMMENT 'Date and time the food handler card was received.',
    `food_handler_card_submitted` BOOLEAN COMMENT 'True when the employee has submitted a valid food handler certification.',
    `i9_completed` BOOLEAN COMMENT 'Indicates whether the employees I-9 employment eligibility form has been completed.',
    `i9_completion_date` TIMESTAMP COMMENT 'Date and time when I-9 verification was finalized.',
    `method` STRING COMMENT 'Mode used to deliver onboarding activities.. Valid values are `in_person|virtual|hybrid`',
    `notes` STRING COMMENT 'Additional comments or observations related to the onboarding process.',
    `onboarding_status` STRING COMMENT 'Current lifecycle state of the onboarding instance.. Valid values are `not_started|in_progress|completed|cancelled`',
    `onboarding_type` STRING COMMENT 'Classification of the onboarding scenario.. Valid values are `new_hire|transfer|seasonal|intern`',
    `pos_access_provision_date` TIMESTAMP COMMENT 'Date and time POS access was granted.',
    `pos_access_provisioned` BOOLEAN COMMENT 'True when the employee has been granted access to the POS system.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the onboarding record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the onboarding record.',
    `servsafe_completion_date` TIMESTAMP COMMENT 'Date and time the ServSafe training was completed.',
    `servsafe_enrolled` BOOLEAN COMMENT 'Indicates whether the employee has enrolled in ServSafe food safety training.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the onboarding process officially began.',
    `training_completed` BOOLEAN COMMENT 'True when all required onboarding training modules have been completed.',
    `training_completion_date` TIMESTAMP COMMENT 'Date and time the final onboarding training was completed.',
    `uniform_issuance_date` TIMESTAMP COMMENT 'Date and time the uniform was issued to the employee.',
    `uniform_issued` BOOLEAN COMMENT 'Indicates whether the employee has been provided with required uniform.',
    CONSTRAINT pk_onboarding PRIMARY KEY(`onboarding_id`)
) COMMENT 'Tracks the onboarding process for newly hired employees, including completion status of required tasks (I-9 verification, food handler card submission, uniform issuance, POS system access provisioning, ServSafe enrollment), onboarding start/end dates, assigned onboarding buddy, and manager sign-off. Ensures compliance with FDA food safety and OSHA workplace safety requirements at point of hire.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'System-generated unique identifier for the certification record.',
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
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant location where the training was completed.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift associated with the training session.',
    `training_employee_id` BIGINT COMMENT 'Unique identifier of the trainer or facilitator.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee works.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or peer who performed the review.',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Performance reviews evaluate an employee in the context of a specific position (e.g., a Shift Lead review uses different criteria than a Crew Member review). The performance_review table stores depart',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the manager or peer who performed the review.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the employee works.',
    `accuracy_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees order accuracy.',
    `acknowledgment_status` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged the review.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total hours actually worked by the employee during the review period.',
    `attendance_score` DECIMAL(18,2) COMMENT 'Score reflecting attendance and punctuality.',
    `certification_status` STRING COMMENT 'Current status of any required certifications (e.g., ServSafe).. Valid values are `valid|expired|pending`',
    `comments` STRING COMMENT 'Free‑form text comments from the reviewer.',
    `competency_score_total` DECIMAL(18,2) COMMENT 'Sum of individual competency scores.',
    `confidentiality_level` STRING COMMENT 'Data classification of the review record.. Valid values are `restricted|confidential|internal|public`',
    `corrective_action_flag` BOOLEAN COMMENT 'True if corrective action is required based on the review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `development_goals` STRING COMMENT 'Narrative of agreed‑upon development objectives.',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Score reflecting adherence to food safety standards.',
    `guest_service_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees guest service quality.',
    `labor_percentage_actual` DECIMAL(18,2) COMMENT 'Actual labor cost as a percentage of sales for the review period.',
    `labor_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the review period.',
    `next_review_due_date` DATE COMMENT 'Planned date for the next performance review.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Aggregated rating summarizing the employees performance.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours logged in the review period.',
    `performance_review_status` STRING COMMENT 'Current lifecycle state of the review.. Valid values are `draft|completed|cancelled|in_progress`',
    `promotion_recommendation` BOOLEAN COMMENT 'True if the reviewer recommends promotion.',
    `rating_scale` STRING COMMENT 'Scale used for the overall and competency scores.. Valid values are `1-5|1-10|percentage`',
    `review_date` TIMESTAMP COMMENT 'Timestamp when the review was conducted or recorded.',
    `review_document_url` STRING COMMENT 'Link to the stored review document or PDF.',
    `review_method` STRING COMMENT 'How the review was conducted.. Valid values are `self|manager|360|peer`',
    `review_number` STRING COMMENT 'Human‑readable business identifier for the review, e.g., PR‑2023‑0001.',
    `review_period_end` DATE COMMENT 'Last day of the performance period covered by the review.',
    `review_period_start` DATE COMMENT 'First day of the performance period covered by the review.',
    `review_type` STRING COMMENT 'Classification of the review based on its trigger or schedule.. Valid values are `90_day|annual|promotion|probation|exit`',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total hours scheduled for the employee during the review period.',
    `shift_daypart` STRING COMMENT 'Typical daypart of the employees shift.. Valid values are `breakfast|lunch|dinner|late_night`',
    `speed_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees speed of service.',
    `training_completed` BOOLEAN COMMENT 'Indicates whether required training was completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Captures all formal employee performance and conduct events including scheduled evaluations (90-day, annual), corrective actions (verbal warnings, written warnings, PIPs, suspensions), and promotion assessments. Records event type, overall rating, competency scores (speed, accuracy, guest service, food safety adherence), infraction details where applicable, reviewer identity, review period, development goals, progressive discipline step, and acknowledgment status. Sourced from Workday HCM Performance module. Serves as the single record of all formal employee assessments for both development and legal compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'System-generated unique identifier for the leave request record.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee is scheduled, used for shift‑coverage planning.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager who reviewed and approved/denied the request (source: Workday HCM).',
    `payroll_record_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_record. Business justification: Leave requests with payroll_impact_flag=TRUE directly affect payroll calculations (paid leave deductions, FMLA pay continuation, PTO payout). Linking leave_request.payroll_record_id to payroll_record ',
    `primary_leave_employee_id` BIGINT COMMENT 'Unique identifier of the employee submitting the leave request (source: Workday HCM).',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee is scheduled, used for shift‑coverage planning.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the leave request was approved or denied.',
    `attachment_present` BOOLEAN COMMENT 'Flag indicating whether the employee attached supporting documentation (e.g., medical certificate).',
    `backfill_assigned_flag` BOOLEAN COMMENT 'True when a replacement shift has been scheduled to cover the employees absence.',
    `coverage_needed_flag` BOOLEAN COMMENT 'True if the requested leave creates a staffing gap that requires backfill.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar date of the requested leave period.',
    `is_paid_leave` BOOLEAN COMMENT 'True if the leave type is paid and will be reflected in payroll; false for unpaid leave.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Employees accrued leave balance after the approved leave is deducted.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Employees accrued leave balance before this request is applied.',
    `leave_days_approved` DECIMAL(18,2) COMMENT 'Number of leave days actually approved for the employee.',
    `leave_days_requested` DECIMAL(18,2) COMMENT 'Total number of leave days (including fractions) the employee is asking for.',
    `notes` STRING COMMENT 'Free‑form text for the employee or manager to provide context or special instructions.',
    `payroll_impact_flag` BOOLEAN COMMENT 'Indicates whether the approved leave should affect the employees payroll calculations.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the leave request for tracking and communication.',
    `request_status` STRING COMMENT 'Current lifecycle status of the leave request.. Valid values are `pending|approved|denied|cancelled`',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date‑time when the employee submitted the leave request.',
    `request_type` STRING COMMENT 'Category of leave being requested, such as vacation, sick, FMLA, personal, or unpaid.. Valid values are `vacation|sick|fmla|personal|unpaid`',
    `return_to_work_date` DATE COMMENT 'Date the employee is scheduled to resume duties after the leave period.',
    `start_date` DATE COMMENT 'First calendar date of the requested leave period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave request record.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Tracks employee requests for time off including vacation, sick leave, FMLA, personal days, and unpaid leave. Captures request type, requested dates, approved dates, leave balance consumed, approval status, approving manager, and return-to-work date. Integrates with Planday scheduling to flag coverage gaps and trigger backfill shift assignments.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` (
    `labor_violation_id` BIGINT COMMENT 'System‑generated unique identifier for each labor violation record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee involved in the violation.',
    `facility_id` BIGINT COMMENT 'Identifier of the specific site (e.g., store, kitchen) within the restaurant.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation occurred.',
    `labor_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the violation occurred.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift during which the violation occurred.',
    `actual_break_time` TIMESTAMP COMMENT 'The break time actually taken by the employee.',
    `compliance_reported` BOOLEAN COMMENT 'Indicates whether the violation has been reported to the required compliance authority.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed.',
    `corrective_action_taken` STRING COMMENT 'Description of the remediation steps performed to address the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the system.',
    `daypart` STRING COMMENT 'Part of the day (e.g., breakfast, lunch) when the violation happened.. Valid values are `breakfast|lunch|dinner|late_night`',
    `labor_violation_description` STRING COMMENT 'Free‑text narrative describing the circumstances of the violation.',
    `detection_method` STRING COMMENT 'Whether the violation was captured automatically or through manual review.. Valid values are `automated|manual`',
    `detection_source` STRING COMMENT 'System or process that first identified the violation.. Valid values are `workday|planday|zenput|manual_audit`',
    `fine_amount` DECIMAL(18,2) COMMENT 'Fine levied by a regulatory body for the violation.',
    `labor_violation_status` STRING COMMENT 'Lifecycle status of the violation record.. Valid values are `open|closed|in_progress|dismissed`',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours recorded beyond allowed limits.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for the violation, if any.',
    `regulatory_body` STRING COMMENT 'Government agency or authority to which the violation must be reported.. Valid values are `OSHA|DOL|state_labour`',
    `reported_by` STRING COMMENT 'Identifier of the person or system that logged the violation.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date‑time when the violation was formally closed or resolved.',
    `scheduled_break_time` TIMESTAMP COMMENT 'The break time that was scheduled for the employee.',
    `severity` STRING COMMENT 'Severity rating assigned to the violation based on impact and risk.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violation_code` STRING COMMENT 'Code that maps the violation to a regulatory or internal taxonomy.',
    `violation_timestamp` TIMESTAMP COMMENT 'Date‑time when the labor violation was detected or occurred.',
    `violation_type` STRING COMMENT 'Categorized type of the violation (e.g., missed break, overtime, under‑age work).. Valid values are `missed_break|overtime|underage_work|certification_mismatch|osha_incident`',
    CONSTRAINT pk_labor_violation PRIMARY KEY(`labor_violation_id`)
) COMMENT 'Records instances of labor compliance violations detected during operations, including missed meal/rest breaks, overtime threshold breaches, minor labor law violations (under-18 hour restrictions), predictive scheduling violations (where applicable), tip credit violations (failure to meet minimum wage with tips, improper tip pool inclusions), scheduling conflicts with certified food handler requirements, and OSHA-reportable workplace incidents. Captures violation type, severity, regulatory framework violated (FLSA, OSHA, state labor code), restaurant location, employee affected, detection source (automated time system, manager report, employee complaint), remediation deadline, and corrective action taken. Supports OSHA 300 log maintenance, DOL Wage & Hour Division audit responses, and state labor board compliance reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` (
    `labor_budget_id` BIGINT COMMENT 'System-generated unique identifier for each labor budget record.',
    `workforce_department_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_department. Business justification: Labor budgets are planned at the intersection of unit, daypart, and department. The labor_budget table already has unit-level FKs but no department_id FK, forcing department-level budget analysis to r',
    `financial_period_id` BIGINT COMMENT 'add column financial_period_id (BIGINT) with FK to finance.financial_period.financial_period_id - labor budgets must reference a time period for planning',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant location to which the labor budget applies.',
    `labor_unit_id` BIGINT COMMENT 'Unique identifier of the restaurant location to which the labor budget applies.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget was approved by finance.',
    `budget_category` STRING COMMENT 'Classification of the budget purpose (e.g., operational labor, training, benefits).. Valid values are `operational|capital|training|benefits`',
    `budget_code` STRING COMMENT 'External business code used to reference the budget in financial systems.',
    `budget_name` STRING COMMENT 'Human‑readable name for the labor budget (e.g., "2024 Q1 Labor Budget").',
    `budget_source` STRING COMMENT 'Origin of the budget figures (historical data, forecasting model, or manager input).. Valid values are `historical|model|manager_input`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget record.. Valid values are `draft|submitted|approved|active|closed|rejected`',
    `budget_type` STRING COMMENT 'Granularity of the budget (annual, quarterly, monthly, weekly, or daypart specific).. Valid values are `annual|quarterly|monthly|weekly|daypart`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Specific daypart the budget applies to; use "all_day" for full‑day budgets.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `fiscal_period` STRING COMMENT 'Period within the fiscal year (e.g., "Q1", "M03").',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year for which the budget is defined.',
    `fte_budget_boh` DECIMAL(18,2) COMMENT 'Planned BOH full‑time equivalent headcount.',
    `fte_budget_foh` DECIMAL(18,2) COMMENT 'Planned FOH full‑time equivalent headcount.',
    `fte_budget_total` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent headcount for the period (combined BOH and FOH).',
    `hours_budget_boh` DECIMAL(18,2) COMMENT 'Planned BOH labor hours.',
    `hours_budget_foh` DECIMAL(18,2) COMMENT 'Planned FOH labor hours.',
    `hours_budget_total` DECIMAL(18,2) COMMENT 'Planned total labor hours for the period.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Projected labor cost derived from forecasting models, may differ from the budgeted amount.',
    `labor_cost_estimate_boh` DECIMAL(18,2) COMMENT 'Projected BOH labor spend derived from forecasting.',
    `labor_cost_estimate_foh` DECIMAL(18,2) COMMENT 'Projected FOH labor spend derived from forecasting.',
    `labor_dollar_budget` DECIMAL(18,2) COMMENT 'Planned total labor spend in local currency for the period.',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'Planned labor cost as a percentage of total sales for the period.',
    `labor_percent_target_boh` DECIMAL(18,2) COMMENT 'Target labor cost percentage for BOH operations.',
    `labor_percent_target_foh` DECIMAL(18,2) COMMENT 'Target labor cost percentage for FOH operations.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the budget.',
    `period_end_date` DATE COMMENT 'Last calendar date of the budgeting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the budgeting period.',
    `scenario` STRING COMMENT 'Forecasting scenario used to generate the budget.. Valid values are `base|optimistic|pessimistic|promotion|lto`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the budget record.',
    `version` STRING COMMENT 'Version number of the budget record for change tracking.',
    CONSTRAINT pk_labor_budget PRIMARY KEY(`labor_budget_id`)
) COMMENT 'Period-level labor budget targets by restaurant location, capturing budgeted Labor%, budgeted total labor dollars, budgeted FTE count by BOH/FOH, budgeted hours by daypart, budgeted SPLH (Sales Per Labor Hour), and the fiscal period. Serves as the financial target against which actual labor spend (from payroll_record and time_entry) and forecasted demand (from labor_forecast) are measured. Supports P&L management, AUV optimization, and manager accountability for labor cost control.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` (
    `tip_compliance_id` BIGINT COMMENT 'Unique identifier for the tip_compliance data product (auto-inserted pre-linking).',
    `corrected_tip_compliance_id` BIGINT COMMENT 'Self-referencing FK on tip_compliance (corrected_tip_compliance_id)',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tip compliance records are specific to an employee; adding employee_id FK enables joining to employee for employee details and eliminates any redundant employee attributes.',
    `payroll_record_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_record. Business justification: Tip compliance records track tip pooling, tip credits, and tip sharing arrangements that directly affect payroll calculations. Linking tip_compliance.payroll_record_id to payroll_record creates a dire',
    `payroll_group_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_group. Business justification: Tip pooling arrangements and tip credit elections are governed at the payroll group level, as different groups may have different tip policies (e.g., tipped vs. non-tipped employee classes). Adding ti',
    CONSTRAINT pk_tip_compliance PRIMARY KEY(`tip_compliance_id`)
) COMMENT 'Tracks tip pooling arrangements, tip credit elections, tip sharing ratios, and employee-level tip declarations required for DOL FLSA §3(m) compliance. Captures tip pool participant roster, contribution percentages, distribution method (hours-based, points-based), tip credit amount claimed per pay period, employee tip declaration forms, and audit trail for tip pool changes. Supports compliance with federal and state tip credit regulations, tip pooling legality verification (front-of-house vs back-of-house eligibility per 2021 DOL final rule), and provides evidence for DOL Wage & Hour Division audits.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` (
    `scheduling_template_id` BIGINT COMMENT 'Primary key for scheduling_template',
    `base_scheduling_template_id` BIGINT COMMENT 'Self-referencing FK on scheduling_template (base_scheduling_template_id)',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - scheduling templates should be assignable to specific units',
    `workforce_department_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_department. Business justification: Scheduling templates are designed for specific departments (e.g., a BOH template differs from an FOH template). The scheduling_template table has role_applicability (STRING) but no department_id FK. A',
    `daypart` STRING COMMENT 'Primary daypart(s) the template applies to.',
    `default_shift_length_minutes` STRING COMMENT 'Standard length of a shift defined by the template, expressed in minutes.',
    `scheduling_template_description` STRING COMMENT 'Detailed free‑text description of the scheduling templates purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the template becomes effective for scheduling.',
    `effective_until` DATE COMMENT 'Date when the template expires or is superseded (null if open‑ended).',
    `fte_target` DECIMAL(18,2) COMMENT 'Planned number of full‑time equivalents required when using this template.',
    `is_default_template` BOOLEAN COMMENT 'Indicates whether this template is the default choice for new locations or schedules.',
    `labor_percentage` DECIMAL(18,2) COMMENT 'Target labor percentage of total operating hours for the template.',
    `location_scope` STRING COMMENT 'Geographic or organizational scope where the template can be applied.',
    `notes` STRING COMMENT 'Additional remarks or operational notes related to the template.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the scheduling template record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scheduling template record.',
    `role_applicability` STRING COMMENT 'Workforce role(s) the template is intended for (Front‑of‑House, Back‑of‑House, or both).',
    `scheduling_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `template_code` STRING COMMENT 'Business code used to reference the scheduling template across systems.',
    `template_name` STRING COMMENT 'Human‑readable name of the scheduling template.',
    `template_type` STRING COMMENT 'Category of the template indicating its purpose or usage scenario.',
    `version_number` STRING COMMENT 'Version of the template to support change management and audit.',
    CONSTRAINT pk_scheduling_template PRIMARY KEY(`scheduling_template_id`)
) COMMENT 'Master reference table for scheduling_template. Referenced by labor_scheduling_template_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` (
    `workforce_department_id` BIGINT COMMENT 'Primary key for department',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manages the department.',
    `parent_department_id` BIGINT COMMENT 'Identifier of the parent department in the organizational hierarchy.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the department operates.',
    `department_id` BIGINT COMMENT '',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the department.',
    `budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the department budget.',
    `compliance_status` STRING COMMENT 'Current compliance status of the department with regulatory requirements.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with the department.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was first created in the system.',
    `department_type` STRING COMMENT 'Category of department indicating its functional area (e.g., Front of House, Back of House).',
    `workforce_department_description` STRING COMMENT 'Detailed description of the departments purpose and responsibilities.',
    `effective_from` DATE COMMENT 'Date when the department became operational.',
    `effective_until` DATE COMMENT 'Date when the department ceased operation (null if still active).',
    `floor_area_sqft` DECIMAL(18,2) COMMENT 'Physical floor area occupied by the department in square feet.',
    `headcount` STRING COMMENT 'Number of full-time equivalent employees assigned to the department.',
    `is_remote` BOOLEAN COMMENT 'Flag indicating if the department operates remotely (e.g., corporate functions).',
    `workforce_department_status` STRING COMMENT 'Current lifecycle status of the department.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the department record.',
    CONSTRAINT pk_workforce_department PRIMARY KEY(`workforce_department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `employee_id` BIGINT COMMENT 'Identifier of the user who processed the payroll run.',
    `payroll_group_id` BIGINT COMMENT 'Identifier of the payroll group or cost center associated with this run.',
    `reversal_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversal_payroll_run_id)',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which the payroll run was processed.',
    `approval_status` STRING COMMENT 'Approval status of the payroll run.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run was approved.',
    `batch_number` STRING COMMENT 'Batch number assigned by the external payroll processor.',
    `cost_center_code` STRING COMMENT 'Business cost center code linked to the payroll run.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for payroll amounts.',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Total amount of taxes, benefits, and other deductions for the payroll run.',
    `payroll_run_description` STRING COMMENT 'Free-text notes or description about the payroll run.',
    `fiscal_period` STRING COMMENT 'Fiscal period (e.g., Q1, Q2) for the payroll run.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross payroll amount before any deductions.',
    `is_finalized` BOOLEAN COMMENT 'Indicates whether the payroll run has been finalized and posted to the payroll ledger.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payroll amount after deductions.',
    `pay_cycle` STRING COMMENT 'Frequency at which employees are paid for this run.',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by the payroll run.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by the payroll run.',
    `payroll_type` STRING COMMENT 'Category of payroll processing for the run.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll run record.',
    `run_number` STRING COMMENT 'External reference number assigned by the payroll system.',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run was executed.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle state of the payroll run.',
    `tax_year` STRING COMMENT 'Fiscal tax year applicable to the payroll run.',
    `total_employee_count` STRING COMMENT 'Number of employees included in this payroll run.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` (
    `payroll_group_id` BIGINT COMMENT 'Primary key for payroll_group',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the default benefit plan applied to employees in this payroll group.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - payroll groups must be scoped to legal entities for tax and compliance',
    `parent_payroll_group_id` BIGINT COMMENT 'Self-referencing FK on payroll_group (parent_payroll_group_id)',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the payroll group for financial allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll group record was created in the system.',
    `default_tax_rate` DECIMAL(18,2) COMMENT 'Standard tax withholding rate applied to payrolls in this group.',
    `payroll_group_description` STRING COMMENT 'Detailed description of the payroll group purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the payroll group becomes effective.',
    `effective_until` DATE COMMENT 'Date when the payroll group ceases to be effective; null if indefinite.',
    `group_code` STRING COMMENT 'Unique business code assigned to the payroll group.',
    `group_manager_email` STRING COMMENT 'Email address of the payroll group manager.',
    `group_manager_name` STRING COMMENT 'Full name of the manager responsible for the payroll group.',
    `group_manager_phone` STRING COMMENT 'Contact phone number of the payroll group manager.',
    `group_name` STRING COMMENT 'Descriptive name of the payroll group used in reporting and payroll processing.',
    `group_type` STRING COMMENT 'Classification of the payroll group based on employee compensation model.',
    `payroll_currency_code` STRING COMMENT 'ISO 4217 currency code for payroll payments.',
    `payroll_frequency` STRING COMMENT 'Regular interval at which payroll is processed for this group.',
    `payroll_group_status` STRING COMMENT 'Current lifecycle status of the payroll group.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll group record.',
    CONSTRAINT pk_payroll_group PRIMARY KEY(`payroll_group_id`)
) COMMENT 'Master reference table for payroll_group. Referenced by payroll_group_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `workday_benefit_plan_id` BIGINT COMMENT 'Unique identifier of this benefit plan in the Workday HCM system of record. Used for system integration, enrollment synchronization, and payroll deduction mapping.',
    `default_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (default_benefit_plan_id)',
    `aca_minimum_essential_coverage` BOOLEAN COMMENT 'Indicates whether this plan qualifies as Minimum Essential Coverage (MEC) under the ACA, satisfying the individual mandate and employer shared responsibility requirements.',
    `aca_minimum_value` BOOLEAN COMMENT 'Indicates whether this health plan meets the ACA minimum value standard (covers at least 60% of total allowed costs). Required for ACA employer mandate compliance and Form 1095-C reporting.',
    `annual_deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount an employee must pay out-of-pocket for covered services before the insurance carrier begins paying. Applicable primarily to medical and dental plans.',
    `auto_enroll_default_contribution_pct` DECIMAL(18,2) COMMENT 'Default contribution percentage applied when an employee is auto-enrolled in a retirement plan. Null for non-auto-enroll plans or non-retirement plan types.',
    `auto_enroll_eligible` BOOLEAN COMMENT 'Indicates whether eligible employees are automatically enrolled in this plan upon meeting eligibility criteria (e.g., 401(k) auto-enrollment). Employees may opt out after automatic enrollment.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or benefits administrator underwriting or administering this plan (e.g., Aetna, UnitedHealthcare, Fidelity, Principal).',
    `carrier_plan_code` STRING COMMENT 'The insurance carriers own identifier for this plan, used for EDI 834 enrollment transmissions, claims adjudication, and carrier reconciliation.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this plan is subject to COBRA continuation coverage requirements, allowing terminated or qualifying-event-affected employees to continue coverage at their own cost.',
    `coverage_tier` STRING COMMENT 'Enrollment tier defining which dependents are covered under this plan election. Drives premium contribution calculations and payroll deduction amounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this benefit plan record (e.g., USD). Supports multi-currency operations for international restaurant brands.',
    `deduction_frequency` STRING COMMENT 'Frequency at which employee premium contributions are deducted from payroll. Must align with the restaurants payroll cycle configuration in Workday.',
    `dependent_coverage_allowed` BOOLEAN COMMENT 'Indicates whether dependents (spouse, domestic partner, children) may be enrolled under this benefit plan. ACA requires dependent coverage up to age 26 for qualifying health plans.',
    `effective_date` DATE COMMENT 'Date on which the benefit plan becomes active and available for employee enrollment. Marks the start of the plan year or mid-year amendment.',
    `eligibility_waiting_period_days` STRING COMMENT 'Number of days a new employee must be employed before becoming eligible to enroll in this benefit plan. ACA limits medical waiting periods to 90 days for qualifying health plans.',
    `eligible_employee_class` STRING COMMENT 'Employee classification(s) eligible for this plan (e.g., full-time, part-time, salaried, hourly, manager, crew). Drives enrollment eligibility rules in Workday HCM. [ENUM-REF-CANDIDATE: full_time|part_time|salaried|hourly|manager|crew|seasonal|temporary — promote to reference product]',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount deducted from the employees paycheck per pay period for this benefit plan at the applicable coverage tier. Drives payroll deduction setup in Workday.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per pay period toward the cost of this benefit plan per enrolled employee at the applicable coverage tier. Used in labor cost modeling and total compensation reporting.',
    `employer_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of the total premium cost covered by the employer. Used when employer contribution is expressed as a percentage rather than a fixed amount (e.g., 80% of premium). Mutually informative with employer_contribution_amount.',
    `erisa_plan_number` STRING COMMENT 'Three-digit plan number assigned by the plan sponsor for DOL Form 5500 filing purposes. Required for ERISA-covered welfare and pension benefit plans.',
    `expiration_date` DATE COMMENT 'Date on which the benefit plan ceases to be available. Null for open-ended plans. Used to manage plan year transitions and sunset legacy offerings.',
    `fsa_annual_limit_amount` DECIMAL(18,2) COMMENT 'Maximum annual employee contribution allowed to a Flexible Spending Account (FSA) under this plan. IRS sets the annual limit; this field captures the plan-specific limit which may be lower.',
    `funding_type` STRING COMMENT 'Indicates how the plan is financially structured. Fully insured plans transfer risk to the carrier; self-funded plans retain risk with the employer; level-funded plans blend fixed monthly costs with self-insurance.',
    `geographic_scope` STRING COMMENT 'Geographic scope of plan availability. National plans are available to all eligible employees; regional or state plans may be offered in specific markets due to carrier network or regulatory differences.',
    `group_number` STRING COMMENT 'Employer group number assigned by the insurance carrier, printed on member ID cards and used for claims processing and eligibility verification.',
    `hsa_employer_contribution_amount` DECIMAL(18,2) COMMENT 'Annual dollar amount the employer seeds into the employees Health Savings Account (HSA) for HSA-compatible High Deductible Health Plans (HDHPs). Null for non-HDHP plans.',
    `minimum_hours_per_week` DECIMAL(18,2) COMMENT 'Minimum average weekly hours an employee must work to be eligible for this benefit plan. Critical for restaurant operations where part-time and variable-hour employees are common. ACA defines full-time as 30+ hours/week.',
    `notes` STRING COMMENT 'Internal administrative notes regarding plan amendments, carrier negotiations, compliance exceptions, or operational considerations. Not displayed to employees.',
    `open_enrollment_end_date` DATE COMMENT 'Last day of the annual open enrollment window. Elections made after this date require a qualifying life event.',
    `open_enrollment_start_date` DATE COMMENT 'First day of the annual open enrollment window during which employees may elect, change, or waive coverage under this plan.',
    `out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount an employee pays in a plan year before the carrier covers 100% of covered in-network costs. ACA-mandated limit for qualifying health plans.',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the benefit plan, used in HR systems, payroll integrations, and employee communications (e.g., MED-PPO-2024, DEN-BASIC).',
    `plan_description` STRING COMMENT 'Free-text description of the benefit plan summarizing key features, coverage highlights, and intended employee population. Used in HR communications and enrollment portals.',
    `plan_document_url` STRING COMMENT 'URL or document management system path to the official Summary Plan Description (SPD) or plan document. ERISA requires SPDs be provided to participants.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees during open enrollment and on pay stubs (e.g., PPO Medical Gold, Basic Dental, 401(k) Standard).',
    `plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan. Active plans are available for enrollment; discontinued plans are closed to new enrollees but may retain existing participants.',
    `plan_subtype` STRING COMMENT 'Further classification within the plan type, distinguishing plan design variants (e.g., PPO, HMO, HDHP for medical; term vs. whole for life; traditional vs. Roth for retirement). [ENUM-REF-CANDIDATE: ppo|hmo|hdhp|epo|pos|term|whole|traditional|roth|basic|enhanced — promote to reference product]',
    `plan_type` STRING COMMENT 'Category of benefit coverage offered by this plan. Drives enrollment eligibility rules, payroll deduction codes, and regulatory reporting. [ENUM-REF-CANDIDATE: medical|dental|vision|life|disability|retirement|fsa|hsa|supplemental|commuter|legal|pet — promote to reference product]',
    `plan_year_end_date` DATE COMMENT 'Last day of the benefit plan year. Marks the close of the annual benefit period for deductible accumulation, FSA use-or-lose deadlines, and ACA reporting.',
    `plan_year_start_date` DATE COMMENT 'First day of the benefit plan year. Determines the annual reset of deductibles, out-of-pocket maximums, FSA/HSA contribution limits, and ACA reporting periods.',
    `planday_integration_code` STRING COMMENT 'Reference code used to link this benefit plan to Planday scheduling and labor management system for labor cost allocation and benefit-eligible hours tracking.',
    `pretax_eligible` BOOLEAN COMMENT 'Indicates whether employee contributions to this plan are deducted on a pre-tax basis under a Section 125 Cafeteria Plan, reducing the employees taxable income.',
    `retirement_match_cap_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of employee compensation up to which the employer match applies for retirement plans (e.g., employer matches 50% of contributions up to 6% of salary). Null for non-retirement plans.',
    `retirement_match_pct` DECIMAL(18,2) COMMENT 'Percentage of employee 401(k) or retirement contributions matched by the employer, up to the match cap. Applicable only to retirement plan types. Null for non-retirement plans.',
    `state_code` STRING COMMENT 'Two-letter US state code for state-specific benefit plans. Null for national plans. Used to apply state-mandated benefit requirements and carrier network restrictions.',
    `summary_plan_description_version` STRING COMMENT 'Version identifier of the Summary Plan Description document associated with this plan, used to track amendments and ensure employees receive current plan information.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified. Used to detect plan amendments, contribution rate changes, and eligibility rule updates.',
    `vesting_period_months` STRING COMMENT 'Total number of months required for full vesting of employer contributions under cliff or graded vesting schedules. Null for immediate vesting plans.',
    `vesting_schedule_type` STRING COMMENT 'Type of vesting schedule governing when employer contributions to retirement or equity plans become fully owned by the employee. Immediate vesting grants full ownership at enrollment; cliff and graded schedules apply time-based milestones.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by default_benefit_plan_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchise to which the department belongs (null for company‑owned).',
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
    `department_status` STRING COMMENT 'Current lifecycle status of the department.',
    `turnover_rate` DECIMAL(18,2) COMMENT 'Annual percentage of staff turnover in the department.',
    `department_type` STRING COMMENT 'Categorizes the department by its functional area.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the department record.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_workforce_department_id` FOREIGN KEY (`workforce_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_primary_shift_employee_id` FOREIGN KEY (`primary_shift_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_manager_employee_id` FOREIGN KEY (`schedule_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_time_employee_id` FOREIGN KEY (`time_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_primary_recruitment_employee_id` FOREIGN KEY (`primary_recruitment_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_workforce_department_id` FOREIGN KEY (`workforce_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_scheduling_template_id` FOREIGN KEY (`scheduling_template_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`scheduling_template`(`scheduling_template_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_workforce_department_id` FOREIGN KEY (`workforce_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_primary_onboarding_assigned_buddy_employee_id` FOREIGN KEY (`primary_onboarding_assigned_buddy_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ADD CONSTRAINT `fk_workforce_onboarding_tertiary_onboarding_manager_employee_id` FOREIGN KEY (`tertiary_onboarding_manager_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_training_employee_id` FOREIGN KEY (`training_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ADD CONSTRAINT `fk_workforce_labor_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ADD CONSTRAINT `fk_workforce_labor_violation_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_workforce_department_id` FOREIGN KEY (`workforce_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ADD CONSTRAINT `fk_workforce_tip_compliance_corrected_tip_compliance_id` FOREIGN KEY (`corrected_tip_compliance_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`tip_compliance`(`tip_compliance_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ADD CONSTRAINT `fk_workforce_tip_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ADD CONSTRAINT `fk_workforce_tip_compliance_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ADD CONSTRAINT `fk_workforce_tip_compliance_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ADD CONSTRAINT `fk_workforce_scheduling_template_base_scheduling_template_id` FOREIGN KEY (`base_scheduling_template_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`scheduling_template`(`scheduling_template_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ADD CONSTRAINT `fk_workforce_scheduling_template_workforce_department_id` FOREIGN KEY (`workforce_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ADD CONSTRAINT `fk_workforce_workforce_department_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ADD CONSTRAINT `fk_workforce_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`workforce_department`(`workforce_department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ADD CONSTRAINT `fk_workforce_workforce_department_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversal_payroll_run_id` FOREIGN KEY (`reversal_payroll_run_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ADD CONSTRAINT `fk_workforce_payroll_group_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ADD CONSTRAINT `fk_workforce_payroll_group_parent_payroll_group_id` FOREIGN KEY (`parent_payroll_group_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_workday_benefit_plan_id` FOREIGN KEY (`workday_benefit_plan_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_default_benefit_plan_id` FOREIGN KEY (`default_benefit_plan_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `vibe_restaurants_v1`.`workforce`.`department`(`department_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Payroll Group Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `employee_work_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Manager Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Employee Department');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Position Classification');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'BOH|FOH|Support');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`position` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Position Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `station` SET TAGS ('dbx_business_glossary_term' = 'Work Station');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`shift` ALTER COLUMN `station` SET TAGS ('dbx_value_regex' = 'BOH|FOH|drive_thru|delivery');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Identifier (MGR_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`time_entry` ALTER COLUMN `time_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Forecast ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `labor_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `expected_adt` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Daily Transactions');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `expected_atc` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `lto_flag` SET TAGS ('dbx_business_glossary_term' = 'Limited Time Offer Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `projected_cover_count` SET TAGS ('dbx_business_glossary_term' = 'Projected Cover Count');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `projected_fte_boh` SET TAGS ('dbx_business_glossary_term' = 'Projected FTE Back‑of‑House');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `projected_fte_foh` SET TAGS ('dbx_business_glossary_term' = 'Projected FTE Front‑of‑House');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `projected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `projected_throughput` SET TAGS ('dbx_business_glossary_term' = 'Projected Throughput');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'baseline|optimistic|pessimistic');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `week_number` SET TAGS ('dbx_business_glossary_term' = 'Week Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_forecast` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `primary_recruitment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `primary_recruitment_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `primary_recruitment_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Location Unit Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `workforce_department_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Workforce Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_count` SET TAGS ('dbx_business_glossary_term' = 'Applicant Count');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Budget (USD)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|seasonal|contract|intern|temporary');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_stage_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage Count');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `job_level` SET TAGS ('dbx_value_regex' = 'entry|associate|manager|director|executive');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `offers_accepted` SET TAGS ('dbx_business_glossary_term' = 'Offers Accepted');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `offers_extended` SET TAGS ('dbx_business_glossary_term' = 'Offers Extended');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_channel` SET TAGS ('dbx_business_glossary_term' = 'Posting Channel');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_channel` SET TAGS ('dbx_value_regex' = 'internal|job_board|recruiter|social|referral|agency');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_status` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_status` SET TAGS ('dbx_value_regex' = 'open|closed|on_hold|cancelled|filled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `required_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `source_of_candidate` SET TAGS ('dbx_business_glossary_term' = 'Source of Candidate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `source_of_candidate` SET TAGS ('dbx_value_regex' = 'internal|referral|agency|online|walk-in');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`recruitment` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `scheduling_template_id` SET TAGS ('dbx_business_glossary_term' = 'Default Scheduling Template Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `workforce_department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Buddy ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_renamed_from' = 'employee_id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Payroll Group Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `primary_onboarding_assigned_buddy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Buddy ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `primary_onboarding_assigned_buddy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `primary_onboarding_assigned_buddy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `tertiary_onboarding_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `tertiary_onboarding_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `tertiary_onboarding_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Onboarding End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `food_handler_card_date` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Card Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `food_handler_card_submitted` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Card Submitted Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `i9_completed` SET TAGS ('dbx_business_glossary_term' = 'I-9 Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `i9_completion_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Method (IN_PERSON, VIRTUAL, HYBRID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status (NOT_STARTED, IN_PROGRESS, COMPLETED, CANCELLED)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type (NEW_HIRE, TRANSFER, SEASONAL, INTERN)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_hire|transfer|seasonal|intern');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `pos_access_provision_date` SET TAGS ('dbx_business_glossary_term' = 'POS Access Provision Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `pos_access_provisioned` SET TAGS ('dbx_business_glossary_term' = 'POS Access Provisioned Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `servsafe_completion_date` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `servsafe_enrolled` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Enrolled Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `uniform_issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Uniform Issuance Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`onboarding` ALTER COLUMN `uniform_issued` SET TAGS ('dbx_business_glossary_term' = 'Uniform Issued Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`training_completion` ALTER COLUMN `training_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (Reviewer ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Position Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (Reviewer ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Competency Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status (Employee Confirmation)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Worked Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `attendance_score` SET TAGS ('dbx_business_glossary_term' = 'Attendance Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (Valid, Expired, Pending)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'valid|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments and Feedback');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_score_total` SET TAGS ('dbx_business_glossary_term' = 'Total Competency Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level of Review Record');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `corrective_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `development_goals` SET TAGS ('dbx_business_glossary_term' = 'Development Goals and Action Items');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Competency Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `guest_service_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Service Competency Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `labor_percentage_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `labor_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Target Labor Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_value_regex' = 'draft|completed|cancelled|in_progress');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale (e.g., 1‑5, 1‑10, Percentage)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_value_regex' = '1-5|1-10|percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date and Time');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_document_url` SET TAGS ('dbx_business_glossary_term' = 'URL to Review Document');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_method` SET TAGS ('dbx_business_glossary_term' = 'Review Method (Self, Manager, 360‑degree, Peer)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_method` SET TAGS ('dbx_value_regex' = 'self|manager|360|peer');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number (PRN)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type (e.g., 90‑Day, Annual, Promotion, Probation, Exit)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = '90_day|annual|promotion|probation|exit');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Work Hours');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `shift_daypart` SET TAGS ('dbx_business_glossary_term' = 'Shift Daypart (Breakfast, Lunch, Dinner, Late Night)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `shift_daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `speed_score` SET TAGS ('dbx_business_glossary_term' = 'Speed Competency Score');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `attachment_present` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Attachment Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `backfill_assigned_flag` SET TAGS ('dbx_business_glossary_term' = 'Backfill Shift Assigned Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Coverage Needed Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `is_paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Prior to Request');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_days_approved` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Days');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_days_requested` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Days');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|fmla|personal|unpaid');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return‑to‑Work Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `labor_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Violation ID');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `labor_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Work Shift Identifier (SHIFT_ID)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `actual_break_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Break Time');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `compliance_reported` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reported Flag');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart of Violation Occurrence');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `labor_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated|manual');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Source System Detecting Violation');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'workday|planday|zenput|manual_audit');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount Assessed (USD)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `labor_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Current Violation Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `labor_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|dismissed');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Exceeded');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount Assessed (USD)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Reporting Requirement');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'OSHA|DOL|state_labour');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Resolved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `scheduled_break_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Break Time');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Standardized Violation Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Occurrence Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Violation Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'missed_break|overtime|underage_work|certification_mismatch|osha_incident');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `workforce_department_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Workforce Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Category');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'operational|capital|training|benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Source');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_value_regex' = 'historical|model|manager_input');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|rejected');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daypart');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House FTE Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House FTE Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_total` SET TAGS ('dbx_business_glossary_term' = 'Total FTE Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Hours Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Hours Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_total` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Hours Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Labor Cost Estimate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Labor Cost Estimate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_dollar_budget` SET TAGS ('dbx_business_glossary_term' = 'Labor Dollar Budget');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Target Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Labor Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Labor Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic|promotion|lto');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`labor_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `tip_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for tip_compliance');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `corrected_tip_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Tip Compliance Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `corrected_tip_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`tip_compliance` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Tip Payroll Group Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `scheduling_template_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Template Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `base_scheduling_template_id` SET TAGS ('dbx_business_glossary_term' = 'Base Scheduling Template Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `base_scheduling_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `workforce_department_id` SET TAGS ('dbx_business_glossary_term' = 'Template Workforce Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `default_shift_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Shift Length Minutes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `scheduling_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `fte_target` SET TAGS ('dbx_business_glossary_term' = 'Fte Target');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `is_default_template` SET TAGS ('dbx_business_glossary_term' = 'Is Default Template');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `labor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `location_scope` SET TAGS ('dbx_business_glossary_term' = 'Location Scope');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `role_applicability` SET TAGS ('dbx_business_glossary_term' = 'Role Applicability');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `scheduling_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`scheduling_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `workforce_department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `department_id` SET TAGS ('dbx_ssot_reference' = 'restaurant.department');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `workforce_department_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `floor_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Sqft');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `workforce_department_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`workforce_department` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Payroll Run Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_description` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_cycle` SET TAGS ('dbx_business_glossary_term' = 'Pay Cycle');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Count');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Default Benefit Plan Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payroll Group Id');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `default_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Group Manager Email');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Group Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Group Manager Phone');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`payroll_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `default_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `hsa_employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `retirement_match_cap_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`benefit_plan` ALTER COLUMN `retirement_match_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'brand_standards');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id');
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
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `turnover_rate` SET TAGS ('dbx_business_glossary_term' = 'Turnover Rate');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_restaurants_v1`.`workforce`.`department` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
