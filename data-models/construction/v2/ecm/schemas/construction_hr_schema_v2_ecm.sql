-- Schema for Domain: hr | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`hr` COMMENT 'Corporate human resources domain managing salaried employee records, organizational structure, benefits administration, performance management, recruitment, training, and labor compliance for office and management staff distinct from field craft labor';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`hr_employee` (
    `hr_employee_id` BIGINT COMMENT 'System-generated unique identifier for each employee record.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to hr.job_profile. Business justification: Job profile centralizes job title and grade; hr.job_profile_id FK replaces redundant job_title and job_grade columns.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager or supervisor.',
    `base_salary` DECIMAL(18,2) COMMENT 'Base monetary compensation before bonuses or allowances.',
    `compensation_type` STRING COMMENT 'Method of compensation for the employee.. Valid values are `salary|hourly|contract`',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with the employees labor expenses.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for salary payments.. Valid values are `[A-Z]{3}`',
    `date_of_birth` DATE COMMENT 'Employees birth date, used for age‑based benefits and compliance.',
    `department_code` STRING COMMENT 'Code identifying the department to which the employee belongs.',
    `education_level` STRING COMMENT 'Highest level of formal education attained.. Valid values are `high_school|associate|bachelor|master|doctorate|other`',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `employee_number` STRING COMMENT 'Company‑assigned employee number used for internal HR processes.',
    `employee_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `permanent|fixed_term|secondment|contractor`',
    `employment_status` STRING COMMENT 'Current employment state of the employee.. Valid values are `active|terminated|on_leave|retired`',
    `first_name` STRING COMMENT 'Given name of the employee as recorded on official documents.',
    `gender` STRING COMMENT 'Self‑identified gender of the employee.. Valid values are `male|female|other|prefer_not_to_say`',
    `health_insurance_plan` STRING COMMENT 'Name of the health insurance plan the employee is enrolled in.',
    `hire_date` DATE COMMENT 'Date the employee officially started employment.',
    `hse_training_completed` BOOLEAN COMMENT 'Indicates whether the employee has completed mandatory Health, Safety, and Environment training.',
    `last_name` STRING COMMENT 'Family name (surname) of the employee.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation.',
    `location_code` STRING COMMENT 'Primary site or office location where the employee works.',
    `marital_status` STRING COMMENT 'Current marital status of the employee.. Valid values are `single|married|divorced|widowed|partnered`',
    `national_id_number` STRING COMMENT 'Government‑issued personal identifier (e.g., SSN, NIN).',
    `pay_frequency` STRING COMMENT 'Regular interval at which the employee is paid.. Valid values are `monthly|biweekly|weekly|semi_monthly`',
    `performance_rating_last_year` STRING COMMENT 'Overall performance rating for the most recent review year.. Valid values are `excellent|good|satisfactory|needs_improvement`',
    `phone_number` STRING COMMENT 'Primary telephone number listed for the employee.',
    `professional_certifications` STRING COMMENT 'Comma‑separated list of professional certifications held by the employee.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `retirement_plan` STRING COMMENT 'Retirement or pension plan assigned to the employee.',
    `security_clearance_level` STRING COMMENT 'Level of security clearance granted to the employee.. Valid values are `none|confidential|secret|top_secret`',
    `social_security_number` STRING COMMENT 'U.S. Social Security Number for payroll and tax reporting.',
    `tax_id_number` STRING COMMENT 'Tax identifier used for payroll reporting and statutory filings.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for employee separation (e.g., resignation, layoff, retirement).',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `visa_status` STRING COMMENT 'Visa or residency status of the employee.. Valid values are `citizen|permanent_resident|work_visa|other`',
    `work_permit_expiry` DATE COMMENT 'Expiration date of the work permit.',
    `work_permit_number` STRING COMMENT 'Number of the work permit authorizing employment, if required.',
    CONSTRAINT pk_hr_employee PRIMARY KEY(`hr_employee_id`)
) COMMENT 'Master record for all salaried, office, and management staff employed by the construction enterprise. Captures full employee identity, employment classification, job title, grade, department, cost center, employment type (permanent, fixed-term, secondment), hire date, termination date, work location, manager, and employment status. SSOT for corporate HR personnel distinct from field craft labor (owned by workforce domain). Integrates with payroll, benefits, performance, and organizational hierarchy.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`position` (
    `position_id` BIGINT COMMENT 'System generated unique identifier for the position record.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to hr.job_profile. Business justification: Linking position to its job profile consolidates overlapping descriptive attributes and eliminates redundancy, ensuring each position references a single authoritative job profile.',
    `hr_org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Positions are scoped to an org unit; position.org_unit_id FK provides hierarchy and allows removal of location_code which is stored in org unit.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the creation of the position.',
    `primary_reporting_position_id` BIGINT COMMENT 'Identifier of the immediate supervisory position.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the position was approved for creation.',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether the position participates in company benefit programs.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for performance bonuses.',
    `budgeted_salary` DECIMAL(18,2) COMMENT 'Salary amount allocated in the project or department budget.',
    `closing_date` DATE COMMENT 'Date the recruitment posting closed.',
    `position_code` STRING COMMENT 'External or legacy code used to reference the position in HR systems.',
    `competency_required` STRING COMMENT 'Key competency or skill set required for the position.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the positions expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system.',
    `department_code` STRING COMMENT 'Organizational department that owns the position.',
    `position_description` STRING COMMENT 'Narrative description of duties, responsibilities, and expectations.',
    `effective_end_date` DATE COMMENT 'Date when the position is scheduled to be retired or closed (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active and can be filled.',
    `fte` DECIMAL(18,2) COMMENT 'Allocated full‑time equivalent headcount for the position.',
    `grade_band` STRING COMMENT 'Compensation grade band assigned to the position (e.g., G5, G6).',
    `is_exempt` BOOLEAN COMMENT 'Indicates if the position is exempt from overtime regulations.',
    `is_manager` BOOLEAN COMMENT 'True if the position includes managerial responsibilities.',
    `job_level` STRING COMMENT 'Hierarchical level within the job family (e.g., Level 3, Manager).',
    `language_requirements` STRING COMMENT 'Languages and proficiency levels required for the position.',
    `last_filled_timestamp` TIMESTAMP COMMENT 'Timestamp when the position was most recently filled by an employee.',
    `position_status` STRING COMMENT 'Current occupancy status of the position.',
    `posting_date` DATE COMMENT 'Date the position was posted for recruitment.',
    `remote_allowed` BOOLEAN COMMENT 'Indicates whether the position can be performed remotely.',
    `salary_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the position, annualized in USD.',
    `salary_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the position, annualized in USD.',
    `security_clearance_level` STRING COMMENT 'Required security clearance for the role.',
    `shift_type` STRING COMMENT 'Work shift pattern associated with the position.',
    `title` STRING COMMENT 'Official title of the authorized position (e.g., Senior Project Engineer).',
    `union_member` BOOLEAN COMMENT 'True if the position is covered by a labor union.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    `vacancy_reason` STRING COMMENT 'Reason why the position is vacant or being created.',
    `work_schedule` STRING COMMENT 'Standard weekly schedule for the position.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized position (headcount slot) within the organizational structure. Defines the approved role, job family, grade band, FTE allocation, reporting line, department, cost center, and whether the position is filled or vacant. Supports headcount planning, org design, and recruitment requisition. Each employee is linked to a position; positions exist independently of incumbents to support vacancy management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` (
    `hr_org_unit_id` BIGINT COMMENT 'Unique surrogate key for the organizational unit.',
    `hr_employee_id` BIGINT COMMENT 'Surrogate key of the employee who is the primary manager of the unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the hierarchy.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the unit, expressed in the corporate currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the organizational unit record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the unit ceased operation or was retired; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the unit became operational.',
    `email` STRING COMMENT 'Primary email address for the unit.',
    `gl_cost_center_code` STRING COMMENT 'Finance cost‑center code associated with the unit for budgeting and reporting.',
    `headcount` STRING COMMENT 'Number of employees assigned to the unit.',
    `location` STRING COMMENT 'Primary physical location or office address of the unit.',
    `org_unit_code` STRING COMMENT 'Unique business code used to identify the unit in ERP and reporting systems.',
    `org_unit_description` STRING COMMENT 'Free‑text description of the unit’s purpose and responsibilities.',
    `org_unit_level` STRING COMMENT 'Depth level of the unit within the organization tree (root = 1).',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the organizational unit (e.g., "East Coast Construction Division").',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the unit.. Valid values are `active|inactive|planned|closed`',
    `org_unit_type` STRING COMMENT 'Category of the unit within the corporate hierarchy.. Valid values are `division|business_unit|department|cost_center|team`',
    `phone_number` STRING COMMENT 'Main telephone contact for the unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the organizational unit record.',
    CONSTRAINT pk_hr_org_unit PRIMARY KEY(`hr_org_unit_id`)
) COMMENT 'Organizational unit master defining the hierarchical structure of the construction enterprise — divisions, business units, departments, and cost centers. Captures unit name, unit type, parent unit, effective dates, responsible manager, and associated GL cost center. Supports org chart rendering, reporting hierarchies, and cost allocation. Distinct from project WBS (owned by project domain) and field crew structures (owned by workforce domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'System-generated unique identifier for the job profile record.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `award_classification` STRING COMMENT 'Industrial award or enterprise agreement governing employment terms for the role.. Valid values are `Modern Award|Enterprise Agreement|Other`',
    `job_profile_code` STRING COMMENT 'External reference code used in HR systems and recruitment tools.',
    `compensation_type` STRING COMMENT 'Method of remuneration for the role (e.g., salaried, hourly, contract, commission).. Valid values are `Salary|Hourly|Contract|Commission`',
    `competency_framework` STRING COMMENT 'Name of the competency model or framework applied to assess the role.',
    `competency_level` STRING COMMENT 'Expected proficiency tier for the role within the competency framework.. Valid values are `Basic|Intermediate|Advanced|Expert`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the job profile record was first created in the system.',
    `job_profile_description` STRING COMMENT 'Free‑text narrative describing responsibilities, scope, and key duties of the role.',
    `effective_from` DATE COMMENT 'Date from which the job profile definition becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the job profile definition is no longer valid (nullable for open‑ended).',
    `employment_type` STRING COMMENT 'Nature of the employment relationship for the role.. Valid values are `Full-time|Part-time|Casual|Contractor|Temporary`',
    `health_and_safety_training_required` BOOLEAN COMMENT 'Indicates whether mandatory HSE training is required before an employee can assume the role.',
    `is_field_facing` BOOLEAN COMMENT 'True if the role primarily works on construction sites or field locations.',
    `is_office_based` BOOLEAN COMMENT 'True if the role is primarily performed in an office environment.',
    `is_project_based` BOOLEAN COMMENT 'True if the role is assigned to specific projects rather than a functional department.',
    `is_union_covered` BOOLEAN COMMENT 'Indicates whether the role is covered by a labor union or award.',
    `job_family` STRING COMMENT 'Broad functional grouping of the role for talent management and reporting.. Valid values are `Engineering|Project Management|Finance|Procurement|Safety|Administration`',
    `job_family_code` STRING COMMENT 'Standardized code representing the job family for integration with external taxonomy.',
    `job_grade` STRING COMMENT 'Internal grade or level assigned to the role for compensation and career progression.',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile.. Valid values are `Active|Inactive|Deprecated|Pending Approval`',
    `location_type` STRING COMMENT 'Primary work location category for the role.. Valid values are `Office|Field|Project|Remote`',
    `overtime_eligible` BOOLEAN COMMENT 'True if the role is eligible for overtime compensation under applicable awards.',
    `reporting_manager_role` STRING COMMENT 'Standardized title of the role to which this position reports.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of professional certifications mandatory for the role.',
    `required_education` STRING COMMENT 'Minimum educational qualification required for the role.. Valid values are `High School|Associate|Bachelor|Master|Doctorate|Other`',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience needed to perform the role.',
    `salary_band_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range applicable to the role, expressed in local currency.',
    `salary_band_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range applicable to the role, expressed in local currency.',
    `title` STRING COMMENT 'Standardized name of the job role as used across the enterprise.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether the role requires regular travel between sites or offices.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the job profile record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Job profile and role definition master capturing the standardized job title, job family, job level/grade, required qualifications, competency framework, and salary band for each role in the construction enterprise. Serves as the template for position creation and recruitment. Includes whether the role is field-facing, office-based, or project-based, and the applicable industrial award or enterprise agreement classification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique surrogate key for the employment contract record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the salaried employee to whom the contract applies.',
    `superseded_employment_contract_id` BIGINT COMMENT 'Self-referencing FK on employment_contract (superseded_employment_contract_id)',
    `agreement_category` STRING COMMENT 'Classification of the contract based on its governing agreement or award.. Valid values are `standard|enterprise|project_specific`',
    `amendment_date` DATE COMMENT 'Date when the latest amendment was executed.',
    `amendment_number` STRING COMMENT 'Sequential number of contract amendment.',
    `award_code` STRING COMMENT 'Industrial award or collective bargaining agreement code applicable.',
    `benefits_description` STRING COMMENT 'Textual description of employee benefits provided under the contract.',
    `bonus_entitlement` DECIMAL(18,2) COMMENT 'Potential annual bonus amount payable under the contract.',
    `comments` STRING COMMENT 'Free-text field for additional notes or remarks about the contract.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a confidentiality clause.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic contract document.',
    `contract_number` STRING COMMENT 'External reference number assigned to the employment contract.',
    `contract_signed_date` DATE COMMENT 'Date when the contract was signed by all parties.',
    `contract_type` STRING COMMENT 'Category of employment contract indicating the nature of the engagement.. Valid values are `permanent|fixed_term|casual|secondment`',
    `department` STRING COMMENT 'Organizational department where the employee works.',
    `effective_from` DATE COMMENT 'Date when the contract becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contract ends or expires; null for open-ended contracts.',
    `enterprise_agreement_code` STRING COMMENT 'Reference to the enterprise agreement governing the contract.',
    `health_insurance_plan` STRING COMMENT 'Name of the health insurance plan provided.',
    `last_review_date` DATE COMMENT 'Date when the contract was last reviewed for compliance or renewal.',
    `leave_accrual_rate` DECIMAL(18,2) COMMENT 'Annual leave accrual rate in days per year.',
    `leave_balance` DECIMAL(18,2) COMMENT 'Current accrued leave balance in days.',
    `lifecycle_status` STRING COMMENT 'Current state of the contract in its lifecycle.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `location_code` STRING COMMENT 'Code representing the primary work location.',
    `non_compete_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a non-compete clause.',
    `notice_period_days` STRING COMMENT 'Number of days of notice required for termination by either party.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Monetary rate applied for overtime hours.',
    `pension_contribution_percent` DECIMAL(18,2) COMMENT 'Employee pension contribution percentage.',
    `position_title` STRING COMMENT 'Job title or position held by the employee.',
    `probation_period_days` STRING COMMENT 'Length of the probationary period in days.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is set for automatic renewal.',
    `salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary agreed in the contract.',
    `salary_currency` STRING COMMENT 'ISO 4217 currency code for the salary amount.',
    `severance_amount` DECIMAL(18,2) COMMENT 'Monetary severance payable upon termination.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Percentage of salary withheld for tax purposes.',
    `termination_date` DATE COMMENT 'Date on which the contract was terminated.',
    `termination_reason` STRING COMMENT 'Reason provided for contract termination.',
    `working_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of working hours per week.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Employment contract record for each salaried employee, capturing contract type (permanent, fixed-term, casual, secondment), contract start and end dates, notice period, probation period, agreed salary, bonus entitlement, working hours, and applicable enterprise agreement or award. Tracks contract amendments and renewals. Distinct from subcontract agreements (subcontractor domain) and project contracts (contract domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the salaried employee to whom this payroll record applies.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run batch that generated this record.',
    `reversal_payroll_record_id` BIGINT COMMENT 'Self-referencing FK on payroll_record (reversal_payroll_record_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment applied to the payroll (positive or negative).',
    `adjustment_reason` STRING COMMENT 'Reason for the payroll adjustment.. Valid values are `bonus|correction|retroactive|other`',
    `allowance_project` DECIMAL(18,2) COMMENT 'Allowance tied to specific project assignments for the period.',
    `allowance_site` DECIMAL(18,2) COMMENT 'Allowance for site-specific duties during the pay period.',
    `allowance_travel` DECIMAL(18,2) COMMENT 'Allowance for travel expenses incurred during the pay period.',
    `bank_account_last4` STRING COMMENT 'Last four digits of the employees bank account used for payroll deposit.. Valid values are `^d{4}$`',
    `bank_routing_number` STRING COMMENT 'Bank routing number for payroll direct deposit.. Valid values are `^d{9}$`',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Additional bonus payment included in this payroll.',
    `bonus_type` STRING COMMENT 'Category of the bonus payment.. Valid values are `performance|holiday|sign_on|other`',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll was processed.',
    `comments` STRING COMMENT 'Free‑form notes or remarks related to the payroll record.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the payroll amounts.. Valid values are `USD|EUR|GBP|AUD|CAD|JPY`',
    `deduction_other_amount` DECIMAL(18,2) COMMENT 'Amount of any additional deduction not covered by standard categories.',
    `deduction_other_description` STRING COMMENT 'Description of the additional deduction.',
    `deduction_salary_sacrifice` DECIMAL(18,2) COMMENT 'Voluntary salary sacrifice amount (e.g., for retirement or benefits).',
    `deduction_superannuation` DECIMAL(18,2) COMMENT 'Employer‑mandated superannuation (pension) contribution deducted.',
    `deduction_tax` DECIMAL(18,2) COMMENT 'Statutory tax withheld from gross salary.',
    `gross_salary` DECIMAL(18,2) COMMENT 'Total gross salary earned for the pay period before any deductions.',
    `is_off_cycle` BOOLEAN COMMENT 'True if the payroll entry is an off‑cycle or supplemental payment.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the payroll record.. Valid values are `draft|processed|posted|cancelled`',
    `net_pay` DECIMAL(18,2) COMMENT 'Final amount paid to the employee after all allowances and deductions.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked in the pay period.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Hourly rate applied to overtime hours.',
    `pay_period_end` DATE COMMENT 'End date of the pay period covered by this payroll.',
    `pay_period_start` DATE COMMENT 'Start date of the pay period covered by this payroll.',
    `payment_date` DATE COMMENT 'Date on which the net pay was transferred or issued.',
    `payment_method` STRING COMMENT 'Method used to deliver the net pay to the employee.. Valid values are `bank_transfer|check|direct_deposit`',
    `payroll_number` STRING COMMENT 'Business identifier code for the payroll record.',
    `payroll_status` STRING COMMENT 'Current processing status of the payroll record.. Valid values are `pending|completed|failed|reversed`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this payroll record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this payroll record.',
    `superannuation_fund` STRING COMMENT 'Name of the superannuation fund receiving contributions.',
    `tax_code` STRING COMMENT 'Internal tax code used for calculating employee tax.. Valid values are `A|B|C|D|E|F`',
    `tax_year` STRING COMMENT 'Fiscal year to which the tax calculations apply.',
    `year_to_date_deductions` DECIMAL(18,2) COMMENT 'Aggregate of all deductions (tax, superannuation, etc.) for the fiscal year.',
    `year_to_date_gross` DECIMAL(18,2) COMMENT 'Cumulative gross earnings for the employee in the current fiscal year.',
    `year_to_date_net` DECIMAL(18,2) COMMENT 'Cumulative net earnings for the employee in the current fiscal year.',
    `year_to_date_tax` DECIMAL(18,2) COMMENT 'Total tax withheld for the employee in the current fiscal year.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Periodic payroll processing record for each salaried employee capturing pay period, gross salary, allowances (site allowance, travel allowance, project allowance), deductions (tax, superannuation/pension, salary sacrifice), net pay, payment method, and payroll run status. Tracks payroll adjustments, off-cycle payments, and year-to-date accumulators. SSOT for corporate payroll distinct from field craft labor payroll (workforce domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'System-generated unique identifier for the benefit plan record.',
    `hr_org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to hr.hr.org_unit_id - benefit plans are sponsored by an organizational unit',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|suspended|terminated|pending`',
    `co_pay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the employee pays per service encounter.',
    `confidential_benefit` BOOLEAN COMMENT 'True if the benefit details are treated as confidential within the organization.',
    `coverage_description` STRING COMMENT 'Narrative description of what the plan covers, including limits and exclusions.',
    `coverage_level` STRING COMMENT 'Scope of coverage (e.g., individual, employee+spouse, family).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the benefit plan record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of monetary values.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the employee must pay before the plan starts covering expenses.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan terminates or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active for eligible employees.',
    `eligibility_criteria` STRING COMMENT 'Rules defining which employees are eligible (e.g., full‑time, tenure, job grade).',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of the premium deducted from employee payroll.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of the premium paid by the employer.',
    `enrollment_end_date` DATE COMMENT 'Last date employees may enroll in the plan for the current period.',
    `enrollment_start_date` DATE COMMENT 'First date employees may enroll in the plan for the current period.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the plan is currently active (true) or not (false).',
    `max_coverage_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit of benefits payable per claim or per year.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum total amount an employee will pay in a benefit year.',
    `plan_admin_email` STRING COMMENT 'Email address of the plan administrator.',
    `plan_admin_name` STRING COMMENT 'Internal contact responsible for plan administration.',
    `plan_admin_phone` STRING COMMENT 'Phone number of the plan administrator.',
    `plan_code` STRING COMMENT 'Internal alphanumeric code used to reference the plan in HR systems.',
    `plan_document_url` STRING COMMENT 'Link to the PDF or web page containing the full plan document.',
    `plan_name` STRING COMMENT 'Descriptive name of the benefit plan as used in employee communications.',
    `plan_type` STRING COMMENT 'Category of the benefit (e.g., health, dental, vision, life, disability, pension, EAP, vehicle allowance, professional membership). [ENUM-REF-CANDIDATE: health|dental|vision|life|disability|pension|eap|vehicle|membership — promote to reference product]',
    `plan_version` STRING COMMENT 'Version identifier for the plan (e.g., v2024.1).',
    `provider_contact_email` STRING COMMENT 'Primary email address for the benefit provider contact.',
    `provider_contact_phone` STRING COMMENT 'Primary phone number for the benefit provider contact.',
    `provider_name` STRING COMMENT 'Name of the external vendor or insurer delivering the benefit.',
    `taxable_benefit` BOOLEAN COMMENT 'True if the benefit is considered taxable income for the employee.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the benefit plan record.',
    `waiting_period_days` STRING COMMENT 'Number of days after enrollment before benefits become payable.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master record defining each employee benefit plan offered by the construction enterprise — health insurance, dental, vision, life insurance, income protection, superannuation/pension, EAP (Employee Assistance Program), vehicle allowance, and professional membership. Captures plan name, plan type, provider, coverage details, eligibility criteria, employer contribution rate, employee contribution rate, and effective dates.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the benefit enrollment record.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier of the benefit plan to which the employee is enrolling.',
    `hr_employee_id` BIGINT COMMENT 'Unique identifier of the employee who is enrolling in the benefit plan.',
    `prior_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (prior_benefit_enrollment_id)',
    `benefit_cost_share` DECIMAL(18,2) COMMENT 'Total cost of the benefit coverage split between employee and employer.',
    `contribution_currency` STRING COMMENT 'Three‑letter ISO currency code of the contribution amount (e.g., USD, EUR).',
    `coverage_end_date` DATE COMMENT 'Date when the benefit coverage ends or is scheduled to terminate (nullable for open‑ended coverage).',
    `coverage_start_date` DATE COMMENT 'Effective date when the selected benefit coverage begins.',
    `coverage_tier` STRING COMMENT 'Level of coverage selected: employee only, employee + spouse, or family.. Valid values are `employee_only|employee_spouse|family`',
    `dependent_count` STRING COMMENT 'Number of dependents covered under the enrollment (spouse and/or children).',
    `elected_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee elects to contribute per pay period for the selected benefit.',
    `employee_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of the premium the employee is responsible for.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount contributed by the employer for the employees coverage.',
    `employer_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of the premium paid by the employer.',
    `enrollment_date` DATE COMMENT 'Date the enrollment transaction was recorded in the system.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `active|inactive|terminated|pending|waived`',
    `mid_year_change_flag` BOOLEAN COMMENT 'True if the enrollment was a change made outside the open enrollment period due to a qualifying event.',
    `open_enrollment_flag` BOOLEAN COMMENT 'True if the enrollment occurred during the annual open enrollment window.',
    `plan_code` STRING COMMENT 'Alphanumeric code used to identify the benefit plan in payroll and HR systems.',
    `plan_group` STRING COMMENT 'Grouping identifier for related benefit plans (e.g., "Medical Benefits Group").',
    `plan_type` STRING COMMENT 'Category of the benefit plan (e.g., health, dental, vision).. Valid values are `health|dental|vision|life|disability|retirement`',
    `plan_version` STRING COMMENT 'Version identifier of the benefit plan (e.g., v2024).',
    `plan_year` STRING COMMENT 'Fiscal year to which the benefit plan version applies.',
    `qualifying_event_date` DATE COMMENT 'Date the qualifying life event occurred.',
    `qualifying_life_event_type` STRING COMMENT 'Type of life event that permits a mid‑year enrollment change.. Valid values are `marriage|birth|adoption|death|divorce|other`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee has waived the benefit (true) or elected coverage (false).',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in a specific benefit plan. Captures enrollment date, coverage tier (employee only, employee + spouse, family), elected contribution amount, effective start and end dates, enrollment status, and any waiver declarations. Tracks open enrollment events, qualifying life events, and mid-year changes. Links employee to benefit plan.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved or rejected the request.',
    `original_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (original_leave_request_id)',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee who submitted the leave request.',
    `accrual_policy_code` STRING COMMENT 'Code referencing the leave accrual policy that governs this request.',
    `approval_decision` STRING COMMENT 'Outcome of the approval process.. Valid values are `approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved or rejected.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting documentation (e.g., medical certificate) is attached.',
    `carryover_allowed` BOOLEAN COMMENT 'True if unused leave days may be carried over to the next year.',
    `comments` STRING COMMENT 'Optional comments from the employee or approver.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the leave request record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar day of the requested leave period.',
    `hr_notified` BOOLEAN COMMENT 'True when the HR department has been notified of the request.',
    `is_paid_leave` BOOLEAN COMMENT 'True if the leave is paid; false if unpaid.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Accrued leave balance for the employee after this request is processed.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Accrued leave balance for the employee prior to this request.',
    `leave_status` STRING COMMENT 'Current lifecycle status of the leave request.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `leave_type` STRING COMMENT 'Category of leave requested (e.g., annual, sick, parental, long service, FMLA, compassionate, study).',
    `leave_year` STRING COMMENT 'Fiscal or calendar year to which the leave request applies.',
    `payroll_impact_flag` BOOLEAN COMMENT 'True if the leave will affect payroll processing.',
    `reason` STRING COMMENT 'Free‑text explanation provided by the employee for the leave request.',
    `request_number` STRING COMMENT 'Human‑readable reference number for the leave request.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the employee submitted the leave request.',
    `start_date` DATE COMMENT 'First calendar day of the requested leave period.',
    `total_days` DECIMAL(18,2) COMMENT 'Number of leave days requested, including fractional days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the leave request record.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave request and approval record capturing leave type (annual leave, sick leave, parental leave, long service leave, FMLA, compassionate leave, study leave), requested start and end dates, number of days, approval status, approver, approval date, and leave balance impact. Tracks leave accruals, carryover balances, and leave liability for financial reporting. Applies to salaried staff distinct from field craft labor attendance (workforce domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`leave_balance` (
    `leave_balance_id` BIGINT COMMENT 'Unique surrogate key for the leave balance record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee to whom this leave balance applies.',
    `prior_leave_balance_id` BIGINT COMMENT 'Self-referencing FK on leave_balance (prior_leave_balance_id)',
    `accrual_cap` DECIMAL(18,2) COMMENT 'Maximum leave that can be accrued for this type.',
    `accrual_method` STRING COMMENT 'Method used to calculate leave accruals.. Valid values are `pro_rata|full_month|custom`',
    `accrual_period` STRING COMMENT 'Frequency at which leave accrues.. Valid values are `monthly|quarterly|annually|weekly`',
    `accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which leave accrues per accrual period (e.g., days per month).',
    `accrued_balance` DECIMAL(18,2) COMMENT 'Total leave accrued to date.',
    `as_of_date` DATE COMMENT 'Date for which the balance snapshot is recorded.',
    `available_balance` DECIMAL(18,2) COMMENT 'Leave currently available for use.',
    `balance_number` STRING COMMENT 'Human‑readable identifier for the leave balance entry.',
    `balance_status` STRING COMMENT 'Current status of the leave balance record.. Valid values are `active|frozen|closed`',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the payroll run that generated this balance snapshot.',
    `carryover_allowed` BOOLEAN COMMENT 'Indicates if unused leave can be carried over to the next period.',
    `carryover_limit` DECIMAL(18,2) COMMENT 'Maximum amount of leave that can be carried over.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave balance record was created.',
    `effective_end_date` DATE COMMENT 'Date when this leave balance ceases to be effective.',
    `effective_start_date` DATE COMMENT 'Date when this leave balance becomes effective.',
    `eligibility_criteria` STRING COMMENT 'Conditions under which the employee is eligible for this leave type.',
    `forfeited_balance` DECIMAL(18,2) COMMENT 'Leave that has been forfeited.',
    `last_accrual_date` DATE COMMENT 'Date of the most recent accrual calculation.',
    `leave_policy_code` STRING COMMENT 'Code of the leave policy governing accrual and usage.',
    `leave_type` STRING COMMENT 'Category of leave (e.g., Annual, Sick, Parental).. Valid values are `annual|sick|parental|bereavement|compensatory|unpaid`',
    `lifecycle_status` STRING COMMENT 'Lifecycle state of the balance record.. Valid values are `active|inactive|archived`',
    `next_accrual_date` DATE COMMENT 'Scheduled date for the next accrual.',
    `notes` STRING COMMENT 'Free‑form notes regarding the leave balance.',
    `pending_balance` DECIMAL(18,2) COMMENT 'Leave approved but not yet taken.',
    `taken_balance` DECIMAL(18,2) COMMENT 'Leave already taken.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the leave balance record.',
    CONSTRAINT pk_leave_balance PRIMARY KEY(`leave_balance_id`)
) COMMENT 'Current leave balance ledger for each employee by leave type, capturing accrued balance, taken balance, pending balance, forfeited balance, and available balance as of the last payroll run. Tracks leave accrual rates, maximum accrual caps, and carryover rules per employment contract and applicable award. Supports leave liability reporting for financial statements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'System-generated unique identifier for the recruitment requisition record.',
    `hr_org_unit_id` BIGINT COMMENT 'Identifier of the organizational department owning the vacancy.',
    `position_id` BIGINT COMMENT 'Reference to the master position record that defines the role and responsibilities.',
    `hr_employee_id` BIGINT COMMENT 'Employee identifier of the manager responsible for the hire.',
    `replacement_recruitment_requisition_id` BIGINT COMMENT 'Self-referencing FK on recruitment_requisition (replacement_recruitment_requisition_id)',
    `approval_date` DATE COMMENT 'Date on which the requisition received formal approval.',
    `approved_headcount` STRING COMMENT 'Number of positions approved for this requisition.',
    `budget_code` STRING COMMENT 'Financial budget identifier linked to the requisitions cost allocation.',
    `closing_date` DATE COMMENT 'Date after which the requisition will no longer accept applications.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for funding the new hire.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the salary range.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `employment_type` STRING COMMENT 'Classification of the employment relationship (e.g., full‑time, part‑time, contract).. Valid values are `full_time|part_time|contract|temporary|intern`',
    `expected_fte` DOUBLE COMMENT 'Projected full‑time equivalent effort the new hire will contribute.',
    `external_job_posting` BOOLEAN COMMENT 'True if the requisition is posted on external job boards or agencies.',
    `internal_job_posting` BOOLEAN COMMENT 'True if the requisition is posted on internal employee portals.',
    `interview_process` STRING COMMENT 'Outline of interview stages and assessment methods for the role.',
    `job_grade` STRING COMMENT 'Internal grade or level assigned to the position for compensation and hierarchy.',
    `justification` STRING COMMENT 'Business reason for creating the requisition, including project or operational need.',
    `posting_date` DATE COMMENT 'Date when the requisition was first posted to internal/external channels.',
    `priority_level` STRING COMMENT 'Urgency classification of the requisition for resource planning.. Valid values are `low|medium|high|critical`',
    `recruitment_requisition_status` STRING COMMENT 'Current lifecycle state of the requisition (e.g., draft, approved, active, on‑hold, filled, cancelled).. Valid values are `draft|approved|active|on_hold|filled|cancelled`',
    `recruitment_source` STRING COMMENT 'Origin of the candidate pipeline for this requisition.. Valid values are `job_board|social_media|employee_referral|recruiter|internal`',
    `remote_option` BOOLEAN COMMENT 'Indicates whether the position can be performed remotely (true) or requires on‑site presence (false).',
    `required_education_level` STRING COMMENT 'Minimum educational qualification required for the role.. Valid values are `high_school|associate|bachelor|master|doctorate`',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience candidates must possess.',
    `requisition_number` STRING COMMENT 'Human‑readable reference number assigned to the requisition, used in communications and tracking.',
    `requisition_timestamp` TIMESTAMP COMMENT 'Date‑time when the requisition was formally created or issued.',
    `salary_max` DECIMAL(18,2) COMMENT 'Upper bound of the annual salary range offered for the position.',
    `salary_min` DECIMAL(18,2) COMMENT 'Lower bound of the annual salary range offered for the position.',
    `skill_set` STRING COMMENT 'Comma‑separated list of key skills and competencies needed.',
    `sourcing_strategy` STRING COMMENT 'Approach used to source candidates (e.g., internal posting, external recruiter).. Valid values are `internal|external|recruiter|employee_referral|agency`',
    `target_start_date` DATE COMMENT 'Planned date for the new hire to begin work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the requisition record.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Recruitment requisition record initiated when a position vacancy is approved for filling. Captures requisition number, position, department, hiring manager, approved headcount, employment type, target start date, salary range, requisition status (draft, approved, active, on-hold, filled, cancelled), sourcing strategy, and justification. Links to the approved position and org unit. Drives the end-to-end talent acquisition workflow.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`applicant` (
    `applicant_id` BIGINT COMMENT 'System-generated unique identifier for the applicant record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the recruiter managing this applicant.',
    `position_id` BIGINT COMMENT 'add column position_id (BIGINT) with FK to hr.position.position_id - applicants apply for specific positions',
    `referred_by_applicant_id` BIGINT COMMENT 'Self-referencing FK on applicant (referred_by_applicant_id)',
    `address_line1` STRING COMMENT 'First line of the applicants mailing address.',
    `address_line2` STRING COMMENT 'Second line of the applicants mailing address, if applicable.',
    `applicant_status` STRING COMMENT 'Current lifecycle status of the applicant within the recruitment process.. Valid values are `applied|interviewed|offered|hired|rejected|withdrawn`',
    `application_date` DATE COMMENT 'Date on which the applicant submitted the application.',
    `availability_date` DATE COMMENT 'Earliest date the applicant is available to start work.',
    `background_check_status` STRING COMMENT 'Current status of the applicants background screening process.. Valid values are `not_started|in_progress|cleared|failed`',
    `certifications` STRING COMMENT 'Comma‑separated list of professional certifications held by the applicant.',
    `citizenship_country_code` STRING COMMENT 'ISO country code representing the applicants citizenship.',
    `city` STRING COMMENT 'City component of the applicants mailing address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the applicants country of residence.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the expected salary.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `current_employer` STRING COMMENT 'Name of the organization where the applicant is currently employed.',
    `date_of_birth` DATE COMMENT 'Applicants birth date for eligibility and compliance checks.',
    `email_address` STRING COMMENT 'Primary email address used for communication with the applicant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_salary` DECIMAL(18,2) COMMENT 'Salary amount the applicant expects or requests for the role.',
    `full_name` STRING COMMENT 'Legal full name of the applicant as provided in the application.',
    `gdpr_consent_status` STRING COMMENT 'Current status of the applicants consent for processing personal data under GDPR.. Valid values are `granted|revoked|pending`',
    `gdpr_consent_timestamp` TIMESTAMP COMMENT 'Date and time when the applicant provided or updated GDPR consent.',
    `gender` STRING COMMENT 'Self‑identified gender of the applicant.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `highest_qualification` STRING COMMENT 'Highest academic degree or certification attained by the applicant.. Valid values are `high_school|associate|bachelor|master|doctorate|other`',
    `languages` STRING COMMENT 'Comma‑separated list of languages the applicant can speak, with proficiency levels if known.',
    `linkedin_profile_url` STRING COMMENT 'URL to the applicants LinkedIn professional profile.',
    `national_id_number` STRING COMMENT 'Government‑issued national identification number of the applicant.',
    `passport_number` STRING COMMENT 'Passport number of the applicant for international travel verification.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant.',
    `position_applied_code` STRING COMMENT 'Code identifying the position for which the applicant applied.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the applicants mailing address.',
    `qualification_field` STRING COMMENT 'Field of study or professional discipline of the highest qualification (e.g., civil engineering).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the applicant record.',
    `referral_source` STRING COMMENT 'Name or identifier of the person or entity that referred the applicant, if applicable.',
    `resume_reference` STRING COMMENT 'Reference (e.g., file path or storage key) to the applicants uploaded resume/CV.',
    `skills` STRING COMMENT 'Comma‑separated list of key skills and competencies reported by the applicant.',
    `source_channel` STRING COMMENT 'Channel through which the applicant learned about or applied for the position.. Valid values are `linkedin|referral|agency|careers_portal|internal|other`',
    `state_province` STRING COMMENT 'State or province component of the applicants mailing address.',
    `visa_status` STRING COMMENT 'Current visa or work‑authorization status of the applicant.. Valid values are `citizen|permanent_resident|work_visa|student_visa|none`',
    `willingness_to_relocate` BOOLEAN COMMENT 'Indicates whether the applicant is willing to relocate for the position.',
    `years_of_experience` STRING COMMENT 'Total number of years of relevant professional experience reported by the applicant.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Candidate/applicant master record for individuals who have applied for a position within the construction enterprise. Captures applicant name, contact details, source channel (LinkedIn, referral, agency, careers portal), CV/resume reference, current employer, years of experience, highest qualification, and GDPR/privacy consent status. Maintains applicant identity across multiple applications and recruitment cycles.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`application` (
    `application_id` BIGINT COMMENT 'System-generated unique identifier for the job application record.',
    `applicant_id` BIGINT COMMENT 'Unique identifier of the candidate who submitted the application.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the recruiter or hiring manager responsible for this application.',
    `recruitment_requisition_id` BIGINT COMMENT 'Identifier of the recruitment requisition to which this application belongs.',
    `resubmitted_application_id` BIGINT COMMENT 'Self-referencing FK on application (resubmitted_application_id)',
    `application_date` DATE COMMENT 'Date the candidate submitted the application.',
    `application_number` STRING COMMENT 'Business-facing reference number for the application (e.g., APP-2023-00123).',
    `application_status` STRING COMMENT 'Current lifecycle status of the application within the recruitment pipeline. [ENUM-REF-CANDIDATE: applied|screening|interview|offer|hired|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `assessment_result` STRING COMMENT 'Outcome of any pre‑screening assessments or tests.. Valid values are `pass|fail|pending`',
    `cover_letter_url` STRING COMMENT 'Link to the candidates uploaded cover letter.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for the salary amounts.. Valid values are `^[A-Z]{3}$`',
    `interview_score` DECIMAL(18,2) COMMENT 'Aggregated numeric score from interview assessments (scale 0‑10).',
    `notes` STRING COMMENT 'Free‑form notes entered by recruiters or hiring managers.',
    `offer_accepted` BOOLEAN COMMENT 'Indicates whether the candidate has accepted the job offer.',
    `offer_salary_gross` DECIMAL(18,2) COMMENT 'Base salary amount offered to the candidate before deductions.',
    `offer_salary_net` DECIMAL(18,2) COMMENT 'Take‑home salary after standard deductions.',
    `offer_start_date` DATE COMMENT 'Proposed first day of employment if the offer is accepted.',
    `rejection_reason` STRING COMMENT 'Textual reason provided when the application is rejected.',
    `resume_url` STRING COMMENT 'Link to the candidates uploaded resume document.',
    `salary_adjustment` DECIMAL(18,2) COMMENT 'Additional monetary adjustments to the offer (e.g., signing bonus, relocation allowance).',
    `source` STRING COMMENT 'Origin channel through which the candidate applied.. Valid values are `referral|job_board|agency|internal|social_media`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the application record.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Job application transactional record linking an applicant to a specific recruitment requisition. Captures application date, application status (applied, screening, interview, offer, hired, rejected, withdrawn), stage in the recruitment pipeline, interview scores, assessment results, offer details (offered salary, start date), offer acceptance status, and rejection reason. Tracks the full candidate journey from application to hire or rejection.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'System-generated unique identifier for the performance review record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the salaried employee being reviewed.',
    `prior_performance_review_id` BIGINT COMMENT 'Self-referencing FK on performance_review (prior_performance_review_id)',
    `tertiary_performance_hr_approval_employee_id` BIGINT COMMENT 'Identifier of the HR representative who approved the review.',
    `bonus_eligible` BOOLEAN COMMENT 'Flag indicating if the employee qualifies for a performance bonus.',
    `calibration_comments` STRING COMMENT 'Comments from the calibration committee.',
    `calibration_status` STRING COMMENT 'Status of the calibration process across the organization.. Valid values are `pending|completed|adjusted`',
    `compensation_change_flag` BOOLEAN COMMENT 'Indicates whether the review resulted in a compensation change.',
    `competency_score` DECIMAL(18,2) COMMENT 'Aggregated competency rating across all competency areas.',
    `employee_self_assessment` STRING COMMENT 'Free‑text self‑evaluation entered by the employee.',
    `final_approved_rating` STRING COMMENT 'Rating after calibration and final approval.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Weighted score reflecting achievement of pre‑set goals.',
    `hr_approval_status` STRING COMMENT 'Current approval status from HR.. Valid values are `pending|approved|rejected`',
    `hr_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when HR completed the approval.',
    `leadership_competency` DECIMAL(18,2) COMMENT 'Score for leadership and people‑management competencies.',
    `lifecycle_status` STRING COMMENT 'Current workflow state of the review record.. Valid values are `draft|in_review|approved|rejected|closed`',
    `manager_comments` STRING COMMENT 'Free‑text feedback provided by the manager.',
    `next_review_due_date` DATE COMMENT 'Planned date for the employees next performance review.',
    `overall_performance_rating` STRING COMMENT 'Executive summary rating of employee performance.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `promotion_eligibility` BOOLEAN COMMENT 'Indicates whether the employee is eligible for promotion based on the review.',
    `rating_explanation` STRING COMMENT 'Narrative explanation of how the rating was derived.',
    `rating_scale` STRING COMMENT 'Definition of the rating scale used (e.g., 1‑5).',
    `rating_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 4.5) corresponding to the overall rating.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `review_cycle` STRING COMMENT 'The scheduled cycle of the review (annual, mid‑year, probation, or project‑end).. Valid values are `annual|mid-year|probation|project-end`',
    `review_date` DATE COMMENT 'Date the review was formally completed.',
    `review_location_code` STRING COMMENT 'Code of the site or office where the review took place.',
    `review_method` STRING COMMENT 'Methodology used to collect review data.. Valid values are `self|manager|360|peer`',
    `review_number` STRING COMMENT 'Human‑readable business identifier for the review (e.g., PR‑2024‑001).',
    `review_period_end` DATE COMMENT 'Last day of the performance period covered by the review.',
    `review_period_start` DATE COMMENT 'First day of the performance period covered by the review.',
    `review_type` STRING COMMENT 'Classification of the review (performance, project, or probation).. Valid values are `performance|project|probation`',
    `review_version` STRING COMMENT 'Version number for the review record to support revisions.',
    `safety_competency` DECIMAL(18,2) COMMENT 'Score for safety‑related competencies, important in construction.',
    `salary_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of salary increase or decrease linked to the review.',
    `succession_plan_flag` BOOLEAN COMMENT 'True if the employee is identified for succession planning.',
    `technical_competency` DECIMAL(18,2) COMMENT 'Score for technical knowledge and skill competencies.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual or mid-year performance review record for a salaried employee. Captures review cycle (annual, mid-year, probation, project-end), review period, overall performance rating, goal achievement score, competency ratings, manager comments, employee self-assessment, calibration status, and final approved rating. Supports performance-linked pay decisions, promotion eligibility, and succession planning for construction management and engineering staff.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`goal` (
    `goal_id` BIGINT COMMENT 'Unique system-generated identifier for the performance goal.',
    `kpi_id` BIGINT COMMENT 'Reference to the corporate KPI that this goal aligns with.',
    `hr_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `parent_goal_id` BIGINT COMMENT 'Self-referencing FK on goal (parent_goal_id)',
    `primary_goal_approved_by_employee_id` BIGINT COMMENT 'Identifier of the manager who approved the goal.',
    `achievement_rating` STRING COMMENT 'Qualitative rating assigned at review time.. Valid values are `exceeds|meets|partially|does_not_meet|not_applicable`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal was approved by the manager.',
    `goal_code` STRING COMMENT 'Business-visible code for the goal, used in reporting and communication.',
    `comments` STRING COMMENT 'Additional comments or notes regarding the goal.',
    `completion_date` DATE COMMENT 'Actual date when the goal was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal record was created.',
    `goal_description` STRING COMMENT 'Detailed description of the goal, including expectations and scope.',
    `due_date` DATE COMMENT 'Date by which the goal is expected to be achieved.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the goal.. Valid values are `draft|active|completed|closed|cancelled`',
    `goal_type` STRING COMMENT 'Classification of the goal indicating its scope and ownership.. Valid values are `individual|team|corporate|project`',
    `is_key_goal` BOOLEAN COMMENT 'Indicates whether this goal is a key strategic goal.',
    `last_review_date` DATE COMMENT 'Date of the most recent performance review for the goal.',
    `measurement_method` STRING COMMENT 'Method used to measure progress toward the target.. Valid values are `absolute|percentage|ratio`',
    `progress_percent` DECIMAL(18,2) COMMENT 'Current progress expressed as a percentage of the target.',
    `rating_score` DECIMAL(18,2) COMMENT 'Numeric score associated with the achievement rating.',
    `review_cycle` STRING COMMENT 'Performance review cycle identifier (e.g., FY2024 Q1).',
    `start_date` DATE COMMENT 'Date when the goal period begins.',
    `supporting_documents` STRING COMMENT 'Link to documents that provide context or evidence for the goal.',
    `target_metric` STRING COMMENT 'Metric or key performance indicator that the goal aims to influence.',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value for the metric.',
    `title` STRING COMMENT 'Short descriptive title of the performance goal.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goal record.',
    `weight_percent` DECIMAL(18,2) COMMENT 'Relative weight of the goal expressed as a percentage of total performance evaluation.',
    CONSTRAINT pk_goal PRIMARY KEY(`goal_id`)
) COMMENT 'Individual performance goal record set for an employee within a performance cycle. Captures goal title, description, goal type (individual, team, corporate, project-specific), weight/percentage, target metric, measurement method, due date, progress status, and achievement rating at review time. Supports cascaded goal-setting from corporate KPIs down to individual construction managers and engineers.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique surrogate identifier for each training course record.',
    `hr_employee_id` BIGINT COMMENT 'Surrogate identifier for the instructor (links to HR personnel record).',
    `prerequisite_training_course_id` BIGINT COMMENT 'Self-referencing FK on training_course (prerequisite_training_course_id)',
    `accreditation_body` STRING COMMENT 'Name of the external body that accredits the course, if any.',
    `accreditation_number` STRING COMMENT 'Reference number assigned by the accreditation body.',
    `applicable_job_profile_codes` STRING COMMENT 'Comma‑separated list of job profile codes for which the course is relevant or required.',
    `assessment_method` STRING COMMENT 'Primary method used to evaluate participant competence.. Valid values are `exam|project|simulation|none`',
    `assessment_pass_rate` DECIMAL(18,2) COMMENT 'Target pass percentage required for participants to receive credit.',
    `certification_awarded_flag` BOOLEAN COMMENT 'Indicates whether successful completion results in a formal certification.',
    `cost` DECIMAL(18,2) COMMENT 'Monetary cost to the organization for delivering the course (e.g., external provider fees).',
    `course_code` STRING COMMENT 'Business identifier code assigned to the training course, used in catalogs and enrollment systems.',
    `course_type` STRING COMMENT 'Classification of the course by business purpose or subject area.. Valid values are `technical|leadership|compliance|hse_awareness|project_management|bim_digital_tools`',
    `cpd_points` DECIMAL(18,2) COMMENT 'Accredited CPD points awarded upon successful completion of the course.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the course cost.',
    `delivery_location` STRING COMMENT 'Physical location or facility where classroom sessions are held (null for virtual).',
    `delivery_mode` STRING COMMENT 'Primary method by which the course is delivered to participants.. Valid values are `classroom|e_learning|on_the_job|external`',
    `training_course_description` STRING COMMENT 'Detailed narrative describing the content, objectives, and outcomes of the training course.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned total instructional time for the course expressed in hours.',
    `effective_end_date` DATE COMMENT 'Date after which the course is retired or no longer offered (null if indefinite).',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment.',
    `enrollment_cap` STRING COMMENT 'Maximum number of participants allowed for a single offering of the course.',
    `enrollment_current` STRING COMMENT 'Number of participants currently enrolled in the upcoming offering.',
    `instructor_name` STRING COMMENT 'Full name of the primary instructor or facilitator.',
    `language` STRING COMMENT 'Primary language in which the course material is delivered.. Valid values are `en|es|fr|de|zh`',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for relevance and compliance.',
    `training_course_level` STRING COMMENT 'Skill level targeted by the course.. Valid values are `beginner|intermediate|advanced`',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the course is required for a specific job profile or compliance purpose.',
    `material_url` STRING COMMENT 'Link to downloadable course materials, slides, or handouts.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks, special instructions, or administrative comments.',
    `online_url` STRING COMMENT 'Web address for accessing the e‑learning version of the course.',
    `prerequisite_course_codes` STRING COMMENT 'Comma‑separated list of course codes that must be completed before enrolling.',
    `review_cycle_months` STRING COMMENT 'Planned interval in months between mandatory content reviews.',
    `target_audience` STRING COMMENT 'Primary employee segment for which the course is intended.. Valid values are `corporate_staff|management|executives`',
    `title` STRING COMMENT 'Human‑readable name of the training course.',
    `training_course_status` STRING COMMENT 'Current lifecycle status of the course.. Valid values are `active|inactive|retired|draft|pending_approval`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the course record.',
    `version_number` STRING COMMENT 'Incremental version identifier for the course content.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master record for each training course or learning program available to corporate and management staff. Captures course code, course title, course type (technical, leadership, compliance, HSE awareness, project management, BIM/digital tools), delivery mode (classroom, e-learning, on-the-job, external), duration, provider, CPD points, mandatory flag, and applicable job profiles. Distinct from field safety inductions (safety domain) and craft certifications (workforce domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the training enrollment record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who is enrolled in the training.',
    `rescheduled_training_enrollment_id` BIGINT COMMENT 'Self-referencing FK on training_enrollment (rescheduled_training_enrollment_id)',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course or program.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the training assessment, typically out of 100.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the issued certificate expires, if applicable.',
    `certificate_issued` BOOLEAN COMMENT 'Indicates whether a certificate was issued after successful completion.',
    `certificate_number` STRING COMMENT 'Unique identifier of the issued certificate.',
    `completion_date` DATE COMMENT 'Actual date the employee completed the training.',
    `compliance_required` BOOLEAN COMMENT 'Indicates if the training is required for regulatory or safety compliance.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost of the training for the organization.',
    `cpd_points` STRING COMMENT 'Number of CPD points awarded for completing the training.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the training cost.. Valid values are `USD|EUR|GBP|CAD|AUD`',
    `delivery_method` STRING COMMENT 'Mode in which the training is delivered.. Valid values are `online|in_person|blended`',
    `enrollment_number` STRING COMMENT 'Business-visible unique enrollment code assigned to the record.',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment was recorded in the system.',
    `hours` DECIMAL(18,2) COMMENT 'Total number of hours allocated for the training.',
    `location_code` STRING COMMENT 'Code of the site or facility where the training takes place (if in‑person).',
    `pass_fail_outcome` STRING COMMENT 'Result of the assessment indicating whether the employee passed or failed.. Valid values are `pass|fail`',
    `scheduled_delivery_date` DATE COMMENT 'Planned date on which the training is to be delivered.',
    `training_enrollment_status` STRING COMMENT 'Current state of the enrollment lifecycle.. Valid values are `enrolled|in_progress|completed|failed|cancelled`',
    `training_provider` STRING COMMENT 'Name of the external or internal organization delivering the training.',
    `training_type` STRING COMMENT 'Classification of the training (e.g., mandatory, optional, refresher).. Valid values are `mandatory|optional|refresher`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in and completion of a training course. Captures enrollment date, scheduled delivery date, completion date, completion status (enrolled, in-progress, completed, failed, cancelled), assessment score, pass/fail outcome, certificate issued flag, certificate expiry date, and CPD points earned. Tracks mandatory compliance training completion rates for corporate staff.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` (
    `disciplinary_case_id` BIGINT COMMENT 'System-generated unique identifier for the disciplinary case record.',
    `parent_disciplinary_case_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_case (related_disciplinary_case_id)',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee subject to the disciplinary case.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner assigned to the case.',
    `appeal_date` DATE COMMENT 'Date when the appeal decision was rendered.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether the employee filed an appeal against the outcome.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if an appeal was filed.. Valid values are `upheld|rejected|withdrawn`',
    `case_closed_date` DATE COMMENT 'Date when the disciplinary case was formally closed.',
    `case_number` STRING COMMENT 'External reference number assigned to the disciplinary case.',
    `case_priority` STRING COMMENT 'Priority level assigned to the case for handling urgency.. Valid values are `low|medium|high`',
    `case_source` STRING COMMENT 'Origin of the case report.. Valid values are `internal|external|self_reported`',
    `case_type` STRING COMMENT 'Category of the disciplinary case indicating the nature of the issue.. Valid values are `misconduct|performance|attendance|policy_breach|code_of_conduct_violation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first captured in the system.',
    `disciplinary_case_description` STRING COMMENT 'Narrative description of the incident or issue leading to the case.',
    `disciplinary_action_effective_date` DATE COMMENT 'Date when the disciplinary action (e.g., warning) takes effect.',
    `disciplinary_case_status` STRING COMMENT 'Current lifecycle status of the disciplinary case.. Valid values are `open|under_investigation|outcome_issued|appealed|closed`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the case is treated as confidential per HR policy.',
    `notes` STRING COMMENT 'Supplementary notes or comments added by HR or investigators.',
    `outcome` STRING COMMENT 'Final disciplinary action taken as a result of the case.. Valid values are `verbal_warning|written_warning|final_warning|termination`',
    `outcome_date` DATE COMMENT 'Date when the disciplinary outcome became effective.',
    `raised_timestamp` TIMESTAMP COMMENT 'Date and time when the disciplinary case was initially created.',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control and audit.',
    `severity_score` STRING COMMENT 'Numeric rating (e.g., 1‑5) reflecting the seriousness of the outcome.',
    `termination_date` DATE COMMENT 'Effective date of employment termination, if the outcome is termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the case record.',
    CONSTRAINT pk_disciplinary_case PRIMARY KEY(`disciplinary_case_id`)
) COMMENT 'Formal disciplinary case record for a salaried employee, capturing case number, case type (misconduct, performance, attendance, policy breach, code of conduct violation), date raised, investigating manager, HR business partner assigned, case status (open, under investigation, outcome issued, appealed, closed), outcome (verbal warning, written warning, final warning, termination), and appeal outcome. Maintains confidential HR case management records.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Unique identifier for the grievance record.',
    `escalated_grievance_id` BIGINT COMMENT 'Self-referencing FK on grievance (escalated_grievance_id)',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who raised the grievance.',
    `tertiary_grievance_respondent_employee_id` BIGINT COMMENT 'Identifier of the employee or manager against whom the grievance is filed.',
    `grievance_category` STRING COMMENT 'High‑level classification of the grievance type.. Valid values are `harassment|discrimination|unsafe_condition|unfair_treatment|management_conduct|other`',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation awarded as part of the grievance resolution, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for any monetary compensation.. Valid values are `^[A-Z]{3}$`',
    `grievance_description` STRING COMMENT 'Detailed narrative of the grievance submitted by the complainant.',
    `escalation_date` DATE COMMENT 'Date when the grievance was escalated to an external body.',
    `escalation_external_body` STRING COMMENT 'External authority to which the grievance was escalated, if any.. Valid values are `fair_work_commission|eeoc|employment_tribunal|none`',
    `grievance_number` STRING COMMENT 'Business identifier assigned to the grievance, used for tracking and reference.',
    `grievance_status` STRING COMMENT 'Current lifecycle status of the grievance.. Valid values are `open|in_progress|resolved|closed|rejected`',
    `incident_date` DATE COMMENT 'Date on which the incident that gave rise to the grievance occurred.',
    `investigation_end_date` DATE COMMENT 'Date when the investigation of the grievance concluded.',
    `investigation_start_date` DATE COMMENT 'Date when the investigation of the grievance began.',
    `investigation_status` STRING COMMENT 'Current status of the grievance investigation.. Valid values are `not_started|ongoing|completed`',
    `location_code` STRING COMMENT 'Identifier of the site or location where the grievance incident occurred.',
    `lodged_timestamp` TIMESTAMP COMMENT 'Date and time when the grievance was formally lodged.',
    `notes` STRING COMMENT 'Supplementary notes added by HR during case handling.',
    `resolution_date` DATE COMMENT 'Date when the grievance was formally resolved.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the grievance after investigation.. Valid values are `resolved|unresolved|settled|dismissed|escalated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grievance record.',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Employee grievance record capturing formal complaints raised by salaried staff regarding workplace issues — harassment, discrimination, unfair treatment, unsafe conditions, or management conduct. Captures grievance number, complainant, respondent, grievance category, date lodged, HR case owner, investigation status, resolution outcome, and escalation to external body (Fair Work Commission, EEOC, employment tribunal). Supports labor compliance and ER case management.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`compensation_review` (
    `compensation_review_id` BIGINT COMMENT 'System-generated unique identifier for each compensation review record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the manager or HR officer who approved the review.',
    `position_id` BIGINT COMMENT 'Identifier of the employees position at the time of review.',
    `primary_compensation_employee_id` BIGINT COMMENT 'Identifier of the employee whose compensation is being reviewed.',
    `prior_compensation_review_id` BIGINT COMMENT 'Self-referencing FK on compensation_review (prior_compensation_review_id)',
    `approval_status` STRING COMMENT 'Current approval state of the compensation review.. Valid values are `pending|approved|rejected|under_review`',
    `budget_consumed_amount` DECIMAL(18,2) COMMENT 'Amount of the budget pool consumed by this salary increase.',
    `budget_pool_code` STRING COMMENT 'Code of the compensation budget pool from which the increase is drawn.',
    `budget_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining amount in the budget pool after this review.',
    `comments` STRING COMMENT 'Free‑form notes entered by the reviewer.',
    `compensation_component` STRING COMMENT 'Component of compensation being adjusted (e.g., base salary, bonus, equity).. Valid values are `base|bonus|equity|allowance`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for salary amounts.',
    `current_salary` DECIMAL(18,2) COMMENT 'Employees base salary amount before the review.',
    `department_code` STRING COMMENT 'Code of the department to which the employee belongs.',
    `effective_date` DATE COMMENT 'Date the approved compensation changes become effective.',
    `grade_level` STRING COMMENT 'Grade level associated with the employees position.',
    `increase_percentage` DECIMAL(18,2) COMMENT 'Percentage change applied to the current salary.',
    `increase_type` STRING COMMENT 'Reason for salary change (e.g., merit, market adjustment, promotion, equity, bonus).',
    `internal_equity_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees pay equity relative to peers.',
    `is_equity_granted` BOOLEAN COMMENT 'Flag indicating whether equity compensation was granted.',
    `is_promoted` BOOLEAN COMMENT 'Flag indicating whether the employee received a promotion during the review.',
    `is_salary_adjusted` BOOLEAN COMMENT 'Flag indicating whether the salary was changed as a result of the review.',
    `justification` STRING COMMENT 'Business rationale supporting the proposed salary change.',
    `location_code` STRING COMMENT 'Geographic location identifier for the employees primary work site.',
    `market_rate` DECIMAL(18,2) COMMENT 'External market salary benchmark for the employees role.',
    `new_salary` DECIMAL(18,2) COMMENT 'Final salary amount after the review is approved.',
    `pay_band` STRING COMMENT 'Pay band or salary range classification for the employee.',
    `proposed_salary` DECIMAL(18,2) COMMENT 'Salary amount proposed by the review before final approval.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `review_cycle` STRING COMMENT 'The scheduled cycle of the compensation review (e.g., annual, mid‑year, off‑cycle).. Valid values are `annual|midyear|offcycle`',
    `review_date` DATE COMMENT 'Date the compensation review was conducted.',
    `review_number` STRING COMMENT 'Business identifier code for the review cycle, used for tracking and audit.',
    `review_period_end` DATE COMMENT 'End date of the performance period covered by the review.',
    `review_period_start` DATE COMMENT 'Start date of the performance period covered by the review.',
    `review_status` STRING COMMENT 'Lifecycle status of the compensation review record.. Valid values are `draft|submitted|finalized|closed`',
    `review_year` STRING COMMENT 'Calendar year in which the review takes place.',
    `salary_basis` STRING COMMENT 'Indicates whether the salary figure represents base, total, or target compensation.. Valid values are `base|total|target`',
    CONSTRAINT pk_compensation_review PRIMARY KEY(`compensation_review_id`)
) COMMENT 'Annual or off-cycle compensation review record capturing the salary review cycle, employee current salary, proposed salary increase, increase type (merit, market adjustment, promotion, equity), percentage increase, new salary, effective date, approval status, approver, and budget pool consumed. Supports remuneration benchmarking, pay equity analysis, and compensation governance for construction management and professional staff.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'System-generated unique identifier for the succession plan record.',
    `hr_employee_id` BIGINT COMMENT 'Employee currently holding the target position.',
    `superseded_succession_plan_id` BIGINT COMMENT 'Self-referencing FK on succession_plan (superseded_succession_plan_id)',
    `position_id` BIGINT COMMENT 'Identifier of the critical position for which the succession plan is created.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan was formally approved by senior leadership.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was first created in the system.',
    `development_actions` STRING COMMENT 'Planned development activities, training, or experiences required for the successor.',
    `effective_end_date` DATE COMMENT 'Date when the succession plan expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the succession plan becomes active.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the plan.',
    `plan_code` STRING COMMENT 'Business identifier or code used to reference the plan in HR systems and reports.',
    `plan_name` STRING COMMENT 'Descriptive name of the succession plan, typically indicating the critical role or business unit.',
    `plan_review_date` DATE COMMENT 'Scheduled date for formal review and update of the succession plan.',
    `plan_type` STRING COMMENT 'Classification of the plan (e.g., critical leadership, technical specialist).. Valid values are `critical|non_critical|leadership|technical`',
    `readiness_level` STRING COMMENT 'Readiness assessment of the successor (immediate, 1‑2 years, 3‑5 years).. Valid values are `ready_now|ready_1_2_years|ready_3_5_years`',
    `risk_rating` STRING COMMENT 'Risk classification for the succession gap (e.g., flight risk, retirement risk).. Valid values are `low|medium|high|flight_risk|retirement_risk`',
    `succession_plan_status` STRING COMMENT 'Current lifecycle state of the plan.. Valid values are `draft|active|inactive|archived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the succession plan record.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning record identifying critical positions and their designated successors within the construction enterprise. Captures the target position, incumbent employee, successor candidate, readiness level (ready now, ready in 1-2 years, ready in 3-5 years), development actions required, risk rating (flight risk, retirement risk), and plan review date. Supports talent pipeline management for senior construction leadership and project director roles.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` (
    `onboarding_checklist_id` BIGINT COMMENT 'Unique identifier for the onboarding checklist instance.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction site associated with the onboarding.',
    `hr_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `onboarding_template_id` BIGINT COMMENT 'Identifier of the onboarding checklist template used for this employee.',
    `parent_onboarding_checklist_id` BIGINT COMMENT 'Self-referencing FK on onboarding_checklist (parent_onboarding_checklist_id)',
    `primary_onboarding_employee_id` BIGINT COMMENT 'Identifier of the new hire employee.',
    `tertiary_onboarding_buddy_assigned_employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the onboarding buddy.',
    `acknowledgment_date` DATE COMMENT 'Date when the employee acknowledged the required policies.',
    `acknowledgment_received` BOOLEAN COMMENT 'Flag indicating if the employee has acknowledged required policies.',
    `background_check_completed` BOOLEAN COMMENT 'Indicates if the employees background check is completed.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed.',
    `benefits_enrollment_completed` BOOLEAN COMMENT 'Indicates if benefits enrollment is completed.',
    `benefits_enrollment_date` DATE COMMENT 'Date when benefits enrollment was completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of tasks completed (0‑100).',
    `compliance_training_completed` BOOLEAN COMMENT 'Indicates if compliance training (e.g., OSHA) is completed.',
    `compliance_training_date` DATE COMMENT 'Date when compliance training was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding checklist record was created.',
    `end_date` DATE COMMENT 'Planned completion date of the onboarding process.',
    `equipment_assigned` BOOLEAN COMMENT 'Indicates if required equipment has been assigned to the employee.',
    `equipment_assigned_date` DATE COMMENT 'Date when equipment was assigned to the employee.',
    `health_safety_training_completed` BOOLEAN COMMENT 'Indicates if health and safety training required by OSHA/ISO 45001 is completed.',
    `health_safety_training_date` DATE COMMENT 'Date when health and safety training was completed.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the onboarding process is mandatory for the employees role.',
    `last_task_completed_date` DATE COMMENT 'Date when the most recent onboarding task was completed.',
    `location_code` STRING COMMENT 'Code of the primary work location or site for the employee.',
    `notes` STRING COMMENT 'Free‑text notes or comments related to the onboarding process.',
    `overall_status` STRING COMMENT 'Current overall status of the onboarding checklist.. Valid values are `pending|in_progress|completed|cancelled`',
    `payroll_setup_completed` BOOLEAN COMMENT 'Indicates if payroll setup is completed for the employee.',
    `payroll_setup_date` DATE COMMENT 'Date when payroll setup was completed.',
    `policy_acknowledged` STRING COMMENT 'Specific policy that was acknowledged by the employee.. Valid values are `code_of_conduct|safety_policy|privacy_policy|it_usage_policy`',
    `requires_security_clearance` BOOLEAN COMMENT 'Indicates whether the role requires a security clearance.',
    `security_clearance_level` STRING COMMENT 'Required security clearance level for the employee.. Valid values are `confidential|secret|top_secret`',
    `start_date` DATE COMMENT 'Date the onboarding process begins for the employee.',
    `task_completed` STRING COMMENT 'Number of onboarding tasks that have been marked as completed.',
    `task_total` STRING COMMENT 'Total number of tasks defined in the selected onboarding template.',
    `training_completed` BOOLEAN COMMENT 'Indicates if mandatory training has been completed.',
    `training_completion_date` DATE COMMENT 'Date when mandatory training was completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding checklist.',
    `visa_expiry_date` DATE COMMENT 'Expiration date of the employees visa.',
    `visa_status` STRING COMMENT 'Current visa status of the employee, if applicable.. Valid values are `none|pending|approved|expired`',
    CONSTRAINT pk_onboarding_checklist PRIMARY KEY(`onboarding_checklist_id`)
) COMMENT 'Structured onboarding task checklist instance created for each new hire joining the construction enterprise. Captures the employee, start date, onboarding template used, assigned HR coordinator, list of onboarding tasks (IT setup, security access, site induction scheduling, policy acknowledgements, payroll setup, benefits enrollment, buddy assignment), task completion status, and overall onboarding completion percentage. Ensures consistent onboarding experience for new construction management and office staff.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`separation` (
    `separation_id` BIGINT COMMENT 'Unique system-generated identifier for the employee separation event.',
    `hr_employee_id` BIGINT COMMENT 'Unique identifier of the employee who is separating.',
    `rehire_separation_id` BIGINT COMMENT 'Self-referencing FK on separation (rehire_separation_id)',
    `tertiary_separation_processed_by_employee_id` BIGINT COMMENT 'Identifier of the HR staff member who processed the separation.',
    `benefits_termination_date` DATE COMMENT 'Date on which employee benefits coverage ends.',
    `compliance_review_date` DATE COMMENT 'Date the compliance review was performed.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether a compliance (e.g., HSE, legal) review was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the separation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.',
    `effective_separation_date` DATE COMMENT 'Date the separation becomes legally effective (often same as last working day).',
    `equipment_return_date` DATE COMMENT 'Date on which all required equipment was returned.',
    `equipment_return_status` STRING COMMENT 'Status of company equipment returned by the employee.. Valid values are `not_returned|partial|returned`',
    `exit_interview_completed` BOOLEAN COMMENT 'Indicates whether the employee completed an exit interview (True/False).',
    `exit_interview_feedback` STRING COMMENT 'Free‑text field capturing themes or comments from the exit interview.',
    `exit_interview_score` STRING COMMENT 'Numeric rating (e.g., 1‑5) summarizing the employees exit interview responses.',
    `exit_interview_theme` STRING COMMENT 'Key thematic area identified from the exit interview (e.g., compensation, culture).',
    `final_pay_amount` DECIMAL(18,2) COMMENT 'Total monetary amount to be paid to the employee on separation.',
    `final_pay_status` STRING COMMENT 'Current processing status of the employees final paycheck.. Valid values are `pending|calculated|paid|error`',
    `last_working_day` DATE COMMENT 'Final day the employee is scheduled to work for the organization.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by HR staff.',
    `notice_date` DATE COMMENT 'Date the employee submitted their notice of separation.',
    `payroll_cutoff_date` DATE COMMENT 'Final payroll processing date for the employee.',
    `rehire_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for future rehire.',
    `separation_number` STRING COMMENT 'Human‑readable business identifier or reference number for the separation.',
    `separation_status` STRING COMMENT 'Current lifecycle status of the separation process.. Valid values are `initiated|in_progress|completed|cancelled`',
    `separation_type` STRING COMMENT 'Category of separation such as resignation, retirement, termination, etc.. Valid values are `resignation|retirement|termination|redundancy|end_of_contract|death_in_service`',
    `severance_pay_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid as severance, if applicable.',
    `severance_pay_status` STRING COMMENT 'Current status of severance payment processing.. Valid values are `pending|paid|not_applicable`',
    `system_access_revocation_date` DATE COMMENT 'Date when all system access rights were revoked.',
    `termination_reason` STRING COMMENT 'Free‑text description of the reason for termination, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the separation record.',
    CONSTRAINT pk_separation PRIMARY KEY(`separation_id`)
) COMMENT 'Employee separation (offboarding) record capturing the full exit lifecycle for departing salaried staff. Captures separation type (resignation, redundancy, retirement, termination, end of contract, death in service), notice date, last working day, exit interview completion flag, exit interview feedback themes, final pay calculation status, equipment return status, system access revocation date, and rehire eligibility flag. Supports workforce attrition analysis and compliance with termination obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique surrogate key for the HR policy record.',
    `hr_org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Associating each HR policy with an org unit provides clear scope and eliminates the generic department list column, ensuring policies are tied to the organizational hierarchy.',
    `hr_employee_id` BIGINT COMMENT 'add column owner_employee_id (BIGINT) with FK to hr.hr.employee_id - policies have a designated owner',
    `superseded_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (superseded_policy_id)',
    `applicable_jurisdictions` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑3 country codes where the policy applies.',
    `approving_authority` STRING COMMENT 'Name or role of the individual or committee that approved the policy.',
    `policy_category` STRING COMMENT 'Category of the policy (e.g., leave, code of conduct, anti-harassment, remuneration, flexible work, travel).. Valid values are `leave|code_of_conduct|anti_harassment|remuneration|flexible_work|travel`',
    `change_reason` STRING COMMENT 'Reason or business driver for the most recent policy change.',
    `policy_code` STRING COMMENT 'Business identifier code for the policy, used in external references and documentation.',
    `compliance_requirements` STRING COMMENT 'Specific regulatory or internal compliance obligations addressed by the policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was initially created in the system.',
    `policy_description` STRING COMMENT 'Full textual description of the policy content and purpose.',
    `document_url` STRING COMMENT 'Link to the authoritative policy document stored in the document management system.',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective and binding.',
    `enforcement_level` STRING COMMENT 'Degree to which compliance with the policy is required.. Valid values are `mandatory|advisory|optional`',
    `expiration_date` DATE COMMENT 'Date when the policy expires or is superseded (nullable for open‑ended policies).',
    `mandatory_acknowledgement` BOOLEAN COMMENT 'Indicates whether employees must formally acknowledge the policy (true) or not (false).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy.. Valid values are `active|inactive|draft|pending|retired`',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp capturing when the record was first persisted for audit purposes.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp capturing the last modification of the record for audit purposes.',
    `review_date` DATE COMMENT 'Scheduled date for the next policy review to ensure relevance and compliance.',
    `title` STRING COMMENT 'Descriptive title of the HR policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `version_notes` STRING COMMENT 'Free‑form notes describing changes made in this version.',
    `version_number` STRING COMMENT 'Version identifier of the policy (e.g., v1.0, v2.3).',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master register of all HR policies and procedures applicable to the construction enterprises salaried workforce. Captures policy code, policy title, policy category (leave, code of conduct, anti-harassment, remuneration, flexible work, travel, expense, health and wellbeing), version number, effective date, review date, approving authority, applicable jurisdictions, and mandatory acknowledgement flag. Supports labor compliance and audit readiness.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` (
    `workforce_headcount_plan_id` BIGINT COMMENT 'System-generated unique identifier for each workforce headcount plan record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the HR business partner or manager who approved the plan.',
    `hr_org_unit_id` BIGINT COMMENT 'Identifier of the org unit (department, division, or cost centre) to which the plan applies.',
    `prior_workforce_headcount_plan_id` BIGINT COMMENT 'Self-referencing FK on workforce_headcount_plan (prior_workforce_headcount_plan_id)',
    `actual_fte` DECIMAL(18,2) COMMENT 'Observed headcount in full‑time equivalents at the end of the period.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the plan received formal approval.',
    `approved_backfills` STRING COMMENT 'Number of backfill positions approved to replace attrition.',
    `approved_new_hires` STRING COMMENT 'Number of new hires authorized in the plan for the period.',
    `attrition_rate_percent` DECIMAL(18,2) COMMENT 'Assumed attrition percentage used for forecasting headcount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the headcount plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the headcount plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date on which the headcount plan becomes effective.',
    `job_family` STRING COMMENT 'Broad functional grouping of positions (e.g., Engineering, Finance, HR).',
    `job_grade` STRING COMMENT 'Specific grade or level within the job family used for compensation and hierarchy.',
    `notes` STRING COMMENT 'Additional comments, assumptions, or rationale associated with the plan.',
    `period` STRING COMMENT 'Fiscal or calendar period the plan covers (e.g., 2024_Q1). [ENUM-REF-CANDIDATE: 2023_Q1|2023_Q2|2023_Q3|2023_Q4|2024_Q1|2024_Q2|2024_Q3|2024_Q4 — 8 candidates stripped; promote to reference product]',
    `plan_number` STRING COMMENT 'Human‑readable plan number or code used for external reference and reporting.',
    `plan_type` STRING COMMENT 'Category of the headcount plan indicating its planning horizon.. Valid values are `annual|quarterly|monthly|rolling|ad_hoc`',
    `planned_fte` DECIMAL(18,2) COMMENT 'Approved budgeted headcount expressed in full‑time equivalents for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the headcount plan record.',
    `variance_fte` DECIMAL(18,2) COMMENT 'Difference between planned and actual FTE (planned_fte - actual_fte).',
    `workforce_headcount_plan_status` STRING COMMENT 'Current lifecycle state of the headcount plan.. Valid values are `draft|submitted|approved|active|closed|rejected`',
    CONSTRAINT pk_workforce_headcount_plan PRIMARY KEY(`workforce_headcount_plan_id`)
) COMMENT 'Corporate workforce headcount planning record defining the approved FTE budget by org unit, job family, grade, and period (monthly/quarterly/annual). Captures planned headcount, actual headcount, variance, approved new hires, approved backfills, and attrition assumptions. Supports annual budgeting, project mobilization planning for office staff, and HR business partner reporting. Distinct from field craft labor staffing plans (workforce domain).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`kpi` (
    `kpi_id` BIGINT COMMENT 'Primary key for kpi',
    `alignment_kpi_id` BIGINT COMMENT 'Self-referencing FK on kpi (alignment_kpi_id)',
    `hr_org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to hr.hr.org_unit_id - KPIs are owned by org units',
    `baseline_value` DECIMAL(18,2) COMMENT 'Historical baseline against which current performance is compared.',
    `calculation_method` STRING COMMENT 'Narrative description of the formula or logic used to compute the KPI.',
    `kpi_category` STRING COMMENT 'High‑level classification of the KPI.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance rule linked to the KPI.',
    `confidentiality_level` STRING COMMENT 'Data classification for the KPI definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KPI record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) indicating the quality of the source data.',
    `data_source` STRING COMMENT 'System or process that provides the raw data used for the KPI.',
    `kpi_description` STRING COMMENT 'Detailed business definition and purpose of the KPI.',
    `effective_from` DATE COMMENT 'Date when the KPI becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date when the KPI is retired or superseded (nullable).',
    `frequency` STRING COMMENT 'How often the KPI is measured or reported.',
    `is_key_performance_indicator` BOOLEAN COMMENT 'Indicates whether this metric is a core KPI for the organization.',
    `kpi_status` STRING COMMENT 'Current lifecycle status of the KPI definition.',
    `kpi_type` STRING COMMENT 'Indicates whether the KPI is leading, lagging, or both.',
    `last_review_date` DATE COMMENT 'Date when the KPI definition was last reviewed.',
    `measurement_unit` STRING COMMENT 'Unit of measure used for the KPI value (e.g., percent, days, dollars).',
    `kpi_name` STRING COMMENT 'Human‑readable name of the key performance indicator.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the KPI.',
    `owner_department` STRING COMMENT 'Business department responsible for the KPI.',
    `related_process` STRING COMMENT 'Name of the business process that the KPI measures.',
    `reporting_level` STRING COMMENT 'Organizational level at which the KPI is reported.',
    `retention_period_days` STRING COMMENT 'Number of days the KPI definition is retained before archival.',
    `review_frequency` STRING COMMENT 'How often the KPI definition is reviewed for relevance.',
    `target_direction` STRING COMMENT 'Desired direction of change for the KPI (e.g., increase).',
    `target_value` DECIMAL(18,2) COMMENT 'Desired numeric target for the KPI.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Acceptable lower or upper bound for the KPI before it is considered out of range.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the KPI record.',
    `version_number` STRING COMMENT 'Version of the KPI definition for change management.',
    `visualization_type` STRING COMMENT 'Preferred visual representation for the KPI in reports.',
    CONSTRAINT pk_kpi PRIMARY KEY(`kpi_id`)
) COMMENT 'Master reference table for kpi. Referenced by alignment_kpi_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`onboarding_template` (
    `onboarding_template_id` BIGINT COMMENT 'Primary key for onboarding_template',
    `hr_org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to hr.hr.org_unit_id - onboarding templates are owned by org units',
    `parent_onboarding_template_id` BIGINT COMMENT 'Self-referencing FK on onboarding_template (parent_onboarding_template_id)',
    `access_level` STRING COMMENT 'System access level required to edit or view the template.',
    `compliance_requirements` STRING COMMENT 'Comma‑separated list of regulatory or policy requirements addressed by the template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created in the system.',
    `department` STRING COMMENT 'Business department for which the template is intended (e.g., Human Resources, Finance).',
    `onboarding_template_description` STRING COMMENT 'Detailed description of the templates purpose and contents.',
    `document_count` STRING COMMENT 'Count of distinct documents that must be submitted as part of this onboarding template.',
    `effective_from` DATE COMMENT 'Date when the template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the template is retired (null if indefinite).',
    `estimated_completion_time_minutes` STRING COMMENT 'Typical time in minutes to complete the onboarding steps defined by the template.',
    `is_mandatory` BOOLEAN COMMENT 'Flag indicating if the template is mandatory for the applicable role.',
    `language` STRING COMMENT 'Language in which the template is authored.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the template was last reviewed for compliance.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the template.',
    `onboarding_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `requires_manager_approval` BOOLEAN COMMENT 'Indicates whether completion of this onboarding template requires manager approval.',
    `reviewer` STRING COMMENT 'Name of the person who performed the last review.',
    `role_applicable` STRING COMMENT 'Job role or employee classification that the template targets (e.g., Manager, Analyst).',
    `template_code` STRING COMMENT 'Unique business code used to reference the template across systems.',
    `template_name` STRING COMMENT 'Human‑readable name of the onboarding template.',
    `template_owner` STRING COMMENT 'Owner responsible for maintaining the template.',
    `template_type` STRING COMMENT 'Category of the template indicating the functional area it supports.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `version_number` STRING COMMENT 'Sequential version number of the template.',
    `version_release_date` DATE COMMENT 'Date when the current version of the template was released.',
    CONSTRAINT pk_onboarding_template PRIMARY KEY(`onboarding_template_id`)
) COMMENT 'Master reference table for onboarding_template. Referenced by onboarding_template_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `payroll_group_id` BIGINT COMMENT 'Identifier of the employee group or cost center to which this payroll run applies.',
    `prior_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (prior_payroll_run_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payroll amounts.',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all statutory and voluntary deductions for the payroll run.',
    `payroll_run_description` STRING COMMENT 'Free‑form text describing the purpose or special notes for the payroll run.',
    `employee_count` STRING COMMENT 'Count of distinct employees included in this payroll run.',
    `fiscal_period` STRING COMMENT 'Quarter of the fiscal year for reporting purposes.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross earnings before any deductions for the payroll run.',
    `is_manual` BOOLEAN COMMENT 'True if the payroll run was initiated manually rather than by an automated schedule.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable to employees after deductions.',
    `pay_cycle` STRING COMMENT 'Frequency with which the payroll run is generated.',
    `pay_date` DATE COMMENT 'Date on which employees receive their net pay for this run.',
    `payroll_period_end` DATE COMMENT 'Last calendar date of the pay period covered by this run.',
    `payroll_period_start` DATE COMMENT 'First calendar date of the pay period covered by this run.',
    `payroll_run_status` STRING COMMENT 'Current processing state of the payroll run.',
    `payroll_type` STRING COMMENT 'Classification of the payroll run (e.g., regular salary, bonus, overtime, severance).',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run completed processing and was ready for posting.',
    `run_number` STRING COMMENT 'Human‑readable sequential number assigned to the payroll run.',
    `run_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the payroll run was executed.',
    `tax_year` STRING COMMENT 'Fiscal year to which the payroll taxes are reported.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payroll run record.',
    `version_number` STRING COMMENT 'Version of the payroll run record for audit and change tracking.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`hr`.`payroll_group` (
    `payroll_group_id` BIGINT COMMENT 'Primary key for payroll_group',
    `company_code_id` BIGINT COMMENT 'add column company_code_id (BIGINT) with FK to finance.company_code.company_code_id - payroll groups roll up to company codes',
    `parent_payroll_group_id` BIGINT COMMENT 'Self-referencing FK on payroll_group (parent_payroll_group_id)',
    `benefit_eligibility_flag` BOOLEAN COMMENT 'Indicates whether employees in this group are eligible for benefits.',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with payroll expenses for this group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll group record was created.',
    `default_currency` STRING COMMENT 'ISO 4217 currency code used for payroll calculations.',
    `payroll_group_description` STRING COMMENT 'Free-text description providing additional details about the payroll group.',
    `effective_from` DATE COMMENT 'Date when the payroll group becomes effective.',
    `effective_until` DATE COMMENT 'Date when the payroll group ceases to be effective; null if open-ended.',
    `employee_count_estimate` STRING COMMENT 'Estimated number of employees assigned to this payroll group.',
    `gl_account_number` STRING COMMENT 'GL account number to which payroll expenses are posted.',
    `group_code` STRING COMMENT 'Unique alphanumeric code identifying the payroll group.',
    `group_name` STRING COMMENT 'Descriptive name of the payroll group.',
    `group_type` STRING COMMENT 'Classification of payroll group (e.g., salaried, hourly, contractor).',
    `is_default_group` BOOLEAN COMMENT 'Indicates if this payroll group is the default for new employees.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether overtime pay applies to this group.',
    `owner` STRING COMMENT 'Internal department or manager responsible for the payroll group.',
    `pay_cycle_day` STRING COMMENT 'Day of month or week number when payroll is executed.',
    `pay_frequency` STRING COMMENT 'Regular interval at which payroll is processed for this group.',
    `payment_method` STRING COMMENT 'Default method of payment for this payroll group.',
    `payroll_group_status` STRING COMMENT 'Current lifecycle status of the payroll group.',
    `region` STRING COMMENT 'Region or location to which the payroll group applies.',
    `tax_code` STRING COMMENT 'Internal tax code used for payroll tax calculations.',
    `tax_status` STRING COMMENT 'Tax classification applicable to the payroll group.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll group record.',
    CONSTRAINT pk_payroll_group PRIMARY KEY(`payroll_group_id`)
) COMMENT 'Master reference table for payroll_group. Referenced by payroll_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ADD CONSTRAINT `fk_hr_hr_employee_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_construction_v1`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ADD CONSTRAINT `fk_hr_hr_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_construction_v1`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_primary_reporting_position_id` FOREIGN KEY (`primary_reporting_position_id`) REFERENCES `vibe_construction_v1`.`hr`.`position`(`position_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ADD CONSTRAINT `fk_hr_hr_org_unit_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ADD CONSTRAINT `fk_hr_hr_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ADD CONSTRAINT `fk_hr_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `vibe_construction_v1`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ADD CONSTRAINT `fk_hr_employment_contract_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ADD CONSTRAINT `fk_hr_employment_contract_superseded_employment_contract_id` FOREIGN KEY (`superseded_employment_contract_id`) REFERENCES `vibe_construction_v1`.`hr`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_construction_v1`.`hr`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_reversal_payroll_record_id` FOREIGN KEY (`reversal_payroll_record_id`) REFERENCES `vibe_construction_v1`.`hr`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ADD CONSTRAINT `fk_hr_benefit_plan_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ADD CONSTRAINT `fk_hr_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `vibe_construction_v1`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_construction_v1`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_prior_benefit_enrollment_id` FOREIGN KEY (`prior_benefit_enrollment_id`) REFERENCES `vibe_construction_v1`.`hr`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ADD CONSTRAINT `fk_hr_leave_request_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ADD CONSTRAINT `fk_hr_leave_request_original_leave_request_id` FOREIGN KEY (`original_leave_request_id`) REFERENCES `vibe_construction_v1`.`hr`.`leave_request`(`leave_request_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ADD CONSTRAINT `fk_hr_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ADD CONSTRAINT `fk_hr_leave_balance_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ADD CONSTRAINT `fk_hr_leave_balance_prior_leave_balance_id` FOREIGN KEY (`prior_leave_balance_id`) REFERENCES `vibe_construction_v1`.`hr`.`leave_balance`(`leave_balance_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_construction_v1`.`hr`.`position`(`position_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_replacement_recruitment_requisition_id` FOREIGN KEY (`replacement_recruitment_requisition_id`) REFERENCES `vibe_construction_v1`.`hr`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ADD CONSTRAINT `fk_hr_applicant_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ADD CONSTRAINT `fk_hr_applicant_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_construction_v1`.`hr`.`position`(`position_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ADD CONSTRAINT `fk_hr_applicant_referred_by_applicant_id` FOREIGN KEY (`referred_by_applicant_id`) REFERENCES `vibe_construction_v1`.`hr`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ADD CONSTRAINT `fk_hr_application_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_construction_v1`.`hr`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ADD CONSTRAINT `fk_hr_application_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ADD CONSTRAINT `fk_hr_application_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `vibe_construction_v1`.`hr`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ADD CONSTRAINT `fk_hr_application_resubmitted_application_id` FOREIGN KEY (`resubmitted_application_id`) REFERENCES `vibe_construction_v1`.`hr`.`application`(`application_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_prior_performance_review_id` FOREIGN KEY (`prior_performance_review_id`) REFERENCES `vibe_construction_v1`.`hr`.`performance_review`(`performance_review_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_tertiary_performance_hr_approval_employee_id` FOREIGN KEY (`tertiary_performance_hr_approval_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ADD CONSTRAINT `fk_hr_goal_kpi_id` FOREIGN KEY (`kpi_id`) REFERENCES `vibe_construction_v1`.`hr`.`kpi`(`kpi_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ADD CONSTRAINT `fk_hr_goal_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ADD CONSTRAINT `fk_hr_goal_parent_goal_id` FOREIGN KEY (`parent_goal_id`) REFERENCES `vibe_construction_v1`.`hr`.`goal`(`goal_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ADD CONSTRAINT `fk_hr_goal_primary_goal_approved_by_employee_id` FOREIGN KEY (`primary_goal_approved_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ADD CONSTRAINT `fk_hr_training_course_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ADD CONSTRAINT `fk_hr_training_course_prerequisite_training_course_id` FOREIGN KEY (`prerequisite_training_course_id`) REFERENCES `vibe_construction_v1`.`hr`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ADD CONSTRAINT `fk_hr_training_enrollment_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ADD CONSTRAINT `fk_hr_training_enrollment_rescheduled_training_enrollment_id` FOREIGN KEY (`rescheduled_training_enrollment_id`) REFERENCES `vibe_construction_v1`.`hr`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ADD CONSTRAINT `fk_hr_training_enrollment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_construction_v1`.`hr`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ADD CONSTRAINT `fk_hr_disciplinary_case_parent_disciplinary_case_id` FOREIGN KEY (`parent_disciplinary_case_id`) REFERENCES `vibe_construction_v1`.`hr`.`disciplinary_case`(`disciplinary_case_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ADD CONSTRAINT `fk_hr_disciplinary_case_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ADD CONSTRAINT `fk_hr_disciplinary_case_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ADD CONSTRAINT `fk_hr_grievance_escalated_grievance_id` FOREIGN KEY (`escalated_grievance_id`) REFERENCES `vibe_construction_v1`.`hr`.`grievance`(`grievance_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ADD CONSTRAINT `fk_hr_grievance_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ADD CONSTRAINT `fk_hr_grievance_tertiary_grievance_respondent_employee_id` FOREIGN KEY (`tertiary_grievance_respondent_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ADD CONSTRAINT `fk_hr_compensation_review_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ADD CONSTRAINT `fk_hr_compensation_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_construction_v1`.`hr`.`position`(`position_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ADD CONSTRAINT `fk_hr_compensation_review_primary_compensation_employee_id` FOREIGN KEY (`primary_compensation_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ADD CONSTRAINT `fk_hr_compensation_review_prior_compensation_review_id` FOREIGN KEY (`prior_compensation_review_id`) REFERENCES `vibe_construction_v1`.`hr`.`compensation_review`(`compensation_review_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_superseded_succession_plan_id` FOREIGN KEY (`superseded_succession_plan_id`) REFERENCES `vibe_construction_v1`.`hr`.`succession_plan`(`succession_plan_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_construction_v1`.`hr`.`position`(`position_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_onboarding_template_id` FOREIGN KEY (`onboarding_template_id`) REFERENCES `vibe_construction_v1`.`hr`.`onboarding_template`(`onboarding_template_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_parent_onboarding_checklist_id` FOREIGN KEY (`parent_onboarding_checklist_id`) REFERENCES `vibe_construction_v1`.`hr`.`onboarding_checklist`(`onboarding_checklist_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_primary_onboarding_employee_id` FOREIGN KEY (`primary_onboarding_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ADD CONSTRAINT `fk_hr_onboarding_checklist_tertiary_onboarding_buddy_assigned_employee_id` FOREIGN KEY (`tertiary_onboarding_buddy_assigned_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ADD CONSTRAINT `fk_hr_separation_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ADD CONSTRAINT `fk_hr_separation_rehire_separation_id` FOREIGN KEY (`rehire_separation_id`) REFERENCES `vibe_construction_v1`.`hr`.`separation`(`separation_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ADD CONSTRAINT `fk_hr_separation_tertiary_separation_processed_by_employee_id` FOREIGN KEY (`tertiary_separation_processed_by_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ADD CONSTRAINT `fk_hr_policy_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ADD CONSTRAINT `fk_hr_policy_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ADD CONSTRAINT `fk_hr_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `vibe_construction_v1`.`hr`.`policy`(`policy_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ADD CONSTRAINT `fk_hr_workforce_headcount_plan_hr_employee_id` FOREIGN KEY (`hr_employee_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_employee`(`hr_employee_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ADD CONSTRAINT `fk_hr_workforce_headcount_plan_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ADD CONSTRAINT `fk_hr_workforce_headcount_plan_prior_workforce_headcount_plan_id` FOREIGN KEY (`prior_workforce_headcount_plan_id`) REFERENCES `vibe_construction_v1`.`hr`.`workforce_headcount_plan`(`workforce_headcount_plan_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ADD CONSTRAINT `fk_hr_kpi_alignment_kpi_id` FOREIGN KEY (`alignment_kpi_id`) REFERENCES `vibe_construction_v1`.`hr`.`kpi`(`kpi_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ADD CONSTRAINT `fk_hr_kpi_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ADD CONSTRAINT `fk_hr_onboarding_template_hr_org_unit_id` FOREIGN KEY (`hr_org_unit_id`) REFERENCES `vibe_construction_v1`.`hr`.`hr_org_unit`(`hr_org_unit_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ADD CONSTRAINT `fk_hr_onboarding_template_parent_onboarding_template_id` FOREIGN KEY (`parent_onboarding_template_id`) REFERENCES `vibe_construction_v1`.`hr`.`onboarding_template`(`onboarding_template_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_construction_v1`.`hr`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_prior_payroll_run_id` FOREIGN KEY (`prior_payroll_run_id`) REFERENCES `vibe_construction_v1`.`hr`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ADD CONSTRAINT `fk_hr_payroll_group_parent_payroll_group_id` FOREIGN KEY (`parent_payroll_group_id`) REFERENCES `vibe_construction_v1`.`hr`.`payroll_group`(`payroll_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`hr` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_construction_v1`.`hr` SET TAGS ('pii_domain' = 'hr');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `base_salary` SET TAGS ('pii_business_glossary_term' = 'Base Salary (BASE_SALARY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `base_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `base_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `compensation_type` SET TAGS ('pii_business_glossary_term' = 'Compensation Type (COMP_TYPE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `compensation_type` SET TAGS ('pii_value_regex' = 'salary|hourly|contract');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `compensation_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `compensation_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code (DEPT_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `education_level` SET TAGS ('pii_business_glossary_term' = 'Education Level (EDU_LEVEL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `education_level` SET TAGS ('pii_value_regex' = 'high_school|associate|bachelor|master|doctorate|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Work Email Address (EMAIL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `employee_number` SET TAGS ('pii_business_glossary_term' = 'Employee Number (EMP_NUM)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `employee_type` SET TAGS ('pii_business_glossary_term' = 'Employee Type (EMP_TYPE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `employee_type` SET TAGS ('pii_value_regex' = 'permanent|fixed_term|secondment|contractor');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `employment_status` SET TAGS ('pii_business_glossary_term' = 'Employment Status (EMP_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `employment_status` SET TAGS ('pii_value_regex' = 'active|terminated|on_leave|retired');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Employee First Name (FIRST_NAME)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|other|prefer_not_to_say');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_business_glossary_term' = 'Health Insurance Plan (HEALTH_PLAN)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date (HIREDATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `hse_training_completed` SET TAGS ('pii_business_glossary_term' = 'HSE Training Completed (HSE_TRAINED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Employee Last Name (LAST_NAME)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Performance Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Work Location Code (LOC_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `marital_status` SET TAGS ('pii_business_glossary_term' = 'Marital Status (MARITAL_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `marital_status` SET TAGS ('pii_value_regex' = 'single|married|divorced|widowed|partnered');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `marital_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `marital_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `national_id_number` SET TAGS ('pii_business_glossary_term' = 'National ID Number (NATIONAL_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `national_id_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `national_id_number` SET TAGS ('pii_national_id' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `pay_frequency` SET TAGS ('pii_business_glossary_term' = 'Pay Frequency (PAY_FREQ)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `pay_frequency` SET TAGS ('pii_value_regex' = 'monthly|biweekly|weekly|semi_monthly');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `performance_rating_last_year` SET TAGS ('pii_business_glossary_term' = 'Performance Rating (PERF_RATING)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `performance_rating_last_year` SET TAGS ('pii_value_regex' = 'excellent|good|satisfactory|needs_improvement');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Work Phone Number (PHONE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `professional_certifications` SET TAGS ('pii_business_glossary_term' = 'Professional Certifications (CERTIFICATIONS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `retirement_plan` SET TAGS ('pii_business_glossary_term' = 'Retirement Plan (RETIRE_PLAN)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Level (SEC_CLEARANCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_value_regex' = 'none|confidential|secret|top_secret');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `social_security_number` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `social_security_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `social_security_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `tax_id_number` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `tax_id_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `tax_id_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date (TERM_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `visa_status` SET TAGS ('pii_business_glossary_term' = 'Visa Status (VISA_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `visa_status` SET TAGS ('pii_value_regex' = 'citizen|permanent_resident|work_visa|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `work_permit_expiry` SET TAGS ('pii_business_glossary_term' = 'Work Permit Expiry Date (WORK_PERMIT_EXP)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `work_permit_number` SET TAGS ('pii_business_glossary_term' = 'Work Permit Number (WORK_PERMIT_NO)');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `work_permit_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_employee` ALTER COLUMN `work_permit_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `primary_reporting_position_id` SET TAGS ('pii_business_glossary_term' = 'Reporting Position ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `benefits_eligible` SET TAGS ('pii_business_glossary_term' = 'Benefits Eligibility');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `bonus_eligible` SET TAGS ('pii_business_glossary_term' = 'Bonus Eligibility');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `budgeted_salary` SET TAGS ('pii_business_glossary_term' = 'Budgeted Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `budgeted_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `budgeted_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `closing_date` SET TAGS ('pii_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_code` SET TAGS ('pii_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `competency_required` SET TAGS ('pii_business_glossary_term' = 'Required Competency');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_description` SET TAGS ('pii_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `fte` SET TAGS ('pii_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `grade_band` SET TAGS ('pii_business_glossary_term' = 'Grade Band');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `is_exempt` SET TAGS ('pii_business_glossary_term' = 'Exempt Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `is_manager` SET TAGS ('pii_business_glossary_term' = 'Managerial Role Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `job_level` SET TAGS ('pii_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `language_requirements` SET TAGS ('pii_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `last_filled_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Filled Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_filled' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_vacant' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_on_hold' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_closed' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_pending' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `remote_allowed` SET TAGS ('pii_business_glossary_term' = 'Remote Work Allowed');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_max` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_max` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_min` SET TAGS ('pii_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_min` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `salary_min` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_none' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_secret' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_top_secret' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_day' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_night' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_flex' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_rotating' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_split' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_on_call' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `union_member` SET TAGS ('pii_business_glossary_term' = 'Union Membership');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_new' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_replacement' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_reorg' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_budget' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_project' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('pii_seasonal' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_business_glossary_term' = 'Work Schedule');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_mon_fri' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_mon_sat' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_flex' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_compressed' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`position` ALTER COLUMN `work_schedule` SET TAGS ('pii_custom' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Parent Organizational Unit Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `budget_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Email Address');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `gl_cost_center_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `headcount` SET TAGS ('pii_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Location');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('pii_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('pii_value_regex' = 'division|business_unit|department|cost_center|team');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`hr_org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('pii_business_glossary_term' = 'Parent Job Profile Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `award_classification` SET TAGS ('pii_business_glossary_term' = 'Award Classification');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `award_classification` SET TAGS ('pii_value_regex' = 'Modern Award|Enterprise Agreement|Other');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('pii_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `compensation_type` SET TAGS ('pii_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `compensation_type` SET TAGS ('pii_value_regex' = 'Salary|Hourly|Contract|Commission');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `compensation_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `compensation_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `competency_framework` SET TAGS ('pii_business_glossary_term' = 'Competency Framework');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `competency_level` SET TAGS ('pii_business_glossary_term' = 'Competency Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `competency_level` SET TAGS ('pii_value_regex' = 'Basic|Intermediate|Advanced|Expert');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_profile_description` SET TAGS ('pii_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('pii_value_regex' = 'Full-time|Part-time|Casual|Contractor|Temporary');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `health_and_safety_training_required` SET TAGS ('pii_business_glossary_term' = 'Health & Safety Training Required');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `health_and_safety_training_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `health_and_safety_training_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `is_field_facing` SET TAGS ('pii_business_glossary_term' = 'Field‑Facing Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `is_office_based` SET TAGS ('pii_business_glossary_term' = 'Office‑Based Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `is_project_based` SET TAGS ('pii_business_glossary_term' = 'Project‑Based Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `is_union_covered` SET TAGS ('pii_business_glossary_term' = 'Union Covered Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('pii_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('pii_value_regex' = 'Engineering|Project Management|Finance|Procurement|Safety|Administration');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_family_code` SET TAGS ('pii_business_glossary_term' = 'Job Family Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_grade` SET TAGS ('pii_business_glossary_term' = 'Job Grade');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('pii_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('pii_value_regex' = 'Active|Inactive|Deprecated|Pending Approval');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `location_type` SET TAGS ('pii_value_regex' = 'Office|Field|Project|Remote');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `overtime_eligible` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `reporting_manager_role` SET TAGS ('pii_business_glossary_term' = 'Reporting Manager Role');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('pii_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `required_education` SET TAGS ('pii_business_glossary_term' = 'Required Education');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `required_education` SET TAGS ('pii_value_regex' = 'High School|Associate|Bachelor|Master|Doctorate|Other');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `required_experience_years` SET TAGS ('pii_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_max` SET TAGS ('pii_business_glossary_term' = 'Salary Band Maximum');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_max` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_max` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_min` SET TAGS ('pii_business_glossary_term' = 'Salary Band Minimum');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_min` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `salary_band_min` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `travel_required` SET TAGS ('pii_business_glossary_term' = 'Travel Required Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('pii_business_glossary_term' = 'Employment Contract ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `superseded_employment_contract_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Employment Contract Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `superseded_employment_contract_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `agreement_category` SET TAGS ('pii_business_glossary_term' = 'Agreement Category (CATEGORY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `agreement_category` SET TAGS ('pii_value_regex' = 'standard|enterprise|project_specific');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date (AMEND_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number (AMEND_NUM)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `award_code` SET TAGS ('pii_business_glossary_term' = 'Award Code (AWARD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `benefits_description` SET TAGS ('pii_business_glossary_term' = 'Benefits Description (BENEFITS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `bonus_entitlement` SET TAGS ('pii_business_glossary_term' = 'Bonus Entitlement (BONUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `bonus_entitlement` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `bonus_entitlement` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Clause Flag (CONFIDENTIALITY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_document_url` SET TAGS ('pii_business_glossary_term' = 'Contract Document URL (DOC_URL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('pii_business_glossary_term' = 'Contract Signed Date (SIGNED_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type (TYPE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'permanent|fixed_term|casual|secondment');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Department (DEPT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Start Date (START_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Contract Effective End Date (END_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `enterprise_agreement_code` SET TAGS ('pii_business_glossary_term' = 'Enterprise Agreement Code (EA_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_business_glossary_term' = 'Health Insurance Plan (HEALTH_PLAN)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `health_insurance_plan` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `leave_accrual_rate` SET TAGS ('pii_business_glossary_term' = 'Leave Accrual Rate (LEAVE_RATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `leave_balance` SET TAGS ('pii_business_glossary_term' = 'Leave Balance (LEAVE_BAL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Contract Lifecycle Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code (LOC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `non_compete_clause_flag` SET TAGS ('pii_business_glossary_term' = 'Non-Compete Clause Flag (NON_COMPETE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('pii_business_glossary_term' = 'Notice Period (DAYS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `overtime_rate` SET TAGS ('pii_business_glossary_term' = 'Overtime Rate (RATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `overtime_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `overtime_rate` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `pension_contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Pension Contribution Percent (PENSION_PCT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `pension_contribution_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `pension_contribution_percent` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `position_title` SET TAGS ('pii_business_glossary_term' = 'Position Title (TITLE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `probation_period_days` SET TAGS ('pii_business_glossary_term' = 'Probation Period (DAYS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Flag (RENEWAL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('pii_business_glossary_term' = 'Base Salary Amount (AMOUNT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('pii_business_glossary_term' = 'Salary Currency (CURRENCY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `severance_amount` SET TAGS ('pii_business_glossary_term' = 'Severance Amount (SEVERANCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `severance_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `severance_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `tax_withholding_rate` SET TAGS ('pii_business_glossary_term' = 'Tax Withholding Rate (TAX_RATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `tax_withholding_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `tax_withholding_rate` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date (TERM_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `vibe_construction_v1`.`hr`.`employment_contract` ALTER COLUMN `working_hours_per_week` SET TAGS ('pii_business_glossary_term' = 'Weekly Working Hours (HOURS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `reversal_payroll_record_id` SET TAGS ('pii_business_glossary_term' = 'Reversal Payroll Record Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `reversal_payroll_record_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `adjustment_reason` SET TAGS ('pii_value_regex' = 'bonus|correction|retroactive|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `allowance_project` SET TAGS ('pii_business_glossary_term' = 'Project Allowance Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `allowance_site` SET TAGS ('pii_business_glossary_term' = 'Site Allowance Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `allowance_travel` SET TAGS ('pii_business_glossary_term' = 'Travel Allowance Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('pii_business_glossary_term' = 'Bank Account Last 4 Digits (BANK_ACC_LAST4)');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('pii_value_regex' = '^d{4}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_account_last4` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_value_regex' = '^d{9}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('pii_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bonus_type` SET TAGS ('pii_business_glossary_term' = 'Bonus Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `bonus_type` SET TAGS ('pii_value_regex' = 'performance|holiday|sign_on|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payroll Processing Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|AUD|CAD|JPY');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_other_amount` SET TAGS ('pii_business_glossary_term' = 'Other Deduction Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_other_description` SET TAGS ('pii_business_glossary_term' = 'Other Deduction Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_salary_sacrifice` SET TAGS ('pii_business_glossary_term' = 'Salary Sacrifice Deduction Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_salary_sacrifice` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_salary_sacrifice` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_superannuation` SET TAGS ('pii_business_glossary_term' = 'Superannuation Deduction Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `deduction_tax` SET TAGS ('pii_business_glossary_term' = 'Tax Deduction Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `gross_salary` SET TAGS ('pii_business_glossary_term' = 'Gross Salary Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `gross_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `gross_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `is_off_cycle` SET TAGS ('pii_business_glossary_term' = 'Off‑Cycle Payroll Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Record Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|processed|posted|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('pii_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `overtime_rate` SET TAGS ('pii_business_glossary_term' = 'Overtime Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `pay_period_end` SET TAGS ('pii_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `pay_period_start` SET TAGS ('pii_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payment_date` SET TAGS ('pii_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'bank_transfer|check|direct_deposit');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('pii_business_glossary_term' = 'Payroll Record Number (PAYROLL_NO)');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('pii_value_regex' = 'pending|completed|failed|reversed');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `superannuation_fund` SET TAGS ('pii_business_glossary_term' = 'Superannuation Fund Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `tax_code` SET TAGS ('pii_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `tax_year` SET TAGS ('pii_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `year_to_date_deductions` SET TAGS ('pii_business_glossary_term' = 'Year‑To‑Date Total Deductions');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `year_to_date_gross` SET TAGS ('pii_business_glossary_term' = 'Year‑To‑Date Gross Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `year_to_date_net` SET TAGS ('pii_business_glossary_term' = 'Year‑To‑Date Net Pay');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_record` ALTER COLUMN `year_to_date_tax` SET TAGS ('pii_business_glossary_term' = 'Year‑To‑Date Tax Withheld');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Benefit Plan Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `co_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Co‑Pay Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `confidential_benefit` SET TAGS ('pii_business_glossary_term' = 'Confidential Benefit Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `coverage_description` SET TAGS ('pii_business_glossary_term' = 'Benefit Coverage Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `coverage_level` SET TAGS ('pii_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Benefit Eligibility Criteria');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `employee_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `employer_contribution_rate` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `enrollment_end_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `enrollment_start_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `max_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Maximum Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `out_of_pocket_max` SET TAGS ('pii_business_glossary_term' = 'Out‑of‑Pocket Maximum');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_email` SET TAGS ('pii_business_glossary_term' = 'Plan Administrator Email');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_name` SET TAGS ('pii_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_phone` SET TAGS ('pii_business_glossary_term' = 'Plan Administrator Phone');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_admin_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('pii_business_glossary_term' = 'Plan Document URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_business_glossary_term' = 'Benefit Provider Contact Email');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Benefit Provider Contact Phone');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('pii_business_glossary_term' = 'Benefit Provider Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `taxable_benefit` SET TAGS ('pii_business_glossary_term' = 'Taxable Benefit Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('pii_business_glossary_term' = 'Waiting Period (Days)');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `prior_benefit_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Benefit Enrollment Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `prior_benefit_enrollment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_cost_share` SET TAGS ('pii_business_glossary_term' = 'Benefit Cost Share');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `contribution_currency` SET TAGS ('pii_business_glossary_term' = 'Contribution Currency');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('pii_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('pii_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('pii_value_regex' = 'employee_only|employee_spouse|family');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('pii_business_glossary_term' = 'Dependent Count');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `elected_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Elected Contribution Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Percent');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_percent` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Percent');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_value_regex' = 'active|inactive|terminated|pending|waived');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `mid_year_change_flag` SET TAGS ('pii_business_glossary_term' = 'Mid‑Year Change Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `open_enrollment_flag` SET TAGS ('pii_business_glossary_term' = 'Open Enrollment Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_group` SET TAGS ('pii_business_glossary_term' = 'Plan Group');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'health|dental|vision|life|disability|retirement');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('pii_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('pii_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('pii_value_regex' = 'marriage|birth|adoption|death|divorce|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_construction_v1`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('pii_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` SET TAGS ('pii_subdomain' = 'leave_attendance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('pii_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('pii_business_glossary_term' = 'Original Leave Request Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `accrual_policy_code` SET TAGS ('pii_business_glossary_term' = 'Accrual Policy Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `approval_decision` SET TAGS ('pii_business_glossary_term' = 'Approval Decision');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `approval_decision` SET TAGS ('pii_value_regex' = 'approved|rejected');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `attachment_flag` SET TAGS ('pii_business_glossary_term' = 'Attachment Present Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `carryover_allowed` SET TAGS ('pii_business_glossary_term' = 'Carryover Allowed Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Additional Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Leave End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `hr_notified` SET TAGS ('pii_business_glossary_term' = 'HR Notified Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `is_paid_leave` SET TAGS ('pii_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('pii_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('pii_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('pii_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('pii_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `leave_year` SET TAGS ('pii_business_glossary_term' = 'Leave Year');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `payroll_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Leave Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Leave Request Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `total_days` SET TAGS ('pii_business_glossary_term' = 'Total Leave Days Requested');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` SET TAGS ('pii_subdomain' = 'leave_attendance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `leave_balance_id` SET TAGS ('pii_business_glossary_term' = 'Leave Balance ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `prior_leave_balance_id` SET TAGS ('pii_business_glossary_term' = 'Prior Leave Balance Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `prior_leave_balance_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_cap` SET TAGS ('pii_business_glossary_term' = 'Accrual Cap');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_method` SET TAGS ('pii_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_method` SET TAGS ('pii_value_regex' = 'pro_rata|full_month|custom');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_period` SET TAGS ('pii_business_glossary_term' = 'Accrual Period');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_period` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually|weekly');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrual_rate` SET TAGS ('pii_business_glossary_term' = 'Accrual Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `accrued_balance` SET TAGS ('pii_business_glossary_term' = 'Accrued Balance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `as_of_date` SET TAGS ('pii_business_glossary_term' = 'Balance As‑Of Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `available_balance` SET TAGS ('pii_business_glossary_term' = 'Available Balance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `balance_number` SET TAGS ('pii_business_glossary_term' = 'Balance Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `balance_status` SET TAGS ('pii_business_glossary_term' = 'Balance Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `balance_status` SET TAGS ('pii_value_regex' = 'active|frozen|closed');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `carryover_allowed` SET TAGS ('pii_business_glossary_term' = 'Carryover Allowed');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `carryover_limit` SET TAGS ('pii_business_glossary_term' = 'Carryover Limit');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `forfeited_balance` SET TAGS ('pii_business_glossary_term' = 'Forfeited Balance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `last_accrual_date` SET TAGS ('pii_business_glossary_term' = 'Last Accrual Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `leave_policy_code` SET TAGS ('pii_business_glossary_term' = 'Leave Policy Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `leave_type` SET TAGS ('pii_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `leave_type` SET TAGS ('pii_value_regex' = 'annual|sick|parental|bereavement|compensatory|unpaid');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `next_accrual_date` SET TAGS ('pii_business_glossary_term' = 'Next Accrual Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `pending_balance` SET TAGS ('pii_business_glossary_term' = 'Pending Balance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `taken_balance` SET TAGS ('pii_business_glossary_term' = 'Taken Balance');
ALTER TABLE `vibe_construction_v1`.`hr`.`leave_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `replacement_recruitment_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Replacement Recruitment Requisition Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `replacement_recruitment_requisition_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('pii_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `budget_code` SET TAGS ('pii_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `closing_date` SET TAGS ('pii_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('pii_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `expected_fte` SET TAGS ('pii_business_glossary_term' = 'Expected Full‑Time Equivalent');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `external_job_posting` SET TAGS ('pii_business_glossary_term' = 'External Job Posting Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `internal_job_posting` SET TAGS ('pii_business_glossary_term' = 'Internal Job Posting Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `interview_process` SET TAGS ('pii_business_glossary_term' = 'Interview Process Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `job_grade` SET TAGS ('pii_business_glossary_term' = 'Job Grade');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `posting_date` SET TAGS ('pii_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_status` SET TAGS ('pii_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|on_hold|filled|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_source` SET TAGS ('pii_business_glossary_term' = 'Recruitment Source');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_source` SET TAGS ('pii_value_regex' = 'job_board|social_media|employee_referral|recruiter|internal');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `remote_option` SET TAGS ('pii_business_glossary_term' = 'Remote Work Option');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `required_education_level` SET TAGS ('pii_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `required_education_level` SET TAGS ('pii_value_regex' = 'high_school|associate|bachelor|master|doctorate');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `required_experience_years` SET TAGS ('pii_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_timestamp` SET TAGS ('pii_business_glossary_term' = 'Requisition Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_max` SET TAGS ('pii_business_glossary_term' = 'Salary Maximum (Annual)');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_max` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_max` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_min` SET TAGS ('pii_business_glossary_term' = 'Salary Minimum (Annual)');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_min` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_min` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `skill_set` SET TAGS ('pii_business_glossary_term' = 'Required Skill Set');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('pii_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('pii_value_regex' = 'internal|external|recruiter|employee_referral|agency');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('pii_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`recruitment_requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('pii_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Recruiter Identifier (RECRUITER_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('pii_business_glossary_term' = 'Referred By Applicant Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Applicant Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Applicant Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `applicant_status` SET TAGS ('pii_business_glossary_term' = 'Applicant Status (APPLICANT_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `applicant_status` SET TAGS ('pii_value_regex' = 'applied|interviewed|offered|hired|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Applicant Application Date (APPLICATION_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `availability_date` SET TAGS ('pii_business_glossary_term' = 'Applicant Availability Date (AVAILABILITY_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('pii_business_glossary_term' = 'Background Check Status (BACKGROUND_CHECK_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|cleared|failed');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `certifications` SET TAGS ('pii_business_glossary_term' = 'Applicant Certifications (CERTIFICATIONS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `citizenship_country_code` SET TAGS ('pii_business_glossary_term' = 'Citizenship Country Code (CITIZENSHIP_COUNTRY_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `citizenship_country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `citizenship_country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Applicant City (CITY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `city` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Applicant Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `country_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('pii_business_glossary_term' = 'Applicant Current Employer (CURRENT_EMPLOYER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_business_glossary_term' = 'Applicant Date of Birth (DATE_OF_BIRTH)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Applicant Email Address (EMAIL_ADDRESS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('pii_business_glossary_term' = 'Applicant Expected Salary (EXPECTED_SALARY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `full_name` SET TAGS ('pii_business_glossary_term' = 'Applicant Full Name (FULL_NAME)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `full_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `full_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_status` SET TAGS ('pii_business_glossary_term' = 'GDPR Consent Status (GDPR_CONSENT_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_status` SET TAGS ('pii_value_regex' = 'granted|revoked|pending');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('pii_business_glossary_term' = 'GDPR Consent Timestamp (GDPR_CONSENT_TIMESTAMP)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Applicant Gender (GENDER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `highest_qualification` SET TAGS ('pii_business_glossary_term' = 'Applicant Highest Qualification (HIGHEST_QUALIFICATION)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `highest_qualification` SET TAGS ('pii_value_regex' = 'high_school|associate|bachelor|master|doctorate|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `languages` SET TAGS ('pii_business_glossary_term' = 'Applicant Languages (LANGUAGES)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `linkedin_profile_url` SET TAGS ('pii_business_glossary_term' = 'LinkedIn Profile URL (LINKEDIN_PROFILE_URL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('pii_business_glossary_term' = 'National ID Number (NATIONAL_ID_NUMBER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `national_id_number` SET TAGS ('pii_national_id' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `passport_number` SET TAGS ('pii_business_glossary_term' = 'Passport Number (PASSPORT_NUMBER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `passport_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `passport_number` SET TAGS ('pii_passport' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Applicant Phone Number (PHONE_NUMBER)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `position_applied_code` SET TAGS ('pii_business_glossary_term' = 'Position Applied Code (POSITION_APPLIED_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Applicant Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `qualification_field` SET TAGS ('pii_business_glossary_term' = 'Applicant Qualification Field (QUALIFICATION_FIELD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp (RECORD_AUDIT_CREATED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp (RECORD_AUDIT_UPDATED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `referral_source` SET TAGS ('pii_business_glossary_term' = 'Referral Source (REFERRAL_SOURCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `resume_reference` SET TAGS ('pii_business_glossary_term' = 'Applicant Resume Reference (RESUME_REFERENCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `skills` SET TAGS ('pii_business_glossary_term' = 'Applicant Skills (SKILLS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('pii_business_glossary_term' = 'Applicant Source Channel (SOURCE_CHANNEL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('pii_value_regex' = 'linkedin|referral|agency|careers_portal|internal|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'Applicant State/Province (STATE_PROVINCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `state_province` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `visa_status` SET TAGS ('pii_business_glossary_term' = 'Visa Status (VISA_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `visa_status` SET TAGS ('pii_value_regex' = 'citizen|permanent_resident|work_visa|student_visa|none');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `willingness_to_relocate` SET TAGS ('pii_business_glossary_term' = 'Willingness to Relocate (WILLINGNESS_TO_RELOCATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('pii_business_glossary_term' = 'Applicant Years of Experience (YEARS_OF_EXPERIENCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `application_id` SET TAGS ('pii_business_glossary_term' = 'Application ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `applicant_id` SET TAGS ('pii_business_glossary_term' = 'Candidate ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('pii_business_glossary_term' = 'Requisition ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `resubmitted_application_id` SET TAGS ('pii_business_glossary_term' = 'Resubmitted Application Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `resubmitted_application_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `application_status` SET TAGS ('pii_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `assessment_result` SET TAGS ('pii_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `assessment_result` SET TAGS ('pii_value_regex' = 'pass|fail|pending');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `cover_letter_url` SET TAGS ('pii_business_glossary_term' = 'Cover Letter URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `interview_score` SET TAGS ('pii_business_glossary_term' = 'Interview Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Application Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_accepted` SET TAGS ('pii_business_glossary_term' = 'Offer Acceptance Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_gross` SET TAGS ('pii_business_glossary_term' = 'Offered Gross Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_gross` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_gross` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_net` SET TAGS ('pii_business_glossary_term' = 'Offered Net Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_net` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_salary_net` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `offer_start_date` SET TAGS ('pii_business_glossary_term' = 'Offer Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `resume_url` SET TAGS ('pii_business_glossary_term' = 'Resume URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `salary_adjustment` SET TAGS ('pii_business_glossary_term' = 'Salary Adjustment');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `salary_adjustment` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `salary_adjustment` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `source` SET TAGS ('pii_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `source` SET TAGS ('pii_value_regex' = 'referral|job_board|agency|internal|social_media');
ALTER TABLE `vibe_construction_v1`.`hr`.`application` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `prior_performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Prior Performance Review Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `prior_performance_review_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `tertiary_performance_hr_approval_employee_id` SET TAGS ('pii_business_glossary_term' = 'HR Approval ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `tertiary_performance_hr_approval_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `tertiary_performance_hr_approval_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `bonus_eligible` SET TAGS ('pii_business_glossary_term' = 'Bonus Eligibility');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `calibration_comments` SET TAGS ('pii_business_glossary_term' = 'Calibration Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('pii_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('pii_value_regex' = 'pending|completed|adjusted');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('pii_business_glossary_term' = 'Compensation Change Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `competency_score` SET TAGS ('pii_business_glossary_term' = 'Overall Competency Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('pii_business_glossary_term' = 'Employee Self‑Assessment');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `final_approved_rating` SET TAGS ('pii_business_glossary_term' = 'Final Approved Rating');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `final_approved_rating` SET TAGS ('pii_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('pii_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_approval_status` SET TAGS ('pii_business_glossary_term' = 'HR Approval Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `hr_approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'HR Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `leadership_competency` SET TAGS ('pii_business_glossary_term' = 'Leadership Competency Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Review Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|in_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('pii_business_glossary_term' = 'Manager Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('pii_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `promotion_eligibility` SET TAGS ('pii_business_glossary_term' = 'Promotion Eligibility');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `rating_explanation` SET TAGS ('pii_business_glossary_term' = 'Rating Explanation');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('pii_business_glossary_term' = 'Rating Scale');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `rating_score` SET TAGS ('pii_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_cycle` SET TAGS ('pii_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_cycle` SET TAGS ('pii_value_regex' = 'annual|mid-year|probation|project-end');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_location_code` SET TAGS ('pii_business_glossary_term' = 'Review Location Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_method` SET TAGS ('pii_business_glossary_term' = 'Review Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_method` SET TAGS ('pii_value_regex' = 'self|manager|360|peer');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_period_end` SET TAGS ('pii_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_period_start` SET TAGS ('pii_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'performance|project|probation');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `review_version` SET TAGS ('pii_business_glossary_term' = 'Review Version');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `safety_competency` SET TAGS ('pii_business_glossary_term' = 'Safety Competency Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Salary Adjustment Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `succession_plan_flag` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`performance_review` ALTER COLUMN `technical_competency` SET TAGS ('pii_business_glossary_term' = 'Technical Competency Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_id` SET TAGS ('pii_business_glossary_term' = 'Goal ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `kpi_id` SET TAGS ('pii_business_glossary_term' = 'Alignment KPI ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('pii_business_glossary_term' = 'Parent Goal Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `primary_goal_approved_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID (Employee Identifier)');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `primary_goal_approved_by_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `primary_goal_approved_by_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `achievement_rating` SET TAGS ('pii_business_glossary_term' = 'Achievement Rating');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `achievement_rating` SET TAGS ('pii_value_regex' = 'exceeds|meets|partially|does_not_meet|not_applicable');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_code` SET TAGS ('pii_business_glossary_term' = 'Goal Code (Unique Business Identifier)');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Goal Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_description` SET TAGS ('pii_business_glossary_term' = 'Goal Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_status` SET TAGS ('pii_business_glossary_term' = 'Goal Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_status` SET TAGS ('pii_value_regex' = 'draft|active|completed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_type` SET TAGS ('pii_business_glossary_term' = 'Goal Type (Individual, Team, Corporate, Project)');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `goal_type` SET TAGS ('pii_value_regex' = 'individual|team|corporate|project');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `is_key_goal` SET TAGS ('pii_business_glossary_term' = 'Key Goal Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'absolute|percentage|ratio');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `progress_percent` SET TAGS ('pii_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `rating_score` SET TAGS ('pii_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `review_cycle` SET TAGS ('pii_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `supporting_documents` SET TAGS ('pii_business_glossary_term' = 'Supporting Documents URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `target_metric` SET TAGS ('pii_business_glossary_term' = 'Target Metric');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Goal Title');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`goal` ALTER COLUMN `weight_percent` SET TAGS ('pii_business_glossary_term' = 'Goal Weight Percentage (Weight %)');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('pii_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Instructor ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `prerequisite_training_course_id` SET TAGS ('pii_business_glossary_term' = 'Prerequisite Training Course Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `prerequisite_training_course_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `applicable_job_profile_codes` SET TAGS ('pii_business_glossary_term' = 'Applicable Job Profile Codes');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('pii_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('pii_value_regex' = 'exam|project|simulation|none');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `assessment_pass_rate` SET TAGS ('pii_business_glossary_term' = 'Assessment Pass Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `certification_awarded_flag` SET TAGS ('pii_business_glossary_term' = 'Certification Awarded Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `cost` SET TAGS ('pii_business_glossary_term' = 'Course Cost');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `course_code` SET TAGS ('pii_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `course_type` SET TAGS ('pii_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `course_type` SET TAGS ('pii_value_regex' = 'technical|leadership|compliance|hse_awareness|project_management|bim_digital_tools');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `cpd_points` SET TAGS ('pii_business_glossary_term' = 'Continuing Professional Development Points');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `delivery_location` SET TAGS ('pii_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('pii_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('pii_value_regex' = 'classroom|e_learning|on_the_job|external');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('pii_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Course Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `enrollment_cap` SET TAGS ('pii_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `enrollment_current` SET TAGS ('pii_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `instructor_name` SET TAGS ('pii_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Course Language');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `language` SET TAGS ('pii_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_level` SET TAGS ('pii_business_glossary_term' = 'Course Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_level` SET TAGS ('pii_value_regex' = 'beginner|intermediate|advanced');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Course Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `material_url` SET TAGS ('pii_business_glossary_term' = 'Course Material URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Course Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `online_url` SET TAGS ('pii_business_glossary_term' = 'Online Course URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `prerequisite_course_codes` SET TAGS ('pii_business_glossary_term' = 'Prerequisite Course Codes');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('pii_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('pii_value_regex' = 'corporate_staff|management|executives');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('pii_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|draft|pending_approval');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_course` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Course Version Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `rescheduled_training_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Rescheduled Training Enrollment Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `rescheduled_training_enrollment_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_course_id` SET TAGS ('pii_business_glossary_term' = 'Course ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `certificate_issued` SET TAGS ('pii_business_glossary_term' = 'Certificate Issued');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `compliance_required` SET TAGS ('pii_business_glossary_term' = 'Compliance Required');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `cpd_points` SET TAGS ('pii_business_glossary_term' = 'Continuing Professional Development Points');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'online|in_person|blended');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('pii_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `hours` SET TAGS ('pii_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `pass_fail_outcome` SET TAGS ('pii_business_glossary_term' = 'Pass/Fail Outcome');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `pass_fail_outcome` SET TAGS ('pii_value_regex' = 'pass|fail');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('pii_value_regex' = 'enrolled|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_provider` SET TAGS ('pii_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('pii_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('pii_value_regex' = 'mandatory|optional|refresher');
ALTER TABLE `vibe_construction_v1`.`hr`.`training_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` SET TAGS ('pii_subdomain' = 'employee_relations');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `disciplinary_case_id` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Case ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `parent_disciplinary_case_id` SET TAGS ('pii_business_glossary_term' = 'Related Disciplinary Case Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `parent_disciplinary_case_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID (EMP_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('pii_business_glossary_term' = 'HR Business Partner ID (HR_BP_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Decision Date (APPEAL_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `appeal_filed` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Indicator (APPEAL_FILED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome (APPEAL_OUTCOME)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_closed_date` SET TAGS ('pii_business_glossary_term' = 'Case Closed Date (CASE_CLOSED_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_number` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Case Number (CASE_NO)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_priority` SET TAGS ('pii_business_glossary_term' = 'Case Priority (CASE_PRIORITY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_priority` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_source` SET TAGS ('pii_business_glossary_term' = 'Case Source (CASE_SOURCE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_source` SET TAGS ('pii_value_regex' = 'internal|external|self_reported');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Case Type (CASE_TYPE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('pii_value_regex' = 'misconduct|performance|attendance|policy_breach|code_of_conduct_violation');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `disciplinary_case_description` SET TAGS ('pii_business_glossary_term' = 'Case Description (CASE_DESC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `disciplinary_action_effective_date` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Effective Date (ACTION_EFF_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `disciplinary_case_status` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Case Status (CASE_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `disciplinary_case_status` SET TAGS ('pii_value_regex' = 'open|under_investigation|outcome_issued|appealed|closed');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Confidential Case Indicator (CONFIDENTIAL_FLAG)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Case Notes (CASE_NOTES)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `outcome` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Outcome (OUTCOME)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `outcome` SET TAGS ('pii_value_regex' = 'verbal_warning|written_warning|final_warning|termination');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `outcome_date` SET TAGS ('pii_business_glossary_term' = 'Outcome Effective Date (OUTCOME_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `raised_timestamp` SET TAGS ('pii_business_glossary_term' = 'Case Raised Timestamp (CASE_RAISED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version Number (REC_VERSION)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `severity_score` SET TAGS ('pii_business_glossary_term' = 'Outcome Severity Score (SEVERITY_SCORE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Effective Date (TERMINATION_DATE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`disciplinary_case` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` SET TAGS ('pii_subdomain' = 'employee_relations');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('pii_business_glossary_term' = 'Grievance ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `escalated_grievance_id` SET TAGS ('pii_business_glossary_term' = 'Escalated Grievance Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `escalated_grievance_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Complainant Employee Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `tertiary_grievance_respondent_employee_id` SET TAGS ('pii_business_glossary_term' = 'Respondent Employee Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `tertiary_grievance_respondent_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `tertiary_grievance_respondent_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_category` SET TAGS ('pii_business_glossary_term' = 'Grievance Category');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_category` SET TAGS ('pii_value_regex' = 'harassment|discrimination|unsafe_condition|unfair_treatment|management_conduct|other');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `compensation_amount` SET TAGS ('pii_business_glossary_term' = 'Compensation Amount (Monetary Value)');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `compensation_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `compensation_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_description` SET TAGS ('pii_business_glossary_term' = 'Grievance Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `escalation_external_body` SET TAGS ('pii_business_glossary_term' = 'Escalation External Body');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `escalation_external_body` SET TAGS ('pii_value_regex' = 'fair_work_commission|eeoc|employment_tribunal|none');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_number` SET TAGS ('pii_business_glossary_term' = 'Grievance Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_status` SET TAGS ('pii_business_glossary_term' = 'Grievance Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `grievance_status` SET TAGS ('pii_value_regex' = 'open|in_progress|resolved|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `investigation_end_date` SET TAGS ('pii_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `investigation_status` SET TAGS ('pii_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `investigation_status` SET TAGS ('pii_value_regex' = 'not_started|ongoing|completed');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `lodged_timestamp` SET TAGS ('pii_business_glossary_term' = 'Grievance Lodged Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'resolved|unresolved|settled|dismissed|escalated');
ALTER TABLE `vibe_construction_v1`.`hr`.`grievance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_review_id` SET TAGS ('pii_business_glossary_term' = 'Compensation Review ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_review_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_review_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `prior_compensation_review_id` SET TAGS ('pii_business_glossary_term' = 'Prior Compensation Review Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `prior_compensation_review_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `prior_compensation_review_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `prior_compensation_review_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_consumed_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Consumed Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_consumed_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_consumed_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_pool_code` SET TAGS ('pii_business_glossary_term' = 'Budget Pool Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_remaining_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Remaining Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_remaining_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `budget_remaining_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_component` SET TAGS ('pii_business_glossary_term' = 'Compensation Component');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_component` SET TAGS ('pii_value_regex' = 'base|bonus|equity|allowance');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_component` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `compensation_component` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `current_salary` SET TAGS ('pii_business_glossary_term' = 'Current Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `current_salary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `current_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `grade_level` SET TAGS ('pii_business_glossary_term' = 'Grade Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `increase_percentage` SET TAGS ('pii_business_glossary_term' = 'Increase Percentage');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `increase_type` SET TAGS ('pii_business_glossary_term' = 'Increase Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `internal_equity_score` SET TAGS ('pii_business_glossary_term' = 'Internal Equity Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `internal_equity_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `internal_equity_score` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `is_equity_granted` SET TAGS ('pii_business_glossary_term' = 'Is Equity Granted');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `is_promoted` SET TAGS ('pii_business_glossary_term' = 'Is Promoted');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `is_salary_adjusted` SET TAGS ('pii_business_glossary_term' = 'Is Salary Adjusted');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `is_salary_adjusted` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `is_salary_adjusted` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Compensation Justification');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `market_rate` SET TAGS ('pii_business_glossary_term' = 'Market Rate');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `market_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `market_rate` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `new_salary` SET TAGS ('pii_business_glossary_term' = 'New Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `new_salary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `new_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `pay_band` SET TAGS ('pii_business_glossary_term' = 'Pay Band');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `proposed_salary` SET TAGS ('pii_business_glossary_term' = 'Proposed Salary');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `proposed_salary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `proposed_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_cycle` SET TAGS ('pii_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_cycle` SET TAGS ('pii_value_regex' = 'annual|midyear|offcycle');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Compensation Review Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_period_end` SET TAGS ('pii_business_glossary_term' = 'Review Period End');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_period_start` SET TAGS ('pii_business_glossary_term' = 'Review Period Start');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'draft|submitted|finalized|closed');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `review_year` SET TAGS ('pii_business_glossary_term' = 'Review Year');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `salary_basis` SET TAGS ('pii_business_glossary_term' = 'Salary Basis');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `salary_basis` SET TAGS ('pii_value_regex' = 'base|total|target');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `salary_basis` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`compensation_review` ALTER COLUMN `salary_basis` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('pii_business_glossary_term' = 'Succession Plan ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Incumbent Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `superseded_succession_plan_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Succession Plan Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `superseded_succession_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Target Position ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Plan Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `development_actions` SET TAGS ('pii_business_glossary_term' = 'Development Actions');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('pii_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'critical|non_critical|leadership|technical');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('pii_business_glossary_term' = 'Successor Readiness Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('pii_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Succession Risk Rating');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|flight_risk|retirement_risk');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('pii_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('pii_value_regex' = 'draft|active|inactive|archived');
ALTER TABLE `vibe_construction_v1`.`hr`.`succession_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `onboarding_checklist_id` SET TAGS ('pii_business_glossary_term' = 'Onboarding Checklist ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `onboarding_template_id` SET TAGS ('pii_business_glossary_term' = 'Onboarding Template ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `parent_onboarding_checklist_id` SET TAGS ('pii_business_glossary_term' = 'Parent Onboarding Checklist Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `parent_onboarding_checklist_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `tertiary_onboarding_buddy_assigned_employee_id` SET TAGS ('pii_business_glossary_term' = 'Onboarding Buddy ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `tertiary_onboarding_buddy_assigned_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `tertiary_onboarding_buddy_assigned_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Policy Acknowledgement Date (PAD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `acknowledgment_received` SET TAGS ('pii_business_glossary_term' = 'Policy Acknowledgement Received (PAR)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `background_check_completed` SET TAGS ('pii_business_glossary_term' = 'Background Check Completed (BCC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `background_check_date` SET TAGS ('pii_business_glossary_term' = 'Background Check Completion Date (BCCD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `benefits_enrollment_completed` SET TAGS ('pii_business_glossary_term' = 'Benefits Enrollment Completed (BEC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `benefits_enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Benefits Enrollment Date (BED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `completion_percentage` SET TAGS ('pii_business_glossary_term' = 'Onboarding Completion Percentage (OCP)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `compliance_training_completed` SET TAGS ('pii_business_glossary_term' = 'Compliance Training Completed (CTC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `compliance_training_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Training Date (CTD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Planned End Date (OPED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `equipment_assigned` SET TAGS ('pii_business_glossary_term' = 'Equipment Assigned Flag (EAF)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `equipment_assigned_date` SET TAGS ('pii_business_glossary_term' = 'Equipment Assigned Date (EAD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_completed` SET TAGS ('pii_business_glossary_term' = 'Health & Safety Training Completed (HSTC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_completed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_completed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_date` SET TAGS ('pii_business_glossary_term' = 'Health & Safety Training Date (HSTD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `health_safety_training_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Onboarding Mandatory Flag (OMF)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `last_task_completed_date` SET TAGS ('pii_business_glossary_term' = 'Last Task Completed Date (LTCD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Primary Location Code (PLC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Onboarding Notes (ON)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `overall_status` SET TAGS ('pii_business_glossary_term' = 'Onboarding Overall Status (OOS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `overall_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `payroll_setup_completed` SET TAGS ('pii_business_glossary_term' = 'Payroll Setup Completed (PSC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `payroll_setup_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Setup Date (PSD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `policy_acknowledged` SET TAGS ('pii_business_glossary_term' = 'Policy Acknowledged (PA)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `policy_acknowledged` SET TAGS ('pii_value_regex' = 'code_of_conduct|safety_policy|privacy_policy|it_usage_policy');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `requires_security_clearance` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Required (SCR)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Level (SCL)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_value_regex' = 'confidential|secret|top_secret');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Start Date (OSD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `task_completed` SET TAGS ('pii_business_glossary_term' = 'Completed Onboarding Tasks (COM)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `task_total` SET TAGS ('pii_business_glossary_term' = 'Total Onboarding Tasks (TOT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `training_completed` SET TAGS ('pii_business_glossary_term' = 'Mandatory Training Completed (MTC)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `training_completion_date` SET TAGS ('pii_business_glossary_term' = 'Training Completion Date (TCD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `visa_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Visa Expiry Date (VED)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `visa_status` SET TAGS ('pii_business_glossary_term' = 'Visa Status (VS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_checklist` ALTER COLUMN `visa_status` SET TAGS ('pii_value_regex' = 'none|pending|approved|expired');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_id` SET TAGS ('pii_business_glossary_term' = 'Separation Record Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `rehire_separation_id` SET TAGS ('pii_business_glossary_term' = 'Rehire Separation Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `rehire_separation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `tertiary_separation_processed_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Processed By Employee Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `tertiary_separation_processed_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `tertiary_separation_processed_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `benefits_termination_date` SET TAGS ('pii_business_glossary_term' = 'Benefits Termination Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `compliance_review_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `compliance_review_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `effective_separation_date` SET TAGS ('pii_business_glossary_term' = 'Effective Separation Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `equipment_return_date` SET TAGS ('pii_business_glossary_term' = 'Equipment Return Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `equipment_return_status` SET TAGS ('pii_business_glossary_term' = 'Equipment Return Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `equipment_return_status` SET TAGS ('pii_value_regex' = 'not_returned|partial|returned');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `exit_interview_completed` SET TAGS ('pii_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `exit_interview_feedback` SET TAGS ('pii_business_glossary_term' = 'Exit Interview Feedback');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `exit_interview_score` SET TAGS ('pii_business_glossary_term' = 'Exit Interview Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `exit_interview_theme` SET TAGS ('pii_business_glossary_term' = 'Exit Interview Theme');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `final_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Final Pay Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `final_pay_status` SET TAGS ('pii_business_glossary_term' = 'Final Pay Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `final_pay_status` SET TAGS ('pii_value_regex' = 'pending|calculated|paid|error');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `last_working_day` SET TAGS ('pii_business_glossary_term' = 'Last Working Day');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Separation Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `notice_date` SET TAGS ('pii_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `payroll_cutoff_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Cutoff Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `rehire_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_number` SET TAGS ('pii_business_glossary_term' = 'Separation Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_status` SET TAGS ('pii_business_glossary_term' = 'Separation Process Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_status` SET TAGS ('pii_value_regex' = 'initiated|in_progress|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_type` SET TAGS ('pii_business_glossary_term' = 'Separation Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `separation_type` SET TAGS ('pii_value_regex' = 'resignation|retirement|termination|redundancy|end_of_contract|death_in_service');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `severance_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Severance Pay Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `severance_pay_status` SET TAGS ('pii_business_glossary_term' = 'Severance Pay Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `severance_pay_status` SET TAGS ('pii_value_regex' = 'pending|paid|not_applicable');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `system_access_revocation_date` SET TAGS ('pii_business_glossary_term' = 'System Access Revocation Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`separation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` SET TAGS ('pii_subdomain' = 'employee_relations');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_id` SET TAGS ('pii_business_glossary_term' = 'HR Policy ID');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Policy Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('pii_business_glossary_term' = 'HR Policy Applicable Jurisdictions');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `approving_authority` SET TAGS ('pii_business_glossary_term' = 'HR Policy Approving Authority');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_category` SET TAGS ('pii_business_glossary_term' = 'HR Policy Category');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_category` SET TAGS ('pii_value_regex' = 'leave|code_of_conduct|anti_harassment|remuneration|flexible_work|travel');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'HR Policy Change Reason');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_code` SET TAGS ('pii_business_glossary_term' = 'HR Policy Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'HR Policy Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'HR Policy Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_description` SET TAGS ('pii_business_glossary_term' = 'HR Policy Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'HR Policy Document URL');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'HR Policy Effective Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `enforcement_level` SET TAGS ('pii_business_glossary_term' = 'HR Policy Enforcement Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `enforcement_level` SET TAGS ('pii_value_regex' = 'mandatory|advisory|optional');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'HR Policy Expiration Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `mandatory_acknowledgement` SET TAGS ('pii_business_glossary_term' = 'HR Policy Mandatory Acknowledgement Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'HR Policy Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `policy_status` SET TAGS ('pii_value_regex' = 'active|inactive|draft|pending|retired');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'HR Policy Record Audit Created');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'HR Policy Record Audit Updated');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'HR Policy Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'HR Policy Title');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'HR Policy Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `version_notes` SET TAGS ('pii_business_glossary_term' = 'HR Policy Version Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`policy` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'HR Policy Version Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` SET TAGS ('pii_subdomain' = 'workforce_master');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `workforce_headcount_plan_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Headcount Plan Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Identifier (APPROVED_BY_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Identifier (ORG_UNIT_ID)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `prior_workforce_headcount_plan_id` SET TAGS ('pii_business_glossary_term' = 'Prior Workforce Headcount Plan Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `prior_workforce_headcount_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `actual_fte` SET TAGS ('pii_business_glossary_term' = 'Actual Full‑Time Equivalent (ACTUAL_FTE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `approved_backfills` SET TAGS ('pii_business_glossary_term' = 'Approved Backfills (APPROVED_BACKFILLS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `approved_new_hires` SET TAGS ('pii_business_glossary_term' = 'Approved New Hires (APPROVED_NEW_HIRES)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `attrition_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Attrition Rate Percent (ATTRITION_RATE_PCT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `job_family` SET TAGS ('pii_business_glossary_term' = 'Job Family (JOB_FAMILY)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `job_grade` SET TAGS ('pii_business_glossary_term' = 'Job Grade (JOB_GRADE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Plan Notes (PLAN_NOTES)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `period` SET TAGS ('pii_business_glossary_term' = 'Planning Period (PERIOD)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Plan Number (PLAN_NO)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type (PLAN_TYPE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'annual|quarterly|monthly|rolling|ad_hoc');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `planned_fte` SET TAGS ('pii_business_glossary_term' = 'Planned Full‑Time Equivalent (PLANNED_FTE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `variance_fte` SET TAGS ('pii_business_glossary_term' = 'FTE Variance (VARIANCE_FTE)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `workforce_headcount_plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status (PLAN_STATUS)');
ALTER TABLE `vibe_construction_v1`.`hr`.`workforce_headcount_plan` ALTER COLUMN `workforce_headcount_plan_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|active|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_id` SET TAGS ('pii_business_glossary_term' = 'Kpi Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `alignment_kpi_id` SET TAGS ('pii_business_glossary_term' = 'Alignment Kpi Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `alignment_kpi_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `baseline_value` SET TAGS ('pii_business_glossary_term' = 'Baseline Value');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `calculation_method` SET TAGS ('pii_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_category` SET TAGS ('pii_business_glossary_term' = 'Category');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `compliance_requirement` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `frequency` SET TAGS ('pii_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `is_key_performance_indicator` SET TAGS ('pii_business_glossary_term' = 'Is Key Performance Indicator');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_type` SET TAGS ('pii_business_glossary_term' = 'Kpi Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `measurement_unit` SET TAGS ('pii_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `kpi_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `owner_department` SET TAGS ('pii_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `related_process` SET TAGS ('pii_business_glossary_term' = 'Related Process');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `reporting_level` SET TAGS ('pii_business_glossary_term' = 'Reporting Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `review_frequency` SET TAGS ('pii_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `target_direction` SET TAGS ('pii_business_glossary_term' = 'Target Direction');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `threshold_value` SET TAGS ('pii_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`kpi` ALTER COLUMN `visualization_type` SET TAGS ('pii_business_glossary_term' = 'Visualization Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `onboarding_template_id` SET TAGS ('pii_business_glossary_term' = 'Onboarding Template Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `parent_onboarding_template_id` SET TAGS ('pii_business_glossary_term' = 'Parent Onboarding Template Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `parent_onboarding_template_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `access_level` SET TAGS ('pii_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Department');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `onboarding_template_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `document_count` SET TAGS ('pii_business_glossary_term' = 'Document Count');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `estimated_completion_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Estimated Completion Time Minutes');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Language');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `onboarding_template_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `requires_manager_approval` SET TAGS ('pii_business_glossary_term' = 'Requires Manager Approval');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `reviewer` SET TAGS ('pii_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `role_applicable` SET TAGS ('pii_business_glossary_term' = 'Role Applicable');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `template_code` SET TAGS ('pii_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `template_name` SET TAGS ('pii_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `template_owner` SET TAGS ('pii_business_glossary_term' = 'Template Owner');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `template_type` SET TAGS ('pii_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`onboarding_template` ALTER COLUMN `version_release_date` SET TAGS ('pii_business_glossary_term' = 'Version Release Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_group_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Group Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `prior_payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Prior Payroll Run Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `prior_payroll_run_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `deductions_amount` SET TAGS ('pii_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_run_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('pii_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `fiscal_period` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `is_manual` SET TAGS ('pii_business_glossary_term' = 'Is Manual');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `pay_cycle` SET TAGS ('pii_business_glossary_term' = 'Pay Cycle');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('pii_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_period_end` SET TAGS ('pii_business_glossary_term' = 'Payroll Period End');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_period_start` SET TAGS ('pii_business_glossary_term' = 'Payroll Period Start');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('pii_business_glossary_term' = 'Payroll Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `processed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `run_timestamp` SET TAGS ('pii_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `tax_year` SET TAGS ('pii_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_run` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `payroll_group_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Group Identifier');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('pii_business_glossary_term' = 'Parent Payroll Group Id');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `parent_payroll_group_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `benefit_eligibility_flag` SET TAGS ('pii_business_glossary_term' = 'Benefit Eligibility Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `default_currency` SET TAGS ('pii_business_glossary_term' = 'Default Currency');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `payroll_group_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `employee_count_estimate` SET TAGS ('pii_business_glossary_term' = 'Employee Count Estimate');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `gl_account_number` SET TAGS ('pii_business_glossary_term' = 'Gl Account Number');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `gl_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `gl_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `group_code` SET TAGS ('pii_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `group_name` SET TAGS ('pii_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `group_type` SET TAGS ('pii_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `is_default_group` SET TAGS ('pii_business_glossary_term' = 'Is Default Group');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `owner` SET TAGS ('pii_business_glossary_term' = 'Payroll Group Owner');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `pay_cycle_day` SET TAGS ('pii_business_glossary_term' = 'Pay Cycle Day');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `pay_frequency` SET TAGS ('pii_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `payroll_group_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `tax_code` SET TAGS ('pii_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `tax_status` SET TAGS ('pii_business_glossary_term' = 'Tax Status');
ALTER TABLE `vibe_construction_v1`.`hr`.`payroll_group` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
