-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`workforce` COMMENT 'Owns human capital and workforce management data. Manages employee master records, organizational structure, payroll, benefits, talent acquisition, performance management, compensation, workforce planning, OSHA safety incident records, training records, and labor compliance across manufacturing and commercial operations. Integrates with Workday HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity.',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager or supervisor to whom this employee reports. Used for organizational hierarchy and reporting structure.',
    `org_unit_id` BIGINT COMMENT 'The org unit id of the employee record',
    `position_id` BIGINT COMMENT 'The position id of the employee record',
    `work_location_id` BIGINT COMMENT 'The work location id of the employee record',
    `business_unit` STRING COMMENT 'High-level organizational division or business unit to which the employee belongs (e.g., Manufacturing, Sales, R&D, Supply Chain).',
    `cba_reference` STRING COMMENT 'Reference identifier or name of the collective bargaining agreement that governs the employees terms and conditions, if applicable. Null for non-union employees.',
    `contract_end_date` DATE COMMENT 'Scheduled end date of the current employment contract. Null for permanent or at-will contracts without a defined end date.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current employment contract or agreement.',
    `contract_type` STRING COMMENT 'Type of employment contract governing the employees terms: permanent (indefinite), fixed-term (specific end date), at-will (terminable by either party), or project-based (tied to specific project completion).. Valid values are `permanent|fixed-term|at-will|project-based`',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the employees compensation and expenses are allocated. Used for budgeting and financial reporting.',
    `country_code` STRING COMMENT 'The country code of the employee record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the employee record',
    `date_of_birth` DATE COMMENT 'The date of birth of the employee record',
    `department` STRING COMMENT 'Specific department within the business unit where the employee works (e.g., Quality Control, Brand Marketing, Procurement).',
    `email` STRING COMMENT 'The email of the employee record',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee for business communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to be contacted in case of an emergency involving the employee.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend).',
    `employee_number` STRING COMMENT 'The employee number of the employee record',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee: active (working), inactive (not currently working), leave (on approved leave), terminated (employment ended), suspended (temporarily not working), or probation (trial period).. Valid values are `active|inactive|leave|terminated|suspended|probation`',
    `employment_type` STRING COMMENT 'Classification of the employees working arrangement: full-time, part-time, contract, seasonal, temporary, or intern.. Valid values are `full-time|part-time|contract|seasonal|temporary|intern`',
    `first_name` STRING COMMENT 'The first name of the employee record',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the employee is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non-exempt`',
    `full_name` STRING COMMENT 'The full name of the employee record',
    `gender` STRING COMMENT 'The gender of the employee record',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used for tenure calculations, benefits eligibility, and anniversary tracking.',
    `job_code` STRING COMMENT 'Standardized internal code representing the job classification or position type. Used for compensation benchmarking, workforce planning, and reporting.',
    `job_title` STRING COMMENT 'Official job title or position name assigned to the employee (e.g., Manufacturing Supervisor, Sales Representative, Quality Analyst).',
    `last_name` STRING COMMENT 'The last name of the employee record',
    `legal_first_name` STRING COMMENT 'Employees legal first name as it appears on government-issued identification and payroll records.',
    `legal_last_name` STRING COMMENT 'Employees legal last name (surname/family name) as it appears on government-issued identification and payroll records.',
    `legal_middle_name` STRING COMMENT 'Employees legal middle name or initial as it appears on government-issued identification.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for payroll, tax reporting, and legal compliance.',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required for voluntary resignation or termination as specified in the employment contract.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employees position. Used for salary administration and compensation planning.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee (mobile or desk phone).',
    `plant_site_code` STRING COMMENT 'Code identifying the physical manufacturing plant, distribution center, office location, or field territory where the employee is primarily assigned.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions, which may differ from legal name.',
    `probation_end_date` DATE COMMENT 'Date when the employees probationary period ends. Null if probation has been completed or does not apply.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified in the system.',
    `shift_pattern` STRING COMMENT 'Standard shift schedule or rotation pattern assigned to the employee (e.g., day shift, night shift, rotating 3-shift, 4-on-4-off). Particularly relevant for manufacturing and distribution center workers.',
    `source_system_code` STRING COMMENT 'The source system code of the employee record',
    `standard_working_hours_per_week` DECIMAL(18,2) COMMENT 'Contractual number of hours the employee is expected to work per week (e.g., 40.00 for full-time, 20.00 for part-time).',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for offboarding, final payroll, and compliance reporting.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for employment termination (e.g., voluntary resignation, involuntary termination, retirement, end of contract). Null for active employees.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union or covered by a collective bargaining agreement.',
    `union_name` STRING COMMENT 'Name of the labor union to which the employee belongs, if applicable. Null for non-union employees.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the employee record',
    `work_location_city` STRING COMMENT 'City where the employees primary work location is situated.',
    `work_location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the employee primarily works (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `work_location_state_province` STRING COMMENT 'State, province, or region where the employees primary work location is situated.',
    `workday_worker_code` STRING COMMENT 'External system identifier from Workday HCM. Used for integration and reconciliation with the source system of record.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master record for every worker across manufacturing plants, commercial offices, distribution centers, and field sales teams. Stores legal name, employee ID, national ID, employment type (full-time, part-time, contract, seasonal), hire date, termination date, employment status, job title, job code, cost center, business unit, plant/site assignment, manager reference, pay grade, FLSA classification, union membership flag, Workday HCM worker ID, contract terms (type, notice period, probation, working hours, shift pattern, CBA reference), emergency contact, and employment action history (hire, promotion, transfer, termination, LOA with effective dates and reason codes). SSOT for all workforce identity, employment lifecycle, and worker demographic data integrated from Workday HCM.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key for the org_unit data product.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables multi-level org hierarchy traversal for reporting and analytics. Null for top-level units.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation for this organizational unit in the reporting currency. Used for financial planning and variance analysis.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount. Supports multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `business_unit_code` STRING COMMENT 'Business unit or division code for management reporting and performance analysis. Supports segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit. Used in reporting, financial systems, and operational processes. Must be unique within the enterprise.. Valid values are `^[A-Z0-9]{2,20}$`',
    `company_code` STRING COMMENT 'Legal entity or company code to which this organizational unit belongs. Used for statutory reporting and financial consolidation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this organizational unit is domiciled. Used for regulatory compliance and labor law adherence.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or system identifier of the person or process that created this organizational unit record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_headcount` STRING COMMENT 'Current number of employees assigned to this organizational unit. Updated periodically for workforce analytics and reporting.',
    `org_unit_description` STRING COMMENT 'Detailed business description of the organizational units purpose, responsibilities, and scope within the enterprise.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased or will cease to be active. Null for currently active units. Enables point-in-time org structure reconstruction.',
    `effective_from` DATE COMMENT 'The effective from of the org unit record',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become active and operational. Supports temporal hierarchy analysis and historical reporting.',
    `effective_until` DATE COMMENT 'The effective until of the org unit record',
    `external_code` STRING COMMENT 'External system identifier or legacy code for this organizational unit. Used for integration with third-party systems and data migration tracking.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting labor costs and expenses associated with this organizational unit. Supports financial consolidation and reporting.. Valid values are `^[0-9]{4,10}$`',
    `headcount_capacity` STRING COMMENT 'Maximum planned headcount capacity for this organizational unit. Used in workforce planning and S&OP labor capacity analysis.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this organizational unit in the enterprise hierarchy. Level 1 is top-level, increasing numbers indicate deeper nesting. Supports hierarchy traversal and reporting.',
    `is_commercial_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is a commercial or sales unit. Used to segment commercial workforce for sales force automation and trade promotion planning.',
    `is_manufacturing_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is a manufacturing or production unit. Used to segment manufacturing workforce from commercial operations.',
    `is_support_function` BOOLEAN COMMENT 'Indicates whether this organizational unit is a corporate support function (HR, Finance, IT, Legal). Used for overhead allocation and indirect labor analysis.',
    `last_modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this organizational unit record. Supports change management and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last updated. Supports change tracking and data quality monitoring.',
    `location_code` STRING COMMENT 'Physical location or site code where this organizational unit operates. Used for facility management and workforce planning.. Valid values are `^[A-Z0-9]{2,15}$`',
    `org_unit_name` STRING COMMENT 'Full business name of the organizational unit as it appears in corporate communications and reporting.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and can have employees assigned. Inactive or closed units are historical.. Valid values are `active|inactive|pending|closed|suspended|planned`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit indicating its role in the enterprise hierarchy. Supports segmentation for headcount reporting and S&OP workforce planning. [ENUM-REF-CANDIDATE: department|division|business_unit|plant|region|team|cost_center|function|subsidiary|branch — 10 candidates stripped; promote to reference product]',
    `plant_code` STRING COMMENT 'Manufacturing plant or production facility code for plant-level organizational units. Supports MES integration and production workforce planning.. Valid values are `^[A-Z0-9]{2,10}$`',
    `region_code` STRING COMMENT 'Geographic region code for regional organizational units. Supports geographic segmentation in sales and operations planning.. Valid values are `^[A-Z0-9]{2,10}$`',
    `safety_classification` STRING COMMENT 'OSHA safety risk classification for this organizational unit based on work environment and hazard exposure. Used for safety incident tracking and compliance reporting.. Valid values are `low_risk|moderate_risk|high_risk|critical_risk`',
    `short_name` STRING COMMENT 'Abbreviated or short name of the organizational unit for display in constrained UI contexts and reports.',
    `source_system_code` STRING COMMENT 'The source system code of the org unit record',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union. Used for labor compliance and collective bargaining agreement tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the org unit record',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy unit representing departments, divisions, business units, cost centers, and plant-level teams within the consumer goods enterprise. Stores org unit code, name, org unit type (department, division, plant, region, team), parent org unit reference, effective date range, cost center code, GL account mapping, and responsible manager. Supports multi-level org hierarchy traversal for headcount reporting, labor cost allocation, and S&OP workforce planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the approved headcount position within the organizational structure. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the financial responsibility for this positions compensation and benefits.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the role responsibilities, competencies, and requirements for this position.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or business unit) to which this position belongs.',
    `primary_supervisor_position_id` BIGINT COMMENT 'Reference to the position that supervises this position, establishing the reporting hierarchy within the organizational structure.',
    `work_location_id` BIGINT COMMENT 'Reference to the primary work location (plant, site, office, distribution center) where this position is based.',
    `budgeted_headcount` DECIMAL(18,2) COMMENT 'The approved headcount allocation for this position in the annual workforce budget. May differ from FTE for shared or split positions.',
    `position_code` STRING COMMENT 'Business identifier for the position, typically a human-readable alphanumeric code used across HR systems and organizational charts.. Valid values are `^[A-Z0-9]{6,12}$`',
    `compensation_grade` STRING COMMENT 'The compensation grade or pay band assigned to this position, defining the salary range and compensation structure.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this position record was first created in the system.',
    `critical_position_flag` BOOLEAN COMMENT 'Indicates whether this position is designated as business-critical, requiring succession planning and priority filling due to its impact on operations.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when this position was or will be eliminated or made inactive. Null for positions with no planned end date.',
    `effective_from` DATE COMMENT 'The effective from of the position record',
    `effective_start_date` DATE COMMENT 'The date when this position became active and available for assignment within the organizational structure.',
    `effective_until` DATE COMMENT 'The effective until of the position record',
    `employment_type` STRING COMMENT 'Classification of the position based on working hours commitment (full-time, part-time, casual, or on-call).. Valid values are `full_time|part_time|casual|on_call`',
    `flsa_classification` STRING COMMENT 'Classification under the U.S. Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `fte` DECIMAL(18,2) COMMENT 'The fte of the position record',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The full-time equivalent allocation for this position expressed as a decimal (1.0000 = full-time, 0.5000 = half-time). Used for workforce planning and labor budget calculations.',
    `grade_level` STRING COMMENT 'The grade level of the position record',
    `incumbent_employee_id` BIGINT COMMENT 'The incumbent employee id of the position record',
    `is_vacant` BOOLEAN COMMENT 'The is vacant of the position record',
    `job_family` STRING COMMENT 'Broad occupational category or job family to which this position belongs (e.g., Manufacturing Operations, Supply Chain, Sales, Quality Assurance, R&D).',
    `job_level` STRING COMMENT 'Hierarchical level or grade of the position within the organizations job architecture (e.g., entry-level, mid-level, senior, executive).',
    `last_modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this position record was last updated or modified.',
    `max_salary_range` DECIMAL(18,2) COMMENT 'The maximum annual salary for this position based on its compensation grade and market data.',
    `min_salary_range` DECIMAL(18,2) COMMENT 'The minimum annual salary for this position based on its compensation grade and market data.',
    `minimum_education_level` STRING COMMENT 'The minimum educational qualification required for this position (e.g., High School Diploma, Bachelors Degree, Masters Degree).',
    `minimum_experience_years` STRING COMMENT 'The minimum number of years of relevant work experience required for this position.',
    `occupancy_status` STRING COMMENT 'Indicates whether the position is currently filled by an employee, vacant and available for recruitment, or partially filled (for positions with multiple incumbents or job-sharing arrangements).. Valid values are `filled|vacant|partially_filled`',
    `pay_grade` STRING COMMENT 'The pay grade of the position record',
    `position_status` STRING COMMENT 'Current lifecycle status of the position indicating whether it is active and available for filling, frozen due to budget constraints, eliminated, proposed for future creation, or pending approval.. Valid values are `active|frozen|eliminated|proposed|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature (permanent full-time, temporary, seasonal for peak production, contract, or internship).. Valid values are `permanent|temporary|seasonal|contract|intern`',
    `purpose` STRING COMMENT 'A brief statement describing the primary purpose and key responsibilities of this position within the organization.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether this position is eligible for remote or hybrid work arrangements.',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this position is classified as safety-sensitive under OSHA regulations, requiring additional safety training, certifications, and compliance monitoring.',
    `source_system_code` STRING COMMENT 'The source system code of the position record',
    `title` STRING COMMENT 'Official title of the position as it appears in organizational documentation and job postings.',
    `travel_requirement_pct` DECIMAL(18,2) COMMENT 'The expected percentage of time this position requires business travel, expressed as a percentage (e.g., 25.00 for 25% travel).',
    `union_eligible_flag` BOOLEAN COMMENT 'Indicates whether this position is eligible for union membership or covered by collective bargaining agreements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the position record',
    `work_shift` STRING COMMENT 'The primary work shift assigned to this position, particularly relevant for manufacturing and distribution operations.. Valid values are `day|evening|night|rotating|flexible`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Approved headcount position within the organizational structure representing a budgeted role slot. Stores position code, position title, job profile, org unit, plant/site, position type (permanent, temporary, seasonal), FTE allocation, budgeted headcount, filled/vacant status, effective date, and requisition linkage. Enables workforce planning, vacancy tracking, and labor budget management aligned with Workday HCM Position Management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key. Serves as the reference template for position creation, talent acquisition, compensation management, and performance evaluation across the CPG enterprise.',
    `cost_center_id` BIGINT COMMENT 'Default cost center for labor expense allocation for positions created from this profile. Used for financial planning and budget management.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the supervisory organization or department to which positions created from this profile typically report. Links to organizational hierarchy.',
    `approval_date` DATE COMMENT 'Date when this job profile was formally approved for use in the organization. Required for SOX compliance and internal controls.',
    `approved_by` STRING COMMENT 'Name or identifier of the HR business partner or executive who approved this job profile for use. Supports governance and accountability.',
    `career_path` STRING COMMENT 'Typical progression trajectory for employees in this role, including potential next-level positions and lateral moves. Supports talent development and retention strategies.',
    `job_profile_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the job profile template. Used for integration with Workday HCM and cross-system reference.. Valid values are `^[A-Z0-9]{6,12}$`',
    `competency_profile` STRING COMMENT 'Structured list of technical, functional, and behavioral competencies required for success in the role. Used for talent assessment, development planning, and succession management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the job profile record',
    `job_profile_description` STRING COMMENT 'The job profile description of the job profile record',
    `eeo_category` STRING COMMENT 'The eeo category of the job profile record',
    `effective_end_date` DATE COMMENT 'Date when this job profile version was superseded or retired. Null for currently active profiles. Supports historical analysis and compliance auditing.',
    `effective_start_date` DATE COMMENT 'Date when this job profile version became active and available for use in position creation and talent management processes.',
    `employment_type` STRING COMMENT 'Standard employment arrangement for positions created from this profile. Determines benefits eligibility, work schedule expectations, and labor cost classification.. Valid values are `full_time|part_time|temporary|seasonal|contract`',
    `flsa_classification` STRING COMMENT 'Federal classification determining overtime eligibility and wage requirements under U.S. labor law. Exempt roles are salaried and not eligible for overtime; non-exempt roles are eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `flsa_status` STRING COMMENT 'The flsa status of the job profile record',
    `gmp_training_required_flag` BOOLEAN COMMENT 'Indicates whether the role requires completion of GMP training due to involvement in manufacturing, quality control, or product handling activities. Critical for FDA and ISO 22716 compliance.',
    `incentive_type` STRING COMMENT 'Type of variable compensation plan applicable to this job profile. Determines incentive calculation methodology and payout frequency. [ENUM-REF-CANDIDATE: none|annual_bonus|quarterly_bonus|sales_commission|profit_sharing|long_term_incentive|stock_options — 7 candidates stripped; promote to reference product]',
    `job_code` STRING COMMENT 'The job code of the job profile record',
    `job_description` STRING COMMENT 'Comprehensive narrative describing the purpose, responsibilities, and scope of the role. Used for recruitment, performance management, and organizational design.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles across the organization. Aligns with core business processes in consumer goods manufacturing and distribution. [ENUM-REF-CANDIDATE: manufacturing|quality|supply_chain|sales|marketing|finance|procurement|research_development|regulatory|human_resources|information_technology|legal|customer_service — 13 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the role within the organizational structure. Determines scope of responsibility, decision-making authority, and career progression path. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|senior_manager|director|senior_director|vice_president|senior_vice_president|executive — 11 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile. Active profiles are available for position creation; inactive or obsolete profiles are retained for historical reference only.. Valid values are `active|inactive|under_review|obsolete`',
    `job_title` STRING COMMENT 'Official job title as it appears in organizational documentation, offer letters, and employee records. Human-readable label for the role.',
    `key_responsibilities` STRING COMMENT 'Structured list of primary duties and accountabilities for the role. Defines expected outcomes and performance standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was most recently updated. Supports change tracking and version control.',
    `management_level` STRING COMMENT 'Classification indicating whether the role has direct reports and the span of management responsibility. Critical for organizational design and succession planning.. Valid values are `individual_contributor|people_manager|manager_of_managers|executive_leader`',
    `max_salary` DECIMAL(18,2) COMMENT 'The max salary of the job profile record',
    `merit_increase_guideline_percentage` DECIMAL(18,2) COMMENT 'Standard annual merit increase percentage for satisfactory performance. Used for compensation planning and budget forecasting.',
    `min_salary` DECIMAL(18,2) COMMENT 'The min salary of the job profile record',
    `minimum_qualifications` STRING COMMENT 'The minimum qualifications of the job profile record',
    `pay_grade` STRING COMMENT 'Compensation band code defining the salary range and incentive structure for this job profile. Used for internal equity analysis and market benchmarking.. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `physical_demand_level` STRING COMMENT 'Classification of physical exertion required for the role based on U.S. Department of Labor standards. Used for ADA compliance, workplace accommodations, and safety planning.. Valid values are `sedentary|light|medium|heavy|very_heavy`',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether positions created from this profile are eligible for remote or hybrid work arrangements. Reflects operational requirements and organizational policy.',
    `required_certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, or credentials required for the role. May include industry-specific certifications such as Six Sigma, PMP, CPA, or regulatory certifications.',
    `required_education_level` STRING COMMENT 'Minimum educational qualification required for candidates to be considered for positions created from this profile. Used for talent acquisition screening.. Valid values are `high_school|associate_degree|bachelor_degree|master_degree|doctoral_degree|professional_certification`',
    `required_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the role. Used for candidate qualification and internal mobility eligibility.',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether the role is classified as safety-sensitive, requiring adherence to OSHA standards, drug testing, and enhanced safety protocols. Applies to manufacturing, warehouse, and equipment operation roles.',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary in USD for positions created from this profile. Represents ceiling for exceptional performers or long-tenured employees.',
    `salary_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint annual base salary in USD representing market-competitive compensation for fully competent performance in the role. Target for experienced incumbents.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary in USD for positions created from this profile. Represents entry point for new hires or internal transfers into the role.',
    `source_system_code` STRING COMMENT 'The source system code of the job profile record',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target annual incentive bonus as a percentage of base salary for on-target performance. Used for total compensation calculations and offer letter generation.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Used for candidate expectations, expense budgeting, and work-life balance considerations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the job profile record',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job profile defining the role template, competency requirements, compensation structure, and eligibility criteria for a class of positions across the CPG enterprise. Stores job profile code, job family, job level, FLSA classification, management level, required certifications, GMP training requirements, physical demand level, compensation plan details (pay grade, salary range min/mid/max, target bonus percentage, merit guidelines, incentive type), and job description. Used as the reference template for position creation, talent acquisition, compensation management, and performance evaluation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll record. Primary key for this entity.',
    `payroll_period_id` BIGINT COMMENT 'The payroll period id of the payroll record record',
    `employee_id` BIGINT COMMENT 'The payroll responsible employee id of the payroll record record',
    `payroll_run_id` BIGINT COMMENT 'Identifier for the payroll processing batch or run that generated this record. Groups all payroll records processed together.',
    `primary_payroll_approved_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who approved this payroll record for payment. Required for SOX compliance and audit trail.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base salary or hourly wage amount earned during this pay period, before any additional compensation or deductions.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payments included in this payroll period. May include annual bonuses, spot awards, or incentive payments.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission earnings for this pay period. Applicable to sales force and commercial roles with variable compensation plans.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which this payroll expense is allocated. Used for departmental expense tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the payroll record record',
    `currency_code` STRING COMMENT 'The currency code of the payroll record record',
    `federal_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Federal income tax withheld from gross pay based on employee W-4 elections and IRS withholding tables.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered or legally mandated wage garnishments deducted from gross pay. Includes child support, tax levies, creditor garnishments, and student loan garnishments.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting this payroll expense. Links payroll to financial accounting system.',
    `gross_pay` DECIMAL(18,2) COMMENT 'The gross pay of the payroll record record',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross compensation before any deductions. Sum of base salary, overtime, shift differential, bonus, commission, and other earnings.',
    `health_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee contribution toward health insurance premiums deducted from gross pay. May include medical, dental, and vision coverage.',
    `hours_worked` DECIMAL(18,2) COMMENT 'The hours worked of the payroll record record',
    `local_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Local or municipal income tax withheld from gross pay where applicable. Includes city, county, or school district taxes.',
    `medicare_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of Medicare tax (FICA) withheld from gross pay. Calculated at statutory rate with no wage base limit.',
    `net_pay` DECIMAL(18,2) COMMENT 'The net pay of the payroll record record',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay amount disbursed to the employee after all deductions. The actual amount paid to the employee.',
    `other_benefit_deduction_amount` DECIMAL(18,2) COMMENT 'Total of all other voluntary benefit deductions including life insurance, disability insurance, FSA, HSA, dependent care, and other employee-elected benefits.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The overtime hours of the payroll record record',
    `overtime_hours_worked` DECIMAL(18,2) COMMENT 'Total overtime hours worked during this pay period. Includes time-and-a-half and double-time hours per FLSA regulations.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total overtime compensation earned during this pay period. Includes time-and-a-half and double-time calculations per FLSA regulations.',
    `pay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll record. Supports multi-country payroll operations.. Valid values are `^[A-Z]{3}$`',
    `pay_date` DATE COMMENT 'The date on which the net pay is disbursed to the employee. The actual payment date for this payroll record.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid. Determines the cadence of payroll processing for this employee.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll record. Defines the end of the work period for which compensation is calculated.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll record. Defines the beginning of the work period for which compensation is calculated.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee. Defines the payment instrument used for this payroll payment.. Valid values are `direct_deposit|check|cash|paycard`',
    `payroll_approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll record was approved for payment. Captures the approval event in the payroll workflow.',
    `payroll_processed_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll record was calculated and processed by the payroll system. Audit timestamp for payroll processing.',
    `payroll_record_status` STRING COMMENT 'The payroll record status of the payroll record record',
    `payroll_status` STRING COMMENT 'Current processing status of this payroll record. Tracks the payroll record through calculation, approval, payment, and potential reversal workflows.. Valid values are `draft|calculated|approved|paid|voided|reversed`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll record was first created in the system. Audit field for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll record was last modified. Audit field for tracking changes and data lineage.',
    `regular_hours` DECIMAL(18,2) COMMENT 'The regular hours of the payroll record record',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total regular work hours during this pay period, excluding overtime. Used for hourly employee pay calculations.',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employee pre-tax or Roth contribution to retirement savings plan (401k, 403b, etc.) deducted from gross pay.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional compensation for working non-standard shifts such as night, weekend, or holiday shifts. Common in manufacturing operations.',
    `social_security_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of Social Security tax (FICA) withheld from gross pay. Calculated at statutory rate up to annual wage base limit.',
    `source_system_code` STRING COMMENT 'The source system code of the payroll record record',
    `state_tax_withheld_amount` DECIMAL(18,2) COMMENT 'State income tax withheld from gross pay based on employee state tax elections and state withholding requirements.',
    `total_deductions` DECIMAL(18,2) COMMENT 'The total deductions of the payroll record record',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions from gross pay including taxes, benefits, and garnishments. Gross pay minus total deductions equals net pay.',
    `total_taxes` DECIMAL(18,2) COMMENT 'The total taxes of the payroll record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the payroll record record',
    `work_location_code` STRING COMMENT 'Code identifying the physical work location or facility where the employee worked during this pay period. Important for multi-site operations and tax jurisdiction determination.',
    `year_to_date_federal_tax` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the beginning of the calendar year through this pay period. Used for tax reporting and W-2 preparation.',
    `year_to_date_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay for the employee from the beginning of the calendar year through this pay period. Used for tax reporting and W-2 preparation.',
    `year_to_date_medicare_tax` DECIMAL(18,2) COMMENT 'Cumulative Medicare tax withheld from the beginning of the calendar year through this pay period. Used for W-2 preparation.',
    `year_to_date_social_security_tax` DECIMAL(18,2) COMMENT 'Cumulative Social Security tax withheld from the beginning of the calendar year through this pay period. Used for W-2 preparation and wage base limit tracking.',
    `year_to_date_state_tax` DECIMAL(18,2) COMMENT 'Cumulative state income tax withheld from the beginning of the calendar year through this pay period. Used for state tax reporting.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Periodic payroll processing record capturing gross-to-net pay calculation results for each employee pay period. Stores pay period start/end dates, pay frequency (weekly, bi-weekly, semi-monthly, monthly), gross pay, base salary, overtime pay, shift differential, bonus, commission, total deductions, net pay, tax withholdings (federal, state, local), benefit deductions, garnishments, pay currency, and payroll run status. Sourced from Workday HCM Payroll module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `employee_id` BIGINT COMMENT 'The benefit responsible employee id of the benefit enrollment record',
    `enrollment_id` BIGINT COMMENT 'add column enrollment_id (BIGINT) with FK to workforce.enrollment.enrollment_id - benefit enrollment is a specialization of enrollment',
    `primary_benefit_employee_id` BIGINT COMMENT 'Unique identifier for the employee who enrolled in the benefit plan. Links to the employee master record in Workday HCM.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual dollar amount elected by the employee for this benefit plan. Applicable to FSA (Flexible Spending Account), HSA (Health Savings Account), and retirement contribution elections.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this benefit enrollment requires HR or management approval before becoming effective. True for enrollments that exceed standard limits or require special authorization.',
    `approval_status` STRING COMMENT 'Current approval status for benefit enrollments requiring authorization. Indicates whether approval is not required, pending review, approved, or rejected by the approving authority.. Valid values are `not_required|pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the benefit enrollment was approved by the authorized approver. Used for audit trail and compliance documentation.',
    `beneficiary_designation` STRING COMMENT 'Name or identifier of the designated beneficiary for life insurance and retirement benefit plans. Indicates who will receive benefits in the event of employee death.',
    `benefit_carrier_code` STRING COMMENT 'Unique code identifying the insurance carrier or benefit provider administering this plan (e.g., Aetna, Blue Cross, Fidelity). Used for carrier file feeds and reconciliation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `benefit_category` STRING COMMENT 'High-level classification of the benefit type. Used for grouping and reporting benefit elections across different plan types. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement|fsa|hsa|supplemental|wellness — 10 candidates stripped; promote to reference product]',
    `benefit_enrollment_status` STRING COMMENT 'The benefit enrollment status of the benefit enrollment record',
    `benefit_plan_code` STRING COMMENT 'Unique code identifying the specific benefit plan (e.g., health, dental, vision, life insurance, 401k). Standardized plan identifier used across HR systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `benefit_type` STRING COMMENT 'The benefit type of the benefit enrollment record',
    `carrier_member_number` STRING COMMENT 'Unique member identifier assigned by the benefit carrier to the enrolled employee. Used on insurance cards and for claims adjudication.. Valid values are `^[A-Z0-9]{6,15}$`',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the benefit carrier for this specific enrollment. Used for claims processing and carrier communication.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit enrollment is eligible for COBRA continuation coverage upon qualifying event (termination, reduction in hours). True if plan is subject to COBRA regulations.',
    `cobra_qualifying_event_date` DATE COMMENT 'Date of the qualifying event that triggered COBRA eligibility (e.g., termination date, reduction in hours date). Used to calculate COBRA election and coverage periods.',
    `contribution_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for employee and employer contribution amounts. Supports multi-country workforce with localized benefit plans.. Valid values are `^[A-Z]{3}$`',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and remitted for this benefit enrollment. Aligns with payroll processing schedule.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_end_date` DATE COMMENT 'Last date of active benefit coverage under this enrollment. Populated when enrollment is terminated, employee separates, or coverage is cancelled. Null for active ongoing enrollments.',
    `coverage_level` STRING COMMENT 'The coverage level of the benefit enrollment record',
    `coverage_start_date` DATE COMMENT 'First date of active benefit coverage under this enrollment. May differ from enrollment effective date based on plan waiting periods or carrier processing timelines.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee indicating who is covered under the benefit plan (employee only, employee plus spouse, employee plus children, or full family coverage).. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this benefit enrollment record was first created in the system. Represents the initial enrollment submission or data load timestamp.',
    `currency_code` STRING COMMENT 'The currency code of the benefit enrollment record',
    `deduction_code` STRING COMMENT 'Payroll deduction code used to process employee contributions for this benefit enrollment. Maps to payroll system deduction configuration.. Valid values are `^[A-Z0-9_]{3,10}$`',
    `dependent_count` STRING COMMENT 'Number of eligible dependents covered under this benefit enrollment. Used for coverage tier validation and premium calculation.',
    `effective_date` DATE COMMENT 'The effective date of the benefit enrollment record',
    `employee_contribution` DECIMAL(18,2) COMMENT 'The employee contribution of the benefit enrollment record',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount contributed by the employee per pay period for this benefit plan. Deducted from employee paycheck on a pre-tax or post-tax basis depending on plan type.',
    `employer_contribution` DECIMAL(18,2) COMMENT 'The employer contribution of the benefit enrollment record',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount contributed by the employer per pay period for this benefit plan. Represents company subsidy or match for employee benefit coverage.',
    `end_date` DATE COMMENT 'The end date of the benefit enrollment record',
    `enrollment_confirmation_number` STRING COMMENT 'Unique confirmation number generated upon successful benefit enrollment submission. Provided to employee as proof of enrollment and used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{8,16}$`',
    `enrollment_date` DATE COMMENT 'The enrollment date of the benefit enrollment record',
    `enrollment_effective_date` DATE COMMENT 'Date when the benefit enrollment becomes effective and coverage begins. Must align with plan rules and qualifying event timelines per regulatory requirements.',
    `enrollment_event_type` STRING COMMENT 'Type of event that triggered the benefit enrollment or change. Includes new hire enrollment, annual open enrollment period, qualifying life events (marriage, birth, adoption), or other triggering events per IRS regulations.. Valid values are `new_hire|open_enrollment|life_event|annual_renewal|qualifying_event|rehire`',
    `enrollment_source` STRING COMMENT 'Channel or system through which the benefit enrollment was submitted. Indicates whether enrollment was completed via employee self-service portal, HR administrator, benefits vendor portal, or other method.. Valid values are `employee_self_service|hr_admin|benefits_portal|carrier_direct|paper_form|call_center`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Indicates whether the enrollment is active, pending approval, cancelled, terminated, suspended, or waived by the employee.. Valid values are `active|pending|cancelled|terminated|suspended|waived`',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must provide evidence of insurability (medical underwriting) for this benefit enrollment. Typically required for life insurance or disability coverage above guaranteed issue amounts.',
    `evidence_of_insurability_status` STRING COMMENT 'Current status of the evidence of insurability review process. Indicates whether medical underwriting is not required, pending carrier review, approved, denied, or incomplete awaiting additional information.. Valid values are `not_required|pending|approved|denied|incomplete`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this benefit enrollment record was last updated. Tracks any changes to enrollment details, status updates, or data corrections.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this benefit enrollment. Used by HR administrators to document exceptions, special circumstances, or processing details.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this benefit enrollment record originated (e.g., WORKDAY_HCM, BENEFITS_PORTAL, CARRIER_FEED). Used for data lineage and integration tracking.. Valid values are `^[A-Z_]{2,10}$`',
    `tax_treatment` STRING COMMENT 'Tax treatment classification for employee contributions indicating whether deductions are taken on a pre-tax basis (Section 125), post-tax basis, Roth basis, or fully employer-paid with no employee contribution.. Valid values are `pre_tax|post_tax|roth|employer_paid`',
    `termination_date` DATE COMMENT 'The termination date of the benefit enrollment record',
    `termination_reason` STRING COMMENT 'Reason for termination of the benefit enrollment. Common reasons include employee separation, plan cancellation, coverage change, loss of eligibility, or voluntary termination by employee.',
    `termination_timestamp` TIMESTAMP COMMENT 'Date and time when the benefit enrollment was terminated in the system. Used for audit trail and to track when coverage cessation was processed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the benefit enrollment record',
    `waiver_date` DATE COMMENT 'Date when the employee formally waived or declined benefit coverage. Used for compliance tracking and audit trails.',
    `waiver_reason` STRING COMMENT 'Reason provided by employee for waiving or declining benefit coverage. Common reasons include coverage through spouse, alternative coverage, or cost considerations. Required for compliance documentation.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment record capturing active benefit plan elections across health, dental, vision, life insurance, disability, retirement (401k/pension), FSA, HSA, and supplemental benefits. Stores enrollment effective date, benefit plan code, coverage tier (employee only, employee+spouse, family), employee contribution amount, employer contribution amount, coverage start/end dates, enrollment event type (new hire, open enrollment, life event), and benefit carrier code.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for individual time, attendance, and absence events.',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager or supervisor who approved this time entry. Used for audit trail and approval workflow tracking.',
    `payroll_period_id` BIGINT COMMENT 'Identifier for the payroll period to which this time entry belongs. Used to group time entries for payroll processing and financial period closing.',
    `primary_time_employee_id` BIGINT COMMENT 'Unique identifier for the employee who submitted this time entry. Links to employee master data in Workday HCM.',
    `shift_schedule_id` BIGINT COMMENT 'The shift schedule id of the time entry record',
    `time_approved_by_employee_id` BIGINT COMMENT 'The time approved by employee id of the time entry record',
    `time_responsible_employee_id` BIGINT COMMENT 'The time responsible employee id of the time entry record',
    `work_location_id` BIGINT COMMENT 'The work location id of the time entry record',
    `absence_end_date` DATE COMMENT 'The last date of the absence period for leave requests. Used to calculate total absence duration and expected return-to-work date.',
    `absence_start_date` DATE COMMENT 'The first date of the absence period for leave requests. Used for multi-day absence tracking and leave balance calculations.',
    `absence_type` STRING COMMENT 'Specific type of absence when entry_type is absence or leave. Critical for leave compliance tracking, FMLA reporting, and workforce availability planning. [ENUM-REF-CANDIDATE: sick|vacation|fmla|parental|bereavement|jury_duty|military|unpaid|other — 9 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current approval status of the time entry or absence request. Tracks workflow state from submission through manager approval to payroll processing.. Valid values are `pending|approved|rejected|cancelled|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The exact timestamp when this time entry was approved by the manager. Critical for payroll cutoff and audit compliance.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during this shift in minutes. Deducted from total hours for payroll calculations and labor law compliance.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The exact timestamp when the employee clocked in or started their shift. Captured from time clock systems, mobile apps, or manual entry.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The exact timestamp when the employee clocked out or ended their shift. Used to calculate total hours worked.',
    `comments` STRING COMMENT 'Free-text comments or notes about this time entry. May include explanations for late entries, absence reasons, or special circumstances.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which this time entrys labor costs should be allocated. Used for financial reporting and departmental cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the time entry record',
    `department_code` STRING COMMENT 'Code identifying the organizational department where the employee worked during this time entry. Used for departmental labor cost tracking and workforce analytics.',
    `entry_date` DATE COMMENT 'The calendar date for which this time entry applies. Represents the business date of the work performed or absence recorded.',
    `entry_type` STRING COMMENT 'Classification of the time entry indicating whether it represents hours worked, an absence request, approved leave, or other time-off category. [ENUM-REF-CANDIDATE: worked|absence|leave|holiday|training|jury_duty|bereavement — 7 candidates stripped; promote to reference product]',
    `fmla_case_number` STRING COMMENT 'Unique case identifier for FMLA leave tracking when this absence is part of an approved FMLA claim. Used for regulatory reporting and leave balance management.',
    `fmla_eligible_flag` BOOLEAN COMMENT 'Indicates whether this absence qualifies for FMLA protection. Critical for regulatory compliance and leave tracking under federal labor law.',
    `holiday_flag` BOOLEAN COMMENT 'Indicates whether this time entry falls on a company-recognized holiday. Used for holiday pay calculations and premium pay eligibility.',
    `hours_worked` DECIMAL(18,2) COMMENT 'The hours worked of the time entry record',
    `incident_case_number` STRING COMMENT 'Reference to the safety incident case number if this absence is related to a workplace injury or illness. Links to OSHA incident records.',
    `labor_category_code` STRING COMMENT 'Classification code for the type of labor performed during this time entry. Used for labor cost analysis, union reporting, and job costing in manufacturing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this time entry record was last updated. Used for change tracking and audit compliance.',
    `meal_break_duration_minutes` STRING COMMENT 'Duration of meal break taken during this shift in minutes. Tracked separately for compliance with state labor laws requiring meal periods.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether this absence is related to an OSHA recordable injury or illness. Critical for OSHA 300 log reporting and workplace safety compliance.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The overtime hours of the time entry record',
    `overtime_hours_1_5x` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked at time-and-a-half pay rate. Typically applies to hours beyond 40 per week or 8 per day depending on jurisdiction.',
    `overtime_hours_2x` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked at double-time pay rate. Typically applies to holidays, seventh consecutive day, or hours beyond daily thresholds.',
    `paid_time_off_hours` DECIMAL(18,2) COMMENT 'Number of PTO hours used for this time entry when employee takes paid leave. Deducted from employees PTO balance and included in payroll.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in payroll. Prevents duplicate processing and enables payroll reconciliation.',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility where the employee worked during this time entry. Critical for OTIF workforce planning and labor cost allocation.',
    `production_line_code` STRING COMMENT 'Code identifying the specific production line or work center assignment for this time entry. Used for manufacturing labor cost tracking and efficiency analysis.',
    `project_code` STRING COMMENT 'The project code of the time entry record',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total number of regular hours worked during this time entry period, excluding overtime. Used for standard payroll calculations and labor cost tracking.',
    `return_to_work_date` DATE COMMENT 'The date the employee is expected to return to work following an absence. Used for workforce planning and OSHA injury/illness return-to-work tracking.',
    `shift_type` STRING COMMENT 'Classification of the work shift for this time entry. Used for shift differential pay calculations and workforce planning in manufacturing operations.. Valid values are `day|evening|night|weekend|holiday|rotating`',
    `source` STRING COMMENT 'The system or method through which this time entry was captured. Used for data quality tracking and audit purposes. [ENUM-REF-CANDIDATE: time_clock|manual|mobile_app|web_portal|biometric|badge_swipe|supervisor_entry|import — 8 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'The source system code of the time entry record',
    `submitted_timestamp` TIMESTAMP COMMENT 'The timestamp when this time entry was originally submitted by the employee or supervisor. Used for audit trail and late submission tracking.',
    `time_category` STRING COMMENT 'The time category of the time entry record',
    `union_code` STRING COMMENT 'Code identifying the labor union affiliation for this employees time entry. Used for union reporting, collective bargaining compliance, and labor relations.',
    `unpaid_time_off_hours` DECIMAL(18,2) COMMENT 'Number of unpaid hours for this time entry when employee takes unpaid leave. Excluded from payroll calculations but tracked for attendance and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the time entry record',
    `weekend_flag` BOOLEAN COMMENT 'Indicates whether this time entry falls on a weekend day. Used for weekend shift differential pay and scheduling analytics.',
    `work_date` DATE COMMENT 'The work date of the time entry record',
    `work_order_number` STRING COMMENT 'Manufacturing work order or production order number to which this time entrys labor hours should be allocated. Used for job costing and production variance analysis.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Individual time, attendance, and absence record capturing hours worked, leave requests, and absence events for each employee per shift or day. Stores entry date, clock-in/clock-out timestamps, regular hours, overtime hours (OT1.5x, OT2x), shift type (day, evening, night, weekend), plant/line assignment, entry type (worked, absence request, leave), absence type (sick, vacation, FMLA, parental, bereavement, jury duty, military), requested start/end dates, approval status, approver, FMLA eligibility flag, time entry source (time clock, manual, mobile), and return-to-work date. Critical for manufacturing labor cost tracking, OTIF workforce planning, leave compliance, and OSHA reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` (
    `recruiting_requisition_id` BIGINT COMMENT 'Primary key for recruiting_requisition',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will bear the financial burden of the new hires compensation and benefits.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile that defines the standard job template, competencies, and requirements for this requisition.',
    `position_id` BIGINT COMMENT 'Reference to the position master record that defines the role being filled.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division where the position will be located and the employee will report.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for the position and final hiring decision.',
    `recruiting_hiring_manager_employee_id` BIGINT COMMENT 'The recruiting hiring manager employee id of the recruiting requisition record',
    `recruiting_org_unit_id` BIGINT COMMENT 'The recruiting org unit id of the recruiting requisition record',
    `tertiary_recruiting_replacement_employee_id` BIGINT COMMENT 'Reference to the employee being replaced, applicable for backfill and replacement requisitions.',
    `approved_headcount` STRING COMMENT 'The number of positions approved by finance and leadership for hiring under this requisition.',
    `close_date` DATE COMMENT 'The close date of the recruiting requisition record',
    `created_timestamp` TIMESTAMP COMMENT 'The precise date and time when the requisition record was first created in the system.',
    `education_level_required` STRING COMMENT 'The minimum education level required for the position, ranging from high school to advanced degrees or professional certifications. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|none — 7 candidates stripped; promote to reference product]',
    `employment_type` STRING COMMENT 'The type of employment arrangement for the position, defining whether it is full-time, part-time, temporary, contract-based, internship, or seasonal.. Valid values are `full_time|part_time|temporary|contract|intern|seasonal`',
    `evergreen_requisition` BOOLEAN COMMENT 'Indicates whether this is an evergreen requisition that remains open continuously to build a talent pipeline for high-turnover or high-demand roles.',
    `filled_date` DATE COMMENT 'The filled date of the recruiting requisition record',
    `internal_posting_only` BOOLEAN COMMENT 'Indicates whether the requisition is restricted to internal candidates only before being opened to external applicants.',
    `job_description` STRING COMMENT 'Detailed description of the role, responsibilities, qualifications, and requirements for the position.',
    `job_posting_title` STRING COMMENT 'The external-facing job title used in job postings and advertisements, which may differ from the internal job title for marketing purposes.',
    `job_title` STRING COMMENT 'The official job title for the position being recruited, as it will appear in job postings and offer letters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The precise date and time when the requisition record was last updated or modified.',
    `minimum_years_experience` STRING COMMENT 'The minimum number of years of relevant work experience required for candidates applying to this position.',
    `number_of_openings` STRING COMMENT 'The total number of positions to be filled under this requisition, supporting bulk hiring scenarios.',
    `open_date` DATE COMMENT 'The open date of the recruiting requisition record',
    `opened_date` DATE COMMENT 'The opened date of the recruiting requisition record',
    `priority` STRING COMMENT 'The priority of the recruiting requisition record',
    `priority_level` STRING COMMENT 'The urgency level assigned to this requisition, influencing recruiter focus and resource allocation.. Valid values are `low|medium|high|critical`',
    `reason_for_opening` STRING COMMENT 'The business reason or trigger event that created the need for this requisition. [ENUM-REF-CANDIDATE: resignation|termination|retirement|promotion|transfer|new_position|business_growth|seasonal_demand — 8 candidates stripped; promote to reference product]',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements.',
    `requisition_approved_date` DATE COMMENT 'The date when the requisition received final approval from leadership and finance to proceed with hiring.',
    `requisition_closed_date` DATE COMMENT 'The date when the requisition was officially closed, either after being filled or cancelled.',
    `requisition_created_date` DATE COMMENT 'The date when the requisition was initially created in the system by the hiring manager or recruiter.',
    `requisition_filled_date` DATE COMMENT 'The date when the requisition was marked as filled after a candidate accepted an offer.',
    `requisition_number` STRING COMMENT 'Business identifier for the job requisition, externally visible and used for tracking and communication across hiring stakeholders.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_opened_date` DATE COMMENT 'The date when the requisition was officially opened and made available for candidate sourcing and applications.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition indicating its progression through the approval and hiring workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it is for new headcount expansion, backfill of a vacated position, temporary staffing, contractor engagement, internship, or seasonal workforce. [ENUM-REF-CANDIDATE: new_headcount|backfill|replacement|temporary|contractor|intern|seasonal — 7 candidates stripped; promote to reference product]',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'The maximum annual salary or hourly wage budgeted for this position, defining the upper limit for offer negotiations.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'The minimum annual salary or hourly wage budgeted for this position, used for candidate expectations and offer negotiations.',
    `source_system_code` STRING COMMENT 'The source system code of the recruiting requisition record',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of sourcing channels and job boards where this requisition will be posted (e.g., LinkedIn, Indeed, internal referrals, campus recruiting).',
    `target_fill_date` DATE COMMENT 'The target fill date of the recruiting requisition record',
    `target_hire_date` DATE COMMENT 'The desired date by which the hiring manager expects the position to be filled and the candidate to start.',
    `target_start_date` DATE COMMENT 'The planned first day of work for the new hire, used for onboarding and workforce planning.',
    `time_to_fill_days` STRING COMMENT 'The number of calendar days from requisition opening to requisition filled, used as a key performance indicator (KPI) for recruiting efficiency.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the recruiting requisition record',
    `work_location_code` BIGINT COMMENT 'Reference to the primary work location or facility where the employee will be based.',
    CONSTRAINT pk_recruiting_requisition PRIMARY KEY(`recruiting_requisition_id`)
) COMMENT 'Talent acquisition job requisition record initiating the hiring process for a new or backfill position. Stores requisition number, position reference, job title, job profile, hiring manager, recruiter assigned, requisition type (new headcount, backfill, temporary), target hire date, approved headcount, requisition status (draft, approved, open, on-hold, filled, cancelled), sourcing channels, and time-to-fill tracking dates. Sourced from Workday HCM Recruiting module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Unique identifier for the job application record. Primary key for the job application entity.',
    `applicant_id` BIGINT COMMENT 'Reference to the applicant (candidate) who submitted this application. Links to the candidate master record.',
    `job_profile_id` BIGINT COMMENT 'The job profile id of the job application record',
    `employee_id` BIGINT COMMENT 'Reference to the recruiter responsible for managing this application. Links to the employee master record for the assigned recruiter.',
    `recruiting_requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this application was submitted. Links the candidate to the specific open position.',
    `tertiary_job_referral_employee_id` BIGINT COMMENT 'Reference to the employee who referred this candidate, if the application source is employee referral. Used for referral bonus tracking.',
    `application_date` DATE COMMENT 'Date when the candidate submitted the application for the job requisition. Key timestamp for recruiting funnel analysis.',
    `application_number` STRING COMMENT 'Human-readable unique application number assigned to this job application for tracking and reference purposes.. Valid values are `^APP-[0-9]{8}$`',
    `application_source` STRING COMMENT 'Channel through which the candidate discovered and applied for the position. Used for source effectiveness analysis and recruiting ROI tracking.. Valid values are `career_site|employee_referral|job_board|recruiter|social_media|agency`',
    `application_stage` STRING COMMENT 'Current stage of the application in the recruiting workflow. Tracks candidate progression through the hiring funnel from initial application to final disposition. [ENUM-REF-CANDIDATE: applied|phone_screen|hiring_manager_review|interview|offer|background_check|hired|rejected|withdrawn — 9 candidates stripped; promote to reference product]',
    `application_status` STRING COMMENT 'The application status of the job application record',
    `background_check_completion_date` DATE COMMENT 'Date when the background check process was completed and results were received.',
    `background_check_status` STRING COMMENT 'Status of the pre-employment background check process. Indicates whether the background verification has been completed and the outcome.. Valid values are `not_started|in_progress|clear|flagged|failed`',
    `cover_letter_document_reference` STRING COMMENT 'Reference identifier or storage path to the candidates cover letter document if provided.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job application record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_stage` STRING COMMENT 'The current stage of the job application record',
    `disability_status` STRING COMMENT 'Voluntary self-identification of disability status for compliance with equal opportunity and affirmative action reporting.. Valid values are `not_disclosed|yes|no`',
    `disposition_reason` STRING COMMENT 'The disposition reason of the job application record',
    `diversity_self_identification` STRING COMMENT 'Voluntary self-identification information provided by the candidate for diversity reporting purposes. Stored separately for compliance with equal opportunity regulations.',
    `email_address` STRING COMMENT 'Primary email address of the candidate used for communication throughout the recruiting process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'First name of the candidate submitting the application. Part of candidate identity within the recruiting lifecycle.',
    `hire_date` DATE COMMENT 'Actual date when the candidate was hired and became an employee. Represents the successful completion of the recruiting lifecycle.',
    `internal_candidate_flag` BOOLEAN COMMENT 'Indicates whether the applicant is an internal employee applying for a different position. True for internal candidates, False for external candidates.',
    `interview_date` DATE COMMENT 'Date when the formal interview (on-site or virtual) was conducted with the candidate.',
    `interview_score` DECIMAL(18,2) COMMENT 'Composite numerical score from the formal interview process. Aggregates feedback from multiple interviewers to assess candidate suitability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the job application record was last updated. Tracks the most recent change to any field in the record.',
    `last_name` STRING COMMENT 'Last name of the candidate submitting the application. Part of candidate identity within the recruiting lifecycle.',
    `offer_acceptance_date` DATE COMMENT 'Date when the candidate formally accepted the job offer. Marks the transition to pre-hire onboarding activities.',
    `offer_accepted_flag` BOOLEAN COMMENT 'The offer accepted flag of the job application record',
    `offer_date` DATE COMMENT 'Date when a formal job offer was extended to the candidate.',
    `offer_extended_flag` BOOLEAN COMMENT 'The offer extended flag of the job application record',
    `offer_status` STRING COMMENT 'Current status of the job offer extended to the candidate. Tracks whether the offer is awaiting response, accepted, declined, or withdrawn by the company.. Valid values are `pending|accepted|declined|withdrawn`',
    `offered_salary` DECIMAL(18,2) COMMENT 'Annual salary amount offered to the candidate in the job offer. Used for compensation analysis and offer acceptance tracking.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate. Used for scheduling interviews and communication.',
    `phone_screen_date` DATE COMMENT 'Date when the initial phone screening interview was conducted with the candidate.',
    `phone_screen_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during the phone screening interview. Used to evaluate candidate fit and progression decisions.',
    `rejection_date` DATE COMMENT 'Date when the application was rejected and the candidate was notified of the decision.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for rejecting the application. Used for rejection pattern analysis and process improvement.. Valid values are `qualifications|experience|culture_fit|compensation|position_filled|candidate_withdrew`',
    `rejection_reason_notes` STRING COMMENT 'Free-text notes providing additional context for the rejection decision. Supplements the rejection reason code with specific details.',
    `resume_document_reference` STRING COMMENT 'Reference identifier or storage path to the candidates resume document. Links to document management system for retrieval.',
    `source_channel` STRING COMMENT 'The source channel of the job application record',
    `source_system_code` STRING COMMENT 'The source system code of the job application record',
    `stage` STRING COMMENT 'The stage of the job application record',
    `stage_change_date` DATE COMMENT 'Date when the application last moved to its current stage. Used to calculate time-in-stage metrics and identify bottlenecks.',
    `time_in_stage_days` STRING COMMENT 'Number of days the application has been in its current stage. Used to identify stalled applications and measure recruiting velocity.',
    `time_to_hire_days` STRING COMMENT 'Total number of days from application submission to hire date. Key performance indicator (KPI) for recruiting efficiency.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the job application record',
    `veteran_status` STRING COMMENT 'Voluntary self-identification of veteran status for compliance with federal contractor reporting requirements.. Valid values are `not_disclosed|veteran|non_veteran|protected_veteran`',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Individual job application and candidate record linking an applicant to a specific job requisition. Stores candidate profile data (name, contact, source, resume reference, internal/external flag), application date, application source channel, application stage (applied, phone screen, hiring manager review, interview, offer, background check, hired, rejected), stage change dates, interview scores, offer details (offer date, offered salary, offer status), rejection reason code, and time-in-stage metrics. SSOT for candidate identity within the recruiting lifecycle. Enables talent pipeline tracking, recruiting funnel analysis, and diversity reporting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'System-generated unique identifier for the performance review record.',
    `employee_id` BIGINT COMMENT 'The performance responsible employee id of the performance review record',
    `primary_performance_employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier of the manager or reviewer conducting the evaluation.',
    `calibration_status` STRING COMMENT 'Current status of the calibration step across reviewers.. Valid values are `pending|in_progress|completed`',
    `cascade_level` STRING COMMENT 'Organizational level at which the goal is cascaded.. Valid values are `individual|team|department|company`',
    `comments` STRING COMMENT 'The comments of the performance review record',
    `compensation_change_flag` BOOLEAN COMMENT 'True if any compensation component was adjusted as a result of the review.',
    `confidentiality_level` STRING COMMENT 'Classification indicating the sensitivity of the review data.. Valid values are `public|internal|confidential|restricted`',
    `corporate_kpi_alignment` STRING COMMENT 'Identifier of the corporate KPI that the goal supports.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the performance review record',
    `development_plan` STRING COMMENT 'The development plan of the performance review record',
    `employee_self_assessment_flag` BOOLEAN COMMENT 'True if the employee completed a self‑assessment component.',
    `goal_actual_achievement` DECIMAL(18,2) COMMENT 'Actual measured result for the goal metric.',
    `goal_category` STRING COMMENT 'Category that classifies the nature of the goal.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the goal.. Valid values are `not_started|in_progress|completed|failed`',
    `goal_target_metric` STRING COMMENT 'Metric or target value the employee is expected to achieve.',
    `goal_title` STRING COMMENT 'Title or short description of an individual performance goal.',
    `goal_weight` DECIMAL(18,2) COMMENT 'Weight of the goal expressed as a percentage of the overall rating.',
    `goals_met_pct` DECIMAL(18,2) COMMENT 'The goals met pct of the performance review record',
    `goals_summary` STRING COMMENT 'The goals summary of the performance review record',
    `is_finalized` BOOLEAN COMMENT 'True when the review has been finalized and no further edits are allowed.',
    `is_locked` BOOLEAN COMMENT 'True when the record is locked for compliance or audit purposes.',
    `manager_comments` STRING COMMENT 'Free‑text feedback provided by the manager.',
    `merit_increase_amount` DECIMAL(18,2) COMMENT 'Monetary value of the salary increase.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Percentage of salary increase awarded based on the review outcome.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Numeric score representing the employees overall performance.',
    `performance_review_status` STRING COMMENT 'The performance review status of the performance review record',
    `pip_flag` BOOLEAN COMMENT 'True if a Performance Improvement Plan was created as a result of the review.',
    `promotion_recommendation_flag` BOOLEAN COMMENT 'True if the reviewer recommends the employee for promotion.',
    `rating_scale` STRING COMMENT 'Defines the rating scale used for the overall rating.. Valid values are `1-5|1-10|custom`',
    `rating_score` DECIMAL(18,2) COMMENT 'The rating score of the performance review record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was initially created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `review_completion_date` DATE COMMENT 'Date when the review was marked complete.',
    `review_date` DATE COMMENT 'The review date of the performance review record',
    `review_number` STRING COMMENT 'Business identifier assigned to the review, often used in reporting and audit trails.',
    `review_period` STRING COMMENT 'The review period of the performance review record',
    `review_period_end` DATE COMMENT 'End date of the performance review period.',
    `review_period_start` DATE COMMENT 'Start date of the performance review period.',
    `review_status` STRING COMMENT 'Lifecycle status of the review record.. Valid values are `draft|submitted|approved|rejected`',
    `review_submission_timestamp` TIMESTAMP COMMENT 'Timestamp of the final submission of the review.',
    `review_type` STRING COMMENT 'Indicates the type of review cycle.. Valid values are `annual|mid-year|probation|project`',
    `reviewer_comments` STRING COMMENT 'Additional narrative comments from the reviewer.',
    `source_system_code` STRING COMMENT 'The source system code of the performance review record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the performance review record',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual or mid-year employee performance review record capturing formal evaluation outcomes and associated goal achievement. Stores review period, review type (annual, mid-year, probation, project), overall performance rating, rating scale, manager comments, employee self-assessment flag, calibration status, PIP flag, promotion recommendation flag, review completion date, and goal details (goal title, category, weight, target metric, actual achievement, status, corporate KPI alignment, cascade level). Supports MBO/OKR frameworks, merit increase decisions, and talent calibration. Sourced from Workday HCM Performance module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier for the training record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who completed the training.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to workforce.training_course. Business justification: Normalize training records by referencing the master training_course table; remove duplicated course identifiers.',
    `certification_earned` STRING COMMENT 'The certification earned of the training record record',
    `certification_expiry_date` DATE COMMENT 'The certification expiry date of the training record record',
    `certifying_body` STRING COMMENT 'Organization that issued the training certification.',
    `completion_date` DATE COMMENT 'Date the employee completed the training.',
    `completion_status` STRING COMMENT 'The completion status of the training record record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the training record record',
    `enrollment_date` DATE COMMENT 'The enrollment date of the training record record',
    `expiry_date` DATE COMMENT 'Date the training certification expires, if applicable.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment.. Valid values are `pass|fail|not_applicable`',
    `pass_flag` BOOLEAN COMMENT 'The pass flag of the training record record',
    `passed_flag` BOOLEAN COMMENT 'The passed flag of the training record record',
    `recertification_due_date` DATE COMMENT 'Date by which recertification must be completed, if required.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether the training must be renewed periodically.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved in the training (0‑100).',
    `source_system_code` STRING COMMENT 'The source system code of the training record record',
    `training_hours` DECIMAL(18,2) COMMENT 'Number of hours credited for the training.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `training_record_status` STRING COMMENT 'Current lifecycle status of the training record.. Valid values are `pending|completed|failed|expired|in_progress`',
    `training_type` STRING COMMENT 'Category of the training (e.g., GMP, safety/OSHA, regulatory). [ENUM-REF-CANDIDATE: gmp|safety|regulatory|product_knowledge|leadership|compliance|onboarding — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the training record record',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Employee training and learning completion record tracking mandatory and elective training activities. Stores training course code, course name, training type (GMP, safety/OSHA, regulatory, product knowledge, leadership, compliance, onboarding), delivery method (classroom, e-learning, OJT, external), completion date, expiry date, pass/fail status, score, training hours, certifying body, and recertification required flag. Critical for GMP compliance, OSHA requirements, and FDA audit readiness in CPG manufacturing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'System-generated unique identifier for the training course record.',
    `org_unit_id` BIGINT COMMENT 'Org unit owning this training course.',
    `accreditation_body` STRING COMMENT 'External organization that accredits the course, if any.',
    `applicable_job_profiles` STRING COMMENT 'Comma‑separated list of job profile codes for which the course is relevant.',
    `assessment_method` STRING COMMENT 'Primary method used to evaluate learner performance.. Valid values are `exam|quiz|practical|project|simulation`',
    `training_course_category` STRING COMMENT 'Broad classification of the course (e.g., compliance, safety, GMP, leadership, technical, professional).. Valid values are `compliance|safety|gmp|leadership|technical|professional`',
    `compliance_related_flag` BOOLEAN COMMENT 'The compliance related flag of the training course record',
    `compliance_status` STRING COMMENT 'Indicates whether the course currently meets all applicable regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `cost` DECIMAL(18,2) COMMENT 'Monetary cost to the organization for delivering the course (e.g., vendor fees, material costs).',
    `course_category` STRING COMMENT 'The course category of the training course record',
    `course_code` STRING COMMENT 'External business identifier for the course, e.g., a catalog or LMS code.',
    `course_name` STRING COMMENT 'The course name of the training course record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the training course record',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the course cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delivery_method` STRING COMMENT 'Mode through which the course is delivered to learners.. Valid values are `online|in_person|blended|self_paced`',
    `training_course_description` STRING COMMENT 'Detailed narrative describing the learning objectives, content, and target audience.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the course, expressed in hours.',
    `effective_end_date` DATE COMMENT 'Date when the course is retired or no longer offered (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment.',
    `is_compliance_course` BOOLEAN COMMENT 'The is compliance course of the training course record',
    `is_enrollment_open` BOOLEAN COMMENT 'Indicates whether new enrollments are currently accepted for the course.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of the course is required for the associated job profile(s).',
    `language` STRING COMMENT 'Primary language in which the course is delivered.. Valid values are `en|es|fr|de|zh|ja`',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for accuracy and compliance.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the person or role that performed the most recent review.',
    `learning_objectives` STRING COMMENT 'Bullet‑point list of the competencies or knowledge the learner will acquire.',
    `max_participants` STRING COMMENT 'Maximum number of learners allowed to enroll in a single offering of the course.',
    `owner` STRING COMMENT 'Name or identifier of the department or individual responsible for the course content and maintenance.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score a learner must achieve to pass the course, expressed as a percentage.',
    `prerequisite_course_codes` STRING COMMENT 'Comma‑separated list of course codes that must be completed before enrolling.',
    `provider` STRING COMMENT 'The provider of the training course record',
    `provider_name` STRING COMMENT 'The provider name of the training course record',
    `provides_certification` BOOLEAN COMMENT 'True if successful completion awards a formal certification.',
    `recertification_interval_months` STRING COMMENT 'Number of months after which the learner must retake or renew the certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the course record.',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to the specific OSHA, FDA CFR, GMP, or other regulatory standard the course satisfies.',
    `source_system_code` STRING COMMENT 'The source system code of the training course record',
    `target_audience` STRING COMMENT 'Narrative description of the employee groups or roles the course is intended for.',
    `title` STRING COMMENT 'Human‑readable name of the training course.',
    `training_course_status` STRING COMMENT 'Current state of the course in its lifecycle.. Valid values are `active|inactive|retired|draft|pending_approval`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the training course record',
    `version_number` STRING COMMENT 'Version identifier for the course content, used for change management.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Training course catalog master record defining available learning programs across GMP, safety, regulatory, and professional development tracks. Stores course code, course title, course category, delivery method options, duration hours, passing score threshold, recertification interval (months), mandatory flag, applicable job profiles, regulatory requirement reference (OSHA standard, FDA CFR, GMP), course owner, and active status. Serves as the reference catalog for training assignment and compliance tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique identifier for the safety incident record.',
    `manufacturing_facility_id` BIGINT COMMENT 'Facility where incident occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported the incident.',
    `safety_responsible_employee_id` BIGINT COMMENT 'The safety responsible employee id of the safety incident record',
    `work_location_id` BIGINT COMMENT 'The work location id of the safety incident record',
    `body_part_affected` STRING COMMENT 'Body part of the employee that was affected by the incident.',
    `claim_filing_date` DATE COMMENT 'Date the workers compensation claim was filed.',
    `claim_number` STRING COMMENT 'Unique identifier for the workers compensation claim linked to the incident.',
    `claim_status` STRING COMMENT 'Current status of the workers compensation claim.. Valid values are `open|closed|denied|approved|pending`',
    `claim_type` STRING COMMENT 'Type of workers compensation claim.. Valid values are `medical|indemnity|both|other`',
    `corrective_action` STRING COMMENT 'The corrective action of the safety incident record',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing corrective actions.',
    `corrective_action_reference` STRING COMMENT 'Reference or identifier for the corrective action taken.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `days_away_from_work` STRING COMMENT 'Number of workdays the employee was away due to the incident.',
    `days_lost` STRING COMMENT 'The days lost of the safety incident record',
    `department` STRING COMMENT 'Department within the organization where the incident took place.',
    `incident_date` DATE COMMENT 'The incident date of the safety incident record',
    `incident_description` STRING COMMENT 'Narrative description of what happened.',
    `incident_location` STRING COMMENT 'The incident location of the safety incident record',
    `incident_number` STRING COMMENT 'The incident number of the safety incident record',
    `incident_status` STRING COMMENT 'Overall status of the incident record.. Valid values are `open|closed|reopened`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the incident type.. Valid values are `injury|illness|near_miss|first_aid|property_damage`',
    `indemnity_cost` DECIMAL(18,2) COMMENT 'Indemnity expenses incurred for the claim.',
    `injury_nature` STRING COMMENT 'Specific nature of the injury sustained.. Valid values are `laceration|fracture|burn|sprain|other`',
    `insurance_carrier` STRING COMMENT 'Name of the insurance carrier handling the claim.',
    `investigation_findings` STRING COMMENT 'Key findings from the incident investigation.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation.. Valid values are `pending|in_progress|completed|closed`',
    `lost_time_flag` BOOLEAN COMMENT 'The lost time flag of the safety incident record',
    `medical_cost` DECIMAL(18,2) COMMENT 'Medical expenses incurred for the claim.',
    `modified_duty_flag` BOOLEAN COMMENT 'Indicates if the employee performed modified duty.',
    `osha_300_classification` STRING COMMENT 'OSHA 300 log classification for the incident.. Valid values are `recordable|non_recordable|other`',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident is OSHA recordable.',
    `plant_site` STRING COMMENT 'Identifier of the plant or site where the incident occurred.',
    `restricted_duty_days` STRING COMMENT 'Number of days the employee performed restricted duty.',
    `return_to_work_date` DATE COMMENT 'Date the employee returned to work after the incident.',
    `root_cause` STRING COMMENT 'The root cause of the safety incident record',
    `root_cause_category` STRING COMMENT 'Primary category describing the root cause of the incident.. Valid values are `equipment|human_error|process|environment|other`',
    `safety_incident_status` STRING COMMENT 'The safety incident status of the safety incident record',
    `severity` STRING COMMENT 'The severity of the safety incident record',
    `severity_level` STRING COMMENT 'Severity rating of the incident.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Work shift during which the incident occurred.. Valid values are `day|swing|graveyard|other`',
    `source_system_code` STRING COMMENT 'The source system code of the safety incident record',
    `state_jurisdiction` STRING COMMENT 'State jurisdiction governing the claim.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost (medical + indemnity) of the claim.',
    `tpa_reference` STRING COMMENT 'Reference to the third‑party administrator handling the claim.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'OSHA recordable and non-recordable workplace safety incident record with integrated workers compensation claim tracking for manufacturing plants, distribution centers, and field operations. Stores incident date/time, incident type (injury, illness, near-miss, first aid, property damage), OSHA recordable flag, OSHA 300 log classification, body part affected, injury nature, root cause category, plant/site, department, shift, days away from work, restricted duty days, investigation status, corrective action reference, and workers comp claim details (claim number, filing date, claim type, insurance carrier, claim status, medical cost, indemnity cost, return-to-work date, modified duty flag, state jurisdiction, TPA reference). Mandatory for OSHA 300/301 compliance reporting and total cost of risk management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the shift schedule record.',
    `employee_id` BIGINT COMMENT 'The employee id of the shift schedule record',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the schedule is used.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or functional area the schedule belongs to.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or work cell associated with the schedule.',
    `work_location_id` BIGINT COMMENT 'The work location id of the shift schedule record',
    `break_duration_minutes` STRING COMMENT 'Total minutes allocated for breaks within the shift.',
    `compliance_notes` STRING COMMENT 'Regulatory or safety notes attached to the schedule (e.g., OSHA shift‑length limits).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the shift schedule record',
    `days_of_week` STRING COMMENT 'Pattern of days the schedule applies to.. Valid values are `weekday|weekend|mon_fri|custom`',
    `shift_schedule_description` STRING COMMENT 'Free‑form text describing special rules, notes, or exceptions for the schedule.',
    `effective_end_date` DATE COMMENT 'Date when the schedule is retired or superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the schedule becomes active.',
    `headcount_per_shift` STRING COMMENT 'Planned number of employees assigned to each shift instance.',
    `labor_category` STRING COMMENT 'Broad category of labor the schedule applies to.. Valid values are `production|warehouse|logistics|maintenance|admin`',
    `max_hours_per_day` DECIMAL(18,2) COMMENT 'Upper limit of work hours allowed per day under this schedule.',
    `max_hours_per_week` DECIMAL(18,2) COMMENT 'Upper limit of work hours allowed per week under this schedule.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to base hourly rate for overtime hours.',
    `overtime_trigger_minutes` STRING COMMENT 'Accumulated minutes after which overtime pay rules apply.',
    `payroll_code` STRING COMMENT 'Code used by payroll systems to apply the correct wage rules for this schedule.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `schedule_code` STRING COMMENT 'Human‑readable code used to reference the schedule in operational systems.',
    `schedule_name` STRING COMMENT 'Descriptive name of the shift schedule (e.g., "North Plant 3‑Shift Rotating").',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule.. Valid values are `active|inactive|retired|pending`',
    `schedule_type` STRING COMMENT 'Category of schedule defining its overall pattern.. Valid values are `fixed|rotating|flexible|continental|dsd_route`',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'The scheduled hours of the shift schedule record',
    `shift_code` STRING COMMENT 'The shift code of the shift schedule record',
    `shift_date` DATE COMMENT 'The shift date of the shift schedule record',
    `shift_differential_flag` BOOLEAN COMMENT 'Indicates whether a shift differential premium applies.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly rate applied when the differential flag is true.',
    `shift_end_time` TIMESTAMP COMMENT 'Local time when a shift ends (HH:MM, 24‑hour clock).',
    `shift_group` STRING COMMENT 'Logical grouping identifier for related schedules (e.g., "NorthPlant_A").',
    `shift_name` STRING COMMENT 'The shift name of the shift schedule record',
    `shift_pattern` STRING COMMENT 'Specific shift arrangement applied to the schedule.. Valid values are `2_shift|3_shift|4_crew_continental|12_hour_alternating`',
    `shift_schedule_status` STRING COMMENT 'The shift schedule status of the shift schedule record',
    `shift_start_time` TIMESTAMP COMMENT 'Local time when a shift begins (HH:MM, 24‑hour clock).',
    `shift_type` STRING COMMENT 'The shift type of the shift schedule record',
    `site_code` STRING COMMENT 'Code representing the physical site or location.',
    `source_system_code` STRING COMMENT 'The source system code of the shift schedule record',
    `time_zone` STRING COMMENT 'Time‑zone identifier (e.g., "America/Chicago") for the schedules location.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the shift schedule record',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Manufacturing and distribution shift schedule definition record establishing planned work patterns for plant, DC, and route-based employees. Stores schedule code, schedule name, schedule type (fixed, rotating, flexible, continental, DSD route), shift pattern (2-shift, 3-shift, 4-crew continental, 12-hour alternating), shift start/end times, break periods, days of week, plant/site, department/line, effective date range, headcount per shift, and overtime trigger thresholds. Used as the reference template for time entry validation, shift differential pay calculation, labor capacity planning, and production schedule alignment in CPG manufacturing operations.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` (
    `labor_relation_id` BIGINT COMMENT 'System-generated unique identifier for each labor relation record.',
    `employee_id` BIGINT COMMENT 'Employee linked to labor relation.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Associate labor relations with the org unit they govern, enabling reporting and compliance.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|pending|expired|terminated|negotiating`',
    `agreement_type` STRING COMMENT 'Classification of the labor agreement type.. Valid values are `CBA|Labor Management Agreement|Other`',
    `arbitration_award_reference` STRING COMMENT 'Reference to the arbitration award document, if applicable.',
    `arbitration_flag` BOOLEAN COMMENT 'Indicates whether the grievance proceeded to arbitration.',
    `bargaining_unit` STRING COMMENT 'Group of employees covered by the collective bargaining agreement.',
    `case_number` STRING COMMENT 'The case number of the labor relation record',
    `case_status` STRING COMMENT 'The case status of the labor relation record',
    `case_type` STRING COMMENT 'The case type of the labor relation record',
    `cba_number` STRING COMMENT 'External reference number assigned to the collective bargaining agreement.',
    `cba_reference` STRING COMMENT 'The cba reference of the labor relation record',
    `confidentiality_level` STRING COMMENT 'Data classification level for the record as defined by corporate policy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the labor relation record',
    `labor_relation_description` STRING COMMENT 'The labor relation description of the labor relation record',
    `effective_from` DATE COMMENT 'Date when the agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the agreement expires or is terminated; null for open‑ended agreements.',
    `facility_covered` STRING COMMENT 'Identifier of the plant or distribution facility covered by the agreement.',
    `filed_date` DATE COMMENT 'The filed date of the labor relation record',
    `grievance_category` STRING COMMENT 'The grievance category of the labor relation record',
    `grievance_filer` STRING COMMENT 'Identifier of the employee who filed the grievance.',
    `grievance_filing_date` DATE COMMENT 'Date the grievance was officially filed.',
    `grievance_number` STRING COMMENT 'Unique identifier for a grievance filed under this agreement.',
    `grievance_outcome` STRING COMMENT 'Result of the grievance after resolution.. Valid values are `favorable|unfavorable|settled|withdrawn`',
    `grievance_resolution_date` DATE COMMENT 'Date the grievance was resolved.',
    `grievance_status` STRING COMMENT 'Lifecycle status of the grievance.. Valid values are `open|closed|settled|escalated`',
    `grievance_step` STRING COMMENT 'Current procedural step of the grievance.. Valid values are `filed|review|mediation|arbitration|resolved`',
    `grievance_type` STRING COMMENT 'Category of the grievance issue.. Valid values are `pay|benefits|working_conditions|disciplinary|other`',
    `last_modified_by` STRING COMMENT 'Identifier of the system user who last modified the record.',
    `negotiation_end_date` DATE COMMENT 'Date when negotiation activities concluded.',
    `negotiation_start_date` DATE COMMENT 'Date when negotiation activities commenced.',
    `negotiation_status` STRING COMMENT 'Current status of the negotiation process for the agreement.. Valid values are `in_progress|completed|stalled`',
    `notes` STRING COMMENT 'Free‑form text for additional comments or observations about the agreement or grievance.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the labor relation record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the labor relation record.',
    `relation_type` STRING COMMENT 'The relation type of the labor relation record',
    `resolution_date` DATE COMMENT 'The resolution date of the labor relation record',
    `resolution_status` STRING COMMENT 'The resolution status of the labor relation record',
    `resolution_summary` STRING COMMENT 'The resolution summary of the labor relation record',
    `source_system_code` STRING COMMENT 'The source system code of the labor relation record',
    `union_local_number` STRING COMMENT 'Identifier for the specific local chapter of the union.',
    `union_name` STRING COMMENT 'Legal name of the labor union involved in the agreement.',
    `union_steward` STRING COMMENT 'Name of the union steward handling the grievance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the labor relation record',
    `wage_scale_reference` STRING COMMENT 'Code or identifier linking to the wage scale table applicable under this agreement.',
    `created_by` STRING COMMENT 'Identifier of the system user who created the record.',
    CONSTRAINT pk_labor_relation PRIMARY KEY(`labor_relation_id`)
) COMMENT 'Labor relations record managing collective bargaining agreements (CBAs), grievance filings, and labor-management agreements across unionized manufacturing and distribution facilities. Stores CBA reference number, union name, union local number, bargaining unit, contract effective/expiry dates, wage scale table reference, facility/plant covered, negotiation status, and grievance details (grievance number, filing date, type, filer, union steward, grievance step, status, resolution date, resolution outcome, arbitration flag and award reference). Supports labor compliance, CBA administration, and grievance tracking in CPG manufacturing environments.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'Primary key for the Enrollment association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to employee',
    `payroll_period_id` BIGINT COMMENT 'add column enrollment_period_start_date_id (BIGINT) with FK to workforce.payroll_period.payroll_period_id - enrollment effective period should align to a payroll period',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to training_course',
    `benefit_enrollment_id` BIGINT COMMENT 'The benefit enrollment id of the enrollment record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the enrollment record',
    `approval_date` DATE COMMENT 'The approval date of the enrollment record',
    `approval_status` STRING COMMENT 'The approval status of the enrollment record',
    `approved_by` STRING COMMENT 'The approved by of the enrollment record',
    `auto_enrolled_flag` BOOLEAN COMMENT 'The auto enrolled flag of the enrollment record',
    `certification_earned` BOOLEAN COMMENT 'Whether certification was earned.',
    `certifying_body` STRING COMMENT 'Organization that certifies the training outcome',
    `enrollment_code` STRING COMMENT 'The enrollment code of the enrollment record',
    `completion_date` DATE COMMENT 'Date the employee completed the training',
    `completion_status` STRING COMMENT 'Completion outcome (passed, failed, in_progress, not_started).',
    `confirmation_number` STRING COMMENT 'The confirmation number of the enrollment record',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The contribution amount of the enrollment record',
    `contribution_frequency` STRING COMMENT 'The contribution frequency of the enrollment record',
    `coverage_level` STRING COMMENT 'The coverage level of the enrollment record',
    `coverage_tier` STRING COMMENT 'The coverage tier of the enrollment record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the enrollment record',
    `credits_earned` DECIMAL(18,2) COMMENT 'Training or continuing education credits earned.',
    `currency_code` STRING COMMENT 'The currency code of the enrollment record',
    `dependent_count` STRING COMMENT 'The dependent count of the enrollment record',
    `dependents_count` STRING COMMENT 'The dependents count of the enrollment record',
    `enrollment_description` STRING COMMENT 'The enrollment description of the enrollment record',
    `effective_date` DATE COMMENT 'The effective date of the enrollment record',
    `effective_end_date` DATE COMMENT 'The effective end date of the enrollment record',
    `effective_from` DATE COMMENT 'The effective from of the enrollment record',
    `effective_start_date` DATE COMMENT 'The effective start date of the enrollment record',
    `effective_until` DATE COMMENT 'The effective until of the enrollment record',
    `election_amount` DECIMAL(18,2) COMMENT 'The election amount of the enrollment record',
    `election_date` DATE COMMENT 'The election date of the enrollment record',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The employee contribution amount of the enrollment record',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The employer contribution amount of the enrollment record',
    `end_date` DATE COMMENT 'The end date of the enrollment record',
    `enrollment_date` DATE COMMENT 'The enrollment date of the enrollment record',
    `enrollment_status` STRING COMMENT 'Current status of the enrollment',
    `enrollment_type` STRING COMMENT 'The enrollment type of the enrollment record',
    `is_qualifying_life_event` BOOLEAN COMMENT 'The is qualifying life event of the enrollment record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the enrollment record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the enrollment record',
    `enrollment_name` STRING COMMENT 'The enrollment name of the enrollment record',
    `notes` STRING COMMENT 'The notes of the enrollment record',
    `open_enrollment_period` STRING COMMENT 'The open enrollment period of the enrollment record',
    `plan_code` STRING COMMENT 'The plan code of the enrollment record',
    `plan_name` STRING COMMENT 'The plan name of the enrollment record',
    `pre_tax_flag` BOOLEAN COMMENT 'The pre tax flag of the enrollment record',
    `qualifying_life_event_type` STRING COMMENT 'The qualifying life event type of the enrollment record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the enrollment record',
    `reason` STRING COMMENT 'The reason of the enrollment record',
    `recertification_due_date` DATE COMMENT 'Date by which the employee must recertify',
    `score` DECIMAL(18,2) COMMENT 'Result score achieved by the employee',
    `source` STRING COMMENT 'The source of the enrollment record',
    `source_system_code` STRING COMMENT 'The source system code of the enrollment record',
    `termination_date` DATE COMMENT 'The termination date of the enrollment record',
    `termination_reason` STRING COMMENT 'The termination reason of the enrollment record',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'The total premium amount of the enrollment record',
    `training_hours` DECIMAL(18,2) COMMENT 'Number of hours the employee spent on the course',
    `uom` STRING COMMENT 'The uom of the enrollment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the enrollment record',
    `waived_flag` BOOLEAN COMMENT 'The waived flag of the enrollment record',
    `waiver_reason` STRING COMMENT 'The waiver reason of the enrollment record',
    `withdrawal_reason` STRING COMMENT 'Reason for withdrawal if applicable.',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between an employee and a training course. It captures enrollment-specific data such as completion date, status, score, training hours, certifying body, and recertification due date. Each record links one employee to one training course.. Existence Justification: Employees can enroll in many training courses and each training course can be taken by many employees. The organization actively creates, updates, and deletes enrollment records, tracking completion dates, scores, status, and certification details. This many‑to‑many participation is managed as a distinct business entity called an Enrollment.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Primary key for applicant',
    `job_profile_id` BIGINT COMMENT 'Job profile applied for.',
    `referring_applicant_id` BIGINT COMMENT 'Self-referencing FK on applicant (referring_applicant_id)',
    `address_line1` STRING COMMENT 'First line of the applicants street address.',
    `applicant_status` STRING COMMENT 'The applicant status of the applicant record',
    `application_date` DATE COMMENT 'Date the applicant submitted the application.',
    `application_status` STRING COMMENT 'Current lifecycle status of the application.',
    `availability_start_date` DATE COMMENT 'Earliest date the applicant can start employment.',
    `background_check_date` DATE COMMENT 'Date the background check was completed.',
    `background_check_status` STRING COMMENT 'Current status of the applicants background screening.',
    `certifications` STRING COMMENT 'Professional certifications held by the applicant.',
    `city` STRING COMMENT 'City component of the applicants address.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the applicants residence.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the applicant record',
    `current_employer` STRING COMMENT 'The current employer of the applicant record',
    `date_of_birth` DATE COMMENT 'Birth date of the applicant, used for age verification and compliance.',
    `department_applied` STRING COMMENT 'Business department associated with the applied position.',
    `education_level` STRING COMMENT 'Highest completed education level of the applicant.',
    `email` STRING COMMENT 'Primary email address used for communication with the applicant.',
    `email_address` STRING COMMENT 'The email address of the applicant record',
    `expected_salary` DECIMAL(18,2) COMMENT 'Salary range the applicant expects.',
    `first_name` STRING COMMENT 'Given name of the applicant.',
    `full_name` STRING COMMENT 'Legal full name of the applicant as provided on the application.',
    `hire_date` DATE COMMENT 'Date the applicant officially became an employee.',
    `interview_date` DATE COMMENT 'Scheduled date for the applicants interview.',
    `interview_feedback` STRING COMMENT 'Notes or rating recorded by interviewers.',
    `last_name` STRING COMMENT 'Family name of the applicant.',
    `national_id_number` STRING COMMENT 'Government‑issued identifier (e.g., SSN, SIN) provided for background checks.',
    `offer_amount` DECIMAL(18,2) COMMENT 'Annual base salary offered to the applicant.',
    `offer_date` DATE COMMENT 'Date an employment offer was extended to the applicant.',
    `phone_number` STRING COMMENT 'Primary telephone number for the applicant.',
    `position_applied` STRING COMMENT 'Title of the job position the applicant applied to.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the applicants address.',
    `preferred_location` STRING COMMENT 'Geographic location where the applicant prefers to work.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the applicant record.',
    `relocation_willingness` BOOLEAN COMMENT 'Indicates if the applicant is willing to relocate.',
    `resume_reference` STRING COMMENT 'The resume reference of the applicant record',
    `resume_text` STRING COMMENT 'Full text of the applicants resume or CV.',
    `skills` STRING COMMENT 'Comma‑separated list of key skills and competencies.',
    `source_channel` STRING COMMENT 'Channel through which the applicant learned about the job opening.',
    `source_system_code` STRING COMMENT 'The source system code of the applicant record',
    `state` STRING COMMENT 'State or province component of the applicants address.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for employment termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the applicant record',
    `visa_expiration` DATE COMMENT 'Expiration date of the applicants work visa.',
    `visa_type` STRING COMMENT 'Type of work visa held by the applicant, if applicable.',
    `work_authorization_status` STRING COMMENT 'Applicants legal eligibility to work in the country.',
    `years_experience` STRING COMMENT 'The years experience of the applicant record',
    `years_of_experience` STRING COMMENT 'Total number of years of relevant professional experience.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master reference table for applicant. Referenced by applicant_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `correction_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (correction_payroll_run_id)',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center charged for payroll expenses.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who approved or executed the payroll run.',
    `payroll_group_id` BIGINT COMMENT 'Identifier of the payroll group or batch to which this run belongs.',
    `payroll_period_id` BIGINT COMMENT 'The payroll period id of the payroll run record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payroll amounts.',
    `employee_count` STRING COMMENT 'The employee count of the payroll run record',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross compensation before deductions for the payroll run.',
    `jurisdiction_country` STRING COMMENT 'Three‑letter country code for the payroll runs primary jurisdiction.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state code governing tax and labor rules for the payroll run.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount paid to employees after all deductions.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or explanations about the payroll run.',
    `number_of_employees` STRING COMMENT 'Count of distinct employees included in this payroll run.',
    `pay_date` DATE COMMENT 'Scheduled calendar date on which employees receive payment.',
    `payroll_frequency` STRING COMMENT 'Recurrence interval for the payroll run.',
    `payroll_period_end` DATE COMMENT 'Last calendar date of the payroll period covered by this run.',
    `payroll_period_start` DATE COMMENT 'First calendar date of the payroll period covered by this run.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run.',
    `payroll_type` STRING COMMENT 'Classification of the payroll run (e.g., regular payroll, bonus payout, termination settlement, adjustment).',
    `processed_timestamp` TIMESTAMP COMMENT 'Date‑time when the payroll run was processed and finalized.',
    `run_date` DATE COMMENT 'The run date of the payroll run record',
    `run_number` STRING COMMENT 'Human‑readable business identifier for the payroll run, often used in reports and communications.',
    `run_status` STRING COMMENT 'The run status of the payroll run record',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the payroll run was executed (business event time).',
    `run_type` STRING COMMENT 'The run type of the payroll run record',
    `source_system_code` STRING COMMENT 'The source system code of the payroll run record',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax withholdings deducted from the payroll run.',
    `tax_withholding_code` STRING COMMENT 'Code representing the employees tax withholding status for the run.',
    `tax_year` STRING COMMENT 'Fiscal year to which the payroll tax withholdings apply.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payroll run record',
    `total_hours` DECIMAL(18,2) COMMENT 'Aggregate regular work hours for all employees in the payroll period.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'The total net amount of the payroll run record',
    `total_overtime_hours` DECIMAL(18,2) COMMENT 'Aggregate overtime hours for all employees in the payroll period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payroll run record.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` (
    `work_location_id` BIGINT COMMENT 'Primary key for work_location',
    `org_unit_id` BIGINT COMMENT 'The org unit id of the work location record',
    `parent_work_location_id` BIGINT COMMENT 'Self-referencing FK on work_location (parent_work_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `address_line_1` STRING COMMENT 'The address line 1 of the work location record',
    `capacity_units` STRING COMMENT 'Primary production or handling capacity metric (e.g., units_per_day, pallets_per_hour).',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `compliance_status` STRING COMMENT 'Current regulatory compliance state of the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|CHN|JPN|IND|BRA — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the lakehouse.',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact for the location.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `environmental_certification` STRING COMMENT 'Environmental management certification held by the location.',
    `external_system_code` STRING COMMENT 'Identifier of the location in the originating source system.',
    `fire_safety_rating` STRING COMMENT 'Rating assigned by fire safety inspections.',
    `is_primary_location` BOOLEAN COMMENT 'True if this location is the primary site for the legal entity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude in decimal degrees.',
    `location_code` STRING COMMENT 'External reference code used by ERP/Workday to identify the location.',
    `location_name` STRING COMMENT 'The location name of the work location record',
    `location_type` STRING COMMENT 'Category of the work location indicating its primary function.',
    `longitude` DOUBLE COMMENT 'Geographic longitude in decimal degrees.',
    `manager_email` STRING COMMENT 'Work email address of the location manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `manager_phone` STRING COMMENT 'Contact phone number of the location manager.',
    `work_location_name` STRING COMMENT 'Human‑readable name of the facility, plant, warehouse, office or store.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `opening_date` DATE COMMENT 'Date the location began operations.',
    `operating_hours` STRING COMMENT 'Standard daily operating hours (e.g., 08:00-17:00).',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the location.',
    `region` STRING COMMENT 'Broad business region grouping for reporting.',
    `safety_incident_reporting_flag` BOOLEAN COMMENT 'Indicates whether safety incidents are captured for this location.',
    `shift_pattern` STRING COMMENT 'Description of shift schedule used at the location (e.g., 3‑2‑2).',
    `source_system_code` STRING COMMENT 'The source system code of the work location record',
    `square_footage` BIGINT COMMENT 'Total usable floor area of the location in square feet.',
    `state_province` STRING COMMENT 'State or province of the location.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    `work_location_status` STRING COMMENT 'Current operational status of the location.',
    CONSTRAINT pk_work_location PRIMARY KEY(`work_location_id`)
) COMMENT 'Master reference table for work_location. Referenced by location_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `payroll_group_id` BIGINT COMMENT 'The payroll group id of the payroll period record',
    `previous_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (previous_payroll_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period record was first created in the system.',
    `cut_off_date` DATE COMMENT 'Deadline for submitting time and attendance data for the period.',
    `days_in_period` STRING COMMENT 'Number of calendar days included in the payroll period.',
    `payroll_period_description` STRING COMMENT 'Optional free‑text description providing additional context about the payroll period.',
    `end_date` DATE COMMENT 'Last calendar date covered by the payroll period.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) for the payroll period.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the payroll period belongs.',
    `frequency` STRING COMMENT 'Textual representation of how often the period recurs (e.g., "2 weeks").',
    `is_holiday_adjusted` BOOLEAN COMMENT 'Indicates whether the period dates are adjusted for public holidays.',
    `pay_date` DATE COMMENT 'Date on which employees are paid for the period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period definition.',
    `period_code` STRING COMMENT 'Business-facing code that uniquely identifies the payroll period (e.g., "2023-04-BI" for bi‑weekly period ending April 2023).',
    `period_end_date` DATE COMMENT 'The period end date of the payroll period record',
    `period_name` STRING COMMENT 'Human‑readable name for the payroll period used in reports and UI.',
    `period_start_date` DATE COMMENT 'The period start date of the payroll period record',
    `period_status` STRING COMMENT 'The period status of the payroll period record',
    `period_type` STRING COMMENT 'Classification of the period frequency (e.g., weekly, bi‑weekly, monthly).',
    `processing_deadline` TIMESTAMP COMMENT 'Timestamp by which payroll processing must be completed.',
    `source_system_code` STRING COMMENT 'The source system code of the payroll period record',
    `start_date` DATE COMMENT 'First calendar date covered by the payroll period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll period record.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` (
    `payroll_group_id` BIGINT COMMENT 'Primary key for payroll_group',
    `org_unit_id` BIGINT COMMENT 'The org unit id of the payroll group record',
    `parent_payroll_group_id` BIGINT COMMENT 'Self-referencing FK on payroll_group (parent_payroll_group_id)',
    `accrual_policy_code` STRING COMMENT 'Reference to the leave/accrual policy applied to this payroll group.',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether employees in this group receive standard benefit plans.',
    `payroll_group_code` STRING COMMENT 'Business code that uniquely identifies the payroll group across systems.',
    `company_code` STRING COMMENT 'The company code of the payroll group record',
    `compensation_grade` STRING COMMENT 'Grade or band that defines salary ranges for the payroll group.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which payroll expenses for this group are charged.',
    `country_code` STRING COMMENT 'The country code of the payroll group record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll group record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the payroll group record',
    `default_currency` STRING COMMENT 'ISO 4217 currency code used for payroll calculations in this group.',
    `payroll_group_description` STRING COMMENT 'Free‑form description providing additional context about the payroll group.',
    `effective_from` DATE COMMENT 'Date when the payroll group becomes effective for payroll processing.',
    `effective_until` DATE COMMENT 'Date when the payroll group ceases to be effective; null if open‑ended.',
    `employee_count` STRING COMMENT 'The employee count of the payroll group record',
    `group_code` STRING COMMENT 'The group code of the payroll group record',
    `group_name` STRING COMMENT 'The group name of the payroll group record',
    `group_type` STRING COMMENT 'Classification of the payroll group based on employment relationship.',
    `max_hours_per_week` STRING COMMENT 'Maximum regular hours an employee in this group may work in a week before overtime applies.',
    `min_hours_per_week` STRING COMMENT 'Minimum scheduled hours required for employees in this group.',
    `payroll_group_name` STRING COMMENT 'Human‑readable name of the payroll group used in reports and UI.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees in this group are eligible for overtime pay.',
    `pay_cycle_day` STRING COMMENT 'Day of month on which payroll is processed for monthly frequency groups.',
    `pay_frequency` STRING COMMENT 'The pay frequency of the payroll group record',
    `payroll_frequency` STRING COMMENT 'Standard payroll run cadence for the group.',
    `payroll_group_status` STRING COMMENT 'Current lifecycle status of the payroll group.',
    `region_code` STRING COMMENT 'Three‑letter ISO region code indicating the primary geographic region for the payroll group.',
    `source_system_code` STRING COMMENT 'The source system code of the payroll group record',
    `tax_withholding_code` STRING COMMENT 'Code that determines the tax withholding rules applied to this payroll group.',
    `union_member` BOOLEAN COMMENT 'True if the payroll group is associated with a labor union collective bargaining agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll group record.',
    CONSTRAINT pk_payroll_group PRIMARY KEY(`payroll_group_id`)
) COMMENT 'Master reference table for payroll_group. Referenced by payroll_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_primary_supervisor_position_id` FOREIGN KEY (`primary_supervisor_position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_primary_payroll_approved_by_user_employee_id` FOREIGN KEY (`primary_payroll_approved_by_user_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`enrollment`(`enrollment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_primary_benefit_employee_id` FOREIGN KEY (`primary_benefit_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_time_approved_by_employee_id` FOREIGN KEY (`time_approved_by_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_time_responsible_employee_id` FOREIGN KEY (`time_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_recruiting_hiring_manager_employee_id` FOREIGN KEY (`recruiting_hiring_manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_recruiting_org_unit_id` FOREIGN KEY (`recruiting_org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_tertiary_recruiting_replacement_employee_id` FOREIGN KEY (`tertiary_recruiting_replacement_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_recruiting_requisition_id` FOREIGN KEY (`recruiting_requisition_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition`(`recruiting_requisition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_tertiary_job_referral_employee_id` FOREIGN KEY (`tertiary_job_referral_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_safety_responsible_employee_id` FOREIGN KEY (`safety_responsible_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ADD CONSTRAINT `fk_workforce_labor_relation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ADD CONSTRAINT `fk_workforce_labor_relation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_benefit_enrollment_id` FOREIGN KEY (`benefit_enrollment_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_referring_applicant_id` FOREIGN KEY (`referring_applicant_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_correction_payroll_run_id` FOREIGN KEY (`correction_payroll_run_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ADD CONSTRAINT `fk_workforce_work_location_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ADD CONSTRAINT `fk_workforce_work_location_parent_work_location_id` FOREIGN KEY (`parent_work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_previous_payroll_period_id` FOREIGN KEY (`previous_payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ADD CONSTRAINT `fk_workforce_payroll_group_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ADD CONSTRAINT `fk_workforce_payroll_group_parent_payroll_group_id` FOREIGN KEY (`parent_payroll_group_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_group`(`payroll_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `cba_reference` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed-term|at-will|project-based');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Corporate Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|leave|terminated|suspended|probation');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|contract|seasonal|temporary|intern');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `plant_site_code` SET TAGS ('dbx_business_glossary_term' = 'Plant or Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `standard_working_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Working Hours Per Week');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_city` SET TAGS ('dbx_business_glossary_term' = 'Work Location City');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_state_province` SET TAGS ('dbx_business_glossary_term' = 'Work Location State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `work_location_state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Human Capital Management (HCM) Worker ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `is_commercial_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Commercial Unit Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `is_manufacturing_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Manufacturing Unit Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `is_support_function` SET TAGS ('dbx_business_glossary_term' = 'Is Support Function Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended|planned');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'low_risk|moderate_risk|high_risk|critical_risk');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `union_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `primary_supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|casual|on_call');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Fte');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `incumbent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `incumbent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `incumbent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `is_vacant` SET TAGS ('dbx_business_glossary_term' = 'Is Vacant');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `max_salary_range` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary Range');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `max_salary_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `max_salary_range` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `max_salary_range` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `min_salary_range` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary Range');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `min_salary_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `min_salary_range` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `min_salary_range` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'filled|vacant|partially_filled');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|eliminated|proposed|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|seasonal|contract|intern');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Position Purpose');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `travel_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `union_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Organization ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `career_path` SET TAGS ('dbx_business_glossary_term' = 'Career Path');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `competency_profile` SET TAGS ('dbx_business_glossary_term' = 'Competency Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Eeo Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|seasonal|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Flsa Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `gmp_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Training Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `incentive_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'individual_contributor|people_manager|manager_of_managers|executive_leader');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Max Salary');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `max_salary` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `max_salary` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `merit_increase_guideline_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Guideline Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `merit_increase_guideline_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Min Salary');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `min_salary` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `min_salary` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualifications');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `physical_demand_level` SET TAGS ('dbx_business_glossary_term' = 'Physical Demand Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `physical_demand_level` SET TAGS ('dbx_value_regex' = 'sedentary|light|medium|heavy|very_heavy');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `required_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate_degree|bachelor_degree|master_degree|doctoral_degree|professional_certification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `required_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Required Years of Experience');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `primary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `primary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `primary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `local_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Withheld Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `local_tax_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `local_tax_withheld_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Amount (FICA)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_benefit_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Benefit Deduction Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_benefit_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `other_benefit_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|paycard');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|voided|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Amount (401k/403b)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Amount (FICA)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_taxes` SET TAGS ('dbx_business_glossary_term' = 'Total Taxes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Tax');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Medicare Tax (FICA)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_medicare_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_medicare_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Social Security Tax (FICA)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) State Tax');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_benefit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_benefit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `primary_benefit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Qualifying Event Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|life_event|annual_renewal|qualifying_event|rehire');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'employee_self_service|hr_admin|benefits_portal|carrier_direct|paper_form|call_center');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|cancelled|terminated|suspended|waived');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|incomplete');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z_]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|roth|employer_paid');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|auto_approved');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `fmla_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `holiday_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `incident_case_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `incident_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_category_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `meal_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Duration in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA (Occupational Safety and Health Administration) Recordable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours_1_5x` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours at 1.5x Rate (OT1.5x)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours_2x` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours at 2x Rate (OT2x)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `paid_time_off_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `production_line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend|holiday|rotating');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Submitted Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_category` SET TAGS ('dbx_business_glossary_term' = 'Time Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `unpaid_time_off_hours` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Time Off Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `weekend_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `recruiting_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Requisition Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `recruiting_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `recruiting_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `recruiting_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `recruiting_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `tertiary_recruiting_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `tertiary_recruiting_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `tertiary_recruiting_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Education Level Required');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract|intern|seasonal');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `evergreen_requisition` SET TAGS ('dbx_business_glossary_term' = 'Evergreen Requisition');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Filled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `internal_posting_only` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Only');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `job_posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `reason_for_opening` SET TAGS ('dbx_business_glossary_term' = 'Reason for Opening');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approved Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_created_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Created Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_filled_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Filled Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `target_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Target Hire Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `job_application_id` SET TAGS ('dbx_business_glossary_term' = 'Job Application ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `recruiting_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_source` SET TAGS ('dbx_value_regex' = 'career_site|employee_referral|job_board|recruiter|social_media|agency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_stage` SET TAGS ('dbx_business_glossary_term' = 'Application Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|flagged|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `cover_letter_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `current_stage` SET TAGS ('dbx_business_glossary_term' = 'Current Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'not_disclosed|yes|no');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Self-Identification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `internal_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Candidate Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `interview_score` SET TAGS ('dbx_business_glossary_term' = 'Interview Score');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_extended_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offered_salary` SET TAGS ('dbx_business_glossary_term' = 'Offered Salary Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offered_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offered_salary` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `offered_salary` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_date` SET TAGS ('dbx_business_glossary_term' = 'Phone Screen Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_date` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_score` SET TAGS ('dbx_business_glossary_term' = 'Phone Screen Score');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `phone_screen_score` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = 'qualifications|experience|culture_fit|compensation|position_filled|candidate_withdrew');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `rejection_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `resume_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Resume Document Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `stage_change_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `time_in_stage_days` SET TAGS ('dbx_business_glossary_term' = 'Time in Stage Days');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `time_to_hire_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Hire Days');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'not_disclosed|veteran|non_veteran|protected_veteran');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (Employee ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (Manager or reviewer employee ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status (State of Review Calibration Process)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `cascade_level` SET TAGS ('dbx_business_glossary_term' = 'Cascade Level (Level at which goal cascades, e.g., Individual, Team, Department, Company)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `cascade_level` SET TAGS ('dbx_value_regex' = 'individual|team|department|company');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Flag (Indicates if compensation was changed)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (Data classification of the review record)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `corporate_kpi_alignment` SET TAGS ('dbx_business_glossary_term' = 'Corporate KPI Alignment (Reference to corporate KPI code aligned with goal)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan` SET TAGS ('dbx_business_glossary_term' = 'Development Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Flag (Indicates if employee submitted self-assessment)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_actual_achievement` SET TAGS ('dbx_business_glossary_term' = 'Goal Actual Achievement (Achieved value for the goal metric)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category (Classification of goal, e.g., Financial, Development)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status (Current status of the goal)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_target_metric` SET TAGS ('dbx_business_glossary_term' = 'Goal Target Metric (Metric target for the goal)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title (Name of the performance goal)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_weight` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight (Weight of goal in overall evaluation, percentage)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goals_met_pct` SET TAGS ('dbx_business_glossary_term' = 'Goals Met Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `goals_summary` SET TAGS ('dbx_business_glossary_term' = 'Goals Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized Flag (Indicates if review is finalized and locked)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked Flag (Indicates if review record is locked from edits)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments (Narrative Feedback)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_amount` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Amount (Monetary amount of compensation increase)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage (Percentage increase in compensation based on review)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating (Numeric Score)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan Flag (Indicates if PIP initiated)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag (Indicates if promotion is recommended)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale (Scale Definition)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_value_regex' = '1-5|1-10|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (When record was first captured)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (When record was last modified)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number (PRN)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period` SET TAGS ('dbx_business_glossary_term' = 'Review Period');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (Current lifecycle state of the review)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submission Timestamp (DateTime when review was submitted)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type (e.g., Annual, Mid-Year, Probation, Project)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid-year|probation|project');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments (Additional comments from reviewer)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `certification_earned` SET TAGS ('dbx_business_glossary_term' = 'Certification Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Passed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|expired|in_progress');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `applicable_job_profiles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Profiles');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'exam|quiz|practical|project|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_category` SET TAGS ('dbx_value_regex' = 'compliance|safety|gmp|leadership|technical|professional');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Related Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_related_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_related_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Course Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|blended|self_paced');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `is_compliance_course` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Course');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `is_enrollment_open` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Course Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_course_codes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `provider` SET TAGS ('dbx_business_glossary_term' = 'Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `provides_certification` SET TAGS ('dbx_business_glossary_term' = 'Provides Certification Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `recertification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending_approval');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Course Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee ID (BIGINT)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Date (DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|denied|approved|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type (Medical/Indemnity/Both/Other) (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'medical|indemnity|both|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (TIMESTAMP)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work (INT)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_lost` SET TAGS ('dbx_business_glossary_term' = 'Days Lost');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status (Open/Closed/Reopened) (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|closed|reopened');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time (TIMESTAMP)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type (Injury, Illness, Near-Miss, First Aid, Property Damage)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|illness|near_miss|first_aid|property_damage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Cost Amount (DECIMAL(12,2))');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_value_regex' = 'laceration|fracture|burn|sprain|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `lost_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Medical Cost Amount (DECIMAL(12,2))');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `medical_cost` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `medical_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `modified_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Duty Flag (Boolean)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_300_classification` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Classification (Recordable/Non-Recordable/Other)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_300_classification` SET TAGS ('dbx_value_regex' = 'recordable|non_recordable|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag (Boolean)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `plant_site` SET TAGS ('dbx_business_glossary_term' = 'Plant or Site Identifier (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `restricted_duty_days` SET TAGS ('dbx_business_glossary_term' = 'Restricted Duty Days (INT)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date (DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|human_error|process|environment|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (Low/Medium/High/Critical) (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|graveyard|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Cost Amount (DECIMAL(12,2))');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `total_cost` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `total_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `tpa_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Administrator Reference (STRING)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (TIMESTAMP)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Days of Week');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `days_of_week` SET TAGS ('dbx_value_regex' = 'weekday|weekend|mon_fri|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `headcount_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Headcount Per Shift');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'production|warehouse|logistics|maintenance|admin');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `max_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hours Per Day');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `max_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hours Per Week');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_trigger_minutes` SET TAGS ('dbx_business_glossary_term' = 'Overtime Trigger (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `payroll_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|rotating|flexible|continental|dsd_route');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_group` SET TAGS ('dbx_business_glossary_term' = 'Shift Group');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = '2_shift|3_shift|4_crew_continental|12_hour_alternating');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Relation Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (STS)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|negotiating');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGT)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'CBA|Labor Management Agreement|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `arbitration_award_reference` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Award Reference (ARBIT_AWARD_REF)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `arbitration_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `bargaining_unit` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `cba_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement Number (CBA)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `cba_reference` SET TAGS ('dbx_business_glossary_term' = 'Cba Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_description` SET TAGS ('dbx_business_glossary_term' = 'Labor Relation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_description` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `labor_relation_description` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `facility_covered` SET TAGS ('dbx_business_glossary_term' = 'Facility Covered');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `filed_date` SET TAGS ('dbx_business_glossary_term' = 'Filed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_category` SET TAGS ('dbx_business_glossary_term' = 'Grievance Category');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_filer` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filer Identifier (GRV_FILER)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_filer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_filer` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filing Date (GRV_FILE_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number (GRV_NUM)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Grievance Outcome (GRV_OUTCOME)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|settled|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date (GRV_RES_DATE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status (GRV_STS)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'open|closed|settled|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_step` SET TAGS ('dbx_business_glossary_term' = 'Grievance Step (GRV_STEP)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_step` SET TAGS ('dbx_value_regex' = 'filed|review|mediation|arbitration|resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type (GRV_TYPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'pay|benefits|working_conditions|disciplinary|other');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `negotiation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation End Date (NEG_END)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date (NEG_START)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Status (NEG_STS)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|stalled');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `relation_type` SET TAGS ('dbx_business_glossary_term' = 'Relation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `relation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `relation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `union_steward` SET TAGS ('dbx_business_glossary_term' = 'Union Steward Name (STEWARD)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `union_steward` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `union_steward` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `wage_scale_reference` SET TAGS ('dbx_business_glossary_term' = 'Wage Scale Reference (WSR)');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `wage_scale_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `wage_scale_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_association_edges' = 'workforce.employee,workforce.training_course');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Enrollment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Training Course Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `auto_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enrolled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `certification_earned` SET TAGS ('dbx_business_glossary_term' = 'Certification Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Credits Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `dependents_count` SET TAGS ('dbx_business_glossary_term' = 'Dependents Count');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_description` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `election_amount` SET TAGS ('dbx_business_glossary_term' = 'Election Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `is_qualifying_life_event` SET TAGS ('dbx_business_glossary_term' = 'Is Qualifying Life Event');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_name` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `pre_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre Tax Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Source');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Waived Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `referring_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Applicant Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `referring_applicant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_status` SET TAGS ('dbx_business_glossary_term' = 'Applicant Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Certifications');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `department_applied` SET TAGS ('dbx_business_glossary_term' = 'Department Applied');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `interview_feedback` SET TAGS ('dbx_business_glossary_term' = 'Interview Feedback');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Id Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `position_applied` SET TAGS ('dbx_business_glossary_term' = 'Position Applied');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `preferred_location` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `relocation_willingness` SET TAGS ('dbx_business_glossary_term' = 'Relocation Willingness');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `resume_reference` SET TAGS ('dbx_business_glossary_term' = 'Resume Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `resume_text` SET TAGS ('dbx_business_glossary_term' = 'Resume Text');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `skills` SET TAGS ('dbx_business_glossary_term' = 'Skills');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `visa_expiration` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiration');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `years_experience` SET TAGS ('dbx_business_glossary_term' = 'Years Experience');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years Of Experience');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `correction_payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Correction Payroll Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `correction_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_end` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_start` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `tax_withholding_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Overtime Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `parent_work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Location Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `parent_work_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `is_primary_location` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Location');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `latitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `longitude` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `work_location_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `safety_incident_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Reporting Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `work_location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `previous_payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Payroll Period Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `previous_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `cut_off_date` SET TAGS ('dbx_business_glossary_term' = 'Cut Off Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `days_in_period` SET TAGS ('dbx_business_glossary_term' = 'Days In Period');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `is_holiday_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Adjusted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `processing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Processing Deadline');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payroll Group Id');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `accrual_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Accrual Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `default_currency` SET TAGS ('dbx_business_glossary_term' = 'Default Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `max_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Max Hours Per Week');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `min_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Min Hours Per Week');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `pay_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Pay Cycle Day');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `payroll_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `tax_withholding_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Code');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
