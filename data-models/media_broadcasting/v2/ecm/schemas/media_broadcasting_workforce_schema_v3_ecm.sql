-- Schema for Domain: workforce | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`workforce` COMMENT 'Manages internal employee records, organizational structure, departments, roles, training, and HR operations for Media Broadcasting staff — distinct from external talent managed in the talent domain';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity. This is the system-generated surrogate key used across all internal systems to reference this employee.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee record of this employees direct manager. Used for organizational hierarchy, reporting relationships, and approval workflows. Null for CEO or top-level executives.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department where the employee is assigned. Used for organizational reporting, budget allocation, and workforce planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for audit trails, data lineage, and record lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `date_of_birth` DATE COMMENT 'Employees date of birth. Used for age verification, benefits eligibility, retirement planning, and compliance with labor laws. Format: yyyy-MM-dd.',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to be contacted in case of employee emergency. Critical for workplace safety and incident response.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact. Primary method for reaching emergency contact in case of workplace incident or employee emergency.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend). Provides context for emergency communications.',
    `employee_number` STRING COMMENT 'Business-assigned unique employee number used for HR operations, payroll, and external reporting. Format: two-letter prefix followed by six digits (e.g., MB123456).. Valid values are `^[A-Z]{2}[0-9]{6}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employees relationship with Media Broadcasting. Active indicates currently working; other statuses indicate various non-working states.. Valid values are `Active|On Leave|Suspended|Terminated|Retired|Deceased`',
    `employment_type` STRING COMMENT 'Classification of the employees employment arrangement. Determines benefits eligibility, work schedule expectations, and contract terms.. Valid values are `Full-Time|Part-Time|Fixed-Term|Seasonal|Intern|Contractor`',
    `gender` STRING COMMENT 'Employees self-identified gender. Used for diversity reporting, benefits administration, and compliance with equal employment opportunity regulations.. Valid values are `Male|Female|Non-Binary|Prefer Not to Disclose|Other`',
    `hire_date` DATE COMMENT 'Date the employee officially started employment with Media Broadcasting. Used for seniority calculations, benefits eligibility, anniversary recognition, and tenure reporting. Format: yyyy-MM-dd.',
    `home_address_line1` STRING COMMENT 'First line of the employees residential address (street number and name). Used for payroll tax calculations, benefits administration, and emergency contact.',
    `home_address_line2` STRING COMMENT 'Second line of the employees residential address (apartment, suite, unit number). Optional field. Used for accurate mail delivery and address verification.',
    `home_city` STRING COMMENT 'City or municipality of the employees residential address. Used for payroll tax calculations, benefits administration, and geographic workforce analytics.',
    `home_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the employees residential address (e.g., USA, GBR, CAN). Used for international payroll, tax compliance, and global workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `home_postal_code` STRING COMMENT 'Postal code or ZIP code of the employees residential address. Used for payroll tax calculations, benefits administration, and mail delivery.',
    `home_state_province` STRING COMMENT 'State, province, or region of the employees residential address. Used for payroll tax withholding, benefits eligibility, and regional workforce reporting.',
    `hr_system_code` STRING COMMENT 'Unique identifier for this employee in the source HR system (SAP S/4HANA HR). Used for system integration, data reconciliation, and cross-system reference.',
    `job_level` STRING COMMENT 'Hierarchical level of the employees position within the organization. Used for compensation benchmarking, career pathing, and organizational structure analysis. [ENUM-REF-CANDIDATE: Entry|Associate|Mid|Senior|Lead|Manager|Director|VP|SVP|C-Level — 10 candidates stripped; promote to reference product]',
    `job_title` STRING COMMENT 'Official job title assigned to the employee. Reflects the employees role, level, and function within the organization. Used for organizational charts, job postings, and career progression tracking.',
    `legal_first_name` STRING COMMENT 'Employees legal first name as it appears on government-issued identification documents. Used for payroll, tax reporting, and official HR records.',
    `legal_last_name` STRING COMMENT 'Employees legal last name (surname/family name) as it appears on government-issued identification documents. Used for payroll, tax reporting, and official HR records.',
    `legal_middle_name` STRING COMMENT 'Employees legal middle name or initial as it appears on government-issued identification documents. May be null if not applicable.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll, and legal compliance. Format varies by jurisdiction.',
    `nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the employees citizenship or nationality. Used for work authorization verification, international assignment eligibility, and diversity reporting.. Valid values are `^[A-Z]{3}$`',
    `personal_email` STRING COMMENT 'Employees personal email address. Used for emergency communications, benefits notifications, and post-employment correspondence. Must be kept current.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `personal_phone` STRING COMMENT 'Employees personal mobile or home phone number. Used for emergency contact, urgent work communications, and HR notifications.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day work interactions. May differ from legal name. Used in email signatures, internal directories, and workplace communications.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for final payroll processing, benefits termination, and workforce analytics. Format: yyyy-MM-dd.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis, exit interview tracking, and workforce planning. Null for active employees.. Valid values are `Voluntary Resignation|Involuntary Termination|Retirement|End of Contract|Layoff|Mutual Agreement`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for audit trails, change tracking, and data synchronization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `work_authorization_expiry_date` DATE COMMENT 'Date when the employees work authorization (visa, permit) expires. Null for citizens and permanent residents. Used for compliance tracking and renewal planning. Format: yyyy-MM-dd.',
    `work_authorization_status` STRING COMMENT 'Current status of the employees legal authorization to work in the country where they are employed. Critical for compliance with immigration and labor laws.. Valid values are `Citizen|Permanent Resident|Work Visa|Pending Authorization|Not Authorized`',
    `work_email` STRING COMMENT 'Corporate email address assigned to the employee for business communications. Primary contact method for internal and external work-related correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@mediabroadcasting.(com|net|org)$`',
    `work_phone` STRING COMMENT 'Corporate phone number assigned to the employee. May be desk phone, mobile, or extension. Used for business communications and internal directory.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master identity record for every internal employee at Media Broadcasting — full-time, part-time, and fixed-term staff. Captures legal name, employee number, national ID, date of birth, gender, employment type, hire date, termination date, employment status, work location, home address, personal email, work email, work phone, emergency contact, nationality, visa/work authorization status, and HR system identifier. This is the SSOT for internal workforce identity — distinct from the talent domain which manages on-screen/off-screen creative talent under contract.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key for the org_unit product.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables traversal of the organizational tree structure from child to parent. Null for top-level units.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who serves as the head or manager of this organizational unit, responsible for its operations and performance.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit for expense management and financial planning.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount, supporting multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `business_area` STRING COMMENT 'High-level business function or operational domain that this organizational unit supports within the media broadcasting enterprise. [ENUM-REF-CANDIDATE: broadcast_operations|content_production|digital_platforms|advertising_sales|news|sports|engineering|technology|corporate_services|finance|human_resources — 11 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'Legal entity or company code in the financial system to which this organizational unit belongs for statutory reporting and consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `contact_email` STRING COMMENT 'Primary email address for contacting this organizational unit for business inquiries, escalations, or administrative matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting this organizational unit for business or operational purposes.',
    `cost_center_code` STRING COMMENT 'Financial cost center identifier associated with this organizational unit for expense tracking, budget allocation, and financial reporting in the general ledger.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations within the media broadcasting enterprise.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased or will cease operations. Null for currently active units with no planned closure.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become operational and active within the enterprise structure.',
    `functional_area` STRING COMMENT 'Specific functional specialization or operational focus of the organizational unit, providing granular classification beyond business area.',
    `head_count_actual` STRING COMMENT 'Current actual number of employees assigned to this organizational unit, used for variance analysis against budget.',
    `head_count_budget` STRING COMMENT 'Approved budgeted number of full-time equivalent employees allocated to this organizational unit for workforce planning and cost management.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit in the enterprise hierarchy tree, with 1 representing top-level divisions and increasing numbers for deeper nesting.',
    `hierarchy_path` STRING COMMENT 'Materialized path representation of the organizational units position in the hierarchy, typically a delimited string of ancestor unit codes for efficient tree traversal.',
    `is_broadcast_operations` BOOLEAN COMMENT 'Flag indicating whether this organizational unit is directly involved in broadcast playout, transmission, or on-air operations.',
    `is_content_production` BOOLEAN COMMENT 'Flag indicating whether this organizational unit is engaged in content creation, production, or post-production activities.',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether this organizational unit directly generates revenue through advertising sales, subscription services, or content licensing.',
    `legal_entity_name` STRING COMMENT 'Name of the legal entity or subsidiary under which this organizational unit operates for regulatory and compliance purposes.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this organizational unit record, supporting audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified or updated.',
    `operating_hours` STRING COMMENT 'Standard operating hours or shift pattern for this organizational unit, relevant for broadcast operations, production schedules, and workforce planning.',
    `operational_status` STRING COMMENT 'Current operational state of the organizational unit indicating whether it is actively functioning, temporarily suspended, planned for future activation, or permanently closed.. Valid values are `active|inactive|planned|suspended|closed`',
    `profit_center_code` STRING COMMENT 'Profit center identifier for units that are managed as revenue-generating or P&L-responsible entities within the enterprise.. Valid values are `^[A-Z0-9]{4,10}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the primary operating location of this organizational unit, used for scheduling and time-sensitive operations.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `union_affiliation` STRING COMMENT 'Name of labor union or collective bargaining unit that represents employees in this organizational unit, if applicable.',
    `unit_code` STRING COMMENT 'Business identifier code for the organizational unit used in financial systems, reporting, and internal references. Typically alphanumeric and unique across the enterprise.. Valid values are `^[A-Z0-9]{2,12}$`',
    `unit_name` STRING COMMENT 'Full official name of the organizational unit as used in corporate communications, org charts, and HR systems.',
    `unit_short_name` STRING COMMENT 'Abbreviated or short name of the organizational unit for display in constrained UI contexts, reports, and dashboards.',
    `unit_type` STRING COMMENT 'Classification of the organizational unit indicating its hierarchical level and functional role within the enterprise structure.. Valid values are `division|department|sub_department|team|cost_center|functional_group`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master record for every organizational unit within Media Broadcasting — divisions, departments, sub-departments, cost centers, and functional teams. Captures unit code, unit name, unit type (division/department/team), parent unit reference for hierarchy traversal, effective date, head count budget, physical location, and operational status. Supports org chart rendering, headcount reporting, and cost allocation across broadcast operations, production, technology, and corporate functions.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key for the job profile reference catalog.',
    `org_unit_id` BIGINT COMMENT 'Foreign key reference to the primary department or organizational unit where this job profile is typically assigned. Used for organizational structure reporting and headcount planning.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `primary_reports_to_job_profile_id` BIGINT COMMENT 'Foreign key reference to the job profile of the direct supervisor or manager for this role. Establishes reporting hierarchy and organizational structure.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for annual performance bonuses or incentive compensation. Used for total rewards planning and compensation design.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the system. Used for audit trail and data lineage.',
    `eeo_job_category` STRING COMMENT 'Standard EEO-1 job category used for federal equal employment opportunity reporting to the EEOC. Required for compliance with Title VII of the Civil Rights Act. [ENUM-REF-CANDIDATE: executive_senior_level_officials_and_managers|first_mid_level_officials_and_managers|professionals|technicians|sales_workers|administrative_support_workers|craft_workers|operatives|laborers_and_helpers|service_workers — 10 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this job profile version was superseded or retired. Null for currently active profiles. Supports temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this job profile version became effective and available for use in hiring, workforce planning, and HR operations.',
    `equity_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for equity compensation such as stock options, restricted stock units (RSUs), or employee stock purchase plans (ESPP).',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility. Exempt employees are salaried and not eligible for overtime; non-exempt employees are eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `grade_band` STRING COMMENT 'Compensation grade or pay band assigned to this job profile. Links to salary range tables and determines eligibility for benefits, bonuses, and equity compensation.. Valid values are `^[A-Z0-9]{1,5}$`',
    `job_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying this job profile within the organizations job taxonomy. Used for HR systems integration, payroll processing, and workforce planning.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_description` STRING COMMENT 'Comprehensive narrative describing the roles purpose, key responsibilities, deliverables, and scope of work. Used for recruitment, performance management, and role clarity.',
    `job_family` STRING COMMENT 'Broad occupational grouping that clusters related roles sharing similar skill sets and career progression paths. Used for talent development, succession planning, and compensation benchmarking. [ENUM-REF-CANDIDATE: engineering|production|content|advertising|distribution|technology|finance|legal|human_resources|operations — 10 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level or seniority grade within the organizations career framework. Determines scope of responsibility, decision-making authority, and compensation band eligibility. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|principal|manager|director|vice_president|executive — 9 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of this job profile. Active profiles are available for hiring and workforce planning; inactive or obsolete profiles are retained for historical reference only.. Valid values are `active|inactive|draft|under_review|obsolete`',
    `job_title` STRING COMMENT 'Official job title as it appears on employment contracts, business cards, and organizational charts. Examples: Broadcast Engineer, News Producer, Content Scheduler, Ad Traffic Coordinator, Studio Director.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was last updated. Used for change tracking and audit compliance.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this role. Used for candidate screening and workforce planning.. Valid values are `high_school|associate_degree|bachelor_degree|master_degree|doctoral_degree|professional_certification`',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this role. Used for candidate qualification and talent acquisition.',
    `physical_demands` STRING COMMENT 'Description of physical requirements and working conditions for this role. Examples: ability to lift 50 lbs, prolonged standing, work in outdoor weather conditions, operate heavy equipment. Required for ADA compliance and workplace safety.',
    `preferred_skills` STRING COMMENT 'Comma-separated list of additional skills that are desirable but not mandatory. Used to identify high-potential candidates and development opportunities.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for remote or hybrid work arrangements. Used for workforce planning, real estate optimization, and talent attraction.',
    `required_certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, or credentials required or preferred for this role. Examples: FCC General Radiotelephone Operator License, Certified Broadcast Networking Technician (CBNT), Society of Broadcast Engineers (SBE) Certification.',
    `required_skills` STRING COMMENT 'Comma-separated list of technical, functional, and soft skills required for successful performance in this role. Examples: video editing, broadcast automation systems, Adobe Premiere, Final Cut Pro, project management, stakeholder communication.',
    `salary_band_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for this job profile in USD. Represents the ceiling for this roles compensation range.',
    `salary_band_midpoint` DECIMAL(18,2) COMMENT 'Midpoint or target annual base salary for this job profile in USD. Represents the market-competitive rate for fully competent performance.',
    `salary_band_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for this job profile in USD. Used for compensation planning, budgeting, and pay equity analysis.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary band amounts. Supports multi-currency compensation structures for global operations.. Valid values are `^[A-Z]{3}$`',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Used for candidate expectations, expense budgeting, and work-life balance planning.',
    `union_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for union membership or collective bargaining representation. Critical for labor relations, contract negotiations, and compliance with National Labor Relations Act (NLRA).',
    `union_name` STRING COMMENT 'Name of the labor union or collective bargaining unit representing this role, if applicable. Examples: International Brotherhood of Electrical Workers (IBEW), National Association of Broadcast Employees and Technicians (NABET-CWA), Writers Guild of America (WGA).',
    `version_number` STRING COMMENT 'Sequential version number for this job profile. Incremented with each revision to support change management and historical tracking.',
    `work_schedule_type` STRING COMMENT 'Typical work schedule pattern for this role. Critical for broadcast operations requiring 24/7 coverage and shift-based staffing.. Valid values are `standard_business_hours|shift_work|on_call|flexible|compressed_workweek`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Reference catalog of all standardized job profiles and role definitions used across Media Broadcasting — broadcast engineer, news producer, content scheduler, ad traffic coordinator, studio director, etc. Captures job code, job title, job family, job level/grade band, FLSA classification (exempt/non-exempt), EEO job category, minimum qualifications, required certifications, salary band reference, and whether the role is union-eligible. Serves as the authoritative job taxonomy for workforce planning, compensation benchmarking, and talent acquisition.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the approved headcount position within Media Broadcastings organizational structure. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Positions like "ESPN2 Scheduler" or "Fox Sports Traffic Coordinator" are often channel-specific. Workforce planning and job descriptions in broadcasting are tied to specific channel operations for res',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the budget for this position. Used for financial planning, headcount cost allocation, and budget tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee currently occupying this position. Null if the position is vacant. Enables tracking of position-to-person assignments and vacancy analysis.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the roles responsibilities, competencies, and requirements. Links to the job catalog maintained by HR.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location (office, studio, broadcast facility) where this position is based. Used for facilities planning and geographic workforce distribution analysis.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or team) to which this position is assigned. Enables hierarchical workforce reporting and cost center allocation.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports. Enables construction of organizational reporting hierarchies and span-of-control analysis.',
    `approval_date` DATE COMMENT 'The date on which the position was officially approved for funding by the budget committee or executive leadership. Used for budget cycle tracking and headcount authorization audit.',
    `budget_status` STRING COMMENT 'Budget approval status for the position: approved (funded and authorized), frozen (temporarily unfunded), pending (awaiting budget committee review), or rejected (not authorized for funding).. Valid values are `approved|frozen|pending|rejected`',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'The annual salary amount budgeted for this position in the organizations financial plan. Used for headcount cost forecasting and budget variance analysis. Business-confidential.',
    `business_justification` STRING COMMENT 'Narrative explanation of the business need and strategic rationale for creating or maintaining this position. Used for budget approval and workforce planning documentation.',
    `position_code` STRING COMMENT 'Externally-known unique business identifier for the position, used in HR systems, budget planning, and workforce reporting. Typically alphanumeric code assigned by HR.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_date` DATE COMMENT 'The date on which this position record was first created in the HR system. Used for audit trail and position history tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budgeted salary (e.g., USD, GBP, EUR). Enables multi-currency workforce cost reporting for global operations.. Valid values are `^[A-Z]{3}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions purpose, key responsibilities, and scope. Used for job postings, performance management, and organizational documentation.',
    `effective_end_date` DATE COMMENT 'The date on which this position record expires or is retired. Null for open-ended positions. Used for temporal workforce planning and position lifecycle tracking.',
    `effective_start_date` DATE COMMENT 'The date on which this position record becomes effective and the position is officially available for assignment. Used for temporal workforce planning and historical analysis.',
    `employment_type` STRING COMMENT 'Classification of the position based on working hours and schedule: full-time (standard hours), part-time (reduced hours), casual (irregular hours), or on-call (as-needed).. Valid values are `full-time|part-time|casual|on-call`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The full-time equivalent allocation for this position, expressed as a decimal (e.g., 1.00 for full-time, 0.50 for half-time). Used for headcount budgeting and workforce capacity planning.',
    `is_exempt` BOOLEAN COMMENT 'Boolean flag indicating whether the position is exempt from overtime pay requirements under the Fair Labor Standards Act (FLSA). True if exempt (salaried professional/managerial), False if non-exempt (hourly/overtime-eligible).',
    `is_remote_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the position is eligible for remote or hybrid work arrangements. True if remote work is permitted, False if on-site presence is required.',
    `is_union_position` BOOLEAN COMMENT 'Boolean flag indicating whether this position is covered by a collective bargaining agreement. True if union-represented, False otherwise. Used for labor cost modeling and contract compliance.',
    `job_family` STRING COMMENT 'Broad occupational category to which the position belongs (e.g., Engineering, Content Production, Sales, Finance, IT). Used for workforce segmentation and career path planning.',
    `job_level` STRING COMMENT 'Hierarchical level or grade of the position within the organizations job architecture (e.g., Entry, Mid, Senior, Manager, Director, Executive). Used for compensation benchmarking and career progression.',
    `last_modified_date` DATE COMMENT 'The date on which this position record was most recently updated. Used for change tracking and data quality monitoring.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position: active (approved and available), vacant (approved but unfilled), filled (occupied by employee), frozen (temporarily suspended), obsolete (retired), or pending-approval (awaiting budget authorization).. Valid values are `active|vacant|filled|frozen|obsolete|pending-approval`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature: permanent (ongoing), temporary (fixed-term), contract (external contractor slot), seasonal (recurring short-term), project-based (tied to specific initiative), or internship.. Valid values are `permanent|temporary|contract|seasonal|project-based|internship`',
    `preferred_qualifications` STRING COMMENT 'Summary of the desired (but not mandatory) education, certifications, experience, and skills that would enhance candidate suitability. Used for recruitment and candidate ranking.',
    `required_qualifications` STRING COMMENT 'Summary of the minimum education, certifications, experience, and skills required for the position. Used for recruitment screening and candidate evaluation.',
    `requires_security_clearance` BOOLEAN COMMENT 'Boolean flag indicating whether the position requires a security clearance or background check due to access to sensitive content, facilities, or systems. True if clearance required, False otherwise.',
    `salary_grade` STRING COMMENT 'Compensation grade or band assigned to the position, defining the salary range. Used for pay equity analysis and budget planning. Business-confidential.',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts, job postings, and HR records (e.g., Senior Broadcast Engineer, Content Producer, Ad Sales Manager).',
    `union_affiliation` STRING COMMENT 'Name of the labor union or collective bargaining unit to which this position belongs, if applicable (e.g., IATSE, SAG-AFTRA, NABET-CWA). Null for non-union positions. Used for labor relations and contract compliance.',
    `vacancy_posted_date` DATE COMMENT 'The date on which the position was posted as a job opening for recruitment. Null if the position has never been vacant or posted. Used for time-to-fill analysis and recruitment metrics.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Master record for each approved headcount position within Media Broadcastings organizational structure. A position is a budgeted slot within an org unit that may be filled or vacant. Captures position code, position title, org unit, job profile reference, FTE allocation, position type (permanent/temporary/contract), budget status (approved/frozen), filled/vacant status, incumbent employee reference, and effective date range. Enables workforce planning, vacancy tracking, and headcount budget control distinct from the individual employee record.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` (
    `employment_record_id` BIGINT COMMENT 'Unique identifier for each distinct employment engagement or assignment. Primary key for the employment record.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or job classification that defines the role, responsibilities, and competencies for this employment engagement.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or business unit) where the employee is assigned during this employment period.',
    `position_id` BIGINT COMMENT 'Reference to the specific position held in this employment engagement. Links to the position master record.',
    `previous_employment_record_id` BIGINT COMMENT 'Self-referencing FK on employment_record (previous_employment_record_id)',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this employment record. Links to the employee master record.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical work location (office, studio, broadcast facility) where the employee is based during this employment period.',
    `action_effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employment action became effective in the HR system. Used for audit trails and compliance reporting.',
    `action_processed_by` STRING COMMENT 'The HR administrator or system user who processed and recorded this employment action. Used for audit trails and accountability.',
    `contract_end_date` DATE COMMENT 'The scheduled end date of the employment contract for fixed-term or project-based engagements. Nullable for permanent or at-will contracts.',
    `contract_type` STRING COMMENT 'The type of employment contract governing this employment engagement. Indicates whether the contract is permanent, fixed-term, project-based, at-will, or governed by a union agreement.. Valid values are `permanent|fixed_term|project_based|at_will|union_contract`',
    `cost_center_code` STRING COMMENT 'The cost center to which this employees compensation and benefits are charged during this employment period. Used for financial accounting and budget allocation.',
    `data_source_system` STRING COMMENT 'The source system or application from which this employment record originated. Typically references SAP S/4HANA HR or other HR management systems.',
    `effective_end_date` DATE COMMENT 'The date when this employment engagement or assignment officially ends. Nullable for ongoing employment. Marks the conclusion of this specific employment period.',
    `effective_start_date` DATE COMMENT 'The date when this employment engagement or assignment officially begins. Marks the start of the employment period for this specific position and organizational assignment.',
    `employee_group` STRING COMMENT 'High-level classification of the employee type (e.g., active employees, retirees, external workers). Used for payroll processing and benefits eligibility determination.',
    `employee_subgroup` STRING COMMENT 'Detailed classification within the employee group (e.g., salaried, hourly, union, non-union). Determines specific payroll rules and time management policies.',
    `employment_action_reason` STRING COMMENT 'Detailed reason or justification for the employment action. Provides context for why the hire, transfer, promotion, or other action occurred.',
    `employment_action_type` STRING COMMENT 'The type of employment action that created this employment record. Indicates whether this is an initial hire, internal transfer, promotion, demotion, secondment, or rehire event.. Valid values are `hire|rehire|transfer|promotion|demotion|secondment`',
    `employment_status` STRING COMMENT 'Current lifecycle status of this employment record at the time of the action. Indicates whether the employment engagement is active, inactive, suspended, terminated, or on leave.. Valid values are `active|inactive|suspended|terminated|on_leave`',
    `employment_type` STRING COMMENT 'Classification of the employment engagement by work arrangement. Indicates whether the employee is full-time, part-time, contract, temporary, seasonal, or intern.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The full-time equivalency percentage for this employment engagement. Represents the proportion of a full-time workload, expressed as a percentage (e.g., 100.00 for full-time, 50.00 for half-time).',
    `notice_period_days` STRING COMMENT 'The number of days of notice required for termination of this employment engagement, as specified in the employment contract or applicable labor law.',
    `pay_grade` STRING COMMENT 'The pay grade or salary band assigned to this employment engagement. Determines compensation range and benefits eligibility.',
    `pay_scale_area` STRING COMMENT 'Geographic or organizational area that determines the applicable pay scale. Used for regional compensation adjustments and cost-of-living considerations.',
    `pay_scale_type` STRING COMMENT 'The type of pay scale or compensation structure applied to this employment engagement. May reference union agreements, executive compensation plans, or standard salary structures.',
    `personnel_area` STRING COMMENT 'The personnel area representing the geographic or administrative grouping for HR administration. Used for payroll processing, benefits administration, and compliance reporting.',
    `personnel_subarea` STRING COMMENT 'Subdivision of the personnel area providing finer-grained administrative grouping. Used for location-specific HR policies and time management rules.',
    `probation_end_date` DATE COMMENT 'The date when the probationary period for this employment engagement ends. Nullable if no probation period applies or if the employee has already completed probation.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this employment record is currently active and valid. Used for filtering current vs historical employment engagements in reporting and analytics.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this employment record was first created in the HR system. Used for audit trails and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this employment record was last modified in the HR system. Used for audit trails and change tracking.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for remote or work-from-home arrangements during this employment period. Reflects organizational policy and role requirements.',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs, if applicable. References collective bargaining agreements and union-specific policies.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union during this employment period. Used for collective bargaining agreement compliance and benefits administration.',
    `weekly_hours` DECIMAL(18,2) COMMENT 'The standard number of hours per week the employee is contracted to work during this employment period. Used for full-time equivalency calculations.',
    `work_schedule_code` STRING COMMENT 'Code representing the work schedule pattern assigned to the employee during this employment period. Defines working hours, shift patterns, and time allocation.',
    `work_schedule_description` STRING COMMENT 'Human-readable description of the work schedule. Provides details about working hours, shift patterns, or flexible work arrangements.',
    CONSTRAINT pk_employment_record PRIMARY KEY(`employment_record_id`)
) COMMENT 'Transactional record capturing each distinct employment engagement or assignment for an employee — covering initial hire, internal transfers, promotions, demotions, secondments, and rehires. Each row represents a single employment period with a specific position, org unit, job profile, employment type, and manager. Captures effective start date, effective end date, employment action type, action reason, reporting manager, work schedule, work location, and employment status at time of action. Forms the complete employment history timeline for each employee.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan record. Primary key for the compensation plan entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned to this compensation plan. Links to the employee master record in the workforce domain.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or position that this compensation plan is associated with. Used when the plan is defined at the job level rather than individual employee level.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit where this compensation plan applies. Used for departmental compensation structures.',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `approval_date` DATE COMMENT 'Date when the compensation plan was approved by authorized personnel.',
    `approval_status` STRING COMMENT 'Approval workflow status for the compensation plan: pending (awaiting approval), approved (authorized for use), or rejected (not approved).. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the HR manager or executive who approved this compensation plan.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount for salaried employees. Null for hourly or commission-only plans.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the employee under this plan is eligible for performance bonuses, annual bonuses, or incentive compensation.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission percentage applied to sales or revenue for commission-based compensation plans. Null if commission not applicable.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial accounting and payroll expense allocation. Links compensation costs to organizational budget units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan expires or is superseded by a new plan. Null for open-ended plans currently in effect.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective and active for the employee or job profile.',
    `flsa_classification` STRING COMMENT 'FLSA classification determining overtime eligibility: exempt (not eligible for overtime) or non-exempt (eligible for overtime pay).. Valid values are `exempt|non-exempt`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate for hourly employees. Null for salaried or commission-only plans.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was last updated or modified.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this compensation plan record.',
    `notes` STRING COMMENT 'Free-text notes or comments about the compensation plan, including special terms, conditions, or historical context.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the employee under this plan is eligible for overtime pay under Fair Labor Standards Act (FLSA) or equivalent regulations. True for non-exempt employees, False for exempt.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime not applicable.',
    `pay_frequency` STRING COMMENT 'Frequency at which compensation is paid to the employee: weekly (52 times/year), bi-weekly (26 times/year), semi-monthly (24 times/year), or monthly (12 times/year).. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `pay_grade` STRING COMMENT 'Pay grade or band assigned to this compensation plan within the organizations compensation structure (e.g., Grade 5, Band C, Level 3).',
    `pay_step` STRING COMMENT 'Step or increment within the pay grade, typically representing progression based on tenure or performance (e.g., Step 1, Step 2).',
    `plan_code` STRING COMMENT 'Business identifier code for the compensation plan. Externally-known unique code used in HR systems and payroll processing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan (e.g., Senior Producer Salary Plan, Broadcast Engineer Hourly Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan: draft (being designed), active (in effect), suspended (temporarily paused), terminated (ended), or superseded (replaced by newer plan).. Valid values are `draft|active|suspended|terminated|superseded`',
    `plan_type` STRING COMMENT 'Type of compensation structure: salary (fixed annual), hourly (paid per hour worked), commission (performance-based), hybrid (combination), or contract (fixed-term agreement).. Valid values are `salary|hourly|commission|hybrid|contract`',
    `shift_differential_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for shift differential pay for working non-standard hours (evening, night, weekend shifts).',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly rate or percentage added for shift differential pay. Null if shift differential not applicable.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of hours per week expected under this compensation plan (e.g., 40.00 for full-time, 20.00 for part-time).',
    `target_bonus_percent` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base salary for bonus-eligible employees. Represents the expected bonus at 100% performance achievement.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit governing this compensation plan (e.g., IATSE, SAG-AFTRA, NABET-CWA). Null if non-union.',
    `union_scale_applicable` BOOLEAN COMMENT 'Indicates whether this compensation plan is subject to union scale rates and collective bargaining agreement terms.',
    `work_schedule_type` STRING COMMENT 'Type of work schedule associated with this compensation plan: full-time (standard 40 hours/week), part-time (less than full-time), seasonal (recurring periods), temporary (fixed duration), or on-call (as-needed).. Valid values are `full-time|part-time|seasonal|temporary|on-call`',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master record defining the compensation structure and pay plan assigned to an employee or job profile at Media Broadcasting. Captures pay plan type (salary/hourly/commission), base salary or hourly rate, pay frequency (weekly/bi-weekly/monthly), currency, effective date, pay grade, step within grade, overtime eligibility, shift differential eligibility, and union scale applicability. Distinct from talent compensation structures in the talent domain — this covers internal staff payroll compensation only.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for each payroll processing event. Primary key for the payroll record entity.',
    `adjusted_payroll_record_id` BIGINT COMMENT 'Self-referencing FK on payroll_record (adjusted_payroll_record_id)',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll expense allocation to cost centers is fundamental to media broadcasting financial operations. Enables departmental cost tracking for production units, broadcast operations, news divisions, and',
    `employee_id` BIGINT COMMENT 'Reference to the employee receiving this payroll payment. Links to the employee master record in the workforce domain.',
    `bank_account_number` BIGINT COMMENT 'Reference to the employee bank account used for direct deposit payment. Null if payment method is not direct deposit.',
    `bonus_pay` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payments included in this payroll cycle.',
    `check_number` STRING COMMENT 'Physical check number if payment method is check. Null for direct deposit or other payment methods.',
    `commission_pay` DECIMAL(18,2) COMMENT 'Sales commission earnings included in this payroll payment, typically for sales or revenue-generating roles.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. Typically USD for Media Broadcasting operations.. Valid values are `USD`',
    `dental_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee portion of dental insurance premium deducted from payroll.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Total number of hours worked that qualify for double-time premium pay, typically for holidays or excessive overtime.',
    `federal_income_tax` DECIMAL(18,2) COMMENT 'Amount withheld for federal income tax based on employee W-4 elections and IRS tax tables.',
    `fsa_deduction` DECIMAL(18,2) COMMENT 'Pre-tax contribution to Flexible Spending Account for healthcare or dependent care expenses.',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Court-ordered or legally mandated wage garnishment for child support, tax levies, or other obligations.',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or withholdings. Sum of all pay components for the period.',
    `health_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premium deducted from payroll.',
    `hsa_deduction` DECIMAL(18,2) COMMENT 'Pre-tax contribution to Health Savings Account for qualified medical expenses.',
    `local_income_tax` DECIMAL(18,2) COMMENT 'Amount withheld for local or municipal income tax where applicable.',
    `medicare_tax` DECIMAL(18,2) COMMENT 'Employee portion of Medicare tax withheld under the Federal Insurance Contributions Act (FICA).',
    `net_pay` DECIMAL(18,2) COMMENT 'Take-home pay after all deductions and withholdings. The amount actually disbursed to the employee.',
    `other_deductions` DECIMAL(18,2) COMMENT 'Miscellaneous voluntary or involuntary deductions not categorized elsewhere.',
    `other_earnings` DECIMAL(18,2) COMMENT 'Miscellaneous additional earnings not categorized as regular, overtime, bonus, or commission pay.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of hours worked beyond the standard work schedule that qualify for overtime premium pay.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Additional earnings from overtime hours worked, typically calculated at 1.5x the regular rate.',
    `pay_frequency` STRING COMMENT 'The recurring schedule on which the employee is paid. Determines the cadence of payroll processing for this employee.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last day of the work period covered by this payroll payment. Defines the end of the earnings period.',
    `pay_period_start_date` DATE COMMENT 'The first day of the work period covered by this payroll payment. Defines the beginning of the earnings period.',
    `payment_date` DATE COMMENT 'The date on which the net pay is disbursed to the employee. The actual payment delivery date.',
    `payment_method` STRING COMMENT 'The method by which net pay is delivered to the employee.. Valid values are `direct deposit|check|cash|paycard`',
    `payroll_run_date` DATE COMMENT 'The date on which the payroll calculations were executed and this record was generated.',
    `payroll_status` STRING COMMENT 'Current processing status of this payroll record in its lifecycle from calculation through payment.. Valid values are `draft|calculated|approved|paid|voided|reversed`',
    `pto_hours` DECIMAL(18,2) COMMENT 'Number of paid time off hours used during this pay period, including vacation, sick leave, and personal days.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total number of standard work hours performed during the pay period at the base rate of pay.',
    `regular_pay` DECIMAL(18,2) COMMENT 'Earnings from regular hours worked at the base hourly or salary rate. Excludes overtime and other premium pay.',
    `retirement_401k_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax or Roth contribution to 401(k) retirement savings plan.',
    `social_security_tax` DECIMAL(18,2) COMMENT 'Employee portion of Social Security tax withheld under the Federal Insurance Contributions Act (FICA).',
    `state_income_tax` DECIMAL(18,2) COMMENT 'Amount withheld for state income tax based on state tax regulations and employee elections.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all tax withholdings and voluntary deductions subtracted from gross pay.',
    `vision_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee portion of vision insurance premium deducted from payroll.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Transactional record of each payroll processing event for an employee covering a specific pay period. Captures pay period start and end dates, gross pay, federal/state/local tax withholdings, FICA contributions, voluntary deductions (401k, health insurance, FSA), net pay, payment method (direct deposit/check), bank account reference, payroll run date, and payroll status. Serves as the authoritative payroll ledger for each employee pay cycle — feeds finance domain for payroll expense posting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for this entity.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan in which the employee is enrolling. Links to the benefit plan master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is enrolling in the benefit plan. Links to the employee master record in the workforce domain.',
    `superseded_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (superseded_benefit_enrollment_id)',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'For FSA, HSA, or other contribution-based plans, the total annual amount the employee elected to contribute for the plan year. Expressed in USD. Nullable for non-contribution plans.',
    `carrier_name` STRING COMMENT 'The name of the insurance carrier or benefits provider administering this plan (e.g., Blue Cross Blue Shield, Aetna, Fidelity, Vanguard). Used for vendor management and claims coordination.',
    `contingent_beneficiary_name` STRING COMMENT 'The full legal name of the contingent (secondary) beneficiary who receives benefits if the primary beneficiary is deceased or unable to receive benefits. Nullable if no contingent beneficiary designated.',
    `contingent_beneficiary_relationship` STRING COMMENT 'The relationship of the contingent beneficiary to the employee. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|domestic_partner|other_relative|friend|estate|trust|other — 10 candidates stripped; promote to reference product]',
    `coverage_amount` DECIMAL(18,2) COMMENT 'For life insurance and disability plans, the face value or benefit amount of the coverage (e.g., $100,000 life insurance, 60% salary replacement for disability). Expressed in USD or as a percentage. Nullable for non-insurance benefits.',
    `coverage_tier` STRING COMMENT 'The level of coverage selected by the employee, determining who is covered under the benefit plan (employee only, employee plus spouse, employee plus children, full family, or employee plus domestic partner).. Valid values are `employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source_system` STRING COMMENT 'The name of the source system from which this enrollment record originated (e.g., SAP S/4HANA HR, Workday, ADP, Benefits Administration Portal). Used for data lineage and reconciliation.',
    `effective_date` DATE COMMENT 'The date on which the benefit coverage begins and becomes active. This may differ from enrollment_date due to waiting periods or plan year start dates.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount that the employee contributes per pay period toward the benefit premium or plan cost. Expressed in USD. For retirement plans, this may represent the employee deferral percentage converted to dollar amount.',
    `employee_contribution_frequency` STRING COMMENT 'The frequency at which the employee contribution is deducted from payroll or paid by the employee.. Valid values are `per_pay_period|monthly|quarterly|annually|one_time`',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount that the employer contributes per pay period toward the benefit premium or plan cost. Expressed in USD. For retirement plans, this may include employer match or profit-sharing contributions.',
    `employer_contribution_frequency` STRING COMMENT 'The frequency at which the employer contribution is made toward the benefit plan.. Valid values are `per_pay_period|monthly|quarterly|annually|one_time`',
    `enrollment_confirmation_number` STRING COMMENT 'A confirmation or transaction number provided by the benefits administration system or carrier when the enrollment is processed. Used for audit trail and employee inquiries.',
    `enrollment_date` DATE COMMENT 'The date on which the employee submitted or completed the benefit enrollment election. This is the transaction date when the enrollment decision was made.',
    `enrollment_number` STRING COMMENT 'Human-readable business identifier for the benefit enrollment, typically used in HR systems and employee communications. Format: BEN-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^BEN-[0-9]{8}$`',
    `enrollment_source` STRING COMMENT 'The triggering event or process that allowed this enrollment to occur. New hire indicates initial employment enrollment; open enrollment indicates annual election period; qualifying life event (QLE) indicates mid-year change due to marriage, birth, etc.; plan change indicates employee-initiated modification; rehire indicates return to employment.. Valid values are `new_hire|open_enrollment|qualifying_life_event|annual_reenrollment|plan_change|rehire`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Pending indicates awaiting approval or effective date; active indicates currently in force; terminated indicates coverage has ended; suspended indicates temporary hold; cancelled indicates enrollment was voided before becoming active; waived indicates employee declined coverage.. Valid values are `pending|active|terminated|suspended|cancelled|waived`',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Boolean flag indicating whether the employee must provide medical evidence of insurability (health questionnaire, medical exam) to qualify for this coverage level. Typically required for supplemental life insurance above guaranteed issue amounts.',
    `evidence_of_insurability_status` STRING COMMENT 'If evidence_of_insurability_required is true, this field tracks the status of the EOI submission and approval process. Not_required indicates no EOI needed; pending indicates awaiting carrier review; approved indicates coverage granted; denied indicates coverage declined; incomplete indicates additional information needed.. Valid values are `not_required|pending|approved|denied|incomplete`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was last modified in the system. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `plan_name` STRING COMMENT 'The marketing or display name of the benefit plan as presented to employees (e.g., Premium Health PPO, Basic Dental Plan, 401k Traditional).',
    `plan_type` STRING COMMENT 'Category of benefit plan. Includes health insurance (medical/dental/vision), life insurance, disability insurance, retirement plans (401k/pension), flexible spending accounts (FSA), health savings accounts (HSA), commuter benefits, employee assistance programs (EAP), and supplemental coverage. [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|disability_insurance|retirement_401k|retirement_pension|fsa|hsa|commuter_benefits|employee_assistance_program|supplemental_life|critical_illness|accident_insurance — 14 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'The calendar or fiscal year for which this enrollment is effective. Used to track enrollments across annual benefit cycles and open enrollment periods. Format: YYYY.',
    `policy_number` STRING COMMENT 'The carriers policy or group number under which this enrollment is covered. Used for claims processing and carrier coordination. Confidential business information.',
    `primary_beneficiary_name` STRING COMMENT 'The full legal name of the primary beneficiary designated to receive benefits in the event of the employees death. Applicable primarily to life insurance and retirement plans. Nullable if no beneficiary designated.',
    `primary_beneficiary_percentage` DECIMAL(18,2) COMMENT 'The percentage of benefits allocated to the primary beneficiary. Typically 100 for single beneficiary or split among multiple. Value range 0.00 to 100.00.',
    `primary_beneficiary_relationship` STRING COMMENT 'The relationship of the primary beneficiary to the employee. Used for compliance and verification purposes. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|domestic_partner|other_relative|friend|estate|trust|other — 10 candidates stripped; promote to reference product]',
    `qualifying_event_date` DATE COMMENT 'The date on which the qualifying life event occurred (e.g., marriage date, birth date, loss of coverage date). Nullable for non-QLE enrollments. Used to validate enrollment timing compliance.',
    `qualifying_event_type` STRING COMMENT 'If enrollment_source is qualifying_life_event, this field specifies the type of life event that triggered the mid-year enrollment change. Nullable for non-QLE enrollments. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death_of_dependent|loss_of_coverage|employment_status_change|dependent_age_limit|other — 9 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'The date on which the benefit coverage ends. Nullable for active enrollments. Populated when employee terminates employment, changes plans, or reaches plan end date.',
    `tobacco_user_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the employee declared tobacco use during enrollment. Used for premium rating and wellness program eligibility. Protected health information under HIPAA.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'The total cost of the benefit plan per pay period, representing the sum of employee and employer contributions. Expressed in USD. Used for financial reporting and cost analysis.',
    `waiver_reason` STRING COMMENT 'If enrollment_status is waived, this field captures the reason the employee declined coverage (e.g., covered under spouses plan, Medicare eligible, cost concerns). Free-text field for HR documentation. Nullable for non-waived enrollments.',
    `wellness_program_participant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is participating in employer-sponsored wellness programs that may affect premium rates or provide incentives.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in a specific benefit plan — health insurance (medical/dental/vision), life insurance, disability insurance, 401k/pension, FSA/HSA, commuter benefits, or employee assistance programs. Captures plan name, plan type, coverage tier (employee only/employee+spouse/family), enrollment date, effective date, termination date, employee contribution amount, employer contribution amount, beneficiary designations, and enrollment source (open enrollment/qualifying life event/new hire).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request. Primary key for the leave request transaction.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department where the employee works at the time of the leave request. Used for departmental leave analytics and staffing impact analysis.',
    `original_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (original_leave_request_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to the employee master record in the workforce domain.',
    `tertiary_leave_substitute_employee_id` BIGINT COMMENT 'Identifier of the employee designated to cover the absent employees responsibilities during the leave period. Null if no formal substitute assigned.',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'Actual number of leave days taken, calculated from time and attendance records. Used for leave balance deduction and payroll processing.',
    `actual_end_date` DATE COMMENT 'Actual last date the employee was absent on approved leave. May differ from requested end date if employee returned early or extended leave.',
    `actual_hours_taken` DECIMAL(18,2) COMMENT 'Actual number of leave hours taken, calculated from time and attendance records. Used for hourly leave balance deduction and payroll processing.',
    `actual_start_date` DATE COMMENT 'Actual first date the employee was absent on approved leave. May differ from requested start date if employee returned early or extended leave.',
    `approval_date` DATE COMMENT 'Date when the approving manager made the approval or denial decision. Null if request is still pending.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the leave request: pending (awaiting manager review), approved (manager approved), denied (manager rejected), cancelled (approved but later cancelled by manager), withdrawn (employee withdrew before approval decision).. Valid values are `pending|approved|denied|cancelled|withdrawn`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approving manager made the approval or denial decision, including time zone. Used for audit trail and SLA tracking.',
    `comments` STRING COMMENT 'Free-text comments or notes provided by the employee when submitting the leave request, such as reason for leave or special circumstances.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the employees time is charged. Used for financial reporting and labor cost allocation during leave periods.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave request record was first created in the system. Used for audit trail and data lineage.',
    `denial_reason` STRING COMMENT 'Free-text explanation provided by the manager when denying a leave request. Null if request was approved or is still pending.',
    `denial_reason_code` STRING COMMENT 'Standardized categorical reason for denial: staffing_shortage (inadequate coverage), blackout_period (restricted dates such as sweeps or upfront periods), insufficient_notice (did not meet advance notice policy), policy_violation (does not meet eligibility or usage rules), other (see denial_reason for details).. Valid values are `staffing_shortage|blackout_period|insufficient_notice|policy_violation|other`',
    `fmla_certification_date` DATE COMMENT 'Date when FMLA medical certification was received and approved by HR. Null for non-FMLA leave or if certification not yet approved.',
    `fmla_certification_status` STRING COMMENT 'Status of required medical certification for FMLA leave: not_required (non-FMLA leave), pending (certification requested but not yet received), received (certification submitted by employee), approved (HR approved certification), insufficient (certification does not meet requirements).. Valid values are `not_required|pending|received|approved|insufficient`',
    `fmla_protected_flag` BOOLEAN COMMENT 'Indicates whether this leave request is protected under the Family and Medical Leave Act. True if FMLA-eligible and certified.',
    `intermittent_leave_flag` BOOLEAN COMMENT 'Indicates whether this is an intermittent leave request (multiple non-consecutive absences for the same condition) rather than a continuous block of leave. Common for FMLA medical treatment schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave request record was last updated in the system. Tracks changes to approval status, actual dates, or other fields.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Employees remaining leave balance in days or hours after this request was approved and taken. Used for leave accrual and entitlement tracking.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Employees available leave balance in days or hours before this request was approved and taken. Snapshot for audit and balance tracking.',
    `leave_subtype` STRING COMMENT 'Optional granular classification within the leave type, such as maternity vs paternity under parental leave, or continuous vs intermittent under FMLA.',
    `leave_type` STRING COMMENT 'Category of leave being requested: vacation (paid time off), sick (illness or medical appointments), FMLA (Family and Medical Leave Act protected leave), parental (maternity/paternity/adoption), bereavement (death of family member), jury_duty (civic duty), military (military service), unpaid (leave without pay).. Valid values are `vacation|sick|fmla|parental|bereavement|jury_duty`',
    `manager_comments` STRING COMMENT 'Free-text comments or notes provided by the approving manager when reviewing the leave request, such as approval conditions or coverage arrangements.',
    `paid_leave_flag` BOOLEAN COMMENT 'Indicates whether this leave is paid (employee receives regular compensation) or unpaid (no compensation during absence). Drives payroll deduction calculations.',
    `payroll_period` STRING COMMENT 'Payroll period (YYYY-MM format) in which this leave was processed for compensation adjustments. Used to reconcile leave with payroll cycles.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this leave request has been processed by payroll for deductions or adjustments. True once payroll cycle has incorporated the leave.',
    `reduced_schedule_flag` BOOLEAN COMMENT 'Indicates whether this leave request involves a reduced work schedule (working fewer hours per day or days per week) rather than full-day absences. Common for FMLA return-to-work transitions.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request. Represents the principal business event timestamp for this transaction.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the leave request, typically formatted as LR-YYYYNNNN for external reference and tracking.. Valid values are `^LR-[0-9]{8}$`',
    `requested_end_date` DATE COMMENT 'Last date of the requested leave period. Employee intends to return to work the following business day.',
    `requested_start_date` DATE COMMENT 'First date of the requested leave period. Employee intends to be absent starting this date.',
    `total_days_requested` DECIMAL(18,2) COMMENT 'Total number of leave days requested, calculated as business days between start and end dates. May include fractional days for partial-day leave.',
    `total_hours_requested` DECIMAL(18,2) COMMENT 'Total number of leave hours requested, used for hourly leave tracking and partial-day absences. Supports intermittent FMLA leave measured in hours.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record of each employee leave request submitted at Media Broadcasting — vacation, sick leave, FMLA, parental leave, bereavement, jury duty, military leave, and unpaid leave. Captures request date, leave type, requested start date, requested end date, total days requested, approval status, approving manager, approval date, denial reason if applicable, FMLA certification status, intermittent leave flag, and actual leave taken dates. Feeds time and attendance systems and payroll deduction calculations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` (
    `leave_balance_id` BIGINT COMMENT 'Unique identifier for the leave balance record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee to whom this leave balance belongs. Links to the employee master record in the workforce domain.',
    `prior_leave_balance_id` BIGINT COMMENT 'Self-referencing FK on leave_balance (prior_leave_balance_id)',
    `accrual_cap` DECIMAL(18,2) COMMENT 'Maximum leave balance that can be accrued for this leave type per Media Broadcasting policy. Once reached, no further accrual occurs until balance drops below cap.',
    `accrual_period_end_date` DATE COMMENT 'End date of the current accrual period. Balances may reset, roll over, or be forfeited at this boundary per policy.',
    `accrual_period_start_date` DATE COMMENT 'Start date of the current accrual period (e.g., calendar year, fiscal year, or anniversary year depending on Media Broadcasting policy).',
    `accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which leave accrues per pay period or per hour worked, based on employee tenure and policy tier. Expressed in hours or days per unit time.',
    `accrued_current_period` DECIMAL(18,2) COMMENT 'Total leave hours or days accrued during the current period based on accrual rate and service time. Updated each pay period by payroll system.',
    `adjusted_balance` DECIMAL(18,2) COMMENT 'Manual adjustments to the leave balance (positive or negative) made by HR for corrections, policy exceptions, or one-time grants. Includes adjustment reason in notes.',
    `available_balance` DECIMAL(18,2) COMMENT 'Current available leave balance that the employee can request. Calculated as: opening_balance + accrued_current_period - used_current_period + adjusted_balance - pending_requests.',
    `balance_as_of_date` DATE COMMENT 'The date as of which this leave balance snapshot is accurate. Typically updated at the end of each pay period or after a leave transaction.',
    `carried_over_balance` DECIMAL(18,2) COMMENT 'Leave balance carried forward from the prior accrual period. Subject to carryover caps per Media Broadcasting policy (e.g., maximum 40 hours vacation carryover).',
    `carryover_cap` DECIMAL(18,2) COMMENT 'Maximum leave balance that can be carried over to the next accrual period. Any balance above this cap is forfeited per policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave balance record was first created in the system. Audit trail for record lifecycle.',
    `eligibility_status` STRING COMMENT 'Current eligibility status of the employee for this leave type. Ineligible may apply during probation, leave of absence, or termination notice period.. Valid values are `eligible|ineligible|pending|suspended`',
    `forfeited_balance` DECIMAL(18,2) COMMENT 'Leave hours or days forfeited at the end of the prior period due to exceeding carryover caps or use-it-or-lose-it policy. Represents lost leave liability.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this leave balance record is currently active. Inactive records represent historical snapshots or terminated leave types.',
    `last_accrual_date` DATE COMMENT 'Date of the most recent leave accrual transaction for this employee and leave type. Typically aligns with pay period end date.',
    `last_usage_date` DATE COMMENT 'Date of the most recent leave usage (deduction) for this employee and leave type. Helps identify stale balances and usage patterns.',
    `leave_type_code` STRING COMMENT 'Code representing the type of leave (e.g., VAC for vacation, SICK for sick leave, PTO for paid time off, FLOAT for floating holiday, COMP for compensatory time). Standardized codes per Media Broadcasting HR policy.. Valid values are `^[A-Z]{2,10}$`',
    `leave_type_name` STRING COMMENT 'Human-readable name of the leave type (e.g., Vacation, Sick Leave, Personal Time Off, Floating Holiday, Compensatory Time).',
    `liability_amount` DECIMAL(18,2) COMMENT 'Monetary value of the current available leave balance, calculated as available_balance multiplied by the employees hourly or daily rate. Represents financial liability for Media Broadcasting.',
    `notes` STRING COMMENT 'Free-text notes regarding this leave balance record, including reasons for manual adjustments, policy exceptions, or special circumstances documented by HR.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Leave balance at the start of the current accrual period, including any carryover from the prior period. Expressed in hours or days per unit of measure.',
    `pending_requests` DECIMAL(18,2) COMMENT 'Total leave hours or days currently requested but not yet approved or denied. Represents potential future deductions from available balance.',
    `policy_tier` STRING COMMENT 'The accrual policy tier applicable to this employee for this leave type, typically based on tenure or job level (e.g., Tier 1: 0-2 years, Tier 2: 3-5 years, Tier 3: 6+ years).',
    `projected_year_end_balance` DECIMAL(18,2) COMMENT 'Forecasted leave balance at the end of the current accrual period, assuming no further usage. Used for liability planning and to alert employees of potential forfeitures.',
    `unit_of_measure` STRING COMMENT 'Unit in which leave balance is tracked and reported: hours or days. Standardized per leave type and employee classification.. Valid values are `hours|days`',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this leave balance record. Supports audit and compliance requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave balance record was last modified. Updated each pay period or after leave transactions. Audit trail for record lifecycle.',
    `used_current_period` DECIMAL(18,2) COMMENT 'Total leave hours or days used (taken) by the employee during the current period. Sourced from approved leave requests and time-tracking system.',
    CONSTRAINT pk_leave_balance PRIMARY KEY(`leave_balance_id`)
) COMMENT 'Master record tracking the accrued and available leave balances for each employee across all leave types — vacation, sick, PTO, floating holiday, and comp time. Captures balance as of date, accrued hours/days in current period, used hours/days in current period, carried-over balance from prior year, forfeited balance, and adjusted balance. Updated each pay period by the payroll and time-tracking systems. Enables HR and managers to monitor leave liability and enforce accrual caps per Media Broadcasting policy.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Timesheets in broadcast operations track which channel/property work was performed for. Essential for cost allocation, project tracking, and channel P&L reporting. Standard practice in multi-channel b',
    `corrected_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (corrected_timesheet_id)',
    `location_id` BIGINT COMMENT 'Identifier of the primary work location or facility where the employee performed work during this timesheet period. Links to location master record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department to which the employee belongs during this timesheet period. Links to department master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved or is responsible for approving this timesheet. Links to employee master record.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Crew timesheets reference specific program schedules they worked on (e.g., production crew for specific broadcast). Production cost tracking and labor accounting requires linking timesheets to program',
    `tertiary_timesheet_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this timesheet record. Used for audit trail and accountability.',
    `approval_date` DATE COMMENT 'The date on which the timesheet was approved by the manager. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current approval state of the timesheet in the workflow. Tracks progression from draft through submission, approval, or rejection.. Valid values are `draft|submitted|approved|rejected|pending_revision|cancelled`',
    `approval_timestamp` TIMESTAMP COMMENT 'The precise date and time when the timesheet was approved, used for audit trail and SLA tracking.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the timesheet hours are allocated for financial reporting and departmental cost tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this timesheet record was first created in the system. Used for audit trail and data lineage.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Total number of double-time hours worked, typically compensated at 2x regular rate. Common for holiday work, excessive overtime, or seventh consecutive day worked per union agreements.',
    `holiday_hours` DECIMAL(18,2) COMMENT 'Total number of paid holiday hours included in this timesheet period for recognized company holidays.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this timesheet record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments added by the employee or manager regarding this timesheet, such as explanations for unusual hours or special circumstances.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Total number of on-call hours during the pay period. Relevant for broadcast engineers and technical staff required to be available for emergency playout or transmission issues.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period, typically compensated at 1.5x regular rate. Critical for broadcast operations staff working irregular shifts and live event crews subject to union overtime rules.',
    `pay_grade` STRING COMMENT 'Pay grade or salary band of the employee during this timesheet period. Used for compensation calculation and reporting. Business-confidential information.. Valid values are `^[A-Z0-9]{2,6}$`',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this timesheet. Defines the end of the time reporting window.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this timesheet. Defines the beginning of the time reporting window.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this timesheet has been processed by the payroll system. True if processed, False if pending.',
    `project_code` STRING COMMENT 'Project or production code to which the timesheet hours are allocated. Used for cost tracking and project accounting in content production and live event operations.. Valid values are `^[A-Z0-9]{6,12}$`',
    `pto_hours` DECIMAL(18,2) COMMENT 'Total number of paid time off hours included in this timesheet period, including vacation, sick leave, and personal days.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total number of regular working hours recorded in this timesheet, excluding overtime, double-time, or premium hours. Basis for standard compensation calculation.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the approving manager if the timesheet was rejected. Null if timesheet was not rejected.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Total number of hours worked during shifts eligible for differential pay (e.g., night shift, weekend shift). Common in 24/7 broadcast operations.',
    `submission_date` DATE COMMENT 'The date on which the employee submitted the timesheet for approval. Critical for tracking compliance with submission deadlines.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the timesheet was submitted by the employee, used for audit trail and compliance verification.',
    `timesheet_number` STRING COMMENT 'Human-readable business identifier for the timesheet, typically formatted as TS-YYYYMMDD or similar pattern for external reference and reporting.. Valid values are `^TS-[0-9]{8}$`',
    `total_hours_approved` DECIMAL(18,2) COMMENT 'Total number of hours approved by the manager for payroll processing. May differ from submitted hours if adjustments were made during approval.',
    `total_hours_submitted` DECIMAL(18,2) COMMENT 'Total number of hours submitted by the employee across all categories (regular, overtime, double-time, on-call, shift differential, PTO, holiday, unpaid leave). Sum of all hour types.',
    `union_code` STRING COMMENT 'Code identifying the labor union to which the employee belongs, if applicable. Critical for applying correct overtime rules, shift differentials, and residual calculations per union collective bargaining agreements.. Valid values are `^[A-Z]{2,6}$`',
    `unpaid_leave_hours` DECIMAL(18,2) COMMENT 'Total number of unpaid leave hours recorded in this timesheet period, such as unpaid personal leave or leave without pay.',
    `work_order_number` STRING COMMENT 'Work order number associated with the timesheet, used for tracking time against specific maintenance, production, or operational tasks.. Valid values are `^WO-[0-9]{6,10}$`',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Transactional record of an employees time worked for a specific pay period — capturing regular hours, overtime hours, double-time hours, on-call hours, and shift differential hours by day. Includes timesheet period start/end, submission date, approval status, approving manager, total hours submitted, total hours approved, project/cost center allocation codes, and any time-off hours included. Critical for broadcast operations staff working irregular shifts, live event crews, and production personnel subject to union overtime rules.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` (
    `work_schedule_id` BIGINT COMMENT 'Unique identifier for the work schedule pattern. Primary key.',
    `base_work_schedule_id` BIGINT COMMENT 'Self-referencing FK on work_schedule (base_work_schedule_id)',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Broadcast work schedules align with dayparts (morning shift covers morning daypart, prime time shift covers prime daypart). 24/7 operations shift planning requires mapping work schedules to broadcast ',
    `work_scheduling_daypart_id` BIGINT COMMENT 'Identifier linking to the work scheduling daypart',
    `applicable_job_families` STRING COMMENT 'Comma-separated list of job families or roles this schedule is designed for (e.g., Broadcast Engineer, Playout Operator, Master Control Technician, Production Staff, Administrative). Supports role-based schedule assignment.',
    `applicable_org_units` STRING COMMENT 'Comma-separated list of organizational unit codes or names where this schedule is used (e.g., Broadcast Operations, Playout Engineering, News Production, Corporate Office). Enables filtering schedules by department or division.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks during the shift, measured in minutes (e.g., 30 for half-hour lunch, 60 for one-hour lunch). Used to calculate net working hours and compliance with labor regulations.',
    `created_by_user` STRING COMMENT 'Username or employee identifier of the person who created this work schedule record. Supports accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work schedule record was first created in the system. Used for audit trail and data lineage.',
    `daypart_classification` STRING COMMENT 'Broadcast industry daypart classification for the schedule: morning (6-9 AM), daytime (9 AM-4 PM), early_fringe (4-7 PM), prime_access (7-8 PM), prime_time (8-11 PM), late_fringe (11 PM-1 AM), overnight (1-6 AM). Aligns shift schedules with programming and advertising dayparts. [ENUM-REF-CANDIDATE: morning|daytime|early_fringe|prime_access|prime_time|late_fringe|overnight — 7 candidates stripped; promote to reference product]',
    `days_of_week` STRING COMMENT 'Comma-separated list of days this schedule applies to (e.g., Mon,Tue,Wed,Thu,Fri for standard office; Mon,Tue,Wed,Thu for compressed week; Sat,Sun for weekend shift). Supports broadcast operations requiring 24/7 coverage.',
    `effective_end_date` DATE COMMENT 'Date when this work schedule pattern is no longer active. Null for currently active schedules. Used to retire outdated schedules while preserving historical assignments.',
    `effective_start_date` DATE COMMENT 'Date when this work schedule pattern becomes active and available for employee assignment. Supports versioning and historical tracking of schedule changes.',
    `flsa_classification` STRING COMMENT 'FLSA classification for employees on this schedule: exempt (salaried, not eligible for overtime) or non_exempt (hourly, eligible for overtime). Determines overtime calculation and minimum wage requirements.. Valid values are `exempt|non_exempt`',
    `holiday_work_required` BOOLEAN COMMENT 'Indicates whether employees on this schedule are expected to work on company-recognized holidays. True for essential broadcast operations (playout, master control), false for administrative roles.',
    `last_modified_by_user` STRING COMMENT 'Username or employee identifier of the person who last modified this work schedule record. Supports accountability and audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work schedule record was last updated. Used for audit trail and change tracking.',
    `meal_break_required` BOOLEAN COMMENT 'Indicates whether a meal break is legally or contractually required for this schedule. True for shifts exceeding a certain duration (typically 6+ hours), false for shorter shifts. Ensures compliance with labor regulations.',
    `on_call_frequency` STRING COMMENT 'Frequency of on-call duty for schedules that include on-call rotation: none (no on-call), weekly (one week per rotation), biweekly (one week every two weeks), monthly (one week per month), as_needed (ad-hoc). Relevant for broadcast engineering and technical support roles.. Valid values are `none|weekly|biweekly|monthly|as_needed`',
    `on_call_response_time_minutes` STRING COMMENT 'Maximum time in minutes an on-call employee must respond to a call-out (e.g., 30 for 30-minute response, 60 for one-hour response). Null for schedules without on-call duty. Critical for broadcast continuity and Service Level Agreement (SLA) compliance.',
    `overtime_calculation_basis` STRING COMMENT 'Basis for calculating overtime: daily (hours beyond threshold in a single day), weekly (hours beyond threshold in a work week), biweekly (hours beyond threshold in a two-week pay period). Determines when premium pay rates apply.. Valid values are `daily|weekly|biweekly`',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours per day or week after which overtime compensation applies for employees on this schedule. Typically 8 hours per day or 40 hours per week under FLSA; may vary by jurisdiction and collective bargaining agreements.',
    `paid_break_duration_minutes` STRING COMMENT 'Total duration of paid breaks during the shift, measured in minutes (e.g., 15 for two 15-minute breaks). Separate from unpaid meal breaks; included in compensable time.',
    `requires_broadcast_license` BOOLEAN COMMENT 'Indicates whether employees assigned to this schedule must hold a valid broadcast engineering or operator license (e.g., FCC General Radiotelephone Operator License). True for technical playout and transmission roles, false for administrative and production roles.',
    `rest_period_between_shifts_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours required between the end of one shift and the start of the next for employees on this schedule (e.g., 8 for eight-hour rest, 11 for eleven-hour rest). Ensures compliance with labor regulations and employee well-being, especially for rotating broadcast shifts.',
    `rotation_cycle_days` STRING COMMENT 'Number of days in the rotation cycle for rotating shift schedules (e.g., 7 for weekly rotation, 14 for bi-weekly, 28 for four-week cycle). Null for fixed schedules. Broadcast operations often use 7, 14, or 21-day cycles to ensure equitable distribution of overnight and weekend shifts.',
    `schedule_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the schedule pattern (e.g., STD-9TO5, SHIFT-AM, SHIFT-PM, ONCALL-ROT). Used for quick reference in HR systems and employee assignments.. Valid values are `^[A-Z0-9]{3,10}$`',
    `schedule_description` STRING COMMENT 'Detailed description of the work schedule pattern, including any special conditions, rotation details, or operational notes (e.g., Four 10-hour shifts Monday-Thursday with Friday off; on-call rotation every fourth week; requires FCC license).',
    `schedule_name` STRING COMMENT 'Human-readable name of the work schedule pattern (e.g., Standard Office Hours, Morning Broadcast Shift, Evening Playout Shift, On-Call Rotation, Compressed Work Week).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the work schedule. Active schedules are available for employee assignment; inactive schedules are no longer used; draft schedules are under review; deprecated schedules are phased out but retained for historical reference.. Valid values are `active|inactive|draft|deprecated`',
    `schedule_type` STRING COMMENT 'Classification of the schedule pattern: fixed (consistent daily hours), rotating (shifts that change on a cycle), on_call (availability-based), compressed (longer days, fewer days per week), flexible (variable start/end within boundaries), split_shift (two separate work periods in one day).. Valid values are `fixed|rotating|on_call|compressed|flexible|split_shift`',
    `shift_differential_eligible` BOOLEAN COMMENT 'Indicates whether employees on this schedule are eligible for shift differential pay (premium compensation for evening, night, or weekend shifts). True for overnight broadcast shifts, false for standard daytime office schedules.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Percentage or flat amount of additional compensation for shift differential, if applicable (e.g., 10 for 10% premium, 2.50 for $2.50/hour premium). Null if shift_differential_eligible is false.',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the work shift in HH:MM 24-hour format (e.g., 17:00 for 5 PM, 06:00 for 6 AM next day). For rotating or flexible schedules, this represents the primary or latest end time.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the work shift in HH:MM 24-hour format (e.g., 09:00 for 9 AM, 22:00 for 10 PM). For rotating or flexible schedules, this represents the primary or earliest start time.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the schedule (e.g., America/New_York, America/Los_Angeles, Europe/London). Critical for broadcast operations spanning multiple time zones to ensure accurate shift timing and playout coordination.',
    `total_weekly_hours` DECIMAL(18,2) COMMENT 'Total number of hours per week defined by this schedule pattern. Standard full-time is typically 40 hours; broadcast operations may have 37.5, 40, or 42 hours depending on shift structure and break policies.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit whose agreement governs this schedule (e.g., IBEW for International Brotherhood of Electrical Workers, NABET-CWA for National Association of Broadcast Employees and Technicians). Null for non-union schedules.',
    `weekend_work_required` BOOLEAN COMMENT 'Indicates whether this schedule includes regular weekend work (Saturday and/or Sunday). True for broadcast operations requiring 24/7 coverage, false for standard Monday-Friday office schedules.',
    CONSTRAINT pk_work_schedule PRIMARY KEY(`work_schedule_id`)
) COMMENT 'Reference master defining the standard work schedule patterns used across Media Broadcasting — 9-to-5 office, rotating broadcast shift (AM/PM/overnight), live event schedule, on-call rotation, and compressed work week. Captures schedule code, schedule name, schedule type, total weekly hours, shift start time, shift end time, days of week, break duration, overtime threshold, and applicable org units. Broadcast operations require 24/7 shift coverage — this entity governs shift pattern assignments for all operational staff.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the senior manager or HR leader who provided final approval of the performance review.',
    `previous_performance_review_id` BIGINT COMMENT 'Self-referencing FK on performance_review (previous_performance_review_id)',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in the workforce domain.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the review, typically the direct manager or supervisor.',
    `approval_date` DATE COMMENT 'The date on which the performance review received final approval and became official.',
    `calibration_date` DATE COMMENT 'The date on which the performance review rating was calibrated through management review session.',
    `calibration_status` STRING COMMENT 'Status indicating whether the review has undergone calibration process to ensure rating consistency across the organization. Calibration involves peer review of ratings by management.. Valid values are `not_required|pending|in_progress|completed|waived`',
    `collaboration_rating` DECIMAL(18,2) COMMENT 'Competency rating for teamwork, communication, and cross-functional collaboration on a 1-5 scale.',
    `compensation_adjustment_recommended_flag` BOOLEAN COMMENT 'Boolean indicator of whether a compensation adjustment (salary increase, bonus) is recommended based on this performance review.',
    `completed_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review was marked as completed, indicating all required steps including approval and acknowledgement are finished.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the system.',
    `development_plan_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal performance improvement or development plan is required as an outcome of this review.',
    `dispute_comments` STRING COMMENT 'Narrative explanation provided by the employee if they dispute the performance review rating or feedback.',
    `employee_acknowledgement_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has acknowledged the performance review. Required for review completion.',
    `employee_comments` STRING COMMENT 'Narrative comments and self-reflection provided by the employee as part of their self-assessment in the performance review.',
    `employee_dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has formally disputed the performance review rating or feedback.',
    `employee_self_assessment_score` DECIMAL(18,2) COMMENT 'The self-rating provided by the employee on a 1-5 scale as part of the performance review process. Captures employees own perception of their performance.',
    `final_approved_rating` DECIMAL(18,2) COMMENT 'The final overall performance rating after calibration and approval by senior management. This is the official rating used for compensation and promotion decisions.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Percentage score representing the degree to which the employee achieved their performance goals during the review period. Calculated as weighted average of individual goal completion rates.',
    `innovation_rating` DECIMAL(18,2) COMMENT 'Competency rating for creativity, problem-solving, and innovative thinking on a 1-5 scale.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was last updated or modified.',
    `leadership_rating` DECIMAL(18,2) COMMENT 'Competency rating for leadership capabilities, people management, and influence on a 1-5 scale. Applicable to employees in leadership roles or demonstrating leadership potential.',
    `overall_rating` DECIMAL(18,2) COMMENT 'The overall performance rating assigned to the employee on a 1-5 scale, where 1 is unsatisfactory and 5 is exceptional. May include decimal precision for nuanced scoring.',
    `pre_calibration_rating` DECIMAL(18,2) COMMENT 'The initial overall rating assigned by the reviewer before the calibration process. Retained for audit trail and calibration impact analysis.',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is eligible for promotion consideration based on this performance review outcome.',
    `recommended_compensation_adjustment_percent` DECIMAL(18,2) COMMENT 'The recommended percentage increase in base compensation resulting from this performance review. Used to inform compensation planning decisions.',
    `review_acknowledgement_date` DATE COMMENT 'The date on which the employee formally acknowledged receipt and review of their performance evaluation.',
    `review_date` DATE COMMENT 'The date on which the formal performance review discussion was conducted between reviewer and employee.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated in this review.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated in this review.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review. Tracks progression from draft through calibration to final approval. [ENUM-REF-CANDIDATE: draft|submitted|in_calibration|calibrated|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'The type or category of performance review being conducted. Determines the review cycle and evaluation criteria applied.. Valid values are `annual|mid_year|probationary|project_based|quarterly|ad_hoc`',
    `reviewer_comments` STRING COMMENT 'Detailed narrative feedback provided by the reviewer regarding the employees performance, strengths, areas for improvement, and development recommendations.',
    `succession_planning_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee should be included in succession planning discussions based on this performance review outcome.',
    `technical_skills_rating` DECIMAL(18,2) COMMENT 'Competency rating for technical skills and job-specific expertise on a 1-5 scale. Evaluates proficiency in role-required technical capabilities.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record of each formal employee performance evaluation conducted at Media Broadcasting — annual reviews, mid-year check-ins, probationary reviews, and project-based assessments. Captures review period, review type, overall rating (1-5 scale), competency ratings by dimension (technical skills, collaboration, innovation, leadership), goal achievement score, reviewer comments, employee self-assessment score, calibration status, and final approved rating. Feeds compensation adjustment decisions, promotion eligibility, and succession planning.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` (
    `goal_id` BIGINT COMMENT 'Unique identifier for the employee performance goal record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Employee goals in broadcasting are often tied to specific channel performance (ratings targets, revenue goals, audience growth). Performance management workflow requires linking goals to channels for ',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit to which this goal is aligned. Supports departmental goal rollup and reporting. Links to the department master record.',
    `parent_goal_id` BIGINT COMMENT 'Self-referencing FK on goal (parent_goal_id)',
    `employee_id` BIGINT COMMENT 'Reference to the employee to whom this goal is assigned. Links to the employee master record in the workforce domain.',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of goal completion based on current value relative to target value. Values over 100% indicate the goal was exceeded. Used for performance scoring and reporting.',
    `approval_status` STRING COMMENT 'Workflow status of goal approval. Draft: being created by employee; pending approval: submitted to manager; approved: accepted by manager; rejected: not accepted; revision requested: manager requested changes before approval.. Valid values are `draft|pending_approval|approved|rejected|revision_requested`',
    `approved_date` DATE COMMENT 'Date when the manager approved this goal. Null if the goal has not yet been approved.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Starting or current value of the metric at the time the goal was set. Provides context for measuring progress and improvement (e.g., current audience reach before the goal period).',
    `goal_category` STRING COMMENT 'Classification of the goal scope and level. Individual goals are personal performance targets; team goals are shared across a work group; organizational goals cascade from company-wide objectives; departmental goals align with division priorities; project goals are tied to specific initiatives; strategic goals support long-term business strategy.. Valid values are `individual|team|organizational|departmental|project|strategic`',
    `completion_date` DATE COMMENT 'Actual date when the goal was marked as completed or achieved. Null if the goal is still in progress or not yet achieved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this goal record was first created in the system. Supports audit trail and goal lifecycle tracking.',
    `current_value` DECIMAL(18,2) COMMENT 'Most recent measured value of the target metric, reflecting progress toward the goal. Updated periodically as performance data becomes available.',
    `goal_description` STRING COMMENT 'Detailed narrative description of the goal, including context, expected outcomes, and success criteria. Provides comprehensive understanding of what the employee is expected to achieve.',
    `due_date` DATE COMMENT 'Target completion date by which the goal should be achieved. Used to assess timeliness of goal attainment and plan performance reviews.',
    `employee_notes` STRING COMMENT 'Free-text notes from the employee documenting progress, challenges encountered, resources needed, or self-assessment. Supports employee self-reflection and two-way performance dialogue.',
    `goal_type` STRING COMMENT 'Nature of the goal measurement. Quantitative goals have numeric targets (e.g., revenue, ratings); qualitative goals are assessed subjectively (e.g., leadership quality); behavioral goals focus on conduct and values; developmental goals target skill acquisition; operational goals improve processes; strategic goals advance long-term positioning.. Valid values are `quantitative|qualitative|behavioral|developmental|operational|strategic`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this goal is mandatory (required for all employees in a role or department) or optional (individually selected). Mandatory goals often relate to compliance, training, or core job functions.',
    `is_stretch_goal` BOOLEAN COMMENT 'Indicates whether this is a stretch goal (aspirational target beyond normal expectations). Stretch goals are typically weighted differently in performance evaluations and partial achievement is often considered successful.',
    `last_review_date` DATE COMMENT 'Date of the most recent progress review or check-in for this goal. Used to track regular monitoring and feedback cadence.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this goal record was most recently modified. Tracks the currency of goal data and supports change auditing.',
    `manager_notes` STRING COMMENT 'Free-text notes and feedback from the manager regarding goal progress, challenges, support provided, or observations. Used for coaching and performance documentation.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target value (e.g., percent, viewers, hours, episodes, dollars, rating points). Clarifies how the numeric target should be interpreted.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next progress review or check-in. Supports proactive performance management and ensures regular goal monitoring.',
    `okr_alignment` STRING COMMENT 'Reference to the company-level or department-level OKR (Objectives and Key Results) that this goal supports. Ensures goal alignment with organizational strategy. May reference specific objective identifiers or descriptive text.',
    `priority_level` STRING COMMENT 'Business priority assigned to this goal. Critical goals are essential to business success; high priority goals are important but not mission-critical; medium priority goals are standard objectives; low priority goals are developmental or stretch targets.. Valid values are `critical|high|medium|low`',
    `progress_status` STRING COMMENT 'Current state of goal progress. Not started: work has not begun; in progress: actively being worked on; on track: progressing as expected; at risk: may not meet target; behind: falling short of milestones; completed: target achieved; exceeded: surpassed target; cancelled: goal no longer applicable. [ENUM-REF-CANDIDATE: not_started|in_progress|on_track|at_risk|behind|completed|exceeded|cancelled — 8 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'Date when the goal period begins and the employee starts working toward the objective. Marks the beginning of the performance measurement window.',
    `target_metric` STRING COMMENT 'The specific measurable indicator or key performance indicator (KPI) used to assess goal achievement (e.g., Audience Reach, Content Production Volume, System Uptime Percentage, Training Completion Rate).',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value that defines success for the goal. Used in conjunction with measurement_unit to specify the quantitative objective (e.g., 15.0 for 15% increase, 1000000 for one million viewers).',
    `title` STRING COMMENT 'Short, descriptive title of the performance goal (e.g., Increase Audience Reach by 15%, Complete Digital Asset Migration).',
    `visibility_level` STRING COMMENT 'Defines who can view this goal. Private: only employee and manager; manager: visible to management chain; department: visible to department members; organization: visible company-wide; public: visible to external stakeholders.. Valid values are `private|manager|department|organization|public`',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Relative importance or weight of this goal within the employees overall performance review, expressed as a percentage (e.g., 25.00 means this goal represents 25% of the total performance score). All goals for an employee typically sum to 100%.',
    CONSTRAINT pk_goal PRIMARY KEY(`goal_id`)
) COMMENT 'Master record for individual employee performance goals and objectives set within Media Broadcastings performance management cycle. Captures goal title, goal description, goal category (individual/team/organizational), alignment to company OKR, target metric, target value, measurement unit, due date, weight percentage within review, progress status, and last updated date. Supports MBO (Management by Objectives) and OKR frameworks used across broadcast operations, content, technology, and corporate functions.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course. Primary key.',
    `prerequisite_training_course_id` BIGINT COMMENT 'Self-referencing FK on training_course (prerequisite_training_course_id)',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Training courses for broadcast operations may be daypart-specific (e.g., "Prime Time Programming Strategy", "Morning Show Production Techniques"). Specialized training curriculum design requires linki',
    `accreditation_body` STRING COMMENT 'Name of the external accreditation or certification body that has approved or accredited this training course (e.g., Society of Cable Telecommunications Engineers, Federal Communications Commission, Project Management Institute). Null if not externally accredited.',
    `training_course_category` STRING COMMENT 'Primary classification of the training course by subject area: broadcast operations (playout, scheduling, transmission), regulatory compliance (FCC, EEO, COPPA), technical skills (MAM, CDN, encoding), leadership development, cybersecurity awareness, or editorial standards.. Valid values are `broadcast_operations|regulatory_compliance|technical_skills|leadership_development|cybersecurity|editorial_standards`',
    `certification_awarded` STRING COMMENT 'Name of the certification, credential, or certificate of completion awarded upon successful course completion (e.g., FCC Broadcast Operator License, SCTE Broadband Transportation Specialist, Media Broadcasting Editorial Standards Certificate). Null if no formal certification is awarded.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units (CEUs) or professional development hours (PDHs) awarded upon course completion, recognized by industry associations or regulatory bodies. Null if no formal credits are awarded.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost charged per participant for enrollment in the training course, in USD. Includes tuition, materials, and vendor fees. Used for training budget planning and cost allocation. Null if the course is provided at no charge.',
    `course_code` STRING COMMENT 'Unique alphanumeric code assigned to the training course for catalog and registration purposes (e.g., BC-101, FCC-REG-2023, EEO-COMP).. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Comprehensive narrative description of the training course content, topics covered, instructional approach, and target audience. Used in the learning catalog and course registration materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was first created in the learning management system.',
    `delivery_method` STRING COMMENT 'Mode of instruction for the training course: instructor-led (in-person classroom), e-learning (self-paced online), blended (combination of online and in-person), virtual classroom (live online), or on-the-job (hands-on mentoring).. Valid values are `instructor_led|e_learning|blended|virtual_classroom|on_the_job`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the training course, measured in hours (e.g., 2.5 hours for a half-day workshop, 40 hours for a week-long certification program).',
    `effective_date` DATE COMMENT 'Date on which the training course became or will become available for enrollment and delivery. Represents the start of the courses active lifecycle.',
    `expiration_date` DATE COMMENT 'Date on which the training course will be retired or is no longer available for enrollment. Null if the course has no planned end date.',
    `language` STRING COMMENT 'Primary language in which the training course is delivered, using ISO 639-2 three-letter language codes (e.g., ENG for English, SPA for Spanish, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date on which the training course content was last reviewed and validated for accuracy, relevance, and regulatory compliance. Used to track currency of course materials.',
    `learning_objectives` STRING COMMENT 'Detailed description of the knowledge, skills, and competencies that participants will acquire upon successful completion of the training course. Defines the expected learning outcomes.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training course is mandatory for specific job roles or all employees (True) or optional/elective (False). Mandatory courses are typically driven by regulatory requirements (FCC, EEO, COPPA) or critical operational competencies.',
    `max_enrollment` STRING COMMENT 'Maximum number of participants that can be enrolled in a single offering or session of the training course. Null if there is no enrollment cap (e.g., for self-paced e-learning courses).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was last updated or modified in the learning management system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and update of the training course content. Ensures courses remain current with regulatory changes, technology updates, and business process evolution.',
    `prerequisites` STRING COMMENT 'Description of prerequisite courses, certifications, or experience required before an employee can enroll in this training course (e.g., Must complete BC-100 Introduction to Broadcasting, Requires 6 months experience in playout operations). Null if no prerequisites.',
    `provider_name` STRING COMMENT 'Name of the organization or entity that developed or delivers the training course (e.g., Media Broadcasting Learning & Development, Dalet Academy, Society of Cable Telecommunications Engineers).',
    `provider_type` STRING COMMENT 'Source of the training course: internal (developed and delivered by Media Broadcasting HR/L&D), external (third-party training vendor), vendor (system vendor training such as Dalet or Ericsson), industry association (MPA, ATSC, SCTE), or regulatory body (FCC-mandated training).. Valid values are `internal|external|vendor|industry_association|regulatory_body`',
    `recertification_period_months` STRING COMMENT 'Number of months after which the certification or training must be renewed or retaken to maintain compliance or currency (e.g., 12 months for annual cybersecurity awareness, 36 months for FCC regulatory training). Null if no recertification is required.',
    `title` STRING COMMENT 'Full descriptive title of the training course as displayed in the learning catalog and on certificates.',
    `training_course_status` STRING COMMENT 'Current lifecycle status of the training course: active (available for enrollment), inactive (temporarily unavailable), under development (being created or updated), retired (permanently discontinued), or suspended (on hold pending review or update).. Valid values are `active|inactive|under_development|retired|suspended`',
    `version` STRING COMMENT 'Version number of the training course content, incremented with each major or minor revision (e.g., 1.0, 1.1, 2.0). Tracks course evolution and ensures participants complete the current version.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Reference catalog of all training courses and learning programs available to Media Broadcasting employees — broadcast operations certifications, FCC regulatory training, EEO compliance training, editorial standards, cybersecurity awareness, leadership development, and technical skills programs. Captures course code, course title, course category, delivery method (instructor-led/e-learning/blended), duration hours, provider (internal/external), certification awarded, recertification period, mandatory flag, and applicable job profiles.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee enrolled in the training course. Links to the employee master record in the workforce domain.',
    `primary_previous_enrollment_training_enrollment_id` BIGINT COMMENT 'Identifier of the previous training enrollment record that this recertification enrollment supersedes. Used to track recertification history and lineage. Null for initial enrollments.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course or learning program for which the employee is enrolled. Links to the training course catalog.',
    `actual_start_date` DATE COMMENT 'Actual date when the employee commenced the training course. May differ from scheduled start date due to delays or early starts.',
    `assessment_result` STRING COMMENT 'Outcome of the training assessment indicating whether the employee passed, failed, has a pending assessment, did not require assessment for completion, or has an incomplete assessment.. Valid values are `pass|fail|pending|not-required|incomplete`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the employee on the training assessment, test, or examination. Typically expressed as a percentage (0-100) or raw score. Null if no assessment was administered or not yet taken.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of scheduled training sessions or modules that the employee attended or completed. Calculated as (hours completed / hours scheduled) * 100. Used for compliance verification and completion criteria.',
    `certificate_expiry_date` DATE COMMENT 'Date when the training certificate expires and recertification or refresher training is required. Null for certifications that do not expire or if no certificate was issued. Critical for tracking compliance with FCC technical certification requirements.',
    `certificate_issue_date` DATE COMMENT 'Date when the training completion certificate was issued to the employee. Null if no certificate was issued.',
    `certificate_issued` BOOLEAN COMMENT 'Boolean flag indicating whether a training completion certificate was issued to the employee upon successful completion. True if certificate was issued, False otherwise.',
    `certificate_number` STRING COMMENT 'Unique certificate identification number issued upon successful training completion. Used for verification and audit purposes. Null if no certificate was issued.. Valid values are `^CERT-[A-Z0-9]{10}$`',
    `completion_date` DATE COMMENT 'Date when the employee completed all requirements of the training course. Null if training is not yet completed.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training enrollment including tuition, materials, instructor fees, and facility costs. Used for training budget tracking and cost allocation.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the training expenses are allocated. Used for financial reporting and departmental budget tracking.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `enrolled_by_user` STRING COMMENT 'Username or identifier of the person who initiated the enrollment (e.g., HR administrator, manager, or self-enrollment by employee). Used for audit trail and enrollment source tracking.',
    `enrollment_date` DATE COMMENT 'Date when the employee was enrolled in the training course. Represents the business event timestamp for enrollment initiation.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number assigned to this training enrollment for tracking and reporting purposes.. Valid values are `^ENR-[0-9]{8}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the training enrollment indicating progression through the learning journey. Tracks whether the employee is enrolled, actively participating, has completed, failed, withdrawn, or had the enrollment cancelled.. Valid values are `enrolled|in-progress|completed|failed|withdrawn|cancelled`',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment indicating whether the training is mandatory (required by policy or regulation), voluntary (employee-initiated), recommended (suggested by manager), or compliance-driven (regulatory requirement such as FCC or EEO training).. Valid values are `mandatory|voluntary|recommended|compliance`',
    `instructor_name` STRING COMMENT 'Name of the instructor, facilitator, or trainer who delivered the training session. Null for self-paced online courses without instructor involvement.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this training is mandatory for the employee based on role, regulatory requirements, or company policy. True for mandatory training, False for optional training.',
    `is_recertification` BOOLEAN COMMENT 'Boolean flag indicating whether this enrollment represents a recertification or refresher training for a previously completed course. True for recertification enrollments, False for initial certifications.',
    `is_regulatory_required` BOOLEAN COMMENT 'Boolean flag indicating whether this training is required to meet regulatory compliance obligations such as FCC broadcast licensing requirements, EEO training mandates, or technical certification standards. True for regulatory-required training.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this enrollment record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified or updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this training enrollment. May include accommodations provided, special arrangements, or other relevant information.',
    `number_of_attempts` STRING COMMENT 'Count of how many times the employee attempted the training assessment or examination. Used for tracking learning progress and identifying employees who may need additional support.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment and achieve completion status. Used to determine pass/fail result. Null if no assessment is required for completion.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or governing body requirement that mandates this training (e.g., FCC Broadcast License Compliance, EEO Training, OSHA Safety, SOX Financial Controls). Null if not regulatory-driven.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the training session or learning program is scheduled to conclude for this enrollment.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the training session or learning program is scheduled to begin for this enrollment.',
    `training_delivery_method` STRING COMMENT 'Method by which the training content is delivered to the employee. Includes in-person classroom sessions, virtual instructor-led training, self-paced online courses, blended learning combining multiple methods, or on-the-job practical training.. Valid values are `in-person|virtual|online|blended|on-the-job`',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Actual number of training hours completed by the employee. Used for tracking progress, compliance reporting, and crediting continuing education units.',
    `training_hours_scheduled` DECIMAL(18,2) COMMENT 'Total number of training hours scheduled for this enrollment based on the course curriculum. Used for planning and resource allocation.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training is conducted. For in-person training, includes facility name or address. For virtual training, may include platform name (e.g., Zoom, Microsoft Teams). Null for self-paced online courses.',
    `withdrawal_date` DATE COMMENT 'Date when the employee withdrew from the training course before completion. Null if the enrollment was not withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation or categorized reason for why the employee withdrew from the training. Used for analyzing training dropout patterns and improving course design. Null if not withdrawn.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment and completion status for a specific training course or learning program. Captures enrollment date, scheduled session date, completion date, completion status (enrolled/in-progress/completed/failed/withdrawn), assessment score, pass/fail result, certificate issued flag, certificate expiry date, and training hours credited. Enables compliance tracking for mandatory FCC regulatory training, EEO training, and broadcast technical certifications required for licensed operations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the professional certification record. Primary key for the certification entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this certification. Links to the employee master record in the workforce domain.',
    `renewed_certification_id` BIGINT COMMENT 'Self-referencing FK on certification (renewed_certification_id)',
    `certification_category` STRING COMMENT 'Functional domain or technical discipline that the certification covers. Used to align certifications with job roles and departmental needs. [ENUM-REF-CANDIDATE: broadcast_engineering|it_infrastructure|cloud_computing|network_engineering|audio_engineering|video_engineering|rf_transmission|compliance_regulatory|project_management|cybersecurity — 10 candidates stripped; promote to reference product]',
    `certificate_url` STRING COMMENT 'Web URL or digital link to the electronic certificate or credential badge. Used for digital verification and display of credentials.',
    `certification_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body. This is the official credential identifier that can be used for verification purposes.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active certifications are valid and current; expired certifications have passed their expiry date; suspended certifications are temporarily invalid; revoked certifications have been permanently withdrawn; pending verification certifications are awaiting confirmation; in-progress certifications are being pursued but not yet awarded.. Valid values are `active|expired|suspended|revoked|pending_verification|in_progress`',
    `certification_type` STRING COMMENT 'Classification of the certification based on its nature and purpose. Regulatory licenses are legally required for specific broadcast operations; professional certifications demonstrate industry expertise; technical certifications validate specialized technical skills; vendor certifications are product-specific credentials; industry credentials are association-based qualifications.. Valid values are `regulatory_license|professional_certification|technical_certification|vendor_certification|industry_credential`',
    `certification_code` STRING COMMENT 'Short code or abbreviation for the certification type. Examples: GROL, CBNT, CBT, CPBE, AWS-SAA, SMPTE-CTS. Used for internal classification and reporting.',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'Number of continuing education hours the employee has completed toward the current renewal cycle. Used to track progress toward recertification requirements.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development hours required to maintain or renew the certification. Null for certifications without continuing education requirements.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew the certification, including exam fees, training costs, and application fees. Used for workforce development budget tracking and ROI analysis.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost. Examples: USD, GBP, EUR, CAD.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_storage_path` STRING COMMENT 'File path or document management system reference to the scanned or digital copy of the physical certificate. Used for record retention and audit purposes.',
    `employer_sponsored` BOOLEAN COMMENT 'Indicates whether the certification was sponsored or paid for by the employer. True if the company funded the certification; false if the employee self-funded it.',
    `exam_score` DECIMAL(18,2) COMMENT 'Score achieved on the certification exam, if applicable. May be a percentage, numeric score, or standardized score depending on the certification body. Null for certifications that do not have scored exams.',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid. Null for certifications that do not expire. Critical for compliance tracking and renewal planning.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this certification is required by law or regulation for the employee to perform specific duties. True for FCC licenses and other legally mandated credentials; false for voluntary professional certifications.',
    `is_required_for_role` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory requirement for the employees current job role. True for certifications that are job prerequisites (e.g., FCC GROL for broadcast engineers); false for optional or supplementary credentials.',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued or awarded to the employee. Used to calculate tenure and experience with the credential.',
    `issuing_body` STRING COMMENT 'Name of the organization or regulatory authority that issued the certification. Examples: Federal Communications Commission (FCC), Society of Broadcast Engineers (SBE), Society of Motion Picture and Television Engineers (SMPTE), Amazon Web Services (AWS), Microsoft, Cisco.',
    `certification_level` STRING COMMENT 'Proficiency or seniority level represented by the certification. Entry-level certifications demonstrate foundational knowledge; expert and master levels indicate advanced expertise and leadership capability.. Valid values are `entry|associate|professional|expert|master`',
    `modified_by_user` STRING COMMENT 'User identifier or username of the person who last modified this certification record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated. Used for audit trail and change tracking.',
    `certification_name` STRING COMMENT 'Full official name of the professional certification, license, or credential. Examples: FCC General Radiotelephone Operator License (GROL), SBE Certified Broadcast Networking Technologist (CBNT), AWS Certified Solutions Architect, SMPTE Certified Technology Specialist.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the certification must be renewed to maintain active status. Used for proactive renewal reminders and compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or context about the certification. May include details about specializations, endorsements, or unique circumstances.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the certification exam. Used to contextualize the exam score and assess performance relative to the standard.',
    `renewal_date` DATE COMMENT 'Date on which the certification was last renewed or recertified. Tracks ongoing maintenance of the credential.',
    `training_provider` STRING COMMENT 'Name of the organization or institution that provided the training or preparation for the certification exam. May be the same as the issuing body or a separate training vendor.',
    `verification_date` DATE COMMENT 'Date on which the certification was verified with the issuing body. Used for audit trail and compliance documentation.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity of the certification. Online registry checks use public databases; issuer confirmation involves direct contact with the certifying body; document review examines physical certificates; third-party services use specialized verification providers; self-attestation relies on employee declaration.. Valid values are `online_registry|issuer_confirmation|document_review|third_party_service|self_attestation`',
    `verification_status` STRING COMMENT 'Status of third-party verification of the certification with the issuing body. Verified certifications have been confirmed as authentic; pending verifications are awaiting response; failed verifications could not be confirmed; not required applies to internal or non-critical certifications.. Valid values are `verified|pending|failed|not_required`',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Master record of professional certifications, licenses, and credentials held by Media Broadcasting employees — FCC General Radiotelephone Operator License (GROL), SBE (Society of Broadcast Engineers) certifications, SMPTE technical certifications, IT/cloud certifications, and professional credentials. Captures certification name, issuing body, certification number, issue date, expiry date, renewal status, verification status, and associated job profile requirements. Critical for ensuring licensed broadcast operations are staffed with appropriately credentialed engineers.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `escalated_disciplinary_action_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_action (escalated_disciplinary_action_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the Media Broadcasting employee who is the subject of this disciplinary action.',
    `tertiary_disciplinary_issuing_manager_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who issued the disciplinary action to the employee.',
    `action_date` DATE COMMENT 'Date the disciplinary action was formally issued to the employee. This is the official date of record for the action and starts any applicable timelines.',
    `action_number` STRING COMMENT 'Business identifier for the disciplinary action, formatted as DA-YYYYNNNN for external reference and case tracking.. Valid values are `^DA-[0-9]{8}$`',
    `action_status` STRING COMMENT 'Current lifecycle state of the disciplinary action: draft (being prepared), pending review (awaiting HR/legal approval), active (in effect), completed (action fulfilled or time elapsed), overturned (reversed on appeal), or expired (no longer on employee record per retention policy).. Valid values are `draft|pending_review|active|completed|overturned|expired`',
    `action_type` STRING COMMENT 'Classification of the disciplinary action severity level: verbal warning (informal counseling), written warning (first formal step), final warning (last chance before termination), performance improvement plan (PIP - structured remediation), suspension (temporary removal from duties), or termination for cause (employment ended due to policy violation).. Valid values are `verbal_warning|written_warning|final_warning|performance_improvement_plan|suspension|termination_for_cause`',
    `appeal_filed_date` DATE COMMENT 'Date the employee filed a formal appeal or grievance. Null if no appeal has been filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal appeal or grievance challenging this disciplinary action. True if appeal filed, false otherwise.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal or grievance process: upheld (original action stands), overturned (action reversed), modified (action reduced or changed), or pending (under review). Null if no appeal filed.. Valid values are `upheld|overturned|modified|pending`',
    `corrective_action_required` STRING COMMENT 'Specific actions, behavioral changes, or performance improvements the employee must demonstrate to resolve the disciplinary action. May include training completion, metric achievement, or behavioral modification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was first created in the HR system. Audit trail for record creation.',
    `employee_acknowledgment_date` DATE COMMENT 'Date the employee signed or electronically acknowledged the disciplinary action documentation. Null if not yet acknowledged.',
    `employee_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt and review of the disciplinary action documentation. True if acknowledged, false if not yet acknowledged.',
    `employee_response` STRING COMMENT 'Written response or statement provided by the employee regarding the disciplinary action. May include explanations, disagreements, or mitigating circumstances. Null if no response provided.',
    `incident_date` DATE COMMENT 'Date when the policy violation or performance issue that triggered this disciplinary action occurred. May precede the action date due to investigation time.',
    `investigation_summary` STRING COMMENT 'Summary of the investigation conducted prior to issuing the disciplinary action, including interviews, evidence reviewed, and findings. Documents due process and fair treatment.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required legal review has been completed and approved. Null if legal review is not required.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this disciplinary action requires legal department review and approval before issuance. Typically true for terminations, suspensions, or actions involving potential litigation risk.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal department representative who reviewed and approved this disciplinary action. Null if legal review was not required or not yet completed.',
    `modified_by_user` STRING COMMENT 'User ID or name of the HR system user who last modified this disciplinary action record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Additional confidential notes, context, or follow-up information related to the disciplinary action. May include manager observations, HR guidance, or case management details.',
    `outcome` STRING COMMENT 'Final outcome of the disciplinary action: successful (employee met corrective action requirements and improved), unsuccessful (employee failed to improve, may lead to further action), in progress (action period still active), or terminated (employment ended as result of this action).. Valid values are `successful|unsuccessful|in_progress|terminated`',
    `pip_end_date` DATE COMMENT 'End date of the performance improvement plan period if action type is PIP. Typically 30, 60, or 90 days from start. Null for non-PIP actions.',
    `pip_start_date` DATE COMMENT 'Start date of the performance improvement plan period if action type is PIP. Null for non-PIP actions.',
    `policy_violated` STRING COMMENT 'Reference to the specific company policy, code of conduct section, or employment agreement clause that was violated. Includes policy number and title for traceability.',
    `record_retention_date` DATE COMMENT 'Date until which this disciplinary action record must be retained in the employee file per employment law and company policy. After this date, record may be purged or archived per retention schedule.',
    `response_deadline_date` DATE COMMENT 'Date by which the employee must provide a written response, complete required corrective actions, or demonstrate improvement. Null if no response is required.',
    `suspension_end_date` DATE COMMENT 'End date of suspension period if action type is suspension. Null for non-suspension actions.',
    `suspension_paid_flag` BOOLEAN COMMENT 'Indicates whether the suspension is paid (true) or unpaid (false). Null for non-suspension actions. Paid suspensions are typically used during investigations; unpaid for disciplinary purposes.',
    `suspension_start_date` DATE COMMENT 'Start date of suspension period if action type is suspension. Null for non-suspension actions.',
    `termination_triggered_flag` BOOLEAN COMMENT 'Indicates whether this disciplinary action resulted in or triggered employee termination. True if termination occurred, false otherwise. Feeds termination workflow when true.',
    `union_notification_required_flag` BOOLEAN COMMENT 'Indicates whether union notification is required for this disciplinary action per collective bargaining agreement. True for union-represented employees in positions covered by CBA disciplinary procedures.',
    `union_notified_date` DATE COMMENT 'Date the union representative was formally notified of the disciplinary action. Null if union notification is not required or not yet completed.',
    `union_representative_name` STRING COMMENT 'Name of the union representative notified and involved in the disciplinary action process. Null if not applicable.',
    `violation_category` STRING COMMENT 'High-level classification of the policy violation type: attendance (tardiness, absenteeism), performance (failure to meet job standards), conduct (behavioral issues), safety (workplace safety violations), compliance (regulatory or legal violations), confidentiality (data/information breach), or harassment (workplace harassment or discrimination). [ENUM-REF-CANDIDATE: attendance|performance|conduct|safety|compliance|confidentiality|harassment — 7 candidates stripped; promote to reference product]',
    `violation_description` STRING COMMENT 'Detailed narrative description of the specific policy violation or performance issue, including facts, circumstances, and impact. Maintained as confidential employment record.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Transactional record of formal disciplinary actions taken against Media Broadcasting employees — verbal warnings, written warnings, performance improvement plans (PIPs), suspensions, and terminations for cause. Captures action date, action type, policy violation description, investigation summary, corrective action required, response deadline, employee acknowledgment status, HR business partner assigned, legal review flag, and outcome. Maintained under restricted access per employment law requirements and feeds termination workflow when applicable.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` (
    `workforce_grievance_id` BIGINT COMMENT 'Unique identifier for the workforce grievance record. Primary key for the workforce grievance entity.',
    `escalated_workforce_grievance_id` BIGINT COMMENT 'Self-referencing FK on workforce_grievance (escalated_workforce_grievance_id)',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit where the complainant was assigned at the time of filing. Links to the org_unit master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who filed the grievance. Links to the employee master record.',
    `tertiary_workforce_employee_id` BIGINT COMMENT 'Identifier of the HR investigator or case manager assigned to investigate and resolve the grievance. Links to the employee master record.',
    `appeal_date` DATE COMMENT 'The date when an appeal was formally filed, if applicable.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal was filed by either party following the initial resolution.',
    `appeal_status` STRING COMMENT 'Current status of the appeal process if an appeal was filed.. Valid values are `pending|under_review|upheld|overturned|dismissed`',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the grievance, including the nature of the complaint, circumstances, and impact on the complainant.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality required for the grievance case based on sensitivity, legal risk, and privacy considerations.. Valid values are `standard|high|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the HR system.',
    `disciplinary_action_taken` STRING COMMENT 'Type of disciplinary action taken against the respondent if the grievance was substantiated.. Valid values are `none|verbal_warning|written_warning|suspension|termination|other`',
    `external_agency_name` STRING COMMENT 'Name of the external agency to which the grievance was reported (e.g., EEOC, OSHA, state labor department).',
    `external_agency_reported_flag` BOOLEAN COMMENT 'Indicates whether the grievance was also reported to an external regulatory or enforcement agency such as EEOC, OSHA, or state labor board.',
    `external_case_number` STRING COMMENT 'Case or complaint number assigned by the external agency for tracking purposes.',
    `filed_date` DATE COMMENT 'The date when the formal grievance was officially filed with Human Resources, marking the start of the investigation timeline.',
    `grievance_number` STRING COMMENT 'Externally-visible unique business identifier for the grievance case, formatted as GRV-YYYYNNNN for tracking and reference purposes.. Valid values are `^GRV-[0-9]{8}$`',
    `grievance_status` STRING COMMENT 'Current lifecycle status of the grievance case in the investigation and resolution workflow.. Valid values are `filed|under_investigation|pending_review|resolved|closed|appealed`',
    `grievance_type` STRING COMMENT 'Classification of the grievance based on the nature of the complaint: workplace harassment, discrimination, wage dispute, unsafe working conditions, union grievance filing, or retaliation.. Valid values are `workplace_harassment|discrimination|wage_dispute|unsafe_conditions|union_grievance|retaliation`',
    `incident_date` DATE COMMENT 'The date when the alleged incident or violation that prompted the grievance occurred.',
    `incident_location` STRING COMMENT 'Physical or virtual location where the alleged incident occurred (e.g., studio, office, remote work, production site).',
    `investigation_end_date` DATE COMMENT 'The date when the investigation was completed and findings were documented.',
    `investigation_findings` STRING COMMENT 'Summary of the investigation findings, evidence collected, witness statements, and conclusions reached by the investigator.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation of the grievance commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was last updated, reflecting the most recent change to case status or details.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether legal counsel was engaged by either party during the grievance process.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the HR system user who last modified the grievance record.',
    `resolution_date` DATE COMMENT 'The date when the grievance was formally resolved and outcome communicated to involved parties.',
    `resolution_description` STRING COMMENT 'Detailed description of the resolution actions taken, corrective measures implemented, and any remediation provided to the complainant.',
    `resolution_outcome` STRING COMMENT 'Final determination of the grievance investigation: substantiated (complaint upheld), unsubstantiated (complaint not supported), partially substantiated, withdrawn by complainant, or settled through mediation.. Valid values are `substantiated|unsubstantiated|partially_substantiated|withdrawn|settled`',
    `respondent_type` STRING COMMENT 'Classification of the respondent entity: individual employee, manager, department, organization-level, or external party.. Valid values are `employee|manager|department|organization|external_party`',
    `retaliation_reported_flag` BOOLEAN COMMENT 'Indicates whether the complainant reported retaliation following the filing of the grievance.',
    `severity_level` STRING COMMENT 'Assessment of the grievance severity based on potential impact, legal risk, and urgency of resolution required.. Valid values are `low|medium|high|critical`',
    `union_involved_flag` BOOLEAN COMMENT 'Indicates whether a labor union was involved in the grievance filing or resolution process.',
    `union_name` STRING COMMENT 'Name of the labor union representing the complainant or involved in the grievance process, if applicable.',
    `union_representative_name` STRING COMMENT 'Name of the union representative who assisted the complainant or participated in the grievance proceedings.',
    CONSTRAINT pk_workforce_grievance PRIMARY KEY(`workforce_grievance_id`)
) COMMENT 'Transactional record of formal employee grievances, complaints, and HR investigations filed at Media Broadcasting — workplace harassment, discrimination, wage disputes, unsafe working conditions, and union grievance filings. Captures grievance date, grievance type, complainant employee, respondent employee or manager, description of complaint, investigation status, assigned HR investigator, resolution date, resolution outcome, and appeal status. Distinct from talent grievances in the talent domain — this covers internal staff employment disputes only.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount plan record. Primary key for the headcount plan entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically a senior executive or finance leader) who approved this headcount plan. Links to the employee master data.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, cost center) for which this headcount plan is defined. Links to the org_unit master data.',
    `revised_headcount_plan_id` BIGINT COMMENT 'Self-referencing FK on headcount_plan (revised_headcount_plan_id)',
    `approval_date` DATE COMMENT 'The date on which this headcount plan was formally approved by the authorized approver. Marks the transition from draft to approved status.',
    `approved_fte_count` DECIMAL(18,2) COMMENT 'The approved target headcount expressed in Full-Time Equivalent (FTE) units for this org unit, job family, and fiscal year. Represents the authorized staffing level approved by finance and executive leadership.',
    `attrition_assumption_percentage` DECIMAL(18,2) COMMENT 'The assumed annual attrition rate (as a percentage) used in workforce planning for this org unit and job family. Informs net hiring targets and replacement planning.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted compensation and benefits amount allocated for this headcount plan (org unit, job family, fiscal year). Expressed in the budget currency and used for financial planning and variance analysis.',
    `budget_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, GBP, EUR). Supports multi-currency budgeting for global Media Broadcasting operations.. Valid values are `^[A-Z]{3}$`',
    `contractor_fte_count` DECIMAL(18,2) COMMENT 'The planned or approved headcount for contractors and contingent workers expressed in FTE units. Tracked separately from permanent employee FTE for total workforce visibility.',
    `created_by_user` STRING COMMENT 'The user ID or username of the person who created this headcount plan record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_role_flag` BOOLEAN COMMENT 'Indicates whether this headcount plan record covers critical or hard-to-fill roles that require special attention in workforce planning and talent acquisition. True if critical; False otherwise.',
    `current_filled_fte` DECIMAL(18,2) COMMENT 'The current actual headcount in FTE units as of the plan snapshot date. Used to calculate variance against approved FTE and identify open capacity.',
    `diversity_hiring_target_percentage` DECIMAL(18,2) COMMENT 'The target percentage of new hires from underrepresented groups for this org unit and job family. Supports diversity, equity, and inclusion (DEI) goals and regulatory compliance.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this headcount plan applies (e.g., 2024, 2025). Aligns with Media Broadcastings annual budget and planning cycle.',
    `intern_fte_count` DECIMAL(18,2) COMMENT 'The planned or approved headcount for interns and temporary student workers expressed in FTE units. Supports talent pipeline and early career program planning.',
    `job_family` STRING COMMENT 'The job family or functional category for which headcount is planned (e.g., Broadcast Operations, Content Production, Engineering, Sales). Aligns with Media Broadcastings job architecture and talent segmentation. [ENUM-REF-CANDIDATE: broadcast_operations|content_production|engineering|sales|finance|hr|legal|marketing|it|executive — 10 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this headcount plan record. Supports audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was last updated. Supports change tracking and audit trail.',
    `net_hiring_target` STRING COMMENT 'The net number of new hires required to achieve the approved FTE count after accounting for attrition and current filled FTE. Calculated as (approved_fte_count - current_filled_fte + expected_attrition).',
    `open_requisition_count` STRING COMMENT 'The number of open job requisitions currently in the recruitment pipeline for this org unit and job family. Tracks active hiring efforts against the approved plan.',
    `plan_approval_status` STRING COMMENT 'The current approval status of this headcount plan record in the budget and planning workflow. Tracks progression from draft through executive approval.. Valid values are `draft|submitted|under_review|approved|rejected|revised`',
    `plan_effective_end_date` DATE COMMENT 'The date through which this headcount plan remains effective. Typically aligns with the end of the fiscal year or planning period. Null indicates an open-ended plan.',
    `plan_effective_start_date` DATE COMMENT 'The date from which this headcount plan becomes effective. Typically aligns with the start of the fiscal year or the beginning of a planning period.',
    `plan_notes` STRING COMMENT 'Free-text notes and commentary on this headcount plan record. Captures business context, assumptions, constraints, or special considerations for workforce planning.',
    `plan_type` STRING COMMENT 'The type or category of headcount plan (e.g., Annual, Quarterly, Mid-Year Revision, Strategic). Distinguishes between regular annual planning cycles and ad-hoc revisions.. Valid values are `annual|quarterly|mid_year_revision|strategic`',
    `plan_version_code` STRING COMMENT 'Version identifier for the headcount plan (e.g., FY2024-V1, FY2024-V2-REVISED). Supports multiple iterations of the annual plan as revisions are made during budget cycles.. Valid values are `^[A-Z0-9]{2,20}$`',
    `planning_scenario` STRING COMMENT 'The business scenario or strategic context for this headcount plan (e.g., Baseline, Growth, Cost Reduction, Restructuring, Merger Integration). Supports scenario-based workforce planning.. Valid values are `baseline|growth|cost_reduction|restructuring|merger_integration`',
    `remote_work_fte_count` DECIMAL(18,2) COMMENT 'The number of FTEs in this plan designated for remote or hybrid work arrangements. Supports workforce flexibility planning and real estate optimization.',
    `succession_plan_required_flag` BOOLEAN COMMENT 'Indicates whether roles in this headcount plan require formal succession planning due to business criticality or leadership pipeline needs. True if succession planning is required; False otherwise.',
    `union_fte_count` DECIMAL(18,2) COMMENT 'The number of FTEs in this plan covered by collective bargaining agreements or union membership. Critical for labor relations planning and compliance in broadcast operations.',
    `variance_fte` DECIMAL(18,2) COMMENT 'The variance between approved FTE count and current filled FTE. Calculated as (approved_fte_count - current_filled_fte). Positive values indicate unfilled capacity; negative values indicate overstaffing.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Master record for workforce headcount planning at Media Broadcasting — capturing approved headcount targets by org unit, job family, and fiscal year. Captures plan version, fiscal year, org unit, job family, approved FTE count, current filled FTE, open requisition count, attrition assumption percentage, net hiring target, and plan approval status. Supports annual workforce planning cycles, budget submissions to finance, and ongoing headcount variance tracking against approved plan.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the job requisition record. Primary key for the requisition entity.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile defining role requirements, qualifications, and compensation band for this requisition.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or team) requesting the hire.',
    `position_id` BIGINT COMMENT 'Reference to the approved position being filled by this requisition. Links to the position master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this requisition, typically a senior manager or HR director.',
    `replacement_requisition_id` BIGINT COMMENT 'Self-referencing FK on requisition (replacement_requisition_id)',
    `tertiary_requisition_recruiter_employee_id` BIGINT COMMENT 'Reference to the HR recruiter or talent acquisition specialist assigned to manage this requisition.',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval from authorized approvers to proceed with recruiting.',
    `approved_headcount_source` STRING COMMENT 'Source of headcount authorization indicating whether the position is funded from annual budget, supplemental budget, backfill allocation, reallocation, or new approval.. Valid values are `annual_budget|supplemental_budget|backfill|reallocation|new_approval`',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for performance-based bonus compensation.',
    `business_justification` STRING COMMENT 'Detailed explanation of the business need and rationale for opening this requisition, including impact on operations, revenue, or strategic initiatives.',
    `close_date` DATE COMMENT 'Date when the requisition was closed, either due to successful fill, cancellation, or other closure reason.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system.',
    `eeo_job_category` STRING COMMENT 'EEO-1 job category classification for regulatory reporting to the Equal Employment Opportunity Commission.',
    `employment_type` STRING COMMENT 'Type of employment arrangement for the position being filled: full-time, part-time, contract, temporary, intern, or freelance.. Valid values are `full_time|part_time|contract|temporary|intern|freelance`',
    `equity_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for equity compensation such as stock options or restricted stock units.',
    `flsa_classification` STRING COMMENT 'FLSA classification indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the requisition record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was last modified or updated.',
    `number_of_openings` STRING COMMENT 'Total number of positions to be filled under this requisition. Supports bulk hiring for multiple identical roles.',
    `open_date` DATE COMMENT 'Date when the requisition was officially opened and made available for candidate sourcing and recruiting activities.',
    `openings_filled` STRING COMMENT 'Number of positions that have been successfully filled and closed under this requisition.',
    `posting_description` STRING COMMENT 'Full job description text used in external job postings, including responsibilities, qualifications, and company information.',
    `posting_title` STRING COMMENT 'Public-facing job title used in job postings and external advertisements, which may differ from internal job profile title.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency of filling the position.. Valid values are `critical|high|medium|low`',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the position allows remote or hybrid work arrangements.',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition identifier used in HR systems and communications. Externally visible requisition code.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition indicating its stage in the talent acquisition pipeline. [ENUM-REF-CANDIDATE: draft|pending_approval|open|on_hold|filled|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it is for a new position, backfill of a departed employee, replacement, contract-to-hire conversion, internal transfer, or seasonal hire.. Valid values are `new_hire|backfill|replacement|contract_to_hire|internal_transfer|seasonal`',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly rate for the position, defining the upper bound of the compensation band.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly rate for the position, used for candidate expectations and budget planning.',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether the position requires a security clearance or background check due to access to sensitive broadcast content or systems.',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of authorized sourcing channels for candidate recruitment (e.g., internal job board, LinkedIn, agency, referral, campus recruiting).',
    `target_start_date` DATE COMMENT 'Desired start date for the new hire to begin employment. Used for workforce planning and onboarding preparation.',
    `travel_requirement_percentage` STRING COMMENT 'Percentage of time the position requires business travel, expressed as an integer from 0 to 100.',
    `union_name` STRING COMMENT 'Name of the labor union representing this position, if applicable (e.g., IATSE, SAG-AFTRA, NABET-CWA).',
    `union_position` BOOLEAN COMMENT 'Indicates whether the position is covered by a collective bargaining agreement or union contract.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Transactional record of an approved job requisition opened to fill a position at Media Broadcasting — covering new hire requisitions, backfill requisitions, and contract-to-hire conversions. Captures requisition number, position reference, job profile, org unit, hiring manager, recruiter assigned, requisition type, approved headcount source, target start date, requisition open date, requisition status (open/on-hold/filled/cancelled), number of openings, and sourcing channels authorized. The SSOT for talent acquisition pipeline tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique identifier for each job applicant who has applied to a Media Broadcasting requisition. Primary key for the applicant master record.',
    `employee_id` BIGINT COMMENT 'Employee ID of the internal staff member who referred this applicant. Nullable if not an employee referral.',
    `referred_by_applicant_id` BIGINT COMMENT 'Self-referencing FK on applicant (referred_by_applicant_id)',
    `requisition_id` BIGINT COMMENT 'Reference to the job requisition this applicant applied for. Links to the open position posting.',
    `address_line1` STRING COMMENT 'First line of applicants current residential address (street number and name).',
    `address_line2` STRING COMMENT 'Second line of applicants address (apartment, suite, unit number). Nullable.',
    `alternate_phone_number` STRING COMMENT 'Secondary contact phone number for the applicant. Optional backup contact method.',
    `application_date` DATE COMMENT 'Date when the applicant submitted their application for the requisition. Business event timestamp for application lifecycle.',
    `application_number` STRING COMMENT 'Externally-visible unique application tracking number assigned when candidate submits application. Format: APP-YYYYMMDD-sequence.. Valid values are `^APP-[0-9]{8}$`',
    `application_source` STRING COMMENT 'Channel or platform through which the applicant submitted their application (e.g., LinkedIn, Indeed, employee referral, recruitment agency).. Valid values are `linkedin|indeed|glassdoor|company_website|employee_referral|recruitment_agency`',
    `application_status` STRING COMMENT 'Current lifecycle status of the application in the recruitment workflow (e.g., new, screening, interviewed, offer extended, rejected). [ENUM-REF-CANDIDATE: new|screening|interview_scheduled|interviewed|offer_extended|offer_accepted|offer_declined|rejected|withdrawn — 9 candidates stripped; promote to reference product]',
    `background_check_consent` BOOLEAN COMMENT 'Indicates whether the applicant has provided consent for a background check as part of the hiring process. Required for compliance.',
    `city` STRING COMMENT 'City or municipality of applicants current residential address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for applicants current residential address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `cover_letter_reference` STRING COMMENT 'Reference identifier or URI to the applicants cover letter document. Nullable if not provided.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in the ATS (Applicant Tracking System). Audit trail for record creation.',
    `current_employer` STRING COMMENT 'Name of the organization where the applicant is currently employed. Nullable if unemployed or not disclosed.',
    `current_job_title` STRING COMMENT 'Job title or role the applicant currently holds at their present employer. Nullable if unemployed.',
    `degree_field` STRING COMMENT 'Major or field of study for the applicants highest degree (e.g., Communications, Journalism, Film Production, Business Administration).',
    `desired_salary_amount` DECIMAL(18,2) COMMENT 'Salary amount the applicant is seeking for the position. Used for compensation alignment during offer stage.',
    `desired_salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the desired salary amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `disability_status` STRING COMMENT 'Self-reported disability status for OFCCP Section 503 compliance reporting. Collected separately for accommodation and compliance purposes.. Valid values are `has_disability|no_disability|prefer_not_to_say`',
    `earliest_start_date` DATE COMMENT 'Earliest date the applicant is available to begin employment if an offer is extended.',
    `eeoc_ethnicity` STRING COMMENT 'Self-reported ethnicity for EEOC applicant flow reporting. Used for diversity and compliance tracking.. Valid values are `hispanic_latino|not_hispanic_latino|prefer_not_to_say`',
    `eeoc_gender` STRING COMMENT 'Self-reported gender for EEOC applicant flow reporting. Collected separately from application data for compliance purposes.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `eeoc_race` STRING COMMENT 'Self-reported race for EEOC applicant flow reporting. Collected for diversity and compliance tracking purposes.. Valid values are `[ENUM-REF-CANDIDATE: white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native|two_or_more_races|prefer_not_to_say — promote to reference product]`',
    `email_address` STRING COMMENT 'Primary email address for applicant communication throughout the recruitment process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `highest_education_level` STRING COMMENT 'Highest level of formal education completed by the applicant (e.g., high school, bachelor, master, doctorate).. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was last updated. Audit trail for tracking changes to application status or candidate information.',
    `legal_first_name` STRING COMMENT 'Applicants legal first name as it appears on government-issued identification documents.',
    `legal_last_name` STRING COMMENT 'Applicants legal last name (surname/family name) as it appears on government-issued identification.',
    `legal_middle_name` STRING COMMENT 'Applicants legal middle name or initial. Nullable if not provided.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant. Used for interview scheduling and recruitment communication.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of applicants current residential address.',
    `preferred_name` STRING COMMENT 'Name the applicant prefers to be called during the recruitment process. May differ from legal name.',
    `recruitment_agency_name` STRING COMMENT 'Name of the external recruitment or staffing agency that sourced this applicant. Nullable if not agency-sourced.',
    `resume_document_reference` STRING COMMENT 'Reference identifier or URI to the applicants resume/CV document stored in the Media Asset Management (MAM) or document management system.',
    `state_province` STRING COMMENT 'State, province, or region of applicants current residential address.',
    `university_name` STRING COMMENT 'Name of the educational institution where the applicant earned their highest degree.',
    `veteran_status` STRING COMMENT 'Self-reported veteran status for OFCCP (Office of Federal Contract Compliance Programs) compliance reporting.. Valid values are `protected_veteran|not_a_veteran|prefer_not_to_say`',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the applicant is willing to relocate for the position if required.',
    `work_authorization_status` STRING COMMENT 'Applicants legal authorization to work in the country where the position is located (e.g., citizen, permanent resident, work visa, requires sponsorship).. Valid values are `citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized`',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional work experience reported by the applicant. Used for qualification screening.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master record for each job applicant who has applied to a Media Broadcasting requisition — capturing candidate identity, contact information, application source (LinkedIn/Indeed/employee referral/agency), resume reference, application date, current employer, years of experience, highest education level, and consent to background check. Distinct from the employee master — applicants who are hired will have an employee record created upon onboarding. Supports ATS (Applicant Tracking System) integration and EEOC applicant flow reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` (
    `interview_event_id` BIGINT COMMENT 'Unique identifier for each interview event conducted as part of the hiring process.',
    `applicant_id` BIGINT COMMENT 'Reference to the candidate being interviewed for the position.',
    `position_id` BIGINT COMMENT 'Reference to the specific position being filled through this interview process.',
    `employee_id` BIGINT COMMENT 'Reference to the lead interviewer responsible for conducting and documenting this interview.',
    `requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this interview is being conducted.',
    `rescheduled_interview_event_id` BIGINT COMMENT 'Self-referencing FK on interview_event (rescheduled_interview_event_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the interview concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the interview began, which may differ from scheduled time.',
    `advance_to_next_round` BOOLEAN COMMENT 'Indicates whether the candidate should proceed to the next interview round based on this interviews outcome.',
    `assessment_completion_time_minutes` STRING COMMENT 'Time taken by the candidate to complete any technical assessment or skills test, measured in minutes.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score from any technical assessment, coding challenge, or skills test administered during the interview.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the interview was cancelled or rescheduled, if applicable.',
    `candidate_consent_recorded` BOOLEAN COMMENT 'Indicates whether the candidate provided consent for interview recording and data processing in compliance with privacy regulations.',
    `communication_skills_rating` DECIMAL(18,2) COMMENT 'Evaluation of the candidates verbal and written communication abilities during the interview.',
    `concerns_summary` STRING COMMENT 'Summary of any concerns, weaknesses, or red flags identified during the interview process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this interview event record was first created in the system.',
    `cultural_fit_rating` DECIMAL(18,2) COMMENT 'Assessment of how well the candidate aligns with Media Broadcastings organizational culture and values.',
    `duration_minutes` STRING COMMENT 'Total length of the interview in minutes, calculated from actual start and end times.',
    `feedback_notes` STRING COMMENT 'Detailed qualitative feedback and observations recorded by the interviewer(s) regarding the candidates performance, strengths, and areas of concern.',
    `feedback_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the interviewer submitted their feedback and ratings for this interview.',
    `hire_recommendation` STRING COMMENT 'Interviewers recommendation on whether to proceed with hiring this candidate.. Valid values are `strong_hire|hire|maybe|no_hire|strong_no_hire`',
    `interview_format` STRING COMMENT 'Delivery method used to conduct the interview (phone, video conference, in-person meeting, or hybrid).. Valid values are `phone|video|in_person|hybrid`',
    `interview_location` STRING COMMENT 'Physical location, office address, or virtual meeting platform where the interview was conducted.',
    `interview_panel_size` STRING COMMENT 'Total number of interviewers participating in this interview event.',
    `interview_recording_available` BOOLEAN COMMENT 'Indicates whether a recording of the interview is available for review, subject to consent and compliance requirements.',
    `interview_round_number` STRING COMMENT 'Sequential number indicating which round of interviews this represents in the hiring process (e.g., 1 for phone screen, 2 for panel interview, 3 for executive interview).',
    `interview_status` STRING COMMENT 'Current lifecycle status of the interview event itself.. Valid values are `pending|in_progress|completed|cancelled|postponed`',
    `interview_type` STRING COMMENT 'Classification of the interview format and purpose conducted during this event.. Valid values are `phone_screen|video_interview|in_person_interview|panel_interview|technical_assessment|executive_interview`',
    `interviewer_calibration_session` STRING COMMENT 'Reference to any calibration session where this interview was reviewed to ensure consistent evaluation standards across hiring panels.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this interview event record was most recently updated.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system that last modified this interview event record.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Composite numerical rating assigned to the candidate based on interview performance, typically on a scale (e.g., 1.00 to 5.00).',
    `scheduled_date` DATE COMMENT 'The date on which the interview was originally scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the interview was scheduled to conclude.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the interview was scheduled to begin.',
    `scheduling_status` STRING COMMENT 'Current state of the interview scheduling and execution process.. Valid values are `scheduled|confirmed|rescheduled|cancelled|completed|no_show`',
    `strengths_summary` STRING COMMENT 'Summary of the candidates key strengths and positive attributes identified during the interview.',
    `technical_competency_rating` DECIMAL(18,2) COMMENT 'Rating of the candidates technical skills and job-specific competencies demonstrated during the interview.',
    `video_conference_link` STRING COMMENT 'URL or meeting link for virtual interviews conducted via video conferencing platforms.',
    CONSTRAINT pk_interview_event PRIMARY KEY(`interview_event_id`)
) COMMENT 'Transactional record of each interview conducted as part of a Media Broadcasting hiring process — phone screens, video interviews, panel interviews, technical assessments, and executive interviews. Captures interview date, interview type, interviewer(s), applicant reference, requisition reference, interview format (phone/video/in-person), interview scorecard rating, hire/no-hire recommendation, feedback notes, and scheduling status. Enables structured interview process tracking and interviewer calibration across hiring panels.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` (
    `onboarding_task_id` BIGINT COMMENT 'Unique identifier for each onboarding task assigned to a new hire or rehire at Media Broadcasting. Primary key for the onboarding task record.',
    `onboarding_dependency_task_id` BIGINT COMMENT 'Reference to another onboarding task that must be completed before this task can begin. Null if this task has no prerequisites. Enables sequencing of onboarding activities (e.g., system access setup depends on background check clearance).',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, business unit) for which this onboarding task is being performed. Links to the org_unit master record to provide organizational context.',
    `position_id` BIGINT COMMENT 'Reference to the position being filled by the new hire. Links to the position master record to provide organizational context for the onboarding task.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (new hire or rehire) to whom this onboarding task is assigned. Links to the employee master record.',
    `primary_prerequisite_onboarding_task_id` BIGINT COMMENT 'Self-referencing FK on onboarding_task (prerequisite_onboarding_task_id)',
    `tertiary_onboarding_completed_by_employee_id` BIGINT COMMENT 'Reference to the employee who actually completed the task. May differ from assigned owner if task was delegated or reassigned. Links to the employee master record.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing this onboarding task. Used to refine future estimates and identify process improvement opportunities.',
    `approval_date` DATE COMMENT 'Date when the task completion was approved by the designated approver. Null if approval is not required or not yet granted.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this task requires manager or HR approval before being marked as completed. True for tasks with compliance or security implications (e.g., system access setup, background check clearance).',
    `assigned_date` DATE COMMENT 'Date when the onboarding task was assigned to the employee and owner. Typically triggered by hire date confirmation or completion of a prerequisite task.',
    `assigned_owner_role` STRING COMMENT 'Functional role of the person assigned to complete this onboarding task. Indicates which department or function is responsible for task execution. [ENUM-REF-CANDIDATE: hr_specialist|it_administrator|hiring_manager|facilities_coordinator|training_coordinator|union_representative|payroll_administrator — 7 candidates stripped; promote to reference product]',
    `completion_date` DATE COMMENT 'Actual date when the onboarding task was completed successfully. Null if task is not yet completed. Used to calculate onboarding cycle time and identify overdue tasks.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the onboarding task was marked as completed in the system. Provides audit trail for compliance reporting and Service Level Agreement (SLA) tracking.',
    `compliance_requirement_code` STRING COMMENT 'Code identifying the regulatory or compliance requirement that mandates this onboarding task (e.g., IRCA for I-9 verification, FCC for broadcast license verification, OSHA for safety training, GDPR for data privacy training). Null for non-compliance tasks.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_by_user` STRING COMMENT 'User ID or system account that created this onboarding task record. Provides audit trail for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding task record was first created in the system. Provides audit trail for record creation.',
    `documentation_url` STRING COMMENT 'URL or file path to supporting documentation, forms, or instructions for completing this onboarding task. May link to internal knowledge base, policy documents, or training materials.',
    `due_date` DATE COMMENT 'Target date by which the onboarding task must be completed. Calculated based on hire date, task priority, and regulatory requirements (e.g., I-9 must be completed within 3 business days of hire date per federal law).',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete this onboarding task. Used for workload planning and resource allocation across HR, IT, and facilities teams.',
    `is_blocking_task` BOOLEAN COMMENT 'Boolean flag indicating whether this task must be completed before subsequent onboarding tasks can begin. True for critical path tasks (e.g., I-9 verification, background check clearance, system access setup); false for tasks that can proceed in parallel.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this task is mandatory for all new hires (true) or optional/role-specific (false). Mandatory tasks include I-9 verification, benefits enrollment, compliance training; optional tasks may include union card processing (union positions only) or specialized equipment provisioning.',
    `last_modified_by_user` STRING COMMENT 'User ID or system account that last modified this onboarding task record. Provides audit trail for record modifications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding task record was last updated. Provides audit trail for record modifications.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this onboarding task. May include reasons for delays, exceptions granted, or coordination details.',
    `priority_level` STRING COMMENT 'Priority level indicating urgency and importance of the onboarding task. Critical tasks (e.g., I-9 verification) must be completed before employee can start work; high priority tasks should be completed within first week; medium and low priority tasks have more flexible timelines.. Valid values are `critical|high|medium|low`',
    `start_date` DATE COMMENT 'Actual date when work on the onboarding task began. May differ from assigned date if task was queued or awaiting prerequisite completion.',
    `task_category` STRING COMMENT 'High-level category grouping onboarding tasks by functional area: compliance (I-9, background checks), hr_administration (benefits enrollment, payroll setup), it_provisioning (system access, equipment), facilities (badge, workspace), training (orientation, safety, compliance), union_processing (union card, dues setup).. Valid values are `compliance|hr_administration|it_provisioning|facilities|training|union_processing`',
    `task_code` STRING COMMENT 'Standardized code identifying the type of onboarding task (e.g., I9_VERIFY, BG_CHECK, EQUIP_PROV, SYS_ACCESS, BENEFITS_ENROLL, COMPLIANCE_TRAIN, FACILITY_ORIENT, UNION_CARD). Used for task categorization and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `task_description` STRING COMMENT 'Detailed description of the onboarding task, including specific actions required, documentation needed, and any special instructions for completion.',
    `task_name` STRING COMMENT 'Human-readable name of the onboarding task (e.g., I-9 Employment Eligibility Verification, Background Check Clearance, Equipment Provisioning, System Access Setup, Benefits Enrollment, Mandatory Compliance Training, Broadcast Facility Orientation, Union Card Processing).',
    `task_status` STRING COMMENT 'Current lifecycle status of the onboarding task: not_started (assigned but not yet begun), in_progress (actively being worked), pending_approval (awaiting manager or HR approval), completed (finished successfully), cancelled (no longer required), blocked (cannot proceed due to dependency or issue).. Valid values are `not_started|in_progress|pending_approval|completed|cancelled|blocked`',
    CONSTRAINT pk_onboarding_task PRIMARY KEY(`onboarding_task_id`)
) COMMENT 'Transactional record tracking each onboarding task assigned to a new hire or rehire at Media Broadcasting — I-9 verification, background check clearance, equipment provisioning, system access setup, benefits enrollment, mandatory compliance training, broadcast facility orientation, and union card processing. Captures task name, task category, assigned owner (HR/IT/manager), due date, completion date, completion status, and blocking flag (whether subsequent tasks depend on this one). Ensures consistent onboarding across all Media Broadcasting locations and business units.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` (
    `union_membership_id` BIGINT COMMENT 'Unique identifier for the union membership record. Primary key for tracking each employees union affiliation within Media Broadcasting.',
    `employee_id` BIGINT COMMENT 'Reference to the Media Broadcasting employee who holds this union membership. Links to the workforce employee master record.',
    `prior_union_membership_id` BIGINT COMMENT 'Self-referencing FK on union_membership (prior_union_membership_id)',
    `location_id` BIGINT COMMENT 'Reference to the primary work location or facility where this union membership applies. Union contracts may vary by location, and some employees may be covered by different CBAs at different facilities.',
    `bargaining_unit_code` STRING COMMENT 'Code identifying the specific bargaining unit to which this employee belongs. A bargaining unit is a group of employees with a clear community of interest who are represented by a union for collective bargaining purposes. Large employers may have multiple bargaining units for different job families, locations, or divisions.',
    `cba_effective_start_date` DATE COMMENT 'Date when the current collective bargaining agreement became effective and binding. CBAs are typically negotiated for multi-year terms and this date marks the beginning of the current contract period.',
    `cba_expiration_date` DATE COMMENT 'Date when the current collective bargaining agreement expires. Negotiations for a successor agreement typically begin 60-90 days before expiration. If no new agreement is reached, the existing CBA may be extended or employees may work under the expired contract terms while negotiations continue.',
    `cba_reference_code` STRING COMMENT 'Reference code or identifier for the specific collective bargaining agreement that governs this employees terms and conditions of employment. Multiple CBAs may exist for different unions, job classifications, or facilities within Media Broadcasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this union membership record was first created in the system. Used for audit trail and data lineage tracking.',
    `dues_deduction_amount` DECIMAL(18,2) COMMENT 'Amount of union dues deducted from the employees paycheck each pay period. May be a flat amount or a percentage of gross earnings as specified in the collective bargaining agreement. Null if dues deduction is not authorized.',
    `dues_deduction_authorized` BOOLEAN COMMENT 'Indicates whether the employee has authorized automatic payroll deduction of union dues. True means the employee has signed a dues checkoff authorization form and Media Broadcasting deducts dues from each paycheck and remits to the union. False means the employee pays dues directly to the union.',
    `dues_deduction_frequency` STRING COMMENT 'Frequency at which union dues are deducted from the employees paycheck. Must align with the employees pay frequency and union requirements.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `fair_share_fee_payer` BOOLEAN COMMENT 'Indicates whether the employee pays a fair share or agency fee rather than full union dues. In some jurisdictions and under some CBAs, non-members who are covered by the union contract must pay a fee to cover the cost of representation, but this fee is typically lower than full membership dues. This practice varies by state right-to-work laws and recent Supreme Court rulings.',
    `grievance_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to file grievances under the collective bargaining agreements grievance and arbitration procedures. True for members in good standing. False for employees in probationary periods, suspended members, or those who have opted out of union representation where permitted by law.',
    `health_welfare_plan_participant` BOOLEAN COMMENT 'Indicates whether the employee participates in a union-sponsored health and welfare benefit plan. Many unions maintain multi-employer health plans that provide medical, dental, vision, and other benefits funded by employer contributions.',
    `initiation_fee_amount` DECIMAL(18,2) COMMENT 'One-time initiation fee paid by the employee when joining the union. This fee covers administrative costs of processing the membership application and is typically specified in the union constitution. May be paid in a lump sum or through payroll deduction installments.',
    `initiation_fee_paid_date` DATE COMMENT 'Date when the employee completed payment of the union initiation fee. Membership may not be fully active until this fee is paid in full.',
    `job_classification_code` STRING COMMENT 'Union job classification code that determines the employees pay scale, work rules, and benefits under the collective bargaining agreement. Job classifications define specific roles, skill levels, and wage rates negotiated between the union and employer.',
    `job_classification_title` STRING COMMENT 'Descriptive title of the union job classification under which the employee is covered. Examples include Camera Operator, Audio Engineer, Production Assistant, Broadcast Technician, Grip, Electrician, Driver, etc. This may differ from the employees official job title in HR systems.',
    `last_dues_payment_date` DATE COMMENT 'Date of the most recent union dues payment received from or on behalf of this employee. Used to track dues currency and membership good standing status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this union membership record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `membership_end_date` DATE COMMENT 'Date when the employees union membership ended, either through withdrawal, termination of employment, or conversion to retired status. Null for active memberships.',
    `membership_initiation_date` DATE COMMENT 'Date when the employee was formally initiated into union membership and became a full member. This may differ from the hire date if there was a probationary period or if the employee joined the union after starting employment.',
    `membership_status` STRING COMMENT 'Current status of the employees union membership. Active indicates full membership in good standing with dues current. Inactive indicates membership has lapsed or employee is on leave. Suspended indicates temporary suspension due to disciplinary action or non-payment. Pending indicates application submitted but not yet approved. Withdrawn indicates voluntary resignation from union. Retired indicates membership converted to retired status.. Valid values are `active|inactive|suspended|pending|withdrawn|retired`',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this union membership record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this union membership. May include information about dues payment arrangements, membership transfers, special accommodations, or historical context.',
    `pension_plan_participant` BOOLEAN COMMENT 'Indicates whether the employee participates in a union-sponsored pension or retirement plan. Many unions, particularly in broadcasting and entertainment, maintain multi-employer pension plans funded by employer contributions negotiated in the CBA.',
    `probationary_period_end_date` DATE COMMENT 'Date when the employees probationary period under the collective bargaining agreement ends. During probation, employees may have limited rights and protections. After probation ends, employees typically gain full seniority rights, just cause protection, and full grievance rights.',
    `right_to_work_state` BOOLEAN COMMENT 'Indicates whether the employee works in a right-to-work state where union membership and dues payment cannot be required as a condition of employment. This affects whether union security clauses in the CBA apply to this employee.',
    `seniority_date` DATE COMMENT 'Date used to calculate the employees seniority for purposes of layoffs, recalls, shift bidding, vacation scheduling, and other seniority-based rights under the collective bargaining agreement. May be the original hire date or adjusted for breaks in service.',
    `union_local_number` STRING COMMENT 'The local chapter or lodge number of the union to which the employee belongs. Local unions represent members in specific geographic regions or facilities and handle local grievances and contract administration.',
    `union_member_number` STRING COMMENT 'Unique member identification number assigned by the union to this employee. This ID is used for union records, benefit claims, and communications. Different from the employee_id which is Media Broadcastings internal identifier.',
    `union_name` STRING COMMENT 'Name of the labor union or guild to which the employee belongs. Primary unions for Media Broadcasting staff include NABET-CWA (National Association of Broadcast Employees and Technicians - Communications Workers of America) for broadcast engineers and technicians, SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists) for on-air talent, WGA (Writers Guild of America) for writers, IATSE (International Alliance of Theatrical Stage Employees) for production crew, Teamsters for drivers and facilities staff, and DGA (Directors Guild of America) for directors.. Valid values are `NABET-CWA|SAG-AFTRA|WGA|IATSE|Teamsters|DGA`',
    `union_steward_flag` BOOLEAN COMMENT 'Indicates whether the employee serves as a union steward or shop steward. Union stewards are elected or appointed members who represent fellow workers in grievances, workplace disputes, and contract enforcement. Stewards have special protections under labor law and may have release time for union duties.',
    CONSTRAINT pk_union_membership PRIMARY KEY(`union_membership_id`)
) COMMENT 'Master record tracking each Media Broadcasting employees union membership and collective bargaining agreement (CBA) affiliation — NABET-CWA (broadcast engineers/technicians), SAG-AFTRA (on-air staff), WGA (writers), IATSE (production crew), and Teamsters (drivers/facilities). Captures union name, local number, membership status, initiation date, dues deduction authorization, CBA reference, job classification under CBA, and grievance eligibility. Distinct from talent guild affiliations in the talent domain — this covers internal staff union membership only.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` (
    `separation_record_id` BIGINT COMMENT 'Unique identifier for the employee separation record. Primary key for the separation_record product.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division) the employee belonged to at separation.',
    `position_id` BIGINT COMMENT 'Reference to the position the employee held at the time of separation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is separating from Media Broadcasting. Links to the employee master record.',
    `prior_separation_record_id` BIGINT COMMENT 'Self-referencing FK on separation_record (prior_separation_record_id)',
    `quaternary_quinary_separation_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or HR leader who approved the separation. Null if not yet approved.',
    `tertiary_quaternary_separation_initiated_by_employee_id` BIGINT COMMENT 'Reference to the employee or HR user who initiated the separation record in the system.',
    `tertiary_separation_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR business partner who managed the separation process and documentation.',
    `approval_date` DATE COMMENT 'The date the separation was formally approved by the authorized manager or HR leader.',
    `badge_access_revocation_date` DATE COMMENT 'The date physical building access badges and credentials were deactivated. Important for facility security.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA health insurance continuation coverage under federal law.',
    `cobra_notification_date` DATE COMMENT 'The date COBRA continuation coverage notification was sent to the employee. Required within 14 days of separation for compliance.',
    `cost_center_code` STRING COMMENT 'The cost center the employee was assigned to at the time of separation. Used for financial reporting and workforce analytics.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this separation record was first created in the system. Audit trail for record creation.',
    `equipment_return_date` DATE COMMENT 'The date all company equipment was returned by the employee. Null if equipment has not been fully returned.',
    `equipment_return_status` STRING COMMENT 'Status of company equipment return: all returned (complete), partially returned (some items outstanding), not returned (no items returned), or not applicable (no equipment issued).. Valid values are `all_returned|partially_returned|not_returned|not_applicable`',
    `exit_interview_completed_flag` BOOLEAN COMMENT 'Indicates whether an exit interview was conducted with the departing employee. True if completed, False if not completed or declined.',
    `exit_interview_date` DATE COMMENT 'The date the exit interview was conducted. Null if no exit interview was completed.',
    `exit_interview_sentiment` STRING COMMENT 'Overall sentiment classification from the exit interview: positive (employee left on good terms), neutral (professional departure), negative (employee expressed dissatisfaction), or not applicable (no interview conducted).. Valid values are `positive|neutral|negative|not_applicable`',
    `exit_interview_summary` STRING COMMENT 'Summary of key themes and feedback from the exit interview. Confidential HR information used for organizational improvement.',
    `final_paycheck_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the final paycheck before deductions. Includes regular pay, accrued PTO payout, and any other final compensation.',
    `final_paycheck_date` DATE COMMENT 'The date the employees final paycheck was issued, including all outstanding wages, accrued paid time off, and other compensation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this separation record was last updated. Audit trail for tracking changes.',
    `last_working_date` DATE COMMENT 'The last date the employee physically worked or performed duties. May differ from separation date if employee is on garden leave or paid time off during notice period.',
    `non_compete_agreement_flag` BOOLEAN COMMENT 'Indicates whether the employee is bound by a non-compete agreement that restricts employment with competitors for a specified period.',
    `non_compete_expiry_date` DATE COMMENT 'The date the non-compete agreement expires and the employee is free to work for competitors. Null if no non-compete exists.',
    `non_disclosure_agreement_flag` BOOLEAN COMMENT 'Indicates whether the employee is bound by a non-disclosure agreement protecting Media Broadcastings confidential information and trade secrets.',
    `notes` STRING COMMENT 'Free-text field for additional confidential notes, special circumstances, or instructions related to the separation.',
    `notice_date` DATE COMMENT 'The date the employee or employer provided notice of the separation. May be null for immediate terminations or unexpected events.',
    `notice_period_days` STRING COMMENT 'Number of days between notice date and separation date. Used to track compliance with contractual notice requirements.',
    `rehire_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire at Media Broadcasting. True if eligible, False if ineligible due to performance, conduct, or policy violations.',
    `rehire_eligibility_reason` STRING COMMENT 'Explanation for the rehire eligibility determination. Confidential HR information documenting the basis for the decision.',
    `separation_date` DATE COMMENT 'The official date the employees employment relationship with Media Broadcasting ended. Last day of active employment.',
    `separation_number` STRING COMMENT 'Business-facing unique identifier for the separation event, used in HR documentation and communications. Format: SEP-YYYYNNNN.. Valid values are `^SEP-[0-9]{8}$`',
    `separation_reason_code` STRING COMMENT 'Detailed reason code for the separation, providing granular classification beyond separation type (e.g., performance, relocation, better opportunity, misconduct, reduction in force).. Valid values are `^[A-Z0-9]{2,10}$`',
    `separation_reason_description` STRING COMMENT 'Free-text description providing additional context and details about the separation reason. Confidential business information.',
    `separation_status` STRING COMMENT 'Current workflow status of the separation record: initiated, pending approval, approved, processing (offboarding in progress), completed (all tasks done), or cancelled.. Valid values are `initiated|pending_approval|approved|processing|completed|cancelled`',
    `separation_type` STRING COMMENT 'High-level classification of the separation event: voluntary resignation, involuntary termination, retirement, layoff, end of contract, or death.. Valid values are `voluntary_resignation|involuntary_termination|retirement|layoff|contract_end|death`',
    `severance_amount` DECIMAL(18,2) COMMENT 'Total severance payment amount provided to the employee. Null if no severance was offered or employee was ineligible.',
    `severance_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a severance package based on separation type, tenure, and company policy.',
    `severance_payment_date` DATE COMMENT 'The date the severance payment was issued to the employee. Null if no severance was provided.',
    `severance_weeks` DECIMAL(18,2) COMMENT 'Number of weeks of pay provided as severance, typically calculated based on tenure and position level.',
    `system_access_revocation_date` DATE COMMENT 'The date all system access, credentials, and permissions were revoked for the employee. Critical for security and compliance.',
    `unemployment_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee filed for unemployment benefits following separation. Used for tracking and responding to claims.',
    `unemployment_claim_status` STRING COMMENT 'Current status of the unemployment benefits claim: approved, denied, pending review, contested by employer, or not filed.. Valid values are `approved|denied|pending|contested|not_filed`',
    CONSTRAINT pk_separation_record PRIMARY KEY(`separation_record_id`)
) COMMENT 'Transactional record capturing the full details of an employees separation from Media Broadcasting — voluntary resignation, involuntary termination, retirement, layoff, end of contract, or death. Captures separation date, separation type, separation reason code, exit interview completion flag, exit interview sentiment, rehire eligibility flag, final paycheck date, severance package details, non-compete agreement flag, equipment return status, system access revocation date, and COBRA notification date. The authoritative offboarding record feeding payroll final settlement and IT deprovisioning.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` (
    `course_requirement_id` BIGINT COMMENT 'Unique identifier for this course requirement record. Primary key.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to the job profile that has this training course requirement.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to the training course that is required or recommended for the job profile.',
    `applicable_job_profiles` STRING COMMENT 'Comma-separated list of job roles, job families, or organizational units for which this training course is applicable or required (e.g., Broadcast Engineers, Content Producers, Ad Sales Representatives, All Employees). Used to auto-assign training to employees based on their job profile. [Moved from training_course: This denormalized STRING field in training_course contains a comma-separated list of job profiles for which the course is applicable. This is the exact relationship data that should be normalized into the course_requirement association, where each job profile becomes a separate record with its own requirement attributes (is_mandatory, completion_deadline_days, etc.). The denormalized field proves the business operates this way but lacks proper normalization.]',
    `completion_deadline_days` STRING COMMENT 'Number of days from hire date or role assignment by which the employee must complete this training course. Used for onboarding and compliance tracking.',
    `completion_order_sequence` STRING COMMENT 'Recommended or required sequence order for completing this course relative to other courses for this job profile. Supports learning path design where prerequisite courses must be completed before advanced courses.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this course requirement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this training requirement was retired or replaced for this job profile. Null if currently active. Enables historical analysis of training program evolution.',
    `effective_start_date` DATE COMMENT 'Date when this training requirement became effective for this job profile. Supports historical tracking of curriculum changes.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training course is mandatory (true) or optional/recommended (false) for this job profile. Drives compliance tracking and enforcement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this course requirement record was last updated or modified.',
    `recertification_period_months` STRING COMMENT 'Number of months after which employees in this job profile must retake or renew this training course. Supports ongoing compliance for roles requiring periodic recertification (e.g., FCC regulations, safety training).',
    `requirement_rationale` STRING COMMENT 'Business justification for why this course is required for this job profile. Examples: regulatory compliance (FCC, EEO), operational safety, technical competency, leadership development.',
    `waiver_allowed_flag` BOOLEAN COMMENT 'Indicates whether this requirement can be waived for employees in this job profile based on prior experience or equivalent credentials.',
    CONSTRAINT pk_course_requirement PRIMARY KEY(`course_requirement_id`)
) COMMENT 'This association product represents the training curriculum requirement between training courses and job profiles. It captures which courses are mandatory or optional for each job role, completion deadlines, recertification periods, and sequencing requirements. Each record links one training course to one job profile with attributes that define the compliance and learning path requirements for that specific role-course combination. Managed by HR and Learning & Development teams to ensure workforce compliance and skills development.. Existence Justification: This is a genuine operational M:N relationship representing training curriculum requirements managed by HR and Learning & Development teams. A training course applies to multiple job profiles (e.g., FCC Compliance Training required for broadcast engineer, studio director, content scheduler), and each job profile requires multiple training courses (e.g., broadcast engineer needs technical certifications, safety training, regulatory compliance courses). The business actively manages this relationship by defining mandatory vs. optional courses, setting completion deadlines, updating requirements as regulations change, and tracking compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this benefit plan record.',
    `benefit_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this benefit plan record.',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `plan_administrator_employee_id` BIGINT COMMENT '',
    `annual_deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the plan begins coverage. Applicable to health and insurance plans.',
    `annual_out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket in a plan year. Applicable to health and insurance plans.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of costs the employee pays after meeting the deductible. Applicable to health and insurance plans.',
    `compliance_status` STRING COMMENT 'Current compliance status of the benefit plan with respect to regulatory requirements such as ERISA and ACA.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are made for this benefit plan.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the employee pays for covered services at the time of service. Applicable to health plans.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit amount or coverage limit provided by the plan. Applicable to life insurance and disability plans.',
    `coverage_level` STRING COMMENT 'Tier of coverage indicating who is eligible to be covered under the benefit plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `benefit_plan_description` STRING COMMENT 'Detailed description of the benefit plan including coverage details, features, and key terms.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan is no longer available for new enrollments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee contributes per pay period for this benefit plan in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employer contributes per pay period for this benefit plan in USD.',
    `enrollment_close_date` DATE COMMENT 'Date when the annual open enrollment period ends for this benefit plan.',
    `enrollment_eligibility_criteria` STRING COMMENT 'Textual description of the eligibility requirements for employees to enroll in this benefit plan.',
    `enrollment_open_date` DATE COMMENT 'Date when the annual open enrollment period begins for this benefit plan.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether enrollment in this benefit plan is mandatory for all eligible employees.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether employee contributions to this benefit plan are subject to income tax withholding.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit or review conducted for this benefit plan.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified in the system.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit or review of this benefit plan.',
    `notes` STRING COMMENT 'Additional notes or comments about the benefit plan for internal HR reference and administration.',
    `plan_category` STRING COMMENT 'Broader classification grouping for the benefit plan used for reporting and compliance purposes.',
    `plan_code` STRING COMMENT 'Externally-known unique code for the benefit plan used in HR systems and employee communications.',
    `plan_document_url` STRING COMMENT 'Web address or document repository location for the official benefit plan document and summary plan description.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees and in HR documentation.',
    `plan_type` STRING COMMENT 'Category of benefit plan indicating the primary benefit offering type.',
    `plan_year_end_date` DATE COMMENT 'End date of the benefit plan year used for deductibles, maximums, and annual limits.',
    `plan_year_start_date` DATE COMMENT 'Start date of the benefit plan year used for deductibles, maximums, and annual limits.',
    `provider_code` BIGINT COMMENT 'Reference to the benefit provider organization administering this plan.',
    `provider_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan indicating availability for enrollment and administration.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible to enroll in this benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_primary_reports_to_job_profile_id` FOREIGN KEY (`primary_reports_to_job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_previous_employment_record_id` FOREIGN KEY (`previous_employment_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employment_record`(`employment_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_adjusted_payroll_record_id` FOREIGN KEY (`adjusted_payroll_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_superseded_benefit_enrollment_id` FOREIGN KEY (`superseded_benefit_enrollment_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_original_leave_request_id` FOREIGN KEY (`original_leave_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`leave_request`(`leave_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_substitute_employee_id` FOREIGN KEY (`tertiary_leave_substitute_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ADD CONSTRAINT `fk_workforce_leave_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ADD CONSTRAINT `fk_workforce_leave_balance_prior_leave_balance_id` FOREIGN KEY (`prior_leave_balance_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`leave_balance`(`leave_balance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_corrected_timesheet_id` FOREIGN KEY (`corrected_timesheet_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_tertiary_timesheet_modified_by_user_employee_id` FOREIGN KEY (`tertiary_timesheet_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_base_work_schedule_id` FOREIGN KEY (`base_work_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_previous_performance_review_id` FOREIGN KEY (`previous_performance_review_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`performance_review`(`performance_review_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_parent_goal_id` FOREIGN KEY (`parent_goal_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`goal`(`goal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_prerequisite_training_course_id` FOREIGN KEY (`prerequisite_training_course_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_primary_previous_enrollment_training_enrollment_id` FOREIGN KEY (`primary_previous_enrollment_training_enrollment_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_renewed_certification_id` FOREIGN KEY (`renewed_certification_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_escalated_disciplinary_action_id` FOREIGN KEY (`escalated_disciplinary_action_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_issuing_manager_employee_id` FOREIGN KEY (`tertiary_disciplinary_issuing_manager_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ADD CONSTRAINT `fk_workforce_workforce_grievance_escalated_workforce_grievance_id` FOREIGN KEY (`escalated_workforce_grievance_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance`(`workforce_grievance_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ADD CONSTRAINT `fk_workforce_workforce_grievance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ADD CONSTRAINT `fk_workforce_workforce_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ADD CONSTRAINT `fk_workforce_workforce_grievance_tertiary_workforce_employee_id` FOREIGN KEY (`tertiary_workforce_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_revised_headcount_plan_id` FOREIGN KEY (`revised_headcount_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_replacement_requisition_id` FOREIGN KEY (`replacement_requisition_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_tertiary_requisition_recruiter_employee_id` FOREIGN KEY (`tertiary_requisition_recruiter_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_referred_by_applicant_id` FOREIGN KEY (`referred_by_applicant_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_rescheduled_interview_event_id` FOREIGN KEY (`rescheduled_interview_event_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`interview_event`(`interview_event_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_onboarding_dependency_task_id` FOREIGN KEY (`onboarding_dependency_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task`(`onboarding_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_primary_prerequisite_onboarding_task_id` FOREIGN KEY (`primary_prerequisite_onboarding_task_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task`(`onboarding_task_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_tertiary_onboarding_completed_by_employee_id` FOREIGN KEY (`tertiary_onboarding_completed_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ADD CONSTRAINT `fk_workforce_union_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ADD CONSTRAINT `fk_workforce_union_membership_prior_union_membership_id` FOREIGN KEY (`prior_union_membership_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`union_membership`(`union_membership_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_prior_separation_record_id` FOREIGN KEY (`prior_separation_record_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`separation_record`(`separation_record_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_quaternary_quinary_separation_approved_by_employee_id` FOREIGN KEY (`quaternary_quinary_separation_approved_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_tertiary_quaternary_separation_initiated_by_employee_id` FOREIGN KEY (`tertiary_quaternary_separation_initiated_by_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ADD CONSTRAINT `fk_workforce_separation_record_tertiary_separation_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_separation_hr_business_partner_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ADD CONSTRAINT `fk_workforce_course_requirement_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ADD CONSTRAINT `fk_workforce_course_requirement_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_benefit_modified_by_user_employee_id` FOREIGN KEY (`benefit_modified_by_user_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_plan_administrator_employee_id` FOREIGN KEY (`plan_administrator_employee_id`) REFERENCES `vibe_media_broadcasting_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'Active|On Leave|Suspended|Terminated|Retired|Deceased');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Fixed-Term|Seasonal|Intern|Contractor');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Non-Binary|Prefer Not to Disclose|Other');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_business_glossary_term' = 'Home City');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_country_code` SET TAGS ('dbx_business_glossary_term' = 'Home Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Home Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_state_province` SET TAGS ('dbx_business_glossary_term' = 'Home State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `home_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `hr_system_code` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) System Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('dbx_business_glossary_term' = 'Personal Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `personal_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'Voluntary Resignation|Involuntary Termination|Retirement|End of Contract|Layoff|Mutual Agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'Citizen|Permanent Resident|Work Visa|Pending Authorization|Not Authorized');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@mediabroadcasting.(com|net|org)$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `head_count_actual` SET TAGS ('dbx_business_glossary_term' = 'Head Count Actual');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `head_count_budget` SET TAGS ('dbx_business_glossary_term' = 'Head Count Budget');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `is_broadcast_operations` SET TAGS ('dbx_business_glossary_term' = 'Is Broadcast Operations');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `is_content_production` SET TAGS ('dbx_business_glossary_term' = 'Is Content Production');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|suspended|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'division|department|sub_department|team|cost_center|functional_group');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Job Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `primary_reports_to_job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `equity_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|obsolete');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate_degree|bachelor_degree|master_degree|doctoral_degree|professional_certification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `physical_demands` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_business_glossary_term' = 'Preferred Skills');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `required_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Skills');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Maximum');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Midpoint');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Minimum');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_band_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `union_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`job_profile` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'standard_business_hours|shift_work|on_call|flexible|compressed_workweek');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'approved|frozen|pending|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Position Created Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|casual|on-call');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt Position Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Work Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `is_union_position` SET TAGS ('dbx_business_glossary_term' = 'Is Union Position Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Position Last Modified Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|filled|frozen|obsolete|pending-approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|contract|seasonal|project-based|internship');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `requires_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Security Clearance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`position` ALTER COLUMN `vacancy_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Posted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Record Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `previous_employment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Employment Record Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `previous_employment_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `action_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Effective Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `action_processed_by` SET TAGS ('dbx_business_glossary_term' = 'Action Processed By');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|project_based|at_will|union_contract');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_group` SET TAGS ('dbx_business_glossary_term' = 'Employee Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Employee Subgroup');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_action_reason` SET TAGS ('dbx_business_glossary_term' = 'Employment Action Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_action_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Action Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_action_type` SET TAGS ('dbx_value_regex' = 'hire|rehire|transfer|promotion|demotion|secondment');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|on_leave');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalency (FTE) Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_scale_area` SET TAGS ('dbx_business_glossary_term' = 'Pay Scale Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_scale_area` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Scale Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `pay_scale_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `personnel_area` SET TAGS ('dbx_business_glossary_term' = 'Personnel Area');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `personnel_subarea` SET TAGS ('dbx_business_glossary_term' = 'Personnel Subarea');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Weekly Working Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `work_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`employment_record` ALTER COLUMN `work_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Compensation Plan Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_step` SET TAGS ('dbx_business_glossary_term' = 'Pay Step');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|hybrid|contract');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `target_bonus_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `union_scale_applicable` SET TAGS ('dbx_business_glossary_term' = 'Union Scale Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`compensation_plan` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|seasonal|temporary|on-call');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `adjusted_payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Payroll Record Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `adjusted_payroll_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `bonus_pay` SET TAGS ('dbx_business_glossary_term' = 'Bonus Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `commission_pay` SET TAGS ('dbx_business_glossary_term' = 'Commission Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Premium Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withholding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `fsa_deduction` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_business_glossary_term' = 'Wage Garnishment Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Premium Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `hsa_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `local_income_tax` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withholding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax (FICA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_earnings` SET TAGS ('dbx_business_glossary_term' = 'Other Earnings Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct deposit|check|cash|paycard');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|voided|reversed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `pto_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `regular_pay` SET TAGS ('dbx_business_glossary_term' = 'Regular Pay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_business_glossary_term' = '401(k) Retirement Plan Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax (FICA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withholding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`payroll_record` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Premium Deduction');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `superseded_benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Benefit Enrollment Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `superseded_benefit_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contingent_beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Contingent Beneficiary Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contingent_beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contingent_beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contingent_beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Contingent Beneficiary Relationship');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_frequency` SET TAGS ('dbx_value_regex' = 'per_pay_period|monthly|quarterly|annually|one_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_frequency` SET TAGS ('dbx_value_regex' = 'per_pay_period|monthly|quarterly|annually|one_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^BEN-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|qualifying_life_event|annual_reenrollment|plan_change|rehire');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|terminated|suspended|cancelled|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|incomplete');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_beneficiary_percentage` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Relationship');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `wellness_program_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Participant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Original Leave Request Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Days Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_hours_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|withdrawn');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = 'staffing_shortage|blackout_period|insufficient_notice|policy_violation|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_certification_date` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Certification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_certification_status` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Certification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_certification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|received|approved|insufficient');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Protected Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|fmla|parental|bereavement|jury_duty');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `paid_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `reduced_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Reduced Schedule Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `total_days_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Days Requested');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_request` ALTER COLUMN `total_hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Requested');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `leave_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `prior_leave_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Leave Balance Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `prior_leave_balance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `accrual_cap` SET TAGS ('dbx_business_glossary_term' = 'Accrual Cap');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `accrual_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `accrual_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `accrued_current_period` SET TAGS ('dbx_business_glossary_term' = 'Accrued Current Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `adjusted_balance` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As Of Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `carried_over_balance` SET TAGS ('dbx_business_glossary_term' = 'Carried Over Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `carryover_cap` SET TAGS ('dbx_business_glossary_term' = 'Carryover Cap');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `forfeited_balance` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `last_accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accrual Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `leave_type_name` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `pending_requests` SET TAGS ('dbx_business_glossary_term' = 'Pending Requests');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `policy_tier` SET TAGS ('dbx_business_glossary_term' = 'Policy Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `projected_year_end_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Year End Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hours|days');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`leave_balance` ALTER COLUMN `used_current_period` SET TAGS ('dbx_business_glossary_term' = 'Used Current Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `corrected_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Timesheet Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `corrected_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `tertiary_timesheet_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `tertiary_timesheet_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `tertiary_timesheet_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_revision|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double-Time Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `holiday_hours` SET TAGS ('dbx_business_glossary_term' = 'Holiday Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `on_call_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Call Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `pto_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_value_regex' = '^TS-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `total_hours_approved` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Approved');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `total_hours_submitted` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Submitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `unpaid_leave_hours` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Leave Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`timesheet` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `base_work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Base Work Schedule Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `base_work_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `applicable_job_families` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Families');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `applicable_org_units` SET TAGS ('dbx_business_glossary_term' = 'Applicable Organizational Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `daypart_classification` SET TAGS ('dbx_business_glossary_term' = 'Daypart Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Days of Week');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `holiday_work_required` SET TAGS ('dbx_business_glossary_term' = 'Holiday Work Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `meal_break_required` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `on_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'On-Call Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `on_call_frequency` SET TAGS ('dbx_value_regex' = 'none|weekly|biweekly|monthly|as_needed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `on_call_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'On-Call Response Time Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `overtime_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Calculation Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `overtime_calculation_basis` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Threshold Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `paid_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `requires_broadcast_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Broadcast License');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `rest_period_between_shifts_hours` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Between Shifts Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `rotation_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|rotating|on_call|compressed|flexible|split_shift');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `shift_differential_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `total_weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Weekly Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`work_schedule` ALTER COLUMN `weekend_work_required` SET TAGS ('dbx_business_glossary_term' = 'Weekend Work Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `previous_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Performance Review Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `previous_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Adjustment Recommended Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommended_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommended_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `dispute_comments` SET TAGS ('dbx_business_glossary_term' = 'Dispute Comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `dispute_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Dispute Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `final_approved_rating` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `innovation_rating` SET TAGS ('dbx_business_glossary_term' = 'Innovation Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `recommended_compensation_adjustment_percent` SET TAGS ('dbx_business_glossary_term' = 'Recommended Compensation Adjustment Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `recommended_compensation_adjustment_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Review Acknowledgement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|quarterly|ad_hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_id` SET TAGS ('dbx_business_glossary_term' = 'Goal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Goal Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revision_requested');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'individual|team|organizational|departmental|project|strategic');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goal Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Current Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `employee_notes` SET TAGS ('dbx_business_glossary_term' = 'Employee Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_business_glossary_term' = 'Goal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|behavioral|developmental|operational|strategic');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Goal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `is_stretch_goal` SET TAGS ('dbx_business_glossary_term' = 'Is Stretch Goal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `manager_notes` SET TAGS ('dbx_business_glossary_term' = 'Manager Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `okr_alignment` SET TAGS ('dbx_business_glossary_term' = 'Objectives and Key Results (OKR) Alignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `progress_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Progress Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Goal Visibility Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `visibility_level` SET TAGS ('dbx_value_regex' = 'private|manager|department|organization|public');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`goal` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Training Course Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_training_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_category` SET TAGS ('dbx_value_regex' = 'broadcast_operations|regulatory_compliance|technical_skills|leadership_development|cybersecurity|editorial_standards');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'instructor_led|e_learning|blended|virtual_classroom|on_the_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Course Prerequisites');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external|vendor|industry_association|regulatory_body');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `recertification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Period Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_course` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `primary_previous_enrollment_training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Enrollment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not-required|incomplete');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^CERT-[A-Z0-9]{10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrolled_by_user` SET TAGS ('dbx_business_glossary_term' = 'Enrolled By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in-progress|completed|failed|withdrawn|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|recommended|compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Training Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `is_recertification` SET TAGS ('dbx_business_glossary_term' = 'Is Recertification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `number_of_attempts` SET TAGS ('dbx_business_glossary_term' = 'Number of Assessment Attempts');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'in-person|virtual|online|blended|on-the-job');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_hours_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Scheduled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`training_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `renewed_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Certification Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `renewed_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_verification|in_progress');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'regulatory_license|professional_certification|technical_certification|vendor_certification|industry_credential');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Completed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `employer_sponsored` SET TAGS ('dbx_business_glossary_term' = 'Employer Sponsored');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `exam_score` SET TAGS ('dbx_business_glossary_term' = 'Exam Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `is_required_for_role` SET TAGS ('dbx_business_glossary_term' = 'Is Required for Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'entry|associate|professional|expert|master');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'online_registry|issuer_confirmation|document_review|third_party_service|self_attestation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `escalated_disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated Disciplinary Action Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `escalated_disciplinary_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_issuing_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Manager ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_issuing_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_issuing_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|active|completed|overturned|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_warning|performance_improvement_plan|suspension|termination_for_cause');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_response` SET TAGS ('dbx_business_glossary_term' = 'Employee Response');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_response` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|in_progress|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `pip_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_violated` SET TAGS ('dbx_business_glossary_term' = 'Policy Violated');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Paid Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Triggered Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `union_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `union_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Union Notified Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `workforce_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Grievance ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `escalated_workforce_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated Workforce Grievance Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `escalated_workforce_grievance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Department ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `tertiary_workforce_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `tertiary_workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `tertiary_workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|dismissed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `complaint_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|restricted');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_value_regex' = 'none|verbal_warning|written_warning|suspension|termination|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `external_agency_name` SET TAGS ('dbx_business_glossary_term' = 'External Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `external_agency_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'External Agency Reported Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `external_case_number` SET TAGS ('dbx_business_glossary_term' = 'External Case Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `filed_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_value_regex' = '^GRV-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'filed|under_investigation|pending_review|resolved|closed|appealed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'workplace_harassment|discrimination|wage_dispute|unsafe_conditions|union_grievance|retaliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|partially_substantiated|withdrawn|settled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `respondent_type` SET TAGS ('dbx_value_regex' = 'employee|manager|department|organization|external_party');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `retaliation_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Retaliation Reported Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `union_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Involved Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`workforce_grievance` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'hiring_onboarding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `revised_headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Headcount Plan Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `revised_headcount_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `attrition_assumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Assumption Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `contractor_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `diversity_hiring_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hiring Target Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `intern_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Intern Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `net_hiring_target` SET TAGS ('dbx_business_glossary_term' = 'Net Hiring Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|revised');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|mid_year_revision|strategic');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'baseline|growth|cost_reduction|restructuring|merger_integration');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `remote_work_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `succession_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `union_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Union Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`headcount_plan` ALTER COLUMN `variance_fte` SET TAGS ('dbx_business_glossary_term' = 'Variance Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'hiring_onboarding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `replacement_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Requisition Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `replacement_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `tertiary_requisition_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `approved_headcount_source` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `approved_headcount_source` SET TAGS ('dbx_value_regex' = 'annual_budget|supplemental_budget|backfill|reallocation|new_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern|freelance');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `equity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `openings_filled` SET TAGS ('dbx_business_glossary_term' = 'Openings Filled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `posting_description` SET TAGS ('dbx_business_glossary_term' = 'Posting Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `posting_title` SET TAGS ('dbx_business_glossary_term' = 'Posting Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_hire|backfill|replacement|contract_to_hire|internal_transfer|seasonal');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`requisition` ALTER COLUMN `union_position` SET TAGS ('dbx_business_glossary_term' = 'Union Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'hiring_onboarding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Applicant Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_source` SET TAGS ('dbx_value_regex' = 'linkedin|indeed|glassdoor|company_website|employee_referral|recruitment_agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `background_check_consent` SET TAGS ('dbx_business_glossary_term' = 'Background Check Consent');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `cover_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field of Study');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Desired Salary Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Desired Salary Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'has_disability|no_disability|prefer_not_to_say');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `earliest_start_date` SET TAGS ('dbx_business_glossary_term' = 'Earliest Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'EEOC (Equal Employment Opportunity Commission) Ethnicity');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_ethnicity` SET TAGS ('dbx_value_regex' = 'hispanic_latino|not_hispanic_latino|prefer_not_to_say');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_business_glossary_term' = 'EEOC (Equal Employment Opportunity Commission) Gender');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_race` SET TAGS ('dbx_business_glossary_term' = 'EEOC (Equal Employment Opportunity Commission) Race');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_race` SET TAGS ('dbx_value_regex' = '[ENUM-REF-CANDIDATE: white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native|two_or_more_races|prefer_not_to_say — promote to reference product]');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `eeoc_race` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `recruitment_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `resume_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Resume Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `university_name` SET TAGS ('dbx_business_glossary_term' = 'University or Institution Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'protected_veteran|not_a_veteran|prefer_not_to_say');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `willing_to_relocate` SET TAGS ('dbx_business_glossary_term' = 'Willing to Relocate');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` SET TAGS ('dbx_subdomain' = 'hiring_onboarding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Event Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Interviewer Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `rescheduled_interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Interview Event Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `rescheduled_interview_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `advance_to_next_round` SET TAGS ('dbx_business_glossary_term' = 'Advance to Next Round Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `assessment_completion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Time in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Assessment Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `candidate_consent_recorded` SET TAGS ('dbx_business_glossary_term' = 'Candidate Consent Recorded Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `communication_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Skills Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `concerns_summary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Concerns Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `concerns_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `cultural_fit_rating` SET TAGS ('dbx_business_glossary_term' = 'Cultural Fit Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interview Duration in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `feedback_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Feedback Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `feedback_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `feedback_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `hire_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Hire Recommendation');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `hire_recommendation` SET TAGS ('dbx_value_regex' = 'strong_hire|hire|maybe|no_hire|strong_no_hire');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_format` SET TAGS ('dbx_business_glossary_term' = 'Interview Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_format` SET TAGS ('dbx_value_regex' = 'phone|video|in_person|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_location` SET TAGS ('dbx_business_glossary_term' = 'Interview Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_panel_size` SET TAGS ('dbx_business_glossary_term' = 'Interview Panel Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_recording_available` SET TAGS ('dbx_business_glossary_term' = 'Interview Recording Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_round_number` SET TAGS ('dbx_business_glossary_term' = 'Interview Round Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_status` SET TAGS ('dbx_business_glossary_term' = 'Interview Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_type` SET TAGS ('dbx_business_glossary_term' = 'Interview Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interview_type` SET TAGS ('dbx_value_regex' = 'phone_screen|video_interview|in_person_interview|panel_interview|technical_assessment|executive_interview');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `interviewer_calibration_session` SET TAGS ('dbx_business_glossary_term' = 'Interviewer Calibration Session Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Interview Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Interview Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|rescheduled|cancelled|completed|no_show');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Strengths Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`interview_event` ALTER COLUMN `video_conference_link` SET TAGS ('dbx_business_glossary_term' = 'Video Conference Link');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` SET TAGS ('dbx_subdomain' = 'hiring_onboarding');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `onboarding_task_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `onboarding_dependency_task_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Task Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `primary_prerequisite_onboarding_task_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Onboarding Task Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `primary_prerequisite_onboarding_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_completed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Completed By Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_completed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_completed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Spent');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Task Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `assigned_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `compliance_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `compliance_requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Task Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Task Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours to Complete');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `is_blocking_task` SET TAGS ('dbx_business_glossary_term' = 'Is Blocking Task Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Task Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Task Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Task Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_category` SET TAGS ('dbx_value_regex' = 'compliance|hr_administration|it_provisioning|facilities|training|union_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_code` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|pending_approval|completed|cancelled|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `prior_union_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Union Membership Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `prior_union_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `bargaining_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `cba_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `cba_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Reference Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `dues_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Dues Deduction Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `dues_deduction_authorized` SET TAGS ('dbx_business_glossary_term' = 'Dues Deduction Authorized Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `dues_deduction_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dues Deduction Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `dues_deduction_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `fair_share_fee_payer` SET TAGS ('dbx_business_glossary_term' = 'Fair Share Fee Payer Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `grievance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Grievance Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `health_welfare_plan_participant` SET TAGS ('dbx_business_glossary_term' = 'Health and Welfare Plan Participant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `health_welfare_plan_participant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `health_welfare_plan_participant` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `initiation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Initiation Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `initiation_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Initiation Fee Paid Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `job_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `job_classification_title` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dues Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `membership_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Initiation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|withdrawn|retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `pension_plan_participant` SET TAGS ('dbx_business_glossary_term' = 'Pension Plan Participant Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `probationary_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probationary Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `right_to_work_state` SET TAGS ('dbx_business_glossary_term' = 'Right-to-Work State Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `seniority_date` SET TAGS ('dbx_business_glossary_term' = 'Seniority Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_member_number` SET TAGS ('dbx_business_glossary_term' = 'Union Member Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_name` SET TAGS ('dbx_value_regex' = 'NABET-CWA|SAG-AFTRA|WGA|IATSE|Teamsters|DGA');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`union_membership` ALTER COLUMN `union_steward_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Steward Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Record Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `prior_separation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Separation Record Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `prior_separation_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `quaternary_quinary_separation_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `quaternary_quinary_separation_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `quaternary_quinary_separation_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_quaternary_separation_initiated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_quaternary_separation_initiated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_quaternary_separation_initiated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_separation_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_separation_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `tertiary_separation_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `badge_access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Badge Access Revocation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `cobra_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `equipment_return_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_value_regex' = 'all_returned|partially_returned|not_returned|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Sentiment');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|not_applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_summary` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `exit_interview_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `final_paycheck_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Paycheck Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `final_paycheck_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `final_paycheck_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `final_paycheck_date` SET TAGS ('dbx_business_glossary_term' = 'Final Paycheck Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `last_working_date` SET TAGS ('dbx_business_glossary_term' = 'Last Working Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `non_compete_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Agreement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `non_compete_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `non_disclosure_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Separation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `rehire_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `rehire_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `rehire_eligibility_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_number` SET TAGS ('dbx_business_glossary_term' = 'Separation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_number` SET TAGS ('dbx_value_regex' = '^SEP-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_status` SET TAGS ('dbx_business_glossary_term' = 'Separation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_status` SET TAGS ('dbx_value_regex' = 'initiated|pending_approval|approved|processing|completed|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|retirement|layoff|contract_end|death');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_amount` SET TAGS ('dbx_business_glossary_term' = 'Severance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Severance Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Severance Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_weeks` SET TAGS ('dbx_business_glossary_term' = 'Severance Weeks');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `severance_weeks` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `system_access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'System Access Revocation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `unemployment_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Unemployment Claim Filed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `unemployment_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Unemployment Claim Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`separation_record` ALTER COLUMN `unemployment_claim_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|contested|not_filed');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` SET TAGS ('dbx_association_edges' = 'workforce.training_course,workforce.job_profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `course_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Course Requirement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Course Requirement - Job Profile Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Requirement - Training Course Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `applicable_job_profiles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Profiles');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `completion_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Completion Deadline Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `completion_order_sequence` SET TAGS ('dbx_business_glossary_term' = 'Completion Order Sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `recertification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Period Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `requirement_rationale` SET TAGS ('dbx_business_glossary_term' = 'Requirement Rationale');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`course_requirement` ALTER COLUMN `waiver_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Benefit Plan Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `annual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `annual_out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Annual Out Of Pocket Maximum');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_close_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Criteria');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_open_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`workforce`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Days');
