-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 12:59:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`workforce` COMMENT 'Human capital and workforce management domain covering employee master data, organizational structure, skills and certifications, shift scheduling, labor tracking, payroll, talent management, and HR administration via Workday HCM. Supports labor cost allocation and ISO 45001 occupational health compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key sourced from Workday HCM. Serves as the single source of truth for employee identity across all manufacturing systems including SAP S/4HANA, Siemens Opcenter MES, and Maximo Asset Management.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payroll tax reporting requires linking each employee to their legal entity (company code) for statutory compliance.',
    `supervisor_employee_id` BIGINT COMMENT 'Employee ID of the direct supervisor or manager. Establishes reporting hierarchy for organizational structure, approval workflows, and performance management.',
    `annual_salary` DECIMAL(18,2) COMMENT 'Annual base salary for salaried employees. Used for budgeting, compensation analysis, and financial reporting. Null for hourly employees.',
    `cost_center` STRING COMMENT 'Financial cost center code for labor cost allocation and budgeting. Used in SAP S/4HANA CO (Controlling) module for tracking labor expenses against departmental budgets and calculating manufacturing overhead.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for audit trail, data lineage, and compliance with data governance policies.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation. Examples: USD, EUR, GBP, CNY. Used for multi-currency payroll processing and global workforce reporting.. Valid values are `^[A-Z]{3}$`',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and compliance with labor laws.',
    `department_code` STRING COMMENT 'Code identifying the organizational department to which the employee is assigned. Used for labor cost allocation, reporting hierarchy, and organizational analytics. Aligns with SAP S/4HANA organizational structure.. Valid values are `^[A-Z0-9]{3,8}$`',
    `department_name` STRING COMMENT 'Full name of the department. Examples: Assembly Line 1, Quality Control Lab, Maintenance Shop, Production Planning, Procurement. Provides human-readable context for organizational assignment.',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for system notifications, training communications, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the employees designated emergency contact person. Used for workplace incidents, medical emergencies, and ISO 45001 safety compliance.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the employees emergency contact. Used for urgent notifications in case of workplace accidents or medical emergencies.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee. Examples: Spouse, Parent, Sibling, Friend. Used for emergency response protocols.',
    `employee_number` STRING COMMENT 'Human-readable employee number assigned by HR system. Used for payroll, timekeeping, and shop floor identification. Displayed on employee badges and MES (Manufacturing Execution System) terminals.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current employment lifecycle status of the employee. Determines access rights, payroll processing, and system permissions. Active employees are eligible for work assignments and compensation.. Valid values are `active|inactive|on_leave|suspended|terminated|retired`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Determines benefits eligibility, labor cost allocation, and compliance with labor regulations. Full-time and part-time are permanent positions; contract and temporary are fixed-term.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in HR system. Used for official documentation, payroll processing, and compliance reporting.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used for seniority calculations, benefits eligibility, service awards, and tenure analytics.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate for hourly employees. Used for payroll calculation, labor cost allocation, and OpEx (Operational Expenditure) tracking. Null for salaried employees.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this employee record is currently active in the system. Used for filtering active workforce, system access control, and data retention policies.',
    `job_code` STRING COMMENT 'Standardized job classification code used for compensation planning, labor reporting, and workforce analytics. Maps to job families and pay grades in Workday HCM.. Valid values are `^[A-Z0-9]{4,10}$`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles. Examples: Production Operations, Engineering, Quality Assurance, Maintenance, Supply Chain, Finance. Used for workforce planning and talent management.',
    `job_title` STRING COMMENT 'Official job title assigned to the employee. Reflects role, seniority, and functional responsibility. Examples: Production Operator, Quality Engineer, Maintenance Technician, Plant Manager.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in HR system. Used for official documentation, payroll processing, and compliance reporting.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review. Used for tracking review cycles and ensuring timely performance evaluations.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee. Optional field used for complete legal identification.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll processing, and legal compliance.',
    `pay_grade` STRING COMMENT 'Compensation grade level assigned to the employee. Determines salary range, bonus eligibility, and compensation structure. Used for pay equity analysis and compensation planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating. Used for talent management, promotion decisions, compensation adjustments, and workforce development planning.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, shift scheduling notifications, and business communication.',
    `safety_certification_expiry_date` DATE COMMENT 'Date when the employees safety certification expires. Used for recertification scheduling and compliance tracking. Null if no certification required or status is not_required.',
    `safety_certification_status` STRING COMMENT 'Status of required safety certifications for the employees role. Used for ISO 45001 compliance, OSHA safety requirements, and work authorization on shop floor and hazardous areas.. Valid values are `certified|expired|pending|not_required`',
    `shift_code` STRING COMMENT 'Code identifying the primary shift assignment. Examples: 1ST, 2ND, 3RD, NIGHT, DAY. Used for production scheduling, labor tracking in MES (Manufacturing Execution System), and shift differential pay calculation.. Valid values are `^[A-Z0-9]{1,4}$`',
    `skill_level` STRING COMMENT 'Overall skill proficiency level of the employee in their primary job function. Used for work assignment, training needs assessment, and workforce capability planning.. Valid values are `entry|intermediate|advanced|expert|master`',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for final payroll processing, benefits termination, system access revocation, and turnover analytics.',
    `termination_reason` STRING COMMENT 'Reason for employment termination. Used for turnover analysis, exit interview tracking, and workforce planning. Null for active employees. [ENUM-REF-CANDIDATE: voluntary_resignation|retirement|involuntary_termination|layoff|end_of_contract|deceased|other — 7 candidates stripped; promote to reference product]',
    `training_hours_ytd` DECIMAL(18,2) COMMENT 'Total training hours completed by the employee in the current calendar year. Used for compliance with training requirements, skills development tracking, and ISO 9001 competency management.',
    `union_code` STRING COMMENT 'Code identifying the labor union to which the employee belongs. Null for non-union employees. Used for contract administration and union reporting.. Valid values are `^[A-Z0-9]{2,8}$`',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Used for collective bargaining compliance, union dues processing, and labor relations reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    `work_location_code` STRING COMMENT 'Code identifying the primary physical work location (plant, facility, office). Used for shift scheduling, safety compliance, and geographic labor reporting.. Valid values are `^[A-Z0-9]{3,8}$`',
    `work_location_name` STRING COMMENT 'Full name of the work location. Examples: Springfield Manufacturing Plant, Chicago Distribution Center, Detroit Assembly Facility. Provides geographic context for workforce distribution.',
    `work_permit_expiry_date` DATE COMMENT 'Date when the employees work permit or visa expires. Used for renewal tracking and compliance with immigration regulations. Null if no work permit required.',
    `work_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the employee requires a work permit or visa to work in the current location. Used for immigration compliance and work authorization tracking.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master record for all employees in the manufacturing organization. Serves as the SSOT for employee identity, personal details, employment status, job classification, cost center assignment, and HR administrative data sourced from Workday HCM. Covers full-time, part-time, contract, and temporary workers on the shop floor and in corporate functions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key for the organizational hierarchy master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org‑unit budgeting and cost allocation reports need a direct FK to the cost center, replacing the denormalized cost_center_code.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who manages this organizational unit. Used for organizational reporting lines and approval workflows.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Null for top-level corporate entity. Enables multi-level hierarchical structures.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit in base currency. Used for financial planning and variance analysis.',
    `business_function` STRING COMMENT 'Primary business function or operational area of this organizational unit. Used for functional reporting and cross-functional analysis. [ENUM-REF-CANDIDATE: production|quality|maintenance|engineering|supply_chain|sales|finance|hr|it|r_and_d — 10 candidates stripped; promote to reference product]',
    `capacity_utilization_target_pct` DECIMAL(18,2) COMMENT 'Target capacity utilization percentage for production organizational units. Used for Overall Equipment Effectiveness (OEE) and Key Performance Indicator (KPI) tracking.',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit used across enterprise systems. Typically alphanumeric code assigned by ERP system.. Valid values are `^[A-Z0-9]{4,20}$`',
    `company_code` STRING COMMENT 'Legal entity or company code in SAP FI for financial consolidation and statutory reporting. Links organizational unit to legal entity structure.. Valid values are `^[A-Z0-9]{4,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the organizational unit is located. Used for regulatory compliance and geographic analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts associated with this organizational unit.. Valid values are `^[A-Z]{3}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased or will cease operations. Null for currently active units. Supports historical organizational structure analysis.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become operational. Used for time-based organizational hierarchy reporting.',
    `environmental_certification_iso14001` BOOLEAN COMMENT 'Indicates whether this organizational unit holds ISO 14001 environmental management system certification. Used for environmental compliance reporting.',
    `external_code` STRING COMMENT 'Identifier used in external systems or legacy systems for data integration and cross-system reconciliation.',
    `headcount_actual` STRING COMMENT 'Current actual number of employees assigned to this organizational unit. Updated from employee assignment transactions.',
    `headcount_planned` STRING COMMENT 'Planned or budgeted number of employees for this organizational unit. Used for workforce planning and budget variance analysis.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy (1=corporate, 2=division, 3=business unit, etc.). Used for hierarchical rollup reporting.',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from corporate root to this organizational unit (e.g., /CORP/DIV01/PLANT05/DEPT20). Enables efficient hierarchy traversal queries.',
    `is_production_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is directly involved in manufacturing production activities. Used for production reporting and Manufacturing Execution System (MES) integration.',
    `location_code` STRING COMMENT 'Physical location or site code where this organizational unit operates. Links to facility master data for geographic reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this organizational unit record. Used for audit trail and data stewardship.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for change tracking and data quality monitoring.',
    `org_unit_name` STRING COMMENT 'Full name of the organizational unit (e.g., Assembly Line 3, Quality Control Department, North American Division).',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and can have employees assigned. Planned units are future entities not yet operational.. Valid values are `active|inactive|planned|closed|suspended`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit within the enterprise hierarchy. Defines the level and function of the unit.. Valid values are `corporate|division|business_unit|plant|department|work_center`',
    `plant_code` STRING COMMENT 'Manufacturing plant code if this organizational unit is or belongs to a production facility. Links to SAP PP (Production Planning) plant master.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_code` STRING COMMENT 'Profit center code for business units that are evaluated as independent profit-generating entities. Used for profitability analysis.. Valid values are `^[A-Z0-9]{4,15}$`',
    `quality_certification_iso9001` BOOLEAN COMMENT 'Indicates whether this organizational unit holds ISO 9001 quality management system certification. Required for quality compliance reporting.',
    `region_code` STRING COMMENT 'Geographic region or territory code for regional reporting and analysis (e.g., EMEA, APAC, AMER).',
    `safety_certification_required` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit require specific safety certifications per ISO 45001 occupational health and safety standards.',
    `shift_pattern` STRING COMMENT 'Standard shift operation pattern for this organizational unit. Used for production scheduling and labor planning.. Valid values are `single_shift|two_shift|three_shift|continuous|flexible`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the organizational unit used in reports and displays.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this organizational units primary location (e.g., America/New_York, Europe/Berlin). Used for shift scheduling and time-based reporting.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing employees in this organizational unit, if applicable.',
    `union_representation` BOOLEAN COMMENT 'Indicates whether this organizational unit has union representation. Used for labor relations and collective bargaining agreement compliance.',
    `work_center_code` STRING COMMENT 'Work center identifier for shop floor production units. Used in Manufacturing Execution System (MES) for production scheduling and capacity planning.. Valid values are `^[A-Z0-9]{4,12}$`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy master representing departments, cost centers, business units, plants, and work centers within the manufacturing enterprise. Supports multi-level hierarchical structures (corporate → division → plant → department → work center) used for labor cost allocation, headcount reporting, and production scheduling.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Job profiles are defined at the organizational unit level; adding responsible_org_unit_id links each job_profile to its owning org_unit, eliminating the need for duplicate org‑unit descriptive columns',
    `approval_status` STRING COMMENT 'Current approval workflow status for this job profile: Pending (awaiting review), Approved (authorized for use), Rejected (not approved).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the HR or business leader who approved this job profile.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile was approved for use.',
    `base_pay_type` STRING COMMENT 'Primary compensation structure for this job profile: Hourly (paid per hour worked), Salary (fixed annual amount), or Piece Rate (paid per unit produced).. Valid values are `hourly|salary|piece_rate`',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary for this job profile (e.g., 10.00 represents 10% target bonus).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary range values (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this job profile is retired or superseded. Null for open-ended profiles.',
    `effective_start_date` DATE COMMENT 'Date when this job profile becomes active and available for use in hiring, workforce planning, and organizational design.',
    `flsa_classification` STRING COMMENT 'FLSA overtime eligibility classification: Exempt (salaried, not eligible for overtime) or Non-Exempt (hourly, eligible for overtime).. Valid values are `exempt|non_exempt`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles (e.g., Production, Engineering, Quality, Maintenance, Supply Chain, Sales, Finance, HR, IT, Management). [ENUM-REF-CANDIDATE: production|engineering|quality|maintenance|supply_chain|sales|finance|hr|it|management — 10 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization (e.g., Entry, Intermediate, Senior, Lead, Manager, Director, Executive). [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|director|executive — 7 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile: Active (in use), Inactive (temporarily suspended), Draft (under development), Obsolete (retired).. Valid values are `active|inactive|draft|obsolete`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was last updated.',
    `last_review_date` DATE COMMENT 'Date when this job profile was last reviewed and validated by HR and business leadership.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and update of this job profile.',
    `occupational_classification_code` STRING COMMENT 'Standard Occupational Classification (SOC) code aligning this job profile to national occupational taxonomy (format: XX-XXXX).. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether positions under this job profile are eligible for overtime compensation under FLSA and local labor laws.',
    `pay_grade` STRING COMMENT 'Compensation grade band assigned to this job profile, determining salary range and benefits eligibility.. Valid values are `^[A-Z0-9]{2,6}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this job profile (e.g., Ability to lift 50 lbs, stand for extended periods, work in noisy environment, exposure to chemicals).',
    `proficiency_level_required` STRING COMMENT 'Overall skill proficiency level expected for this job profile (e.g., Basic, Intermediate, Advanced, Expert).. Valid values are `basic|intermediate|advanced|expert`',
    `profile_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the job profile across the enterprise. Used in HR systems, requisitions, and organizational planning.. Valid values are `^[A-Z0-9]{6,12}$`',
    `profile_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and key responsibilities of the job profile.',
    `profile_name` STRING COMMENT 'Human-readable name of the job profile (e.g., Senior CNC Machinist, Production Supervisor, Quality Engineer).',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this job profile is eligible for remote or hybrid work arrangements.',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications, licenses, or credentials required for this job profile (e.g., CNC Operator Certification, OSHA 30-Hour, Forklift License).',
    `required_education_level` STRING COMMENT 'Minimum educational attainment required for this job profile (e.g., High School, Associate, Bachelor, Master, Doctorate, Vocational, None). [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|vocational|none — 7 candidates stripped; promote to reference product]',
    `safety_sensitive_position` BOOLEAN COMMENT 'Indicates whether this job profile is classified as safety-sensitive, requiring additional screening, training, and compliance monitoring under OSHA and ISO 45001.',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for this job profile in the enterprise default currency.',
    `salary_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint annual base salary for this job profile, representing the target compensation for fully competent performance.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for this job profile in the enterprise default currency.',
    `shift_premium_eligible` BOOLEAN COMMENT 'Indicates whether positions under this job profile are eligible for shift differential pay (e.g., night shift, weekend premium).',
    `soft_skills_required` STRING COMMENT 'Comma-separated list of interpersonal and behavioral competencies required for this job profile (e.g., Leadership, Communication, Problem Solving, Teamwork, Attention to Detail).',
    `succession_planning_critical` BOOLEAN COMMENT 'Indicates whether this job profile is designated as critical for succession planning and talent pipeline development.',
    `technical_skills_required` STRING COMMENT 'Comma-separated list of technical skills and competencies required for this job profile (e.g., CNC Programming, PLC Troubleshooting, Welding, CAD, SAP MM, Statistical Process Control).',
    `travel_requirement_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of work time requiring business travel for this job profile (e.g., 10.00 represents 10% travel).',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether positions under this job profile are eligible for union membership and collective bargaining representation.',
    `years_experience_minimum` STRING COMMENT 'Minimum number of years of relevant work experience required for this job profile.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Reference catalog of standardized job profiles and position classifications used across the manufacturing enterprise. Defines job family, job level, pay grade band, salary range, FLSA classification, required certifications, standard competency and skill requirements, and compensation structure parameters (base pay type, shift premium eligibility, bonus target). Also serves as the reference for skill/competency taxonomy — each profile specifies the technical skills (CNC, PLC, welding, electrical), soft skills, and proficiency levels required. Sourced from Workday HCM Job Profile and aligned to ANSI/ISO occupational classification standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized headcount position within the organizational structure.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Position definitions include responsibility for a control system, used in competency mapping and safety certification.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Position‑level headcount and labor‑cost planning rely on linking each position to its cost center.',
    `employee_id` BIGINT COMMENT 'Reference to the employee currently filling this position. Null if the position is vacant.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the role, responsibilities, competencies, and requirements for this position.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location (plant, office, facility) where this position is based.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, cost center, division) to which this position is assigned.',
    `supervisor_position_id` BIGINT COMMENT 'Reference to the position that supervises this position in the organizational hierarchy.',
    `approved_date` DATE COMMENT 'Date when this position was approved by management for inclusion in the authorized headcount.',
    `budgeted_headcount` DECIMAL(18,2) COMMENT 'Approved headcount allocation for this position in the annual budget, used for workforce planning and gap analysis.',
    `business_unit` STRING COMMENT 'High-level business unit or division to which this position belongs for strategic workforce planning.',
    `position_code` STRING COMMENT 'Business-assigned unique code for the position, used for external identification and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_date` DATE COMMENT 'Date when this position record was originally created in the system.',
    `critical_position_flag` BOOLEAN COMMENT 'Indicates whether this position is classified as business-critical for succession planning and talent management purposes.',
    `position_description` STRING COMMENT 'Detailed description of the position responsibilities, duties, and key accountabilities.',
    `effective_end_date` DATE COMMENT 'Date when this position was closed or is scheduled to be closed. Null for open-ended positions.',
    `effective_start_date` DATE COMMENT 'Date when this position became active and available for assignment within the organizational structure.',
    `employment_category` STRING COMMENT 'Employment category indicating the work schedule pattern: full-time, part-time, casual, or on-call.. Valid values are `full_time|part_time|casual|on_call`',
    `exempt_status` STRING COMMENT 'FLSA classification indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for this position, representing the proportion of a full-time workload (e.g., 1.00 for full-time, 0.50 for half-time).',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether this position is classified as safety-sensitive, requiring additional health and safety compliance per ISO 45001 and OSHA regulations.',
    `job_family` STRING COMMENT 'Broad job family classification grouping similar positions (e.g., Engineering, Operations, Finance, Human Resources).',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization (e.g., entry, mid, senior, executive).. Valid values are `^[A-Z0-9]{1,4}$`',
    `justification` STRING COMMENT 'Business justification for creating or maintaining this position, used for budget approval and workforce planning.',
    `last_filled_date` DATE COMMENT 'Date when this position was most recently filled by an employee. Null if never filled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last updated in the system.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this position (e.g., high school, associate degree, bachelor degree, master degree).',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for this position.',
    `notes` STRING COMMENT 'Additional notes or comments about this position for internal HR and management reference.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position, defining the salary range and compensation structure.. Valid values are `^[A-Z0-9]{2,6}$`',
    `position_status` STRING COMMENT 'Current lifecycle status of the position indicating whether it is filled, vacant, frozen for budget reasons, pending approval, closed, or suspended.. Valid values are `filled|vacant|frozen|pending_approval|closed|suspended`',
    `position_type` STRING COMMENT 'Classification of the position based on employment type: regular (permanent), temporary, contract, seasonal, or intern.. Valid values are `regular|temporary|contract|seasonal|intern`',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this position is eligible for remote or hybrid work arrangements.',
    `replacement_position_flag` BOOLEAN COMMENT 'Indicates whether this position is a replacement for a previously closed position or a net-new headcount addition.',
    `requires_certification` BOOLEAN COMMENT 'Indicates whether this position requires specific professional certifications, licenses, or qualifications to perform the role.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern assigned to this position for manufacturing operations and scheduling.. Valid values are `day|night|rotating|fixed|flexible`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure.',
    `travel_requirement_percentage` STRING COMMENT 'Percentage of time this position is expected to travel for business purposes (0-100).',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit to which this position belongs, if applicable.. Valid values are `^[A-Z0-9]{2,8}$`',
    `vacancy_start_date` DATE COMMENT 'Date when this position became vacant, used for time-to-fill metrics and workforce gap analysis.',
    `work_schedule_hours` DECIMAL(18,2) COMMENT 'Standard number of hours per week assigned to this position for scheduling and labor tracking purposes.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions within the organizational structure, representing approved roles that may be filled or vacant. Tracks position title, org unit assignment, FTE allocation, budgeted headcount, position status (filled/vacant/frozen), and effective dates. Enables workforce planning and headcount gap analysis against production staffing requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Primary key for assignment',
    `assignment_org_unit_id` BIGINT COMMENT 'Reference to the organizational unit to which the employee is assigned. Links to the organizational hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center for labor cost allocation. Used for financial reporting and production cost tracking.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Equipment assignment records which employee is assigned to maintain or operate a device, supporting maintenance planning.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile defining the role, responsibilities, and competencies for this assignment.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit for financial and operational reporting. Links to the enterprise business unit hierarchy.',
    `position_id` BIGINT COMMENT 'Reference to the position master record. Identifies the specific position to which the employee is assigned.',
    `employee_id` BIGINT COMMENT 'Reference to the employee master record. Links this assignment to the worker in the workforce domain.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical work location for this assignment. Links to facility or site master data.',
    `assignment_number` STRING COMMENT 'Business-facing unique identifier for the assignment. Used for external reference and reporting.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Indicates whether the assignment is currently active, inactive, suspended, terminated, or pending activation.. Valid values are `active|inactive|suspended|terminated|pending`',
    `assignment_type` STRING COMMENT 'Classification of the assignment nature. Distinguishes between permanent roles, temporary assignments, acting positions, secondments, contract work, and internships.. Valid values are `permanent|temporary|acting|secondment|contract|intern`',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'Base compensation rate for the assignment. Amount is in the currency specified by pay_currency_code.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base pay. Represents the expected variable compensation opportunity for this assignment.',
    `company_code` STRING COMMENT 'Legal entity or company code for financial reporting and compliance. Aligns with ERP (Enterprise Resource Planning) financial structure.',
    `cost_center_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of labor cost allocated to the primary cost center. Used when an employees time is split across multiple cost centers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the assignment ends or is scheduled to end. Nullable for open-ended assignments.',
    `effective_start_date` DATE COMMENT 'Date when the assignment becomes effective. Marks the beginning of the assignment period.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement. Distinguishes between full-time, part-time, casual, and seasonal employment.. Valid values are `full_time|part_time|casual|seasonal`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of full-time equivalent hours for this assignment. 100.00 represents full-time, values below 100 represent part-time.',
    `job_family` STRING COMMENT 'Broad categorization of the job role. Groups similar positions for workforce planning and talent management.',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization. Used for career progression tracking and compensation benchmarking.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the assignment record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes or comments about the assignment. Used for documenting special circumstances or conditions.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the assignment is eligible for overtime compensation. True if eligible for overtime pay under labor regulations.',
    `pay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation amounts. Specifies the currency in which base pay and other compensation are denominated.. Valid values are `^[A-Z]{3}$`',
    `pay_frequency` STRING COMMENT 'Frequency at which the base pay rate is applied. Indicates whether compensation is calculated hourly, daily, weekly, biweekly, monthly, or annually.. Valid values are `hourly|daily|weekly|biweekly|monthly|annual`',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position. Used for pay equity analysis and compensation benchmarking.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Indicates whether this is the employees primary assignment. True for primary assignment, false for secondary or concurrent assignments.',
    `probation_end_date` DATE COMMENT 'Date when the probationary period for this assignment ends. Null if no probation period applies.',
    `reason` STRING COMMENT 'Business reason or trigger for creating or modifying this assignment. Examples include new hire, promotion, transfer, reorganization, or contract renewal.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire after assignment termination. True if eligible, false if not eligible. Null for active assignments.',
    `scheduled_weekly_hours` DECIMAL(18,2) COMMENT 'Standard number of hours the employee is scheduled to work per week under this assignment.',
    `shift_premium_eligible_flag` BOOLEAN COMMENT 'Indicates whether the assignment is eligible for shift premium pay. True if eligible for additional compensation for non-standard shifts.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this assignment record originated. Used for data lineage and integration tracking.',
    `termination_date` DATE COMMENT 'Date when the assignment was terminated. Null for active assignments. Used for historical tracking and compliance reporting.',
    `termination_reason` STRING COMMENT 'Reason for assignment termination. Examples include resignation, retirement, layoff, dismissal, end of contract, or transfer. Null for active assignments.',
    `time_type` STRING COMMENT 'Classification of time tracking method for this assignment. Examples include salaried exempt, salaried non-exempt, hourly, or piece-rate.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit covering this assignment. Null if not unionized.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the assignment is covered by a collective bargaining agreement. True if the position is unionized.',
    `work_shift_code` STRING COMMENT 'Code identifying the standard work shift pattern for this assignment. Examples include day shift, night shift, rotating shift, or flexible schedule.',
    `created_by` STRING COMMENT 'User identifier or system account that created the assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Transactional record of an employees assignment to a specific position, org unit, job profile, compensation terms, and work location over a defined effective period. Captures primary and secondary assignments, supervisory relationships, cost center splits, assignment type (permanent, temporary, acting), base pay rate, pay frequency, shift premium eligibility, and bonus target percentage. Serves as the central employment terms record supporting labor cost allocation to production cost centers, pay equity analysis, workforce planning, and compensation history tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'Unique identifier for the workforce certification record. Primary key for the workforce certification entity.',
    `certification_type_id` BIGINT COMMENT 'Unique identifier of the certification type from the master catalog. Defines the regulatory, safety, or professional certification standard (e.g., ISO 45001, OSHA 10/30, forklift operator, electrical safety, AWS/ASME welding qualifications, quality auditor).',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who holds or is pursuing this certification. Links to the employee master record in Workday HCM.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Required for tracking which regulatory requirement each certification satisfies, essential for compliance audit reports.',
    `attachment_url` STRING COMMENT 'URL or file path to the digital copy of the certification document, certificate, or credential stored in the document management system. Null if no digital copy is available.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying authority. Used for verification and audit purposes.',
    `certification_category` STRING COMMENT 'High-level classification of the certification domain: safety (OSHA, ISO 45001), quality (ISO 9001, Six Sigma), technical (welding, electrical), regulatory (EPA, FDA), professional (PMP, CPA), or operational (forklift, crane operator).. Valid values are `safety|quality|technical|regulatory|professional|operational`',
    `certification_code` STRING COMMENT 'Standardized code or abbreviation for the certification type used for internal classification and reporting (e.g., OSHA-30, AWS-CWI, ISO9001-LA).',
    `certification_level` STRING COMMENT 'Proficiency or qualification level of the certification (e.g., Basic, Intermediate, Advanced, Lead Auditor, Master Craftsman). Null if the certification does not have levels.',
    `certification_name` STRING COMMENT 'Full name of the certification as recognized by the issuing authority (e.g., OSHA 30-Hour General Industry, AWS Certified Welder, ISO 9001 Lead Auditor).',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is mandated by regulatory or company policy for the employees role (True) or is optional/voluntary (False). Used to enforce ISO 45001 occupational health compliance.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew this certification, including training fees, examination fees, and certification fees. Used for labor cost allocation and training budget tracking.',
    `cost_center_code` STRING COMMENT 'SAP FI/CO cost center code to which the certification cost is allocated. Used for departmental budget tracking and labor cost allocation.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date from which the certification is valid and the employee is authorized to perform certified tasks. May differ from issue date if there is a waiting period.',
    `equipment_authorization` STRING COMMENT 'Comma-separated list of equipment types or asset classes the employee is authorized to operate or work on with this certification (e.g., Overhead Crane, Gantry Crane, MIG Welder, TIG Welder, High Voltage Switchgear).',
    `examination_date` DATE COMMENT 'Date on which the employee took the certification examination or assessment. Null if no examination is required.',
    `examination_score` DECIMAL(18,2) COMMENT 'Numerical score or percentage achieved by the employee on the certification examination. Null if no examination is required or score is not recorded.',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid unless renewed. Null for certifications with no expiration (lifetime certifications).',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the employee by the certifying authority.',
    `issuing_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the certification (e.g., OSHA, American Welding Society, International Register of Certificated Auditors).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction where the certification was issued (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `job_role_applicability` STRING COMMENT 'Comma-separated list of job roles or job families for which this certification is required or recommended (e.g., Welder, Fabricator, Quality Inspector, Auditor, Forklift Operator, Material Handler).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently updated. Used for audit trail and change tracking.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or recertification event. Null if the certification has never been renewed.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the HR administrator or system user who last modified this certification record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or administrative notes related to this certification record (e.g., Renewal pending manager approval, Certification suspended due to incident investigation).',
    `pass_fail_status` STRING COMMENT 'Result of the certification examination or assessment: pass (met requirements), fail (did not meet requirements), pending (awaiting results), or not_applicable (no examination required).. Valid values are `pass|fail|pending|not_applicable`',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory standard or framework that mandates this certification (e.g., ISO 45001, OSHA 1910.147, IEC 61131, EPA 40 CFR 112). Null for non-regulatory certifications.',
    `renewal_count` STRING COMMENT 'Total number of times this certification has been renewed for this employee. Zero for initial certifications that have not yet been renewed.',
    `renewal_due_date` DATE COMMENT 'Target date by which the certification must be renewed to maintain continuous validity. Typically set before the expiry date to allow processing time. Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal (True) or is a one-time/lifetime certification (False).',
    `source_system_code` STRING COMMENT 'Unique identifier of this certification record in the source operational system. Used for reconciliation and data lineage.',
    `training_completion_date` DATE COMMENT 'Date on which the employee completed the required training or coursework for this certification. Null if training is not required or not yet completed.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Number of training or continuing education hours the employee has completed toward this certification. Used to track progress for in-progress certifications.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Total number of training or continuing education hours required to obtain or maintain this certification. Null if not applicable.',
    `training_provider` STRING COMMENT 'Name of the organization or institution that provided the training or preparation for this certification (e.g., Internal Training Center, American Welding Society, TUV Rheinland). May differ from the issuing authority.',
    `validity_period_months` STRING COMMENT 'Standard validity period of the certification in months from the issue date (e.g., 12, 24, 36). Null for lifetime certifications.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified with the issuing authority. Null if never verified.',
    `verification_status` STRING COMMENT 'Status of third-party verification of the certification with the issuing authority: verified (confirmed authentic), pending_verification (awaiting confirmation), failed_verification (could not be confirmed), or not_verified (not yet checked).. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    `verified_by` STRING COMMENT 'Name or identifier of the HR administrator or system that performed the most recent verification. Null if never verified.',
    `work_location_restriction` STRING COMMENT 'Geographic or facility-level restrictions on where this certification is valid (e.g., USA only, EU member states, Plant 101 only). Null if valid globally.',
    `workforce_certification_status` STRING COMMENT 'Current lifecycle status of the certification: active (valid and in effect), expired (past expiry date), suspended (temporarily invalid), revoked (permanently invalidated), pending (awaiting approval), or in_progress (training/testing underway).. Valid values are `active|expired|suspended|revoked|pending|in_progress`',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Master catalog of regulatory, safety, and professional certification types relevant to industrial manufacturing, combined with transactional attainment records for individual employees. Defines certification types (ISO 45001, OSHA 10/30, forklift operator, electrical safety, AWS/ASME welding qualifications, quality auditor) with issuing body, validity period, and renewal requirements. Tracks individual employee attainment including issue date, expiry date, certificate number, issuing authority, current status (active/expired/suspended), and automated renewal workflow triggers. Serves as the SSOT for all certification compliance — ensuring only certified workers are assigned to regulated tasks per ISO 45001 occupational health requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record. Primary key for the shift schedule entity.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Operator shift schedules assign specific machines to employees, enabling production planning and labor tracking.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee assigned to this shift. Links to the employee master record in Workday HCM.',
    `production_line_id` BIGINT COMMENT 'Unique identifier of the production line to which the employee is assigned during this shift. Links to production line master data.',
    `shift_pattern_id` BIGINT COMMENT 'Unique identifier of the shift pattern template applied to this schedule (e.g., 3-shift rotation, 4-on-4-off). Links to shift pattern reference data.',
    `work_center_id` BIGINT COMMENT 'Unique identifier of the work center where the employee is scheduled to work. Links to the work center master in SAP S/4HANA PP.',
    `break_duration_minutes` STRING COMMENT 'Total planned break time in minutes during the shift (e.g., lunch break, rest breaks). Used to calculate net productive hours and ensure compliance with labor regulations.',
    `cancellation_reason` STRING COMMENT 'Free-text description of the reason for shift cancellation (e.g., production order cancelled, employee absence, equipment failure). Populated only when schedule_status is cancelled.',
    `cancelled_datetime` TIMESTAMP COMMENT 'Date and time when the shift schedule was cancelled. Populated only when schedule_status is cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `confirmed_datetime` TIMESTAMP COMMENT 'Date and time when the employee acknowledged or confirmed the shift assignment. Used for tracking employee acceptance and attendance planning. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this shift schedule record. Used for audit trail and accountability.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `exception_reason` STRING COMMENT 'Free-text description of the reason for any schedule exception (e.g., production surge, equipment breakdown, employee request). Populated only when schedule_exception_flag is true.',
    `is_holiday` BOOLEAN COMMENT 'Boolean flag indicating whether the shift occurs on a recognized company or statutory holiday. Used for premium pay calculation and compliance reporting.',
    `is_night_shift` BOOLEAN COMMENT 'Boolean flag indicating whether the shift occurs during night hours (typically 10 PM to 6 AM). Used for shift differential pay and occupational health compliance.',
    `is_overtime` BOOLEAN COMMENT 'Boolean flag indicating whether this shift qualifies as overtime under labor regulations. True if the shift exceeds standard working hours or occurs outside regular schedule.',
    `is_weekend` BOOLEAN COMMENT 'Boolean flag indicating whether the shift occurs on a weekend (Saturday or Sunday). Used for premium pay calculation and workforce analytics.',
    `labor_cost_center` STRING COMMENT 'Cost center code to which labor hours and costs for this shift are allocated. Used for financial reporting and cost accounting in SAP S/4HANA CO.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this shift schedule record. Used for audit trail and accountability.',
    `modified_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was last modified. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `net_productive_hours` DECIMAL(18,2) COMMENT 'Net available labor hours after deducting break time from scheduled duration. Used for capacity planning and Overall Equipment Effectiveness (OEE) calculations.',
    `notes` STRING COMMENT 'Free-text notes or comments about the shift schedule. Used for special instructions, safety reminders, or coordination information.',
    `published_datetime` TIMESTAMP COMMENT 'Date and time when the shift schedule was published and communicated to the employee. Used for compliance with advance notice requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `schedule_date` DATE COMMENT 'Calendar date on which the shift occurs. Used for day-level aggregation and reporting. Format: yyyy-MM-dd.',
    `schedule_exception_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this shift has any exceptions or deviations from the standard shift pattern (e.g., early start, late end, split shift).',
    `schedule_month` STRING COMMENT 'Month number (1-12) of the scheduled shift. Used for monthly labor cost allocation and workforce planning.',
    `schedule_number` STRING COMMENT 'Human-readable business identifier for the shift schedule, typically generated by Opcenter MES or Workday HCM. Format: SCH-YYYYMMDD.. Valid values are `^SCH-[0-9]{8}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the shift schedule. Draft schedules are under planning; published schedules are communicated to employees; confirmed schedules are acknowledged; cancelled schedules are voided; completed schedules have ended.. Valid values are `draft|published|confirmed|cancelled|completed`',
    `schedule_week` STRING COMMENT 'ISO week number of the year for the scheduled shift. Used for weekly labor planning and reporting.',
    `schedule_year` STRING COMMENT 'Calendar year of the scheduled shift. Used for annual labor reporting and compliance.',
    `scheduled_duration_hours` DECIMAL(18,2) COMMENT 'Total planned duration of the shift in hours, calculated as the difference between scheduled end and start datetime. Used for labor capacity planning and payroll calculation.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned end date and time of the shift. Represents the clock-out time for the employee at the assigned work center. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start date and time of the shift. Represents the clock-in time for the employee at the assigned work center. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `scheduling_horizon_weeks` STRING COMMENT 'Number of weeks in advance that this shift was scheduled. Used for workforce planning analytics and compliance with advance notice regulations.',
    `shift_name` STRING COMMENT 'Descriptive name of the shift (e.g., Morning Shift, Night Shift, Swing Shift, Weekend Crew). Used for human-readable identification and communication.',
    `shift_priority` STRING COMMENT 'Business priority level of the shift assignment. Critical shifts support high-priority production orders; high-priority shifts support key customer deliveries; normal shifts are standard operations; low-priority shifts are for non-urgent tasks.. Valid values are `critical|high|normal|low`',
    `shift_type` STRING COMMENT 'Classification of the shift assignment. Regular shifts are standard production hours; overtime shifts exceed standard hours; on-call and standby shifts are for emergency coverage; training shifts are for skill development; maintenance shifts are for equipment servicing.. Valid values are `regular|overtime|on_call|standby|training|maintenance`',
    `skill_requirement` STRING COMMENT 'Required skill or certification for the employee to perform this shift (e.g., CNC Operator, Forklift Certified, Quality Inspector). Used for skill-based scheduling and compliance.',
    `source_system_code` STRING COMMENT 'Unique identifier of this shift schedule record in the source system. Used for data lineage and reconciliation.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Operational schedule assigning employees to specific shifts, work centers, and production lines over a defined scheduling horizon. Captures scheduled start/end datetime, assigned work center, production line, shift pattern, schedule status (draft, published, confirmed), and any schedule exceptions. Integrates with Opcenter MES for shop floor labor availability and capacity planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry transaction.',
    `asset_work_order_id` BIGINT COMMENT 'Unique identifier of the production work order or maintenance job that this labor time is charged to. Used for labor cost allocation to manufacturing operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Time‑entry records must allocate labor hours to a cost center for accurate financial statements.',
    `equipment_register_id` BIGINT COMMENT 'Unique identifier of the machine, equipment, or asset operated or maintained during this time entry. Used for equipment utilization and maintenance labor tracking.',
    `payroll_period_id` BIGINT COMMENT 'Unique identifier of the payroll period to which this time entry is assigned for payment processing.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who recorded this time entry. Links to the employee master record in Workday HCM.',
    `tertiary_time_modified_by_employee_id` BIGINT COMMENT 'Unique identifier of the user or employee who last modified this time entry record. Used for audit trail and accountability.',
    `absence_type` STRING COMMENT 'Type of paid or unpaid absence if this time entry represents non-working time. Set to none for regular working time entries. [ENUM-REF-CANDIDATE: none|sick_leave|vacation|personal|bereavement|jury_duty|training|other — 8 candidates stripped; promote to reference product]',
    `activity_code` STRING COMMENT 'The specific work activity or operation code performed during this time entry (e.g., ASSEMBLY, WELDING, INSPECTION, SETUP, MAINTENANCE). Used for detailed labor tracking and OEE analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `approval_status` STRING COMMENT 'Current approval status of the time entry in the workflow. Time entries must be approved before being released to payroll processing.. Valid values are `pending|approved|rejected|submitted|draft`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry was approved by the supervisor. Null if not yet approved.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during this time entry, expressed in minutes. Deducted from total hours for payroll calculation.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked in or started work for this time entry. Captured from MES shop floor terminals or Workday HCM time tracking.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked out or ended work for this time entry. Used to calculate total hours worked.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether this time entry has been verified for compliance with labor regulations, union agreements, and ISO 45001 occupational health and safety requirements (e.g., maximum consecutive hours, mandatory rest periods).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor rate, premium, and cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `exception_code` STRING COMMENT 'Code indicating any time entry exception or anomaly requiring review (e.g., LATE_CLOCK_IN, MISSING_CLOCK_OUT, OVERTIME_THRESHOLD). Empty if no exception.. Valid values are `^[A-Z0-9_]{0,20}$`',
    `exception_notes` STRING COMMENT 'Free-text notes or comments explaining any time entry exception, correction, or special circumstance. Used for audit trail and dispute resolution.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during this time entry, calculated from clock-in and clock-out timestamps. Expressed in decimal hours (e.g., 8.50 for 8 hours 30 minutes).',
    `job_code` STRING COMMENT 'The job classification or position code of the employee at the time this work was performed. Used for labor mix analysis and skill-based costing.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for this time entry, calculated as hours worked multiplied by labor rate plus any shift premiums. Used for work order costing and variance analysis.',
    `labor_rate` DECIMAL(18,2) COMMENT 'The hourly labor rate applied to this time entry for cost calculation purposes. May differ from actual employee pay rate for standard costing purposes.',
    `labor_type` STRING COMMENT 'Classification of the labor time for payroll and costing purposes. Determines the pay rate multiplier and labor cost calculation method.. Valid values are `regular|overtime|double_time|holiday|on_call|standby`',
    `location_code` STRING COMMENT 'The plant, facility, or work center location code where this time was worked. Used for multi-site labor reporting and compliance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was last modified or updated. Used for change tracking and audit compliance.',
    `oee_productive_time` BOOLEAN COMMENT 'Indicates whether this time entry represents productive manufacturing time that should be included in OEE (Overall Equipment Effectiveness) labor efficiency calculations. False for indirect labor, breaks, or non-productive activities.',
    `operation_sequence` STRING COMMENT 'The sequence number of the manufacturing operation or routing step being performed during this time entry. Used to track labor against specific production process steps.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay for this time entry based on employment classification and labor regulations.',
    `payroll_processed` BOOLEAN COMMENT 'Indicates whether this time entry has been processed and included in a payroll run. Once true, the time entry is locked from further edits.',
    `project_code` STRING COMMENT 'The project or capital expenditure (CapEx) project code to which this labor time is charged. Used for project accounting and capital asset construction tracking.. Valid values are `^[A-Z0-9-]{0,20}$`',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The number of units or pieces produced or processed during this time entry. Used for productivity analysis and labor efficiency calculations (units per hour).',
    `shift_code` STRING COMMENT 'The shift identifier or code during which this time was worked (e.g., DAY, NIGHT, SWING). Used for shift premium calculation and production scheduling analysis.. Valid values are `^[A-Z0-9]{1,10}$`',
    `shift_premium_amount` DECIMAL(18,2) COMMENT 'The additional premium amount paid for this time entry due to shift differential, expressed in the payroll currency. Null if no premium applies.',
    `shift_premium_eligible` BOOLEAN COMMENT 'Indicates whether this time entry qualifies for shift differential or premium pay based on the shift worked and labor agreement terms.',
    `source` STRING COMMENT 'The system or method through which this time entry was captured (e.g., MES shop floor terminal, Workday mobile app, manual supervisor entry).. Valid values are `shop_floor_terminal|mobile_app|web_portal|supervisor_entry|import|biometric`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity produced (e.g., EA for each, KG for kilograms, M for meters). Aligns with material master UOM definitions.. Valid values are `^[A-Z]{2,6}$`',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Used for payroll period assignment and labor reporting.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Granular transactional record of employee time worked, capturing clock-in/clock-out events, work order or cost center charged, labor type (regular, overtime, double-time), shift premium eligibility, and approval status. Sourced from Workday HCM Time Tracking and MES shop floor terminals. Feeds payroll processing, labor cost allocation to production work orders, and OEE labor efficiency calculations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the absence record. Primary key.',
    `asset_work_order_id` BIGINT COMMENT 'Identifier of the work order or production order that was impacted by this absence. Used to track production capacity gaps and schedule adjustments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Absence cost impact is charged to the employees cost center for variance analysis.',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll period in which this absence is processed for payroll deduction or accrual adjustment.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is absent. Links to the employee master record in Workday HCM.',
    `shift_id` BIGINT COMMENT 'Identifier of the scheduled shift from which the employee was absent. Supports shift-level labor availability tracking.',
    `tertiary_absence_replacement_employee_id` BIGINT COMMENT 'Employee identifier of the replacement worker assigned to cover the absent employees shift or responsibilities.',
    `absence_notes` STRING COMMENT 'Free-text notes or comments regarding the absence, including special circumstances, accommodation requests, or manager observations.',
    `absence_reason_code` STRING COMMENT 'Detailed reason code for the absence. May include specific illness codes, family emergency types, or other granular classifications as defined by HR policy.',
    `absence_type_code` STRING COMMENT 'Code representing the category of absence: VACATION (planned vacation leave), SICK (unplanned sick leave), PERSONAL (personal time off), PARENTAL (maternity/paternity leave), FMLA (Family and Medical Leave Act protected leave), BEREAVEMENT (compassionate leave), JURY_DUTY (civic duty leave), MILITARY (military service leave), UNPAID (unpaid leave of absence). [ENUM-REF-CANDIDATE: VACATION|SICK|PERSONAL|PARENTAL|FMLA|BEREAVEMENT|JURY_DUTY|MILITARY|UNPAID — 9 candidates stripped; promote to reference product]',
    `accrual_balance_deducted` DECIMAL(18,2) COMMENT 'Number of hours deducted from the employees leave accrual balance (vacation bank, sick leave bank, etc.) for this absence.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the absence request: PENDING (awaiting manager review), APPROVED (authorized by manager), REJECTED (denied by manager), CANCELLED (approved but subsequently cancelled), WITHDRAWN (employee withdrew request before approval).. Valid values are `PENDING|APPROVED|REJECTED|CANCELLED|WITHDRAWN`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the absence request was approved or rejected by the manager.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this absence record was first created in the lakehouse silver layer.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in calendar days. Supports fractional days for partial-day absences.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in hours. Used for hourly payroll deduction and accrual calculations.',
    `end_date` DATE COMMENT 'The last calendar date of the absence period. Nullable for open-ended absences pending return-to-work confirmation.',
    `is_fmla_protected` BOOLEAN COMMENT 'Indicates whether this absence is protected under the Family and Medical Leave Act (FMLA) regulations, providing job protection and continuation of benefits.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether this absence is part of an intermittent leave pattern (true) such as recurring FMLA leave, or a continuous block of absence (false).',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the absence is paid (true) or unpaid (false). Determines whether payroll deduction or accrual balance adjustment is required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this absence record was last updated in the lakehouse silver layer.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification documentation has been received and validated by HR.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether medical certification documentation is required for this absence per company policy or regulatory requirement.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the employee originally submitted the absence request in Workday HCM.',
    `return_to_work_certification_received` BOOLEAN COMMENT 'Indicates whether a medical clearance or return-to-work certification was received before the employee resumed duties, as required by occupational health policy per ISO 45001.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work following the absence. May differ from the planned end_date if the absence was extended or shortened.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this absence record originated (e.g., WORKDAY_HCM, SAP_HR, MANUAL_ENTRY).',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this absence record in the source system (e.g., Workday HCM absence event ID). Used for data lineage and reconciliation.',
    `start_date` DATE COMMENT 'The first calendar date of the absence period. Used for production capacity planning and labor availability forecasting.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Transactional record of employee absences including planned leave (vacation, personal, parental), unplanned absences (sick leave, FMLA), and approved time-off requests. Captures absence type, start/end dates, duration in hours/days, approval status, and reason code. Supports production capacity planning by surfacing labor availability gaps and feeds payroll deduction or accrual calculations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` (
    `payroll_result_id` BIGINT COMMENT 'Unique identifier for the payroll calculation result record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll expenses are allocated to cost centers to support financial reporting and budgeting.',
    `payroll_period_id` BIGINT COMMENT 'add column payroll_period_id (BIGINT) with FK to workforce.payroll_period.payroll_period_id - payroll results must reference the period they cover',
    `production_run_id` BIGINT COMMENT 'Identifier of the payroll processing batch or run that generated this result. Used for traceability and audit purposes.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee for whom this payroll result was calculated. Links to employee master data in Workday HCM.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total allowances paid to the employee (housing, transportation, meal allowances, etc.).',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll result was approved for payment.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number used for direct deposit payment. Stored for verification purposes only.. Valid values are `^[0-9]{4}$`',
    `base_pay_amount` DECIMAL(18,2) COMMENT 'The base salary or hourly wage earnings for the pay period before any additional earnings or deductions.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'One-time or periodic bonus payments included in this payroll result (performance bonus, retention bonus, etc.).',
    `capex_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total labor cost allocated to capital expenditure projects for this pay period. Used for financial capitalization of labor costs.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission or incentive earnings included in this payroll result.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll result (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code of the employee at the time of payroll calculation.',
    `employer_benefits_cost_amount` DECIMAL(18,2) COMMENT 'Total employer-paid benefits costs (employer contribution to health insurance, retirement matching, etc.) for this payroll result. Used for total labor cost calculation.',
    `employer_tax_amount` DECIMAL(18,2) COMMENT 'Total employer-paid payroll taxes (employer portion of Social Security, Medicare, unemployment insurance, etc.) for this payroll result. Used for CapEx/OpEx labor cost allocation.',
    `federal_tax_amount` DECIMAL(18,2) COMMENT 'Federal income tax withheld from the employees gross pay for this pay period.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishments deducted from gross pay (child support, tax levies, creditor garnishments).',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions. Sum of base pay, overtime, bonuses, commissions, allowances, and other earnings.',
    `health_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee contribution to health insurance premiums deducted from gross pay.',
    `local_tax_amount` DECIMAL(18,2) COMMENT 'Local or municipal tax withheld from the employees gross pay for this pay period.',
    `medicare_tax_amount` DECIMAL(18,2) COMMENT 'Medicare tax withheld from the employees gross pay for this pay period.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'The final take-home pay amount after all deductions. This is the amount paid to the employee.',
    `opex_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total labor cost allocated to operational expenditure for this pay period. Used for financial expense reporting.',
    `other_benefits_deduction_amount` DECIMAL(18,2) COMMENT 'Total deductions for other employee benefits (dental, vision, life insurance, disability insurance, etc.).',
    `other_deduction_amount` DECIMAL(18,2) COMMENT 'Total of all other miscellaneous deductions not categorized above (loan repayments, charitable contributions, etc.).',
    `overtime_hours_worked` DECIMAL(18,2) COMMENT 'Total overtime hours worked by the employee during the pay period.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total overtime earnings for the pay period, calculated based on hours worked beyond standard schedule.',
    `paid_time_off_hours` DECIMAL(18,2) COMMENT 'Total paid time off hours (vacation, sick leave, personal days) used during the pay period.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (weekly, biweekly, semimonthly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_group` STRING COMMENT 'The pay group to which the employee belongs, determining pay schedule and processing rules.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll result.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll result.',
    `payment_date` DATE COMMENT 'The date on which the employee will receive or received payment for this payroll result.',
    `payment_method` STRING COMMENT 'The method by which the employee receives payment (direct deposit, physical check, cash, wire transfer).. Valid values are `direct_deposit|check|cash|wire_transfer`',
    `payroll_calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll result was calculated by the payroll system.',
    `payroll_status` STRING COMMENT 'Current lifecycle status of the payroll result indicating its processing stage.. Valid values are `draft|calculated|approved|paid|voided|reversed`',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total regular hours worked by the employee during the pay period, excluding overtime.',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution to retirement savings plan (401k, pension) deducted from gross pay.',
    `shift_premium_amount` DECIMAL(18,2) COMMENT 'Additional compensation for working non-standard shifts (night shift, weekend shift) as per labor agreements.',
    `social_security_tax_amount` DECIMAL(18,2) COMMENT 'Social Security (FICA) tax withheld from the employees gross pay for this pay period.',
    `state_tax_amount` DECIMAL(18,2) COMMENT 'State income tax withheld from the employees gross pay for this pay period.',
    `total_deduction_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions (taxes, benefits, garnishments, etc.) subtracted from gross pay.',
    `total_labor_cost_amount` DECIMAL(18,2) COMMENT 'Total fully-loaded labor cost including gross pay, employer taxes, and employer benefits. Used for CapEx/OpEx allocation and financial reporting.',
    `union_dues_amount` DECIMAL(18,2) COMMENT 'Union membership dues deducted from gross pay as per collective bargaining agreement.',
    CONSTRAINT pk_payroll_result PRIMARY KEY(`payroll_result_id`)
) COMMENT 'Transactional record of payroll calculation outcomes per employee per pay period. Captures gross pay, net pay, earnings components (base, overtime, shift premium, bonus), deduction components (tax withholding, benefits, garnishments), pay period dates, payroll run identifier, and payment method. Sourced from Workday HCM Payroll. Supports labor cost allocation to cost centers and CapEx/OpEx reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan. Primary key.',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - benefit plans must be assignable to employees',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Benefit plans are offered by a specific organizational unit; adding offering_org_unit_id provides clear ownership and enables joins to org_unit for cost center and location context.',
    `aca_compliant` BOOLEAN COMMENT 'Indicates whether this health benefit plan meets ACA minimum essential coverage and minimum value standards. Required for employer mandate reporting.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan (e.g., Blue Cross Blue Shield, Aetna, Fidelity).',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier to this benefit plan. Used for claims processing and carrier communications.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to COBRA continuation coverage requirements, allowing terminated employees to continue coverage at their own expense.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered service costs the employee pays after meeting the deductible (e.g., 20% coinsurance means employee pays 20%, plan pays 80%).',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are collected (e.g., biweekly aligns with payroll cycles).. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for a covered service (e.g., $25 for a doctor visit). Applies to health and dental plans.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit amount or coverage limit provided by the plan (e.g., $500,000 life insurance coverage, $50,000 annual disability benefit). Null for unlimited coverage plans.',
    `coverage_tier` STRING COMMENT 'Level of coverage offered by the plan, determining who is covered (employee only, employee plus dependents, family coverage). Affects premium rates.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the HR system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contribution amounts (e.g., USD, EUR, GBP). Supports multinational benefit administration.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay out-of-pocket before insurance coverage begins. Applies to health, dental, and vision plans.',
    `dependent_coverage_allowed` BOOLEAN COMMENT 'Indicates whether this benefit plan allows employees to enroll eligible dependents (spouse, children, domestic partner).',
    `effective_end_date` DATE COMMENT 'Date when this benefit plan is no longer available for new enrollments or when coverage terminates. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this benefit plan becomes available for enrollment and coverage begins. Typically aligns with plan year start or new hire eligibility.',
    `eligibility_rule` STRING COMMENT 'Business rule defining which employee classes or employment types are eligible for this benefit plan (e.g., Full-time employees with 90 days of service, Salaried employees only).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee pays per pay period for this benefit plan coverage tier. Deducted from payroll pre-tax or post-tax depending on plan type.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employer pays per pay period toward this benefit plan coverage tier. Represents labor cost allocation for financial reporting.',
    `enrollment_close_date` DATE COMMENT 'Last date employees can enroll in or make changes to this benefit plan during the annual open enrollment period.',
    `enrollment_open_date` DATE COMMENT 'First date employees can enroll in or make changes to this benefit plan during the annual open enrollment period.',
    `erisa_plan_number` STRING COMMENT 'Three-digit plan number assigned to this benefit plan for ERISA Form 5500 reporting. Required for all ERISA-covered plans.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether this benefit plan complies with HIPAA privacy and security requirements for protected health information (PHI).',
    `max_dependents` STRING COMMENT 'Maximum number of dependents an employee can enroll under this benefit plan. Null if no limit applies.',
    `modified_by_user` STRING COMMENT 'User ID or name of the HR administrator who last modified this benefit plan record. Supports audit and compliance requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last updated. Tracks changes to plan configuration, rates, or terms.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum amount an employee will pay out-of-pocket for covered services in a plan year. After this limit, the plan pays 100% of covered expenses.',
    `plan_administrator_email` STRING COMMENT 'Email address for the plan administrator. Used for employee benefit inquiries and regulatory communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or entity responsible for administering the benefit plan and handling employee inquiries, claims, and appeals.',
    `plan_administrator_phone` STRING COMMENT 'Phone number for the plan administrator. Provided to employees for benefit support and claims assistance.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications. Used on enrollment forms and benefit statements.. Valid values are `^[A-Z0-9]{4,20}$`',
    `plan_document_url` STRING COMMENT 'URL or file path to the official Summary Plan Description (SPD) document required under ERISA. Provides employees with detailed plan terms and conditions.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as presented to employees (e.g., Premium Health PPO Plan, Basic Dental Coverage, Employee Stock Purchase Plan).',
    `plan_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or administrative comments about this benefit plan. Used for internal HR reference.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Active plans are available for enrollment; inactive plans are closed to new enrollments but may have existing participants.. Valid values are `active|inactive|pending|suspended|terminated`',
    `plan_type` STRING COMMENT 'Category of benefit plan offered. Determines regulatory compliance requirements and enrollment rules. [ENUM-REF-CANDIDATE: health|dental|vision|life|disability|retirement|hsa|fsa|eap|other — 10 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar year for which this benefit plan configuration is effective. Benefit plans are typically versioned annually with new rates and terms.',
    `section_125_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is eligible for pre-tax payroll deductions under an IRC Section 125 cafeteria plan.',
    `tax_treatment` STRING COMMENT 'Tax treatment of employee contributions to this benefit plan. Pre-tax contributions reduce taxable income; post-tax contributions do not.. Valid values are `pre_tax|post_tax|employer_paid|mixed`',
    `waiting_period_days` STRING COMMENT 'Number of days a new hire must wait before becoming eligible to enroll in this benefit plan. Regulatory limits apply under ACA.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Reference master of employee benefit plans offered by the manufacturing enterprise — including health, dental, vision, life, disability, 401(k)/pension, HSA/FSA, and EAP — combined with transactional enrollment records per employee per plan year. Plan definitions capture plan type, carrier/provider, coverage tiers, enrollment periods, contribution rates, and eligibility rules by employee class. Enrollment records track individual elections: coverage level selected, effective dates, dependent coverage, and life event changes. Sourced from Workday HCM Benefits. Serves as the SSOT for both benefit plan configuration and employee enrollment status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course. Primary key for the training course master catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Training management tracks internal instructors delivering courses to ensure qualification and cost allocation.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Each training course is owned by a department; linking to org_unit provides hierarchy and removes redundant owner_department string.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Ensures each training course is linked to the specific regulation it fulfills, used in compliance training matrices.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the external training vendor in the procurement system. Null for internal training.',
    `accreditation_number` STRING COMMENT 'Official accreditation or approval number issued by the regulatory body or industry association for the training course. Used for compliance audit trails.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether a formal assessment (test, exam, practical demonstration) is required to complete the course. True if assessment is mandatory; false if completion is based on attendance only.',
    `certification_awarded` BOOLEAN COMMENT 'Indicates whether successful completion of the course results in a formal certification or credential being awarded to the employee.',
    `certification_name` STRING COMMENT 'Name of the certification or credential awarded upon successful course completion. Null if no certification is awarded.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry standard that the training course addresses. Examples include ISO 45001 (occupational health and safety), OSHA (workplace safety), ISO 9001 (quality management), IEC 62443 (industrial cybersecurity), EPA (environmental), or internal compliance policies. Multiple frameworks may be listed separated by semicolons.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost per employee for delivering the training course, including instructor fees, materials, facility costs, and external vendor charges. Used for training budget planning and labor cost allocation.',
    `course_category` STRING COMMENT 'Primary classification of the training course by subject area. Safety includes ISO 45001 and OSHA training; technical covers CNC, PLC, SCADA, welding; quality includes SPC, FMEA, PPAP; leadership covers management development; compliance covers regulatory requirements; operational covers MES, ERP, and process training.. Valid values are `safety|technical|quality|leadership|compliance|operational`',
    `course_code` STRING COMMENT 'Unique alphanumeric code identifying the training course in the learning management system. Used for course catalog reference and enrollment processing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, target audience, and prerequisites.',
    `course_materials_url` STRING COMMENT 'Web address or document management system link to access course materials, handouts, presentations, and reference documents.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course. Active courses are available for enrollment; inactive courses are temporarily unavailable; draft courses are under development; retired courses are no longer offered; under review courses are being updated or audited.. Valid values are `active|inactive|draft|retired|under_review`',
    `course_title` STRING COMMENT 'Full descriptive title of the training course as displayed in the learning catalog and on certificates.',
    `course_type` STRING COMMENT 'Classification indicating whether the course is mandatory for specific roles, elective for employee development, or recommended for career progression.. Valid values are `mandatory|elective|recommended`',
    `course_version` STRING COMMENT 'Version number of the training course content. Incremented when course materials, objectives, or assessments are updated. Used for version control and compliance tracking.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was first created in the learning management system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant. Standard currency for training cost reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training course is delivered. Classroom is in-person instructor-led; e-learning is online self-paced; OJT (On-the-Job Training) is hands-on workplace training; blended combines multiple methods; virtual instructor-led is live online; self-paced is asynchronous learning.. Valid values are `classroom|e-learning|ojt|blended|virtual_instructor_led|self_paced`',
    `duration_days` DECIMAL(18,2) COMMENT 'Standard duration of the training course in business days. Used for multi-day courses and scheduling planning.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Standard duration of the training course in hours. Used for scheduling, capacity planning, and labor cost allocation.',
    `effective_end_date` DATE COMMENT 'Date when the training course is retired or no longer available for new enrollments. Null for active courses with no planned retirement date.',
    `effective_start_date` DATE COMMENT 'Date when the training course becomes available for enrollment and delivery. Used for course catalog management and scheduling.',
    `instructor_required` BOOLEAN COMMENT 'Indicates whether the course requires a qualified instructor to deliver the training. True for classroom, OJT, and virtual instructor-led courses; false for self-paced e-learning.',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the course is delivered. Used for multi-language workforce training planning.. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the training course content was last reviewed for accuracy, relevance, and compliance. Used to track course maintenance and ensure content currency.',
    `max_participants` STRING COMMENT 'Maximum number of employees that can be enrolled in a single course session. Used for capacity planning and session scheduling. Null for unlimited enrollment courses such as self-paced e-learning.',
    `min_participants` STRING COMMENT 'Minimum number of enrolled employees required to run a scheduled course session. Sessions below this threshold may be cancelled or rescheduled. Null for self-paced courses.',
    `modified_by` STRING COMMENT 'Username or employee identifier of the person who last modified the training course record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was last modified. Used for change tracking and audit trail.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the training course content. Used for course maintenance planning and compliance with ISO 9001 training program requirements.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to successfully complete the course, expressed as a percentage (0-100). Used to determine pass/fail status and certification eligibility.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this course. Null if no prerequisites exist.',
    `recurrence_interval_months` STRING COMMENT 'Number of months between required course repetitions for recurrent training. Null if recurrence is not required. Common values include 12 (annual), 24 (biennial), or 36 (triennial) for safety and compliance training.',
    `recurrence_required` BOOLEAN COMMENT 'Indicates whether the training course must be repeated periodically to maintain competence or compliance. True for courses with expiration requirements such as safety training, regulatory compliance, or equipment certifications.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory or governing body that mandates or recognizes the training. Examples include OSHA, EPA, ISO, IEC, ANSI, UL, NIST. Null for non-regulatory training.',
    `subject_matter_expert` STRING COMMENT 'Name of the subject matter expert responsible for course content accuracy and technical review. Used for course maintenance and update coordination.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the training course, including job roles, departments, or skill levels. Used for course recommendation and enrollment planning.',
    `created_by` STRING COMMENT 'Username or employee identifier of the person who created the training course record. Used for audit trail and accountability.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master catalog of training courses and learning programs combined with transactional enrollment and completion records for manufacturing employees. Course definitions include code, title, delivery method (classroom/e-learning/OJT), duration, passing criteria, mandatory/elective classification, and recurrence requirements. Enrollment records capture individual employee participation: enrollment date, scheduled session, completion date, assessment score, pass/fail status, instructor, and any linked certification earned upon completion. Covers safety training (ISO 45001, OSHA), technical skills (CNC, PLC, SCADA, welding), quality methods (SPC, FMEA, PPAP), and leadership development. Serves as the SSOT for ISO 45001 competence management and mandatory training compliance tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `employee_id` BIGINT COMMENT 'add column supervisor_employee_id (BIGINT) with FK to workforce.employee.employee_id - performance reviews require the reviewing manager',
    `primary_performance_employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed. Links to employee master data.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor conducting the performance review.',
    `calibration_date` DATE COMMENT 'Date when the performance rating was calibrated through organizational review and alignment process.',
    `calibration_status` STRING COMMENT 'Status indicating whether the performance rating has been through organizational calibration process to ensure consistency (not calibrated, pending calibration, calibrated, calibration waived).. Valid values are `not_calibrated|pending_calibration|calibrated|calibration_waived`',
    `competency_rating` STRING COMMENT 'Rating reflecting the employees demonstration of core competencies and behavioral skills (expert, proficient, developing, basic, not demonstrated).. Valid values are `expert|proficient|developing|basic|not_demonstrated`',
    `competency_score` DECIMAL(18,2) COMMENT 'Numeric score representing competency assessment, typically on a scale (e.g., 1.0 to 5.0).',
    `compliance_training_completed` BOOLEAN COMMENT 'Flag indicating whether the employee completed all required compliance training during the review period, relevant for ISO 45001 occupational health and safety compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system.',
    `department_at_review` STRING COMMENT 'Department or organizational unit of the employee at the time the review was conducted.',
    `development_plan` STRING COMMENT 'Documented plan outlining specific development actions, training, and growth opportunities for the employee going forward.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation.',
    `employee_acknowledgement_status` STRING COMMENT 'Status indicating whether the employee has acknowledged the review (pending, acknowledged, disputed).. Valid values are `pending|acknowledged|disputed`',
    `employee_rebuttal_comments` STRING COMMENT 'Optional comments provided by the employee if they disagree with or wish to provide additional context to the performance review.',
    `employee_self_assessment` STRING COMMENT 'Employees self-evaluation narrative describing their own performance, accomplishments, and development needs during the review period.',
    `goal_achievement_rating` STRING COMMENT 'Rating reflecting the employees achievement of individual goals and objectives set for the review period.. Valid values are `exceeded|achieved|partially_achieved|not_achieved`',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Numeric score representing goal achievement performance, typically on a scale (e.g., 1.0 to 5.0).',
    `job_profile_at_review` STRING COMMENT 'Job profile or position title of the employee at the time the review was conducted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last updated or modified.',
    `location_at_review` STRING COMMENT 'Work location or site of the employee at the time the review was conducted.',
    `manager_comments` STRING COMMENT 'Detailed narrative comments and feedback provided by the reviewing manager regarding employee performance, strengths, and development areas.',
    `merit_increase_eligible` BOOLEAN COMMENT 'Flag indicating whether the employee is eligible for merit-based salary increase based on this performance review outcome.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned to the employee for the review period (exceeds expectations, meets expectations, needs improvement, unsatisfactory, outstanding).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.0 to 5.0).',
    `performance_improvement_plan_required` BOOLEAN COMMENT 'Flag indicating whether a formal Performance Improvement Plan is required due to unsatisfactory performance.',
    `promotion_recommended` BOOLEAN COMMENT 'Flag indicating whether the reviewing manager recommends the employee for promotion based on performance.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized and marked as complete.',
    `review_cycle_year` STRING COMMENT 'Calendar year in which the performance review cycle occurred.',
    `review_due_date` DATE COMMENT 'Target or deadline date by which the performance review should be completed.',
    `review_language` STRING COMMENT 'Language in which the performance review was conducted and documented, using ISO 639-2 three-letter codes. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|DEU|ZHO|JPN|POR — 7 candidates stripped; promote to reference product]',
    `review_period_end_date` DATE COMMENT 'End date of the performance evaluation period being assessed.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance evaluation period being assessed.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review (draft, in progress, submitted, manager review, calibration, approved, completed, cancelled). [ENUM-REF-CANDIDATE: draft|in_progress|submitted|manager_review|calibration|approved|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `review_template_name` STRING COMMENT 'Name of the performance review template or form used for this evaluation (e.g., standard annual review, leadership review).',
    `review_type` STRING COMMENT 'Type or frequency of the performance review cycle (annual, mid-year, probationary, project-based, ad-hoc, quarterly).. Valid values are `annual|mid_year|probationary|project_based|ad_hoc|quarterly`',
    `reviewer_signature_date` DATE COMMENT 'Date when the reviewing manager signed or approved the performance review.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents or violations recorded for the employee during the review period, relevant for ISO 45001 compliance and manufacturing safety standards.',
    `second_level_reviewer_comments` STRING COMMENT 'Comments provided by the second-level reviewer regarding the performance evaluation.',
    `succession_plan_candidate` BOOLEAN COMMENT 'Flag indicating whether the employee has been identified as a candidate for succession planning based on performance and potential.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record of formal employee performance evaluations conducted on a periodic basis (annual, mid-year, probationary). Captures review period, overall rating, individual goal ratings, competency ratings, manager comments, employee self-assessment, calibration status, and review completion date. Sourced from Workday HCM Performance. Feeds merit increase decisions and talent development planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the job requisition record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will bear the labor cost for this position.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created the requisition record.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile defining role responsibilities, qualifications, and competencies.',
    `location_id` BIGINT COMMENT 'Reference to the work location or facility where the position will be based.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or business unit for this position.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position this requisition is intended to fill.',
    `primary_requisition_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved the requisition for opening.',
    `requisition_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified the requisition record.',
    `tertiary_requisition_recruiter_employee_id` BIGINT COMMENT 'Reference to the HR recruiter assigned to manage the candidate pipeline for this requisition.',
    `applicant_count` STRING COMMENT 'Total number of candidates who have applied to this requisition.',
    `approval_status` STRING COMMENT 'Status of the requisition approval workflow indicating whether it has been authorized for recruiting.. Valid values are `pending|approved|rejected|withdrawn`',
    `approved_date` DATE COMMENT 'Date when the requisition was approved by the authorizing manager or HR.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check is mandatory for candidates selected for this position.',
    `closed_date` DATE COMMENT 'Date when the requisition was closed, either due to being filled or cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary and compensation amounts.. Valid values are `^[A-Z]{3}$`',
    `employment_type` STRING COMMENT 'Type of employment arrangement for the position being filled.. Valid values are `full_time|part_time|contract|temporary|intern|seasonal`',
    `internal_posting_only` BOOLEAN COMMENT 'Indicates whether the requisition is restricted to internal candidates only.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the requisition is currently active and accepting applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was last updated.',
    `number_of_openings` STRING COMMENT 'Total number of positions to be filled under this requisition.',
    `opened_date` DATE COMMENT 'Date when the requisition was officially opened and approved for recruiting.',
    `positions_filled` STRING COMMENT 'Number of positions that have been successfully filled under this requisition.',
    `posting_description` STRING COMMENT 'Detailed description of the role, responsibilities, and qualifications for external job postings.',
    `posting_end_date` DATE COMMENT 'Date when the job posting is scheduled to be removed from public visibility.',
    `posting_start_date` DATE COMMENT 'Date when the job posting becomes publicly visible on job boards and career sites.',
    `posting_title` STRING COMMENT 'Public-facing job title used in external job postings and advertisements.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency of filling the position.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'Business justification or reason for opening this requisition, such as growth, attrition, or reorganization.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements.',
    `requisition_number` STRING COMMENT 'Business identifier for the requisition, externally visible and used for tracking and communication.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition indicating its progress through the recruiting workflow.. Valid values are `open|in_progress|on_hold|filled|cancelled|closed`',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it is for a new position, replacement, or other hiring scenario.. Valid values are `new_position|replacement|backfill|temporary|contract|intern`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly rate for the position in local currency.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly rate for the position in local currency.',
    `screening_required` BOOLEAN COMMENT 'Indicates whether formal candidate screening or assessment is required for this requisition.',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether the position requires a security clearance or special authorization.',
    `shift_type` STRING COMMENT 'Type of work shift schedule for the position.. Valid values are `day|evening|night|rotating|flexible`',
    `sourcing_channel` STRING COMMENT 'Primary channel or method used to source candidates for this requisition. [ENUM-REF-CANDIDATE: internal|external|referral|agency|campus|job_board|social_media — 7 candidates stripped; promote to reference product]',
    `target_start_date` DATE COMMENT 'Desired date for the selected candidate to begin employment.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition opening to position being filled, used for recruiting KPI tracking.',
    `travel_percentage` STRING COMMENT 'Expected percentage of time the position requires business travel.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Transactional record of approved requests to fill positions through internal transfer or external hiring. Captures requisition number, linked position, job profile, target start date, hiring manager, recruiter assignment, requisition status (open/in-progress/on-hold/filled/cancelled), sourcing channel, and time-to-fill metrics. Includes candidate pipeline tracking: applicant records with source, pipeline stage (applied/screened/interviewed/offered/hired/rejected), assessment results, background check status, and offer details. Sourced from Workday HCM Recruiting. Serves as the SSOT for the full recruiting lifecycle from requisition opening through candidate hire.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` (
    `labor_agreement_id` BIGINT COMMENT 'Primary key for labor_agreement',
    `employee_id` BIGINT COMMENT 'add column employee_id (BIGINT) with FK to workforce.employee.employee_id - labor agreements govern employee terms and must link to affected employees',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Labor agreements are tied to a specific org unit; linking provides context and removes redundant business_unit string.',
    `agreement_document_url` STRING COMMENT 'URL or file path to the full legal text of the labor agreement. Links to document management system or shared repository.. Valid values are `^https?://.*`',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the labor agreement. Typically includes union name and location or business unit covered.',
    `agreement_notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or context about the agreement not captured in structured fields.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier for the collective bargaining agreement or labor contract. Used for reference in HR systems, union communications, and legal documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the labor agreement. Indicates whether the agreement is in draft, pending ratification, active, expired, or under renegotiation. [ENUM-REF-CANDIDATE: draft|pending_ratification|active|expired|terminated|suspended|under_negotiation — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the labor agreement. Distinguishes between collective bargaining agreements (CBAs), individual contracts, memoranda of understanding, and other labor relations instruments.. Valid values are `collective_bargaining_agreement|union_contract|individual_labor_agreement|memorandum_of_understanding|side_letter|extension_agreement`',
    `annual_wage_increase_percentage` DECIMAL(18,2) COMMENT 'Negotiated annual percentage increase in base wages. May be fixed or tied to cost-of-living adjustments (COLA).',
    `arbitration_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes binding arbitration as the final step in the grievance process.',
    `bargaining_unit_code` STRING COMMENT 'Code identifying the bargaining unit or employee group covered by this agreement. Used for payroll, benefits administration, and labor cost allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `base_wage_scale_reference` STRING COMMENT 'Reference to the wage scale or pay table defined in the agreement. Links to detailed wage schedules by job classification and seniority.',
    `cola_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a cost-of-living adjustment provision that ties wage increases to inflation indices.',
    `covered_employee_group` STRING COMMENT 'Description of the employee population covered by this agreement. May reference job families, locations, business units, or other grouping criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor agreement record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when the labor agreement expires or terminates. Null for open-ended agreements or those without a defined end date.',
    `effective_start_date` DATE COMMENT 'Date when the labor agreement becomes binding and enforceable. Marks the beginning of the agreement term.',
    `grievance_procedure_summary` STRING COMMENT 'Summary of the multi-step grievance and arbitration process defined in the agreement for resolving disputes between management and union.',
    `health_benefits_summary` STRING COMMENT 'Summary of health insurance, medical, dental, and vision benefits provided under the agreement, including employer contribution levels.',
    `job_security_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes job security provisions such as no-layoff guarantees, advance notice requirements, or severance terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor agreement record was last updated. Supports change tracking and audit compliance.',
    `lead_negotiator_name` STRING COMMENT 'Name of the primary management representative who led negotiations for this agreement. Used for accountability and historical reference.',
    `management_rights_clause` STRING COMMENT 'Text or summary of the management rights clause, which reserves certain decision-making authority to the employer outside the scope of collective bargaining.',
    `negotiation_completion_date` DATE COMMENT 'Date when negotiations concluded and a tentative agreement was reached, prior to ratification.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations for this agreement began. Used for tracking negotiation timelines and labor relations history.',
    `no_strike_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a no-strike provision prohibiting work stoppages during the term of the contract.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base wage for overtime hours. Common values include 1.5 for time-and-a-half and 2.0 for double-time.',
    `paid_holidays_count` STRING COMMENT 'Number of paid holidays per year guaranteed under the agreement. Supports benefits administration and labor cost planning.',
    `pension_plan_reference` STRING COMMENT 'Reference to the pension or retirement plan covered by this agreement. May link to defined benefit or defined contribution plan documents.',
    `plant_location_code` STRING COMMENT 'Code identifying the manufacturing plant or facility where this agreement applies. Supports multi-site labor relations management.. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `ratification_approval_percentage` DECIMAL(18,2) COMMENT 'Percentage of votes in favor of ratifying the agreement. Expressed as a decimal (e.g., 87.50 for 87.5%).',
    `ratification_date` DATE COMMENT 'Date when the agreement was formally ratified by union membership vote or other approval process. Critical for legal enforceability.',
    `ratification_vote_count` STRING COMMENT 'Total number of votes cast in the ratification vote. Used for transparency and compliance documentation.',
    `reopener_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a reopener clause allowing renegotiation of specific terms (e.g., wages) before the contract expiration date.',
    `safety_provisions_summary` STRING COMMENT 'Summary of occupational health and safety provisions, including personal protective equipment (PPE) requirements, safety committee structure, and hazard reporting procedures.',
    `seniority_rule_description` STRING COMMENT 'Description of seniority provisions governing layoffs, recalls, promotions, shift bidding, and vacation scheduling as defined in the agreement.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional compensation per hour for non-standard shifts (e.g., night shift, weekend shift) as defined in the agreement.',
    `subcontracting_restrictions` STRING COMMENT 'Description of any restrictions on the employers ability to subcontract work covered by the bargaining unit, protecting union jobs.',
    `successor_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a successor clause requiring a new owner to honor the existing labor agreement in the event of a business sale or merger.',
    `union_dues_deduction_flag` BOOLEAN COMMENT 'Indicates whether the employer is required to deduct union dues from employee paychecks and remit them to the union (checkoff provision).',
    `union_local_number` STRING COMMENT 'Local chapter or branch number of the union. Used to identify the specific union local that negotiated and is covered by this agreement.',
    `union_name` STRING COMMENT 'Name of the labor union or bargaining unit that is party to this agreement. Null for individual labor agreements not involving a union.',
    `union_security_clause_type` STRING COMMENT 'Type of union security provision in the agreement. Defines whether union membership or dues payment is required as a condition of employment.. Valid values are `union_shop|agency_shop|open_shop|closed_shop|maintenance_of_membership`',
    `vacation_accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which vacation time accrues per pay period or year of service, as defined in the agreement. Expressed in hours per year or similar unit.',
    CONSTRAINT pk_labor_agreement PRIMARY KEY(`labor_agreement_id`)
) COMMENT 'Master record of collective bargaining agreements (CBAs), union contracts, and individual labor agreements governing employment terms for specific worker groups in manufacturing plants. Captures agreement name, union/bargaining unit, covered employee group, effective date range, key terms (wage scales, overtime rules, seniority provisions, grievance procedures), and ratification status. Distinct from procurement contracts — this is the HR-owned labor relations record.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `previous_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (previous_payroll_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for payroll amounts in this period.',
    `payroll_period_description` STRING COMMENT 'Additional free‑text description of the payroll period.',
    `duration_days` STRING COMMENT 'Number of days in the payroll period.',
    `end_date` DATE COMMENT 'Last calendar date covered by the payroll period.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) for the payroll period.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the payroll period belongs.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this period is the active payroll period.',
    `lock_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period was locked for changes.',
    `payroll_cycle_number` STRING COMMENT 'Ordinal number of the payroll cycle within the year (e.g., 1 for first weekly cycle).',
    `payroll_frequency` STRING COMMENT 'Frequency at which payroll is processed for this period.',
    `period_code` STRING COMMENT 'External code representing the payroll period, typically in YYYYMM format.',
    `period_name` STRING COMMENT 'Human‑readable name for the payroll period (e.g., "January 2024 Payroll").',
    `period_sequence` STRING COMMENT 'Sequential number of the period within the fiscal year.',
    `period_type` STRING COMMENT 'Category of the payroll period indicating its purpose.',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when payroll calculations were completed for the period.',
    `start_date` DATE COMMENT 'First calendar date covered by the payroll period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll period record.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` (
    `shift_pattern_id` BIGINT COMMENT 'Primary key for shift_pattern',
    `production_plant_id` BIGINT COMMENT 'add column plant_id (BIGINT) with FK to production.plant.plant_id - shift patterns are defined per plant location',
    `rotation_shift_pattern_id` BIGINT COMMENT 'Self-referencing FK on shift_pattern (rotation_shift_pattern_id)',
    `break_duration_minutes` STRING COMMENT 'Total allotted break time within the shift, expressed in minutes.',
    `shift_pattern_code` STRING COMMENT 'Business identifier code for the shift pattern, used in scheduling and reporting.',
    `compliance_iso45001` BOOLEAN COMMENT 'Indicates whether the shift pattern complies with ISO 45001 occupational health and safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift pattern record was first created in the system.',
    `shift_pattern_description` STRING COMMENT 'Free‑form description providing details about the shift pattern.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total length of the shift pattern expressed in hours.',
    `effective_from` DATE COMMENT 'Date when the shift pattern becomes valid for scheduling.',
    `effective_until` DATE COMMENT 'Date when the shift pattern expires; null if open‑ended.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this pattern is the default for new employees or locations.',
    `labor_category` STRING COMMENT 'Category of labor to which the shift pattern applies.',
    `max_consecutive_days` STRING COMMENT 'Maximum number of days an employee may work consecutively under this pattern.',
    `min_rest_hours` DECIMAL(18,2) COMMENT 'Minimum required rest period between the end of one shift and the start of the next, expressed in hours.',
    `shift_pattern_name` STRING COMMENT 'Human‑readable name of the shift pattern.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks about the shift pattern.',
    `overtime_allowed` BOOLEAN COMMENT 'Indicates if overtime work is permitted under this shift pattern.',
    `pattern_type` STRING COMMENT 'Classification of the shift pattern based on its scheduling logic.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift within a day (24‑hour format).',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift within a day (24‑hour format).',
    `shift_pattern_status` STRING COMMENT 'Current lifecycle status of the shift pattern.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift pattern record.',
    CONSTRAINT pk_shift_pattern PRIMARY KEY(`shift_pattern_id`)
) COMMENT 'Master reference table for shift_pattern. Referenced by shift_pattern_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` (
    `certification_type_id` BIGINT COMMENT 'Primary key for certification_type',
    `parent_certification_type_id` BIGINT COMMENT 'Self-referencing FK on certification_type (parent_certification_type_id)',
    `applicable_job_roles` STRING COMMENT 'Comma‑separated list of job role identifiers to which the certification applies.',
    `certification_type_category` STRING COMMENT 'Broad classification of the certification (e.g., safety, quality, environmental, skill, regulatory).',
    `certification_type_code` STRING COMMENT 'Short alphanumeric code used to reference the certification type in systems and reports.',
    `compliance_requirements` STRING COMMENT 'Text describing regulatory or internal compliance obligations tied to the certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification type record was first created in the system.',
    `certification_type_description` STRING COMMENT 'Detailed description of the certification purpose, scope, and applicability.',
    `effective_date` DATE COMMENT 'Date on which the certification type becomes effective for use.',
    `expiry_date` DATE COMMENT 'Optional date after which the certification type is no longer valid for new assignments.',
    `external_reference_code` STRING COMMENT 'Identifier used in external systems (e.g., ISO catalog) to reference the certification.',
    `is_mandatory` BOOLEAN COMMENT 'Flag indicating whether the certification is mandatory for the associated job roles.',
    `issuing_body` STRING COMMENT 'Organization or authority that issues and governs the certification.',
    `last_review_date` DATE COMMENT 'Date when the certification type definition was last reviewed for relevance or updates.',
    `certification_type_name` STRING COMMENT 'Human‑readable name of the certification type (e.g., "ISO 45001 Safety Certification").',
    `renewal_period_months` STRING COMMENT 'Number of months between required renewals when renewal_required is true.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification must be renewed periodically.',
    `certification_type_status` STRING COMMENT 'Current lifecycle status of the certification type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification type record.',
    `validity_period_months` STRING COMMENT 'Number of months the certification remains valid from the effective date.',
    `version_number` STRING COMMENT 'Sequential version number for changes to the certification type definition.',
    CONSTRAINT pk_certification_type PRIMARY KEY(`certification_type_id`)
) COMMENT 'Master reference table for certification_type. Referenced by type_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_assignment_org_unit_id` FOREIGN KEY (`assignment_org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ADD CONSTRAINT `fk_workforce_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_certification_type_id` FOREIGN KEY (`certification_type_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`certification_type`(`certification_type_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_tertiary_time_modified_by_employee_id` FOREIGN KEY (`tertiary_time_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_tertiary_absence_replacement_employee_id` FOREIGN KEY (`tertiary_absence_replacement_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_primary_requisition_approved_by_employee_id` FOREIGN KEY (`primary_requisition_approved_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_last_modified_by_employee_id` FOREIGN KEY (`requisition_last_modified_by_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_tertiary_requisition_recruiter_employee_id` FOREIGN KEY (`tertiary_requisition_recruiter_employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_previous_payroll_period_id` FOREIGN KEY (`previous_payroll_period_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ADD CONSTRAINT `fk_workforce_shift_pattern_rotation_shift_pattern_id` FOREIGN KEY (`rotation_shift_pattern_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ADD CONSTRAINT `fk_workforce_certification_type_parent_certification_type_id` FOREIGN KEY (`parent_certification_type_id`) REFERENCES `vibe_manufacturing_v1`.`workforce`.`certification_type`(`certification_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated|retired');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Pay Rate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `safety_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending|not_required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|master');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `training_hours_ytd` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Year-to-Date (YTD)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `work_location_name` SET TAGS ('dbx_business_glossary_term' = 'Work Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`employee` ALTER COLUMN `work_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `business_function` SET TAGS ('dbx_business_glossary_term' = 'Business Function');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `capacity_utilization_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `environmental_certification_iso14001` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External System ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Headcount Actual');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Headcount Planned');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `is_production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'corporate|division|business_unit|plant|department|work_center');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `quality_certification_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `safety_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|flexible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`org_unit` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `base_pay_type` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `base_pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|piece_rate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `occupational_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Occupational Classification Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `occupational_classification_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `proficiency_level_required` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `proficiency_level_required` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `safety_sensitive_position` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Position');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `shift_premium_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Premium Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `soft_skills_required` SET TAGS ('dbx_business_glossary_term' = 'Soft Skills Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `succession_planning_critical` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Critical');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `technical_skills_required` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`job_profile` ALTER COLUMN `years_experience_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Position Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `employment_category` SET TAGS ('dbx_value_regex' = 'full_time|part_time|casual|on_call');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exempt Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Position Justification');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `last_filled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Filled Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Position Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'filled|vacant|frozen|pending_approval|closed|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|contract|seasonal|intern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `replacement_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Position Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `requires_certification` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|night|rotating|fixed|flexible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `vacancy_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`position` ALTER COLUMN `work_schedule_hours` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Hours per Week');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|acting|secondment|contract|intern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `cost_center_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Split Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|casual|seasonal');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|biweekly|monthly|annual');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `scheduled_weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Weekly Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `shift_premium_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Premium Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `work_shift_code` SET TAGS ('dbx_business_glossary_term' = 'Work Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created By');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Certification ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_type_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Type ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_value_regex' = 'safety|quality|technical|regulatory|professional|operational');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `equipment_authorization` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `examination_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `examination_score` SET TAGS ('dbx_business_glossary_term' = 'Examination Score');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `examination_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `job_role_applicability` SET TAGS ('dbx_business_glossary_term' = 'Job Role Applicability');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `work_location_restriction` SET TAGS ('dbx_business_glossary_term' = 'Work Location Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|in_progress');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `confirmed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Shift Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_night_shift` SET TAGS ('dbx_business_glossary_term' = 'Is Night Shift Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Shift Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_weekend` SET TAGS ('dbx_business_glossary_term' = 'Is Weekend Shift Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Modified Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `net_productive_hours` SET TAGS ('dbx_business_glossary_term' = 'Net Productive Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `published_datetime` SET TAGS ('dbx_business_glossary_term' = 'Published Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Exception Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_month` SET TAGS ('dbx_business_glossary_term' = 'Schedule Month Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^SCH-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|confirmed|cancelled|completed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_week` SET TAGS ('dbx_business_glossary_term' = 'Schedule Week Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_year` SET TAGS ('dbx_business_glossary_term' = 'Schedule Year');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduling_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Horizon in Weeks');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_priority` SET TAGS ('dbx_business_glossary_term' = 'Shift Priority');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|standby|training|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `skill_requirement` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|draft');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{0,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|double_time|holiday|on_call|standby');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `oee_productive_time` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Productive Time Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{0,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Premium Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_premium_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Premium Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'shop_floor_terminal|mobile_app|web_portal|supervisor_entry|import|biometric');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `absence_notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `accrual_balance_deducted` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance Deducted (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED|CANCELLED|WITHDRAWN');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `is_fmla_protected` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Protected Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Absence Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Paid Absence Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Request Submission Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Certification Received Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payroll_result_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Result ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `production_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `capex_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employer_benefits_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Benefits Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employer_benefits_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `employer_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `federal_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `federal_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `opex_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Operational Expenditure (OpEx) Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `other_benefits_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Benefits Deduction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `other_benefits_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `other_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deduction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `other_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `overtime_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `paid_time_off_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `pay_group` SET TAGS ('dbx_business_glossary_term' = 'Pay Group');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|wire_transfer');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payroll_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calculation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|voided|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `shift_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Premium Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `shift_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `state_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `state_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `total_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deduction Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `total_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `total_labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `total_labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_result` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Compliant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_rule` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_close_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_open_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Open Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Retirement Income Security Act (ERISA) Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `max_dependents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Number of Dependents');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `section_125_eligible` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 125 Cafeteria Plan Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Classification');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|employer_paid|mixed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_value_regex' = 'safety|technical|quality|leadership|compliance|operational');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_materials_url` SET TAGS ('dbx_business_glossary_term' = 'Course Materials URL');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'mandatory|elective|recommended');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|e-learning|ojt|blended|virtual_instructor_led|self_paced');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `instructor_required` SET TAGS ('dbx_business_glossary_term' = 'Instructor Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `min_participants` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participants');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `recurrence_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval Months');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `recurrence_required` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `subject_matter_expert` SET TAGS ('dbx_business_glossary_term' = 'Subject Matter Expert (SME)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`training_course` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|pending_calibration|calibrated|calibration_waived');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'expert|proficient|developing|basic|not_demonstrated');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Score');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `compliance_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `department_at_review` SET TAGS ('dbx_business_glossary_term' = 'Department at Review');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan` SET TAGS ('dbx_business_glossary_term' = 'Development Plan');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|disputed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_rebuttal_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Rebuttal Comments');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_value_regex' = 'exceeded|achieved|partially_achieved|not_achieved');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `job_profile_at_review` SET TAGS ('dbx_business_glossary_term' = 'Job Profile at Review');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `location_at_review` SET TAGS ('dbx_business_glossary_term' = 'Location at Review');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_language` SET TAGS ('dbx_business_glossary_term' = 'Review Language');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_template_name` SET TAGS ('dbx_business_glossary_term' = 'Review Template Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|ad_hoc|quarterly');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Signature Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `second_level_reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Second Level Reviewer Comments');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_plan_candidate` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Candidate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `primary_requisition_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `applicant_count` SET TAGS ('dbx_business_glossary_term' = 'Applicant Count');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern|seasonal');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `internal_posting_only` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Only');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Opened Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `positions_filled` SET TAGS ('dbx_business_glossary_term' = 'Positions Filled');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `posting_description` SET TAGS ('dbx_business_glossary_term' = 'Posting Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `posting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Posting End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `posting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `posting_title` SET TAGS ('dbx_business_glossary_term' = 'Posting Title');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Requisition Reason');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|on_hold|filled|cancelled|closed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|backfill|temporary|contract|intern');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `screening_required` SET TAGS ('dbx_business_glossary_term' = 'Screening Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`requisition` ALTER COLUMN `travel_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `labor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Agreement Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_document_url` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'collective_bargaining_agreement|union_contract|individual_labor_agreement|memorandum_of_understanding|side_letter|extension_agreement');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `annual_wage_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Annual Wage Increase Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `annual_wage_increase_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `annual_wage_increase_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `arbitration_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `bargaining_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `bargaining_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_scale_reference` SET TAGS ('dbx_business_glossary_term' = 'Base Wage Scale Reference');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_scale_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_scale_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `cola_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost of Living Adjustment (COLA) Provision Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `covered_employee_group` SET TAGS ('dbx_business_glossary_term' = 'Covered Employee Group');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `grievance_procedure_summary` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure Summary');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Summary');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `job_security_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Job Security Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `lead_negotiator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Negotiator Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `management_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Management Rights Clause');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `negotiation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `no_strike_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Strike Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Multiplier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `paid_holidays_count` SET TAGS ('dbx_business_glossary_term' = 'Paid Holidays Count');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `pension_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Pension Plan Reference');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `plant_location_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `plant_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_approval_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ratification Approval Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Ratification Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Ratification Vote Count');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `reopener_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Reopener Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `safety_provisions_summary` SET TAGS ('dbx_business_glossary_term' = 'Safety Provisions Summary');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `seniority_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Seniority Rule Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `subcontracting_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Restrictions');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `successor_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Successor Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_dues_deduction_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction Flag');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_security_clause_type` SET TAGS ('dbx_business_glossary_term' = 'Union Security Clause Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_security_clause_type` SET TAGS ('dbx_value_regex' = 'union_shop|agency_shop|open_shop|closed_shop|maintenance_of_membership');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`labor_agreement` ALTER COLUMN `vacation_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacation Accrual Rate');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `previous_payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Payroll Period Id');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `previous_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lock Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Cycle Number');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_sequence` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`payroll_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotation_shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Rotation Shift Pattern Id');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotation_shift_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `compliance_iso45001` SET TAGS ('dbx_business_glossary_term' = 'Compliance Iso45001');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `max_consecutive_days` SET TAGS ('dbx_business_glossary_term' = 'Max Consecutive Days');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `min_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Min Rest Hours');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Pattern Type');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`shift_pattern` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Type Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `parent_certification_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Certification Type Id');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `parent_certification_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `applicable_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Roles');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `renewal_period_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Period Months');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `certification_type_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `vibe_manufacturing_v1`.`workforce`.`certification_type` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
