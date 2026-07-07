-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`workforce` COMMENT 'Systems of record: SAP SuccessFactors (talent management), SAP HCM/HR, Workday (select INGOs), Oracle HCM. Covers staff lifecycle, payroll, benefits, recruitment, performance, and learning.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`staff_member` (
    `staff_member_id` BIGINT COMMENT 'Unique identifier for the staff member record.',
    `supervisor_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated supervisor staff member entity.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the base salary quantity or measurement.',
    `contract_end_date` DATE COMMENT 'Date and time when the contract end event occurred for this staff member.',
    `contract_start_date` DATE COMMENT 'Date and time when the contract start event occurred for this staff member.',
    `contract_type` STRING COMMENT 'Classification type categorizing the contract for this record.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this staff member.',
    `date_of_birth` DATE COMMENT 'Attribute capturing the date of birth information for the staff member entity.',
    `department` STRING COMMENT 'Attribute capturing the department information for the staff member entity.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the staff member entity.',
    `duty_station_country` STRING COMMENT 'Attribute capturing the duty station country information for the staff member entity.',
    `emergency_contact_name` STRING COMMENT 'Human-readable name or label for the emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Attribute capturing the emergency contact phone information for the staff member entity.',
    `emergency_contact_relationship` STRING COMMENT 'Attribute capturing the emergency contact relationship information for the staff member entity.',
    `employee_number` STRING COMMENT 'Count or number of employee items associated with this record.',
    `employment_status` STRING COMMENT 'Current status indicator for the employment workflow state.',
    `employment_type` STRING COMMENT 'Classification type categorizing the employment for this record.',
    `exit_interview_completed` BOOLEAN COMMENT 'Attribute capturing the exit interview completed information for the staff member entity.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the final settlement quantity or measurement.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Attribute capturing the fte percentage information for the staff member entity.',
    `gender` STRING COMMENT 'Attribute capturing the gender information for the staff member entity.',
    `hire_date` DATE COMMENT 'Date and time when the hire event occurred for this staff member.',
    `job_grade` STRING COMMENT 'Attribute capturing the job grade information for the staff member entity.',
    `job_title` STRING COMMENT 'Attribute capturing the job title information for the staff member entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this staff member.',
    `legal_first_name` STRING COMMENT 'Human-readable name or label for the legal first.',
    `legal_last_name` STRING COMMENT 'Human-readable name or label for the legal last.',
    `nationality` STRING COMMENT 'Attribute capturing the nationality information for the staff member entity.',
    `passport_expiry_date` DATE COMMENT 'Date and time when the passport expiry event occurred for this staff member.',
    `passport_number` STRING COMMENT 'Count or number of passport items associated with this record.',
    `pay_frequency` STRING COMMENT 'Attribute capturing the pay frequency information for the staff member entity.',
    `preferred_name` STRING COMMENT 'Human-readable name or label for the preferred.',
    `probation_end_date` DATE COMMENT 'Date and time when the probation end event occurred for this staff member.',
    `rehire_eligible` BOOLEAN COMMENT 'Attribute capturing the rehire eligible information for the staff member entity.',
    `salary_currency` STRING COMMENT 'Attribute capturing the salary currency information for the staff member entity.',
    `separation_date` DATE COMMENT 'Date and time when the separation event occurred for this staff member.',
    `separation_reason` STRING COMMENT 'Attribute capturing the separation reason information for the staff member entity.',
    `separation_type` STRING COMMENT 'Classification type categorizing the separation for this record.',
    `work_email` STRING COMMENT 'Attribute capturing the work email information for the staff member entity.',
    `work_permit_expiry_date` DATE COMMENT 'Date and time when the work permit expiry event occurred for this staff member.',
    `work_permit_number` STRING COMMENT 'Count or number of work permit items associated with this record.',
    `work_phone` STRING COMMENT 'Attribute capturing the work phone information for the staff member entity.',
    `workday_worker_reference` STRING COMMENT 'Attribute capturing the workday worker reference information for the staff member entity.',
    CONSTRAINT pk_staff_member PRIMARY KEY(`staff_member_id`)
) COMMENT 'Employee or staff member record. Source systems: SAP SuccessFactors, SAP HCM, Workday, Oracle HCM. Systems-of-record: SAP HCM/SuccessFactors, VISION HR. Framework: IPSAS 25 (Employee Benefits) / UN Staff Regulations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `job_profile_id` BIGINT COMMENT 'Reference identifier linking to the associated job profile entity.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `reports_to_position_id` BIGINT COMMENT 'Reference identifier linking to the associated reports to position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `availability_date` DATE COMMENT 'Date and time when the availability event occurred for this position.',
    `budgeted_annual_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the budgeted annual cost information for the position entity.',
    `position_code` STRING COMMENT 'Standardized code representing the position classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this position.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the position entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this position.',
    `filled_date` DATE COMMENT 'Date and time when the filled event occurred for this position.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Attribute capturing the fte allocation information for the position entity.',
    `funding_source_type` STRING COMMENT 'Classification type categorizing the funding source for this record.',
    `headcount_plan_year` STRING COMMENT 'Attribute capturing the headcount plan year information for the position entity.',
    `icr_applicable` BOOLEAN COMMENT 'Attribute capturing the icr applicable information for the position entity.',
    `is_field_position` BOOLEAN COMMENT 'Boolean indicator specifying whether the record field position.',
    `is_supervisory` BOOLEAN COMMENT 'Boolean indicator specifying whether the record supervisory.',
    `is_vacant` BOOLEAN COMMENT 'Boolean indicator specifying whether the record vacant.',
    `job_description_url` STRING COMMENT 'Attribute capturing the job description url information for the position entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this position.',
    `max_salary` DECIMAL(18,2) COMMENT 'Attribute capturing the max salary information for the position entity.',
    `min_education_level` STRING COMMENT 'Attribute capturing the min education level information for the position entity.',
    `min_salary` DECIMAL(18,2) COMMENT 'Attribute capturing the min salary information for the position entity.',
    `min_years_experience` STRING COMMENT 'Attribute capturing the min years experience information for the position entity.',
    `pay_grade_band` STRING COMMENT 'Attribute capturing the pay grade band information for the position entity.',
    `position_status` STRING COMMENT 'Current status indicator for the position workflow state.',
    `position_type` STRING COMMENT 'Classification type categorizing the position for this record.',
    `raci_role` STRING COMMENT 'Attribute capturing the raci role information for the position entity.',
    `required_competencies` STRING COMMENT 'Attribute capturing the required competencies information for the position entity.',
    `required_languages` STRING COMMENT 'Attribute capturing the required languages information for the position entity.',
    `salary_currency_code` STRING COMMENT 'Standardized code representing the salary currency classification or category.',
    `security_clearance_required` BOOLEAN COMMENT 'Attribute capturing the security clearance required information for the position entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the position entity.',
    `title` STRING COMMENT 'Attribute capturing the title information for the position entity.',
    `vacancy_reason` STRING COMMENT 'Attribute capturing the vacancy reason information for the position entity.',
    `workday_position_reference` STRING COMMENT 'Attribute capturing the workday position reference information for the position entity.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized organizational position (headcount slot) within Ngos structure, distinct from the person filling it. Tracks position title, grade level, FTE allocation, funding source (grant or core), duty station, department, and whether the position is filled or vacant. Includes embedded job profile catalog: job family, job level, job function, competency requirements, minimum qualifications, pay grade band, and career progression path aligned with Workday HCM job catalog. Supports workforce planning, grant-funded headcount tracking, recruitment requisition creation, RACI role assignments, and organizational design.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique identifier for the employment contract record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `job_profile_id` BIGINT COMMENT 'Reference identifier linking to the associated job profile entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `amendment_effective_date` DATE COMMENT 'Date and time when the amendment effective event occurred for this employment contract.',
    `amendment_number` STRING COMMENT 'Count or number of amendment items associated with this record.',
    `amendment_reason` STRING COMMENT 'Attribute capturing the amendment reason information for the employment contract entity.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this employment contract.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the base salary quantity or measurement.',
    `contract_number` STRING COMMENT 'Count or number of contract items associated with this record.',
    `contract_status` STRING COMMENT 'Current status indicator for the contract workflow state.',
    `contract_type` STRING COMMENT 'Classification type categorizing the contract for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this employment contract.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the employment contract entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `education_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the education allowance quantity or measurement.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this employment contract.',
    `funding_source_code` STRING COMMENT 'Standardized code representing the funding source classification or category.',
    `hardship_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the hardship allowance quantity or measurement.',
    `hardship_tier` STRING COMMENT 'Attribute capturing the hardship tier information for the employment contract entity.',
    `home_leave_frequency_months` STRING COMMENT 'Attribute capturing the home leave frequency months information for the employment contract entity.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the housing allowance quantity or measurement.',
    `icr_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the icr rate information for the employment contract entity.',
    `ingo_salary_scale` STRING COMMENT 'Attribute capturing the ingo salary scale information for the employment contract entity.',
    `is_expatriate` BOOLEAN COMMENT 'Boolean indicator specifying whether the record expatriate.',
    `labor_law_jurisdiction` STRING COMMENT 'Attribute capturing the labor law jurisdiction information for the employment contract entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this employment contract.',
    `medevac_coverage_level` STRING COMMENT 'Attribute capturing the medevac coverage level information for the employment contract entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the employment contract entity.',
    `notice_period_days` STRING COMMENT 'Attribute capturing the notice period days information for the employment contract entity.',
    `probation_end_date` DATE COMMENT 'Date and time when the probation end event occurred for this employment contract.',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the relocation allowance quantity or measurement.',
    `rnr_cycle_weeks` STRING COMMENT 'Attribute capturing the rnr cycle weeks information for the employment contract entity.',
    `salary_currency` STRING COMMENT 'Attribute capturing the salary currency information for the employment contract entity.',
    `salary_frequency` STRING COMMENT 'Attribute capturing the salary frequency information for the employment contract entity.',
    `salary_grade` STRING COMMENT 'Attribute capturing the salary grade information for the employment contract entity.',
    `salary_step` STRING COMMENT 'Attribute capturing the salary step information for the employment contract entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the employment contract entity.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this employment contract.',
    `termination_date` DATE COMMENT 'Date and time when the termination event occurred for this employment contract.',
    `termination_reason` STRING COMMENT 'Attribute capturing the termination reason information for the employment contract entity.',
    `workday_contract_reference` STRING COMMENT 'Attribute capturing the workday contract reference information for the employment contract entity.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Formal employment agreement record for each staff member, capturing contract type (fixed-term, open-ended, consultancy, secondment), start and end dates, probation period, notice period, salary grade, base salary, currency, duty station, and applicable labor law jurisdiction. Tracks contract renewals and amendments over time. For internationally-recruited staff, includes full expatriate compensation package: hardship allowance tier and amount, housing allowance, education allowance for dependents, home leave entitlement and frequency, relocation allowance, medical evacuation coverage level, R&R cycle, and applicable INGO salary scale (e.g., UN common system, organizational scale). Supports multi-currency compensation across 50+ country operations. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit record.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated parent org unit entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the annual budget usd information for the org unit entity.',
    `city_name` STRING COMMENT 'Human-readable name or label for the city.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this org unit.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this org unit.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this org unit.',
    `funding_model` STRING COMMENT 'Attribute capturing the funding model information for the org unit entity.',
    `gl_account_code` STRING COMMENT 'Standardized code representing the gl account classification or category.',
    `headcount_actual` STRING COMMENT 'Attribute capturing the headcount actual information for the org unit entity.',
    `headcount_authorized` STRING COMMENT 'Attribute capturing the headcount authorized information for the org unit entity.',
    `hierarchy_level` STRING COMMENT 'Attribute capturing the hierarchy level information for the org unit entity.',
    `hierarchy_path` STRING COMMENT 'Attribute capturing the hierarchy path information for the org unit entity.',
    `iati_org_identifier` STRING COMMENT 'Attribute capturing the iati org identifier information for the org unit entity.',
    `icr_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the icr rate information for the org unit entity.',
    `international_staff_count` STRING COMMENT 'Count or number of international staff items associated with this record.',
    `is_field_office` BOOLEAN COMMENT 'Boolean indicator specifying whether the record field office.',
    `is_hq` BOOLEAN COMMENT 'Boolean indicator specifying whether the record hq.',
    `mandate_description` STRING COMMENT 'Detailed textual description providing context about the mandate.',
    `national_staff_count` STRING COMMENT 'Count or number of national staff items associated with this record.',
    `office_address` STRING COMMENT 'Attribute capturing the office address information for the org unit entity.',
    `office_email` STRING COMMENT 'Attribute capturing the office email information for the org unit entity.',
    `office_phone` STRING COMMENT 'Attribute capturing the office phone information for the org unit entity.',
    `org_unit_status` STRING COMMENT 'Current status indicator for the org unit workflow state.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `region_name` STRING COMMENT 'Human-readable name or label for the region.',
    `registration_country_code` STRING COMMENT 'Standardized code representing the registration country classification or category.',
    `registration_number` STRING COMMENT 'Count or number of registration items associated with this record.',
    `sap_company_code` STRING COMMENT 'Standardized code representing the sap company classification or category.',
    `security_level` STRING COMMENT 'Attribute capturing the security level information for the org unit entity.',
    `unit_code` STRING COMMENT 'Standardized code representing the unit classification or category.',
    `unit_mission_statement` STRING COMMENT 'Attribute capturing the unit mission statement information for the org unit entity.',
    `unit_name` STRING COMMENT 'Human-readable name or label for the unit.',
    `unit_short_name` STRING COMMENT 'Human-readable name or label for the unit short.',
    `unit_type` STRING COMMENT 'Classification type categorizing the unit for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this org unit.',
    `volunteer_count` STRING COMMENT 'Count or number of volunteer items associated with this record.',
    `workday_org_reference` STRING COMMENT 'Attribute capturing the workday org reference information for the org unit entity.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for Ngo, representing departments, divisions, country offices, area/field offices, program units, and cost centers in a recursive parent-child structure. Captures unit name, unit type (HQ department, regional office, country office, field office, program unit), parent unit reference, geographic location, responsible manager, funding model (core vs grant), and active status. Enables hierarchical reporting of headcount, payroll costs, and program staffing across the global organization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile record.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this job profile.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `background_check_level` STRING COMMENT 'Attribute capturing the background check level information for the job profile entity.',
    `competency_framework_code` STRING COMMENT 'Standardized code representing the competency framework classification or category.',
    `core_competencies` STRING COMMENT 'Attribute capturing the core competencies information for the job profile entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this job profile.',
    `duty_station_type` STRING COMMENT 'Classification type categorizing the duty station for this record.',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this job profile.',
    `employment_type` STRING COMMENT 'Classification type categorizing the employment for this record.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this job profile.',
    `field_experience_required` BOOLEAN COMMENT 'Attribute capturing the field experience required information for the job profile entity.',
    `flsa_exemption_status` STRING COMMENT 'Current status indicator for the flsa exemption workflow state.',
    `icr_cost_category` DECIMAL(18,2) COMMENT 'Attribute capturing the icr cost category information for the job profile entity.',
    `is_critical_role` BOOLEAN COMMENT 'Boolean indicator specifying whether the record critical role.',
    `is_safeguarding_designated` BOOLEAN COMMENT 'Boolean indicator specifying whether the record safeguarding designated.',
    `job_category` STRING COMMENT 'Attribute capturing the job category information for the job profile entity.',
    `job_family_group_name` STRING COMMENT 'Human-readable name or label for the job family group.',
    `job_family_name` STRING COMMENT 'Human-readable name or label for the job family.',
    `job_level` STRING COMMENT 'Attribute capturing the job level information for the job profile entity.',
    `key_responsibilities` STRING COMMENT 'Attribute capturing the key responsibilities information for the job profile entity.',
    `language_requirements` STRING COMMENT 'Attribute capturing the language requirements information for the job profile entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this job profile.',
    `leadership_competencies` STRING COMMENT 'Attribute capturing the leadership competencies information for the job profile entity.',
    `management_level` STRING COMMENT 'Attribute capturing the management level information for the job profile entity.',
    `min_education_level` STRING COMMENT 'Attribute capturing the min education level information for the job profile entity.',
    `min_years_experience` STRING COMMENT 'Attribute capturing the min years experience information for the job profile entity.',
    `pay_grade` STRING COMMENT 'Attribute capturing the pay grade information for the job profile entity.',
    `pay_grade_max_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the pay grade max usd information for the job profile entity.',
    `pay_grade_midpoint_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the pay grade midpoint usd information for the job profile entity.',
    `pay_grade_min_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the pay grade min usd information for the job profile entity.',
    `preferred_certifications` STRING COMMENT 'Attribute capturing the preferred certifications information for the job profile entity.',
    `profile_code` STRING COMMENT 'Standardized code representing the profile classification or category.',
    `profile_name` STRING COMMENT 'Human-readable name or label for the profile.',
    `profile_status` STRING COMMENT 'Current status indicator for the profile workflow state.',
    `program_area` STRING COMMENT 'Attribute capturing the program area information for the job profile entity.',
    `required_certifications` STRING COMMENT 'Attribute capturing the required certifications information for the job profile entity.',
    `sdg_alignment` STRING COMMENT 'Attribute capturing the sdg alignment information for the job profile entity.',
    `succession_eligibility` BOOLEAN COMMENT 'Attribute capturing the succession eligibility information for the job profile entity.',
    `summary` STRING COMMENT 'Attribute capturing the summary information for the job profile entity.',
    `travel_requirement` STRING COMMENT 'Attribute capturing the travel requirement information for the job profile entity.',
    `version_number` STRING COMMENT 'Count or number of version items associated with this record.',
    `workday_job_profile_reference` STRING COMMENT 'Attribute capturing the workday job profile reference information for the job profile entity.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job profile catalog defining roles within Ngo, including job family, job level, competency requirements, minimum qualifications, and pay grade band. Used as the template for position creation and recruitment. Aligned with Workday HCM job catalog and HRIS classification standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll run record.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated payroll system platform entity.',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the approved event occurred for this payroll run.',
    `bank_account_reference` STRING COMMENT 'Attribute capturing the bank account reference information for the payroll run entity.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the calculation event occurred for this payroll run.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this payroll run.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `employee_count` STRING COMMENT 'Count or number of employee items associated with this record.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the exchange rate information for the payroll run entity.',
    `fiscal_period` STRING COMMENT 'Attribute capturing the fiscal period information for the payroll run entity.',
    `fiscal_year` STRING COMMENT 'Attribute capturing the fiscal year information for the payroll run entity.',
    `functional_currency_code` STRING COMMENT 'Standardized code representing the functional currency classification or category.',
    `fund_code` STRING COMMENT 'Standardized code representing the fund classification or category.',
    `gl_account_code` STRING COMMENT 'Standardized code representing the gl account classification or category.',
    `grant_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant classification or category.',
    `icr_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the icr rate information for the payroll run entity.',
    `is_retroactive` BOOLEAN COMMENT 'Boolean indicator specifying whether the record retroactive.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this payroll run.',
    `legal_entity_code` STRING COMMENT 'Standardized code representing the legal entity classification or category.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the payroll run entity.',
    `pay_frequency` STRING COMMENT 'Attribute capturing the pay frequency information for the payroll run entity.',
    `pay_period_end_date` DATE COMMENT 'Date and time when the pay period end event occurred for this payroll run.',
    `pay_period_start_date` DATE COMMENT 'Date and time when the pay period start event occurred for this payroll run.',
    `payment_date` DECIMAL(18,2) COMMENT 'Date and time when the payment event occurred for this payroll run.',
    `payment_method` DECIMAL(18,2) COMMENT 'Attribute capturing the payment method information for the payroll run entity.',
    `payroll_group` STRING COMMENT 'Attribute capturing the payroll group information for the payroll run entity.',
    `processed_by` STRING COMMENT 'Reference to the user or entity that performed the processed action.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `retroactive_period_start_date` DATE COMMENT 'Date and time when the retroactive period start event occurred for this payroll run.',
    `run_number` STRING COMMENT 'Count or number of run items associated with this record.',
    `run_status` STRING COMMENT 'Current status indicator for the run workflow state.',
    `run_type` STRING COMMENT 'Classification type categorizing the run for this record.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Attribute capturing the total deductions information for the payroll run entity.',
    `total_employer_contributions` DECIMAL(18,2) COMMENT 'Attribute capturing the total employer contributions information for the payroll run entity.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Attribute capturing the total gross pay information for the payroll run entity.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Attribute capturing the total net pay information for the payroll run entity.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'Attribute capturing the total tax withheld information for the payroll run entity.',
    `workday_run_reference` STRING COMMENT 'Attribute capturing the workday run reference information for the payroll run entity.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing run. Source systems: SAP Payroll, ADP, local payroll providers. Systems-of-record: SAP HCM Payroll, VISION. Framework: IPSAS 25 (Employee Benefits) / US GAAP ASC 712 / local labor law.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique identifier for the payslip record.',
    `original_payslip_id` BIGINT COMMENT 'Reference identifier linking to the associated original payslip entity.',
    `payroll_run_id` BIGINT COMMENT 'Reference identifier linking to the associated payroll run entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval event occurred for this payslip.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `bank_account_reference` STRING COMMENT 'Attribute capturing the bank account reference information for the payslip entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this payslip.',
    `employer_pension_contribution` DECIMAL(18,2) COMMENT 'Attribute capturing the employer pension contribution information for the payslip entity.',
    `employer_social_security` DECIMAL(18,2) COMMENT 'Attribute capturing the employer social security information for the payslip entity.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Attribute capturing the exchange rate information for the payslip entity.',
    `expat_allowance` DECIMAL(18,2) COMMENT 'Attribute capturing the expat allowance information for the payslip entity.',
    `field_allowance` DECIMAL(18,2) COMMENT 'Attribute capturing the field allowance information for the payslip entity.',
    `gl_journal_reference` STRING COMMENT 'Attribute capturing the gl journal reference information for the payslip entity.',
    `grant_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant classification or category.',
    `gross_salary` DECIMAL(18,2) COMMENT 'Attribute capturing the gross salary information for the payslip entity.',
    `hardship_allowance` DECIMAL(18,2) COMMENT 'Attribute capturing the hardship allowance information for the payslip entity.',
    `housing_allowance` DECIMAL(18,2) COMMENT 'Attribute capturing the housing allowance information for the payslip entity.',
    `income_tax_deduction` DECIMAL(18,2) COMMENT 'Attribute capturing the income tax deduction information for the payslip entity.',
    `is_correction` BOOLEAN COMMENT 'Boolean indicator specifying whether the record correction.',
    `is_off_cycle` BOOLEAN COMMENT 'Boolean indicator specifying whether the record off cycle.',
    `local_currency_code` STRING COMMENT 'Standardized code representing the local currency classification or category.',
    `net_pay_local` DECIMAL(18,2) COMMENT 'Attribute capturing the net pay local information for the payslip entity.',
    `net_pay_payment_currency` DECIMAL(18,2) COMMENT 'Attribute capturing the net pay payment currency information for the payslip entity.',
    `pay_period_end_date` DATE COMMENT 'Date and time when the pay period end event occurred for this payslip.',
    `pay_period_start_date` DATE COMMENT 'Date and time when the pay period start event occurred for this payslip.',
    `payment_currency_code` DECIMAL(18,2) COMMENT 'Standardized code representing the payment currency classification or category.',
    `payment_date` DECIMAL(18,2) COMMENT 'Date and time when the payment event occurred for this payslip.',
    `payment_method` DECIMAL(18,2) COMMENT 'Attribute capturing the payment method information for the payslip entity.',
    `payroll_group` STRING COMMENT 'Attribute capturing the payroll group information for the payslip entity.',
    `payroll_run_sequence` STRING COMMENT 'Attribute capturing the payroll run sequence information for the payslip entity.',
    `payslip_number` STRING COMMENT 'Count or number of payslip items associated with this record.',
    `payslip_status` STRING COMMENT 'Current status indicator for the payslip workflow state.',
    `pension_deduction` DECIMAL(18,2) COMMENT 'Attribute capturing the pension deduction information for the payslip entity.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `run_status` STRING COMMENT 'Current status indicator for the run workflow state.',
    `social_security_deduction` DECIMAL(18,2) COMMENT 'Attribute capturing the social security deduction information for the payslip entity.',
    `total_allowances` DECIMAL(18,2) COMMENT 'Attribute capturing the total allowances information for the payslip entity.',
    `total_statutory_deductions` DECIMAL(18,2) COMMENT 'Attribute capturing the total statutory deductions information for the payslip entity.',
    `transport_allowance` DECIMAL(18,2) COMMENT 'Attribute capturing the transport allowance information for the payslip entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this payslip.',
    `voluntary_deductions` DECIMAL(18,2) COMMENT 'Attribute capturing the voluntary deductions information for the payslip entity.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Individual payslip record for each staff member per payroll cycle, serving as SSOT for both payroll run processing (pay period start/end dates, payroll group — national/international/expat, run sequence number, run status, batch approval, total run aggregates) and individual pay details (gross salary, allowances — housing/hardship/field/expat, statutory deductions — income tax/social security/pension, voluntary deductions, net pay in local and payment currencies). Multi-currency supported for international operations across 50+ countries. Includes payment method, bank details reference, and payroll run approval chain. Supports BvA (Budget vs Actual) payroll cost allocation to grants and programs, donor audit requirements, and statutory payroll reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record.',
    `benefit_plan_id` BIGINT COMMENT 'Reference identifier linking to the associated benefit plan entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this benefit enrollment.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `beneficiary_name` STRING COMMENT 'Human-readable name or label for the beneficiary.',
    `beneficiary_relationship` STRING COMMENT 'Attribute capturing the beneficiary relationship information for the benefit enrollment entity.',
    `cobra_eligible` BOOLEAN COMMENT 'Attribute capturing the cobra eligible information for the benefit enrollment entity.',
    `contribution_currency` STRING COMMENT 'Attribute capturing the contribution currency information for the benefit enrollment entity.',
    `contribution_frequency` STRING COMMENT 'Attribute capturing the contribution frequency information for the benefit enrollment entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `coverage_tier` STRING COMMENT 'Attribute capturing the coverage tier information for the benefit enrollment entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this benefit enrollment.',
    `dependent_count` STRING COMMENT 'Count or number of dependent items associated with this record.',
    `duty_station_country` STRING COMMENT 'Attribute capturing the duty station country information for the benefit enrollment entity.',
    `duty_station_hardship_level` STRING COMMENT 'Attribute capturing the duty station hardship level information for the benefit enrollment entity.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this benefit enrollment.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this benefit enrollment.',
    `eligibility_rule_code` STRING COMMENT 'Standardized code representing the eligibility rule classification or category.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the employee contribution quantity or measurement.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the employer contribution quantity or measurement.',
    `enrollment_date` DATE COMMENT 'Date and time when the enrollment event occurred for this benefit enrollment.',
    `enrollment_event_type` STRING COMMENT 'Classification type categorizing the enrollment event for this record.',
    `enrollment_status` STRING COMMENT 'Current status indicator for the enrollment workflow state.',
    `grant_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant classification or category.',
    `is_dependent_coverage` BOOLEAN COMMENT 'Boolean indicator specifying whether the record dependent coverage.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this benefit enrollment.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the life insurance coverage quantity or measurement.',
    `medevac_coverage_zone` STRING COMMENT 'Attribute capturing the medevac coverage zone information for the benefit enrollment entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the benefit enrollment entity.',
    `open_enrollment_period` STRING COMMENT 'Attribute capturing the open enrollment period information for the benefit enrollment entity.',
    `pension_contribution_rate_pct` DECIMAL(18,2) COMMENT 'Attribute capturing the pension contribution rate pct information for the benefit enrollment entity.',
    `plan_provider` STRING COMMENT 'Attribute capturing the plan provider information for the benefit enrollment entity.',
    `plan_provider_policy_number` STRING COMMENT 'Count or number of plan provider policy items associated with this record.',
    `plan_type` STRING COMMENT 'Classification type categorizing the plan for this record.',
    `plan_year` STRING COMMENT 'Attribute capturing the plan year information for the benefit enrollment entity.',
    `rr_cycle_days` STRING COMMENT 'Attribute capturing the rr cycle days information for the benefit enrollment entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the benefit enrollment entity.',
    `termination_reason` STRING COMMENT 'Attribute capturing the termination reason information for the benefit enrollment entity.',
    `waiting_period_days` STRING COMMENT 'Attribute capturing the waiting period days information for the benefit enrollment entity.',
    `waiver_reason` STRING COMMENT 'Attribute capturing the waiver reason information for the benefit enrollment entity.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Record of a staff members enrollment in a specific benefit plan, serving as SSOT for both the benefit plan catalog (plan name, provider, plan type, eligibility criteria for national vs international staff, coverage structure, cost model, effective dates) and individual enrollment instances (coverage tier, enrollment date, effective date, end date, employee contribution, employer contribution, dependent coverage). Covers health insurance, life insurance, pension, medical evacuation, and R&R (Rest and Recuperation) entitlements. Plan catalog entries have header-level attributes; enrollments are line-level records per staff member per plan. Sourced from Workday HCM Benefits module.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan record.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated admin system platform entity.',
    `annual_coverage_limit_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the annual coverage limit usd information for the benefit plan entity.',
    `contribution_frequency` STRING COMMENT 'Attribute capturing the contribution frequency information for the benefit plan entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `coverage_description` STRING COMMENT 'Detailed textual description providing context about the coverage.',
    `coverage_tier` STRING COMMENT 'Attribute capturing the coverage tier information for the benefit plan entity.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `deductible_amount_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the deductible amount usd information for the benefit plan entity.',
    `dependent_coverage_allowed` BOOLEAN COMMENT 'Attribute capturing the dependent coverage allowed information for the benefit plan entity.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this benefit plan.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this benefit plan.',
    `employee_contribution_amount_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the employee contribution amount usd information for the benefit plan entity.',
    `employee_contribution_pct` DECIMAL(18,2) COMMENT 'Attribute capturing the employee contribution pct information for the benefit plan entity.',
    `employer_contribution_amount_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the employer contribution amount usd information for the benefit plan entity.',
    `employer_contribution_pct` DECIMAL(18,2) COMMENT 'Attribute capturing the employer contribution pct information for the benefit plan entity.',
    `employment_type_eligibility` STRING COMMENT 'Attribute capturing the employment type eligibility information for the benefit plan entity.',
    `enrollment_type` STRING COMMENT 'Classification type categorizing the enrollment for this record.',
    `geographic_scope` STRING COMMENT 'Attribute capturing the geographic scope information for the benefit plan entity.',
    `gl_account_code` STRING COMMENT 'Standardized code representing the gl account classification or category.',
    `hardship_location_applicable` BOOLEAN COMMENT 'Attribute capturing the hardship location applicable information for the benefit plan entity.',
    `is_grant_chargeable` BOOLEAN COMMENT 'Boolean indicator specifying whether the record grant chargeable.',
    `is_medevac_included` BOOLEAN COMMENT 'Boolean indicator specifying whether the record medevac included.',
    `is_rnr_included` BOOLEAN COMMENT 'Boolean indicator specifying whether the record rnr included.',
    `last_reviewed_date` DATE COMMENT 'Date and time when the last reviewed event occurred for this benefit plan.',
    `max_dependents_covered` STRING COMMENT 'Attribute capturing the max dependents covered information for the benefit plan entity.',
    `minimum_service_months` STRING COMMENT 'Attribute capturing the minimum service months information for the benefit plan entity.',
    `next_renewal_date` DATE COMMENT 'Date and time when the next renewal event occurred for this benefit plan.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the benefit plan entity.',
    `open_enrollment_end_date` DATE COMMENT 'Date and time when the open enrollment end event occurred for this benefit plan.',
    `open_enrollment_start_date` DATE COMMENT 'Date and time when the open enrollment start event occurred for this benefit plan.',
    `plan_code` STRING COMMENT 'Standardized code representing the plan classification or category.',
    `plan_document_url` STRING COMMENT 'Attribute capturing the plan document url information for the benefit plan entity.',
    `plan_name` STRING COMMENT 'Human-readable name or label for the plan.',
    `plan_status` STRING COMMENT 'Current status indicator for the plan workflow state.',
    `plan_type` STRING COMMENT 'Classification type categorizing the plan for this record.',
    `plan_year_start_month` STRING COMMENT 'Attribute capturing the plan year start month information for the benefit plan entity.',
    `provider_name` STRING COMMENT 'Human-readable name or label for the provider.',
    `provider_policy_number` STRING COMMENT 'Count or number of provider policy items associated with this record.',
    `regulatory_compliance_reference` STRING COMMENT 'Attribute capturing the regulatory compliance reference information for the benefit plan entity.',
    `rnr_frequency_days` STRING COMMENT 'Attribute capturing the rnr frequency days information for the benefit plan entity.',
    `staff_category_eligibility` STRING COMMENT 'Attribute capturing the staff category eligibility information for the benefit plan entity.',
    `waiting_period_days` STRING COMMENT 'Attribute capturing the waiting period days information for the benefit plan entity.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Catalog of benefit plans offered by Ngo to staff, including health insurance schemes, pension plans, group life insurance, medical evacuation coverage, and R&R (Rest and Recuperation) entitlements. Captures plan name, provider, eligibility criteria (national vs international staff), coverage details, and cost structure.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `job_profile_id` BIGINT COMMENT 'Reference identifier linking to the associated job profile entity.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary recruitment staff member entity.',
    `tertiary_recruitment_recruiter_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated tertiary recruitment recruiter staff member entity.',
    `actual_fill_date` DATE COMMENT 'Date and time when the actual fill event occurred for this recruitment requisition.',
    `application_deadline` DATE COMMENT 'Attribute capturing the application deadline information for the recruitment requisition entity.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this recruitment requisition.',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'Attribute capturing the budgeted annual salary information for the recruitment requisition entity.',
    `cancellation_reason` STRING COMMENT 'Attribute capturing the cancellation reason information for the recruitment requisition entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this recruitment requisition.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the recruitment requisition entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `education_level_required` STRING COMMENT 'Attribute capturing the education level required information for the recruitment requisition entity.',
    `employment_type` STRING COMMENT 'Classification type categorizing the employment for this record.',
    `funding_confirmed` BOOLEAN COMMENT 'Attribute capturing the funding confirmed information for the recruitment requisition entity.',
    `funding_source_type` STRING COMMENT 'Classification type categorizing the funding source for this record.',
    `gender_marker` STRING COMMENT 'Attribute capturing the gender marker information for the recruitment requisition entity.',
    `headcount_type` STRING COMMENT 'Classification type categorizing the headcount for this record.',
    `is_emergency_surge` BOOLEAN COMMENT 'Boolean indicator specifying whether the record emergency surge.',
    `job_posting_date` DATE COMMENT 'Date and time when the job posting event occurred for this recruitment requisition.',
    `job_title` STRING COMMENT 'Attribute capturing the job title information for the recruitment requisition entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this recruitment requisition.',
    `minimum_experience_years` STRING COMMENT 'Attribute capturing the minimum experience years information for the recruitment requisition entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the recruitment requisition entity.',
    `number_of_openings` STRING COMMENT 'Attribute capturing the number of openings information for the recruitment requisition entity.',
    `opened_date` DATE COMMENT 'Date and time when the opened event occurred for this recruitment requisition.',
    `positions_filled_count` STRING COMMENT 'Count or number of positions filled items associated with this record.',
    `recruitment_type` STRING COMMENT 'Classification type categorizing the recruitment for this record.',
    `requisition_number` STRING COMMENT 'Count or number of requisition items associated with this record.',
    `requisition_status` STRING COMMENT 'Current status indicator for the requisition workflow state.',
    `salary_grade` STRING COMMENT 'Attribute capturing the salary grade information for the recruitment requisition entity.',
    `security_clearance_required` BOOLEAN COMMENT 'Attribute capturing the security clearance required information for the recruitment requisition entity.',
    `sourcing_channels` STRING COMMENT 'Attribute capturing the sourcing channels information for the recruitment requisition entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the recruitment requisition entity.',
    `target_fill_date` DATE COMMENT 'Date and time when the target fill event occurred for this recruitment requisition.',
    `target_start_date` DATE COMMENT 'Date and time when the target start event occurred for this recruitment requisition.',
    `time_to_fill_days` STRING COMMENT 'Attribute capturing the time to fill days information for the recruitment requisition entity.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Talent acquisition request record initiated when a position needs to be filled or a new position is created, capturing requisition number, linked position, hiring manager, target start date, recruitment type (internal, external, emergency surge), funding source confirmation, approval chain status, sourcing channels (internal posting, external job boards, UN job network, ReliefWeb), and time-to-fill tracking. Supports Ngos workforce planning and rapid surge recruitment for emergency responses.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Unique identifier for the job application record.',
    `candidate_id` BIGINT COMMENT 'Reference identifier linking to the associated candidate entity.',
    `funding_source_id` BIGINT COMMENT 'Reference identifier linking to the associated funding source entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary job staff member entity.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference identifier linking to the associated recruitment requisition entity.',
    `application_date` DATE COMMENT 'Date and time when the application event occurred for this job application.',
    `application_number` STRING COMMENT 'Count or number of application items associated with this record.',
    `application_stage` STRING COMMENT 'Attribute capturing the application stage information for the job application entity.',
    `application_status` STRING COMMENT 'Current status indicator for the application workflow state.',
    `application_timestamp` TIMESTAMP COMMENT 'Date and time when the application event occurred for this job application.',
    `background_check_status` STRING COMMENT 'Current status indicator for the background check workflow state.',
    `candidate_type` STRING COMMENT 'Classification type categorizing the candidate for this record.',
    `cover_letter_reference` STRING COMMENT 'Attribute capturing the cover letter reference information for the job application entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this job application.',
    `cv_document_reference` STRING COMMENT 'Attribute capturing the cv document reference information for the job application entity.',
    `disability_disclosure` STRING COMMENT 'Attribute capturing the disability disclosure information for the job application entity.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the job application entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `gender_self_identified` STRING COMMENT 'Attribute capturing the gender self identified information for the job application entity.',
    `grant_funded_position` DECIMAL(18,2) COMMENT 'Attribute capturing the grant funded position information for the job application entity.',
    `highest_education_level` STRING COMMENT 'Attribute capturing the highest education level information for the job application entity.',
    `hiring_decision` STRING COMMENT 'Attribute capturing the hiring decision information for the job application entity.',
    `interview_date` DATE COMMENT 'Date and time when the interview event occurred for this job application.',
    `interview_panel_notes` STRING COMMENT 'Attribute capturing the interview panel notes information for the job application entity.',
    `interview_score` DECIMAL(18,2) COMMENT 'Attribute capturing the interview score information for the job application entity.',
    `languages_spoken` STRING COMMENT 'Attribute capturing the languages spoken information for the job application entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this job application.',
    `nationality_country_code` STRING COMMENT 'Standardized code representing the nationality country classification or category.',
    `offer_accepted_date` DATE COMMENT 'Date and time when the offer accepted event occurred for this job application.',
    `offer_extended_date` DATE COMMENT 'Date and time when the offer extended event occurred for this job application.',
    `position_title` STRING COMMENT 'Attribute capturing the position title information for the job application entity.',
    `proposed_salary` DECIMAL(18,2) COMMENT 'Attribute capturing the proposed salary information for the job application entity.',
    `proposed_start_date` DATE COMMENT 'Date and time when the proposed start event occurred for this job application.',
    `reference_check_status` STRING COMMENT 'Current status indicator for the reference check workflow state.',
    `rejection_reason` STRING COMMENT 'Attribute capturing the rejection reason information for the job application entity.',
    `safeguarding_check_status` STRING COMMENT 'Current status indicator for the safeguarding check workflow state.',
    `salary_currency_code` STRING COMMENT 'Standardized code representing the salary currency classification or category.',
    `salary_grade` STRING COMMENT 'Attribute capturing the salary grade information for the job application entity.',
    `screening_score` DECIMAL(18,2) COMMENT 'Attribute capturing the screening score information for the job application entity.',
    `source_channel` STRING COMMENT 'Attribute capturing the source channel information for the job application entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the job application entity.',
    `stage_outcome` STRING COMMENT 'Attribute capturing the stage outcome information for the job application entity.',
    `written_assessment_score` DECIMAL(18,2) COMMENT 'Attribute capturing the written assessment score information for the job application entity.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Attribute capturing the years of experience information for the job application entity.',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Candidate application record linked to a recruitment requisition, capturing applicant identity, application date, source channel, CV/resume reference, cover letter, application stage, stage outcome, interview scores, and final hiring decision. Tracks the full candidate pipeline from application to offer for both internal and external candidates.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `calibration_session_id` BIGINT COMMENT 'Reference identifier linking to the associated calibration session entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `performance_improvement_plan_id` BIGINT COMMENT 'Reference identifier linking to the associated performance improvement plan entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary performance staff member entity.',
    `review_template_id` BIGINT COMMENT 'Reference identifier linking to the associated review template entity.',
    `reviewer_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated reviewer staff member entity.',
    `accountability_rating` STRING COMMENT 'Attribute capturing the accountability rating information for the performance review entity.',
    `collaboration_rating` STRING COMMENT 'Attribute capturing the collaboration rating information for the performance review entity.',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Attribute capturing the competency rating score information for the performance review entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this performance review.',
    `development_recommendations` STRING COMMENT 'Attribute capturing the development recommendations information for the performance review entity.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the performance review entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `employee_acknowledged` BOOLEAN COMMENT 'Attribute capturing the employee acknowledged information for the performance review entity.',
    `employee_acknowledged_date` DATE COMMENT 'Date and time when the employee acknowledged event occurred for this performance review.',
    `employee_comments` STRING COMMENT 'Attribute capturing the employee comments information for the performance review entity.',
    `employee_disagreement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the employee disagreement condition applies.',
    `employee_self_assessment` STRING COMMENT 'Attribute capturing the employee self assessment information for the performance review entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this performance review.',
    `leadership_rating` STRING COMMENT 'Attribute capturing the leadership rating information for the performance review entity.',
    `next_review_date` DATE COMMENT 'Date and time when the next review event occurred for this performance review.',
    `objective_achievement_score` DECIMAL(18,2) COMMENT 'Attribute capturing the objective achievement score information for the performance review entity.',
    `overall_rating` STRING COMMENT 'Attribute capturing the overall rating information for the performance review entity.',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Attribute capturing the overall rating score information for the performance review entity.',
    `pip_required` BOOLEAN COMMENT 'Attribute capturing the pip required information for the performance review entity.',
    `promotion_recommendation` BOOLEAN COMMENT 'Attribute capturing the promotion recommendation information for the performance review entity.',
    `rating_scale_version` STRING COMMENT 'Attribute capturing the rating scale version information for the performance review entity.',
    `retention_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the retention risk condition applies.',
    `review_cycle_type` STRING COMMENT 'Classification type categorizing the review cycle for this record.',
    `review_due_date` DATE COMMENT 'Date and time when the review due event occurred for this performance review.',
    `review_meeting_date` DATE COMMENT 'Date and time when the review meeting event occurred for this performance review.',
    `review_number` STRING COMMENT 'Count or number of review items associated with this record.',
    `review_period_end_date` DATE COMMENT 'Date and time when the review period end event occurred for this performance review.',
    `review_period_start_date` DATE COMMENT 'Date and time when the review period start event occurred for this performance review.',
    `review_status` STRING COMMENT 'Current status indicator for the review workflow state.',
    `review_submitted_date` DATE COMMENT 'Date and time when the review submitted event occurred for this performance review.',
    `reviewer_narrative` STRING COMMENT 'Attribute capturing the reviewer narrative information for the performance review entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the performance review entity.',
    `technical_skills_rating` STRING COMMENT 'Attribute capturing the technical skills rating information for the performance review entity.',
    `values_alignment_rating` DECIMAL(18,2) COMMENT 'Attribute capturing the values alignment rating information for the performance review entity.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal performance appraisal record for a staff member covering a defined review period. Captures review cycle (annual, mid-year, probation), overall rating, competency ratings, objective achievement scores, reviewer identity, reviewee acknowledgment, and development recommendations. Supports Ngos talent retention and results-based management (RBM) culture.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the learning enrollment record.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `learning_course_id` BIGINT COMMENT 'Reference identifier linking to the associated learning course entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary learning staff member entity.',
    `actual_hours_spent` DECIMAL(18,2) COMMENT 'Attribute capturing the actual hours spent information for the learning enrollment entity.',
    `attempt_number` STRING COMMENT 'Count or number of attempt items associated with this record.',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `certification_expiry_date` DATE COMMENT 'Date and time when the certification expiry event occurred for this learning enrollment.',
    `completion_date` DATE COMMENT 'Date and time when the completion event occurred for this learning enrollment.',
    `completion_evidence_url` STRING COMMENT 'Attribute capturing the completion evidence url information for the learning enrollment entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `course_category` STRING COMMENT 'Attribute capturing the course category information for the learning enrollment entity.',
    `course_title` STRING COMMENT 'Attribute capturing the course title information for the learning enrollment entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this learning enrollment.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `delivery_mode` STRING COMMENT 'Attribute capturing the delivery mode information for the learning enrollment entity.',
    `department_name` STRING COMMENT 'Human-readable name or label for the department.',
    `due_date` DATE COMMENT 'Date and time when the due event occurred for this learning enrollment.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the duration hours information for the learning enrollment entity.',
    `enrollment_date` DATE COMMENT 'Date and time when the enrollment event occurred for this learning enrollment.',
    `enrollment_source` STRING COMMENT 'Attribute capturing the enrollment source information for the learning enrollment entity.',
    `enrollment_status` STRING COMMENT 'Current status indicator for the enrollment workflow state.',
    `is_certified` BOOLEAN COMMENT 'Boolean indicator specifying whether the record certified.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mandatory.',
    `job_profile` STRING COMMENT 'Attribute capturing the job profile information for the learning enrollment entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this learning enrollment.',
    `pass_fail_status` STRING COMMENT 'Current status indicator for the pass fail workflow state.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Attribute capturing the passing score threshold information for the learning enrollment entity.',
    `provider_name` STRING COMMENT 'Human-readable name or label for the provider.',
    `provider_type` STRING COMMENT 'Classification type categorizing the provider for this record.',
    `required_frequency` STRING COMMENT 'Attribute capturing the required frequency information for the learning enrollment entity.',
    `score` DECIMAL(18,2) COMMENT 'Attribute capturing the score information for the learning enrollment entity.',
    `staff_type` STRING COMMENT 'Classification type categorizing the staff for this record.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this learning enrollment.',
    `training_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the training cost information for the learning enrollment entity.',
    `training_location` STRING COMMENT 'Attribute capturing the training location information for the learning enrollment entity.',
    `waiver_approved_by` STRING COMMENT 'Reference to the user or entity that performed the waiver approved action.',
    `waiver_reason` STRING COMMENT 'Attribute capturing the waiver reason information for the learning enrollment entity.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Record of a staff members enrollment in a learning or training activity, serving as SSOT for both the course catalog (course code, title, delivery mode, duration, provider, required frequency, content category) and individual enrollment instances (enrollment date, completion date, pass/fail status, certification issued, expiry date). Course catalog entries are header-level reference records; enrollments are line-level records per staff member per course. Covers mandatory compliance courses (PSEA, CHS, security, safeguarding), technical skills, leadership development, and field operations training. Supports compliance training tracking, mandatory training deadline monitoring, and staff capacity building.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Unique identifier for the learning course record.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated hosting system platform entity.',
    `available_from_date` DATE COMMENT 'Date and time when the available from event occurred for this learning course.',
    `available_until_date` DATE COMMENT 'Date and time when the available until event occurred for this learning course.',
    `certificate_validity_months` STRING COMMENT 'Attribute capturing the certificate validity months information for the learning course entity.',
    `competency_framework` STRING COMMENT 'Attribute capturing the competency framework information for the learning course entity.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'Attribute capturing the cost per learner information for the learning course entity.',
    `course_code` STRING COMMENT 'Standardized code representing the course classification or category.',
    `course_owner` STRING COMMENT 'Attribute capturing the course owner information for the learning course entity.',
    `course_status` STRING COMMENT 'Current status indicator for the course workflow state.',
    `course_type` STRING COMMENT 'Classification type categorizing the course for this record.',
    `course_url` STRING COMMENT 'Attribute capturing the course url information for the learning course entity.',
    `cpe_credits` DECIMAL(18,2) COMMENT 'Attribute capturing the cpe credits information for the learning course entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this learning course.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `delivery_mode` STRING COMMENT 'Attribute capturing the delivery mode information for the learning course entity.',
    `learning_course_description` STRING COMMENT 'Detailed textual description providing context about the learning course.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the duration hours information for the learning course entity.',
    `external_accreditation` STRING COMMENT 'Attribute capturing the external accreditation information for the learning course entity.',
    `fund_source` STRING COMMENT 'Attribute capturing the fund source information for the learning course entity.',
    `has_assessment` BOOLEAN COMMENT 'Boolean indicator specifying whether the record  assessment.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mandatory.',
    `issues_certificate` BOOLEAN COMMENT 'Attribute capturing the issues certificate information for the learning course entity.',
    `language` STRING COMMENT 'Attribute capturing the language information for the learning course entity.',
    `last_reviewed_date` DATE COMMENT 'Date and time when the last reviewed event occurred for this learning course.',
    `max_enrollment` STRING COMMENT 'Attribute capturing the max enrollment information for the learning course entity.',
    `next_review_date` DATE COMMENT 'Date and time when the next review event occurred for this learning course.',
    `passing_score` DECIMAL(18,2) COMMENT 'Attribute capturing the passing score information for the learning course entity.',
    `prerequisite_course_codes` STRING COMMENT 'Attribute capturing the prerequisite course codes information for the learning course entity.',
    `provider_name` STRING COMMENT 'Human-readable name or label for the provider.',
    `provider_type` STRING COMMENT 'Classification type categorizing the provider for this record.',
    `recurrence_frequency` STRING COMMENT 'Attribute capturing the recurrence frequency information for the learning course entity.',
    `scorm_compliant` BOOLEAN COMMENT 'Attribute capturing the scorm compliant information for the learning course entity.',
    `sdg_alignment` STRING COMMENT 'Attribute capturing the sdg alignment information for the learning course entity.',
    `short_description` STRING COMMENT 'Detailed textual description providing context about the short.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the learning course entity.',
    `subject_area` STRING COMMENT 'Attribute capturing the subject area information for the learning course entity.',
    `tags` STRING COMMENT 'Attribute capturing the tags information for the learning course entity.',
    `target_audience` STRING COMMENT 'Attribute capturing the target audience information for the learning course entity.',
    `title` STRING COMMENT 'Attribute capturing the title information for the learning course entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this learning course.',
    `version_effective_date` DATE COMMENT 'Date and time when the version effective event occurred for this learning course.',
    `version_number` STRING COMMENT 'Count or number of version items associated with this record.',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Catalog of learning and development courses available to Ngo staff, including mandatory compliance courses (PSEA, CHS, security, safeguarding), technical skills courses, leadership development, and field operations training. Captures course code, title, delivery mode (e-learning, classroom, blended), duration, provider, and required frequency.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated approver staff member entity.',
    `primary_leave_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary leave staff member entity.',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'Attribute capturing the actual days taken information for the leave request entity.',
    `actual_end_date` DATE COMMENT 'Date and time when the actual end event occurred for this leave request.',
    `actual_start_date` DATE COMMENT 'Date and time when the actual start event occurred for this leave request.',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval event occurred for this leave request.',
    `approver_comments` STRING COMMENT 'Attribute capturing the approver comments information for the leave request entity.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation event occurred for this leave request.',
    `carry_forward_days` DECIMAL(18,2) COMMENT 'Attribute capturing the carry forward days information for the leave request entity.',
    `contract_type` STRING COMMENT 'Classification type categorizing the contract for this record.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this leave request.',
    `duty_station_country` STRING COMMENT 'Attribute capturing the duty station country information for the leave request entity.',
    `emergency_contact_available` BOOLEAN COMMENT 'Attribute capturing the emergency contact available information for the leave request entity.',
    `entitlement_days` DECIMAL(18,2) COMMENT 'Attribute capturing the entitlement days information for the leave request entity.',
    `handover_completed` BOOLEAN COMMENT 'Attribute capturing the handover completed information for the leave request entity.',
    `is_retroactive` BOOLEAN COMMENT 'Boolean indicator specifying whether the record retroactive.',
    `is_rnr_eligible` BOOLEAN COMMENT 'Boolean indicator specifying whether the record rnr eligible.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this leave request.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Attribute capturing the leave balance after information for the leave request entity.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Attribute capturing the leave balance before information for the leave request entity.',
    `leave_destination_country` STRING COMMENT 'Attribute capturing the leave destination country information for the leave request entity.',
    `leave_reason` STRING COMMENT 'Attribute capturing the leave reason information for the leave request entity.',
    `leave_type` STRING COMMENT 'Classification type categorizing the leave for this record.',
    `leave_year` STRING COMMENT 'Attribute capturing the leave year information for the leave request entity.',
    `medical_certificate_received` BOOLEAN COMMENT 'Attribute capturing the medical certificate received information for the leave request entity.',
    `medical_certificate_required` BOOLEAN COMMENT 'Attribute capturing the medical certificate required information for the leave request entity.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `rejection_reason` STRING COMMENT 'Attribute capturing the rejection reason information for the leave request entity.',
    `request_number` STRING COMMENT 'Count or number of request items associated with this record.',
    `requested_days` DECIMAL(18,2) COMMENT 'Attribute capturing the requested days information for the leave request entity.',
    `requested_end_date` DATE COMMENT 'Date and time when the requested end event occurred for this leave request.',
    `requested_start_date` DATE COMMENT 'Date and time when the requested start event occurred for this leave request.',
    `rnr_cycle_days` STRING COMMENT 'Attribute capturing the rnr cycle days information for the leave request entity.',
    `security_clearance_confirmed` BOOLEAN COMMENT 'Attribute capturing the security clearance confirmed information for the leave request entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the leave request entity.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the submission event occurred for this leave request.',
    `supporting_document_ref` STRING COMMENT 'Attribute capturing the supporting document ref information for the leave request entity.',
    `toil_hours_accrued` DECIMAL(18,2) COMMENT 'Attribute capturing the toil hours accrued information for the leave request entity.',
    `workday_leave_request_reference` STRING COMMENT 'Attribute capturing the workday leave request reference information for the leave request entity.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Staff leave request and approval record capturing leave type (annual, sick, maternity/paternity, R&R, compassionate, TOIL), requested start date, end date, number of days, approval status, approver, and actual dates taken. Tracks leave balances and entitlements per staff member and supports field rotation and R&R scheduling for humanitarian staff.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` (
    `workforce_staff_assignment_id` BIGINT COMMENT 'Unique identifier for the workforce staff assignment record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `country_office_id` BIGINT COMMENT 'Reference identifier linking to the associated country office entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary workforce staff member entity.',
    `project_site_id` BIGINT COMMENT 'Reference identifier linking to the associated project site entity.',
    `tertiary_workforce_approved_by_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated tertiary workforce approved by staff member entity.',
    `approved_date` DATE COMMENT 'Date and time when the approved event occurred for this workforce staff assignment.',
    `assignment_code` STRING COMMENT 'Standardized code representing the assignment classification or category.',
    `assignment_notes` STRING COMMENT 'Attribute capturing the assignment notes information for the workforce staff assignment entity.',
    `assignment_status` STRING COMMENT 'Current status indicator for the assignment workflow state.',
    `assignment_type` STRING COMMENT 'Classification type categorizing the assignment for this record.',
    `contract_type` STRING COMMENT 'Classification type categorizing the contract for this record.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this workforce staff assignment.',
    `duty_country_code` STRING COMMENT 'Standardized code representing the duty country classification or category.',
    `effort_certification_required` BOOLEAN COMMENT 'Attribute capturing the effort certification required information for the workforce staff assignment entity.',
    `effort_percent` DECIMAL(18,2) COMMENT 'Attribute capturing the effort percent information for the workforce staff assignment entity.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this workforce staff assignment.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'Attribute capturing the fte equivalent information for the workforce staff assignment entity.',
    `funding_source_type` STRING COMMENT 'Classification type categorizing the funding source for this record.',
    `grant_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant classification or category.',
    `hardship_level` STRING COMMENT 'Attribute capturing the hardship level information for the workforce staff assignment entity.',
    `is_cost_shared` BOOLEAN COMMENT 'Boolean indicator specifying whether the record cost shared.',
    `is_field_deployment` BOOLEAN COMMENT 'Boolean indicator specifying whether the record field deployment.',
    `is_surge_deployment` BOOLEAN COMMENT 'Boolean indicator specifying whether the record surge deployment.',
    `job_grade` STRING COMMENT 'Attribute capturing the job grade information for the workforce staff assignment entity.',
    `job_title` STRING COMMENT 'Attribute capturing the job title information for the workforce staff assignment entity.',
    `last_effort_certified_date` DATE COMMENT 'Date and time when the last effort certified event occurred for this workforce staff assignment.',
    `raci_role` STRING COMMENT 'Attribute capturing the raci role information for the workforce staff assignment entity.',
    `safeguarding_training_completed` BOOLEAN COMMENT 'Attribute capturing the safeguarding training completed information for the workforce staff assignment entity.',
    `security_clearance_level` STRING COMMENT 'Attribute capturing the security clearance level information for the workforce staff assignment entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the workforce staff assignment entity.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this workforce staff assignment.',
    `tdy_purpose` STRING COMMENT 'Attribute capturing the tdy purpose information for the workforce staff assignment entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this workforce staff assignment.',
    `workday_assignment_ref` STRING COMMENT 'Attribute capturing the workday assignment ref information for the workforce staff assignment entity.',
    CONSTRAINT pk_workforce_staff_assignment PRIMARY KEY(`workforce_staff_assignment_id`)
) COMMENT 'SSOT for HR/workforce staff assignments to organizational units, positions, and duty stations for workforce planning and management. Distinct from grant.grant_staff_assignment which tracks effort allocation to specific grant awards for cost compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`expat_package` (
    `expat_package_id` BIGINT COMMENT 'Unique identifier for the expat package record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `employment_contract_id` BIGINT COMMENT 'Reference identifier linking to the associated employment contract entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary expat staff member entity.',
    `assignment_country_code` STRING COMMENT 'Standardized code representing the assignment country classification or category.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this expat package.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `danger_pay_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the danger pay quantity or measurement.',
    `education_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the education allowance quantity or measurement.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this expat package.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this expat package.',
    `hardship_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the hardship allowance quantity or measurement.',
    `hardship_classification` STRING COMMENT 'Attribute capturing the hardship classification information for the expat package entity.',
    `home_country_code` STRING COMMENT 'Standardized code representing the home country classification or category.',
    `home_leave_frequency_months` STRING COMMENT 'Attribute capturing the home leave frequency months information for the expat package entity.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the housing allowance quantity or measurement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this expat package.',
    `medevac_provider` STRING COMMENT 'Attribute capturing the medevac provider information for the expat package entity.',
    `mobility_premium_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the mobility premium quantity or measurement.',
    `package_status` STRING COMMENT 'Current status indicator for the package workflow state.',
    `package_type` STRING COMMENT 'Classification type categorizing the package for this record.',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the relocation allowance quantity or measurement.',
    `repatriation_grant_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the repatriation grant quantity or measurement.',
    `rnr_cycle_weeks` STRING COMMENT 'Attribute capturing the rnr cycle weeks information for the expat package entity.',
    `rnr_travel_allowance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the rnr travel allowance quantity or measurement.',
    `security_evacuation_plan` STRING COMMENT 'Attribute capturing the security evacuation plan information for the expat package entity.',
    `shipment_allowance_kg` DECIMAL(18,2) COMMENT 'Attribute capturing the shipment allowance kg information for the expat package entity.',
    `total_package_cost_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the total package cost usd information for the expat package entity.',
    CONSTRAINT pk_expat_package PRIMARY KEY(`expat_package_id`)
) COMMENT 'Expatriate compensation and benefits package record for internationally-recruited staff, capturing hardship allowance tier, housing allowance, education allowance for dependents, home leave entitlement, relocation allowance, medical evacuation coverage level, and applicable INGO salary scale (e.g., UN common system, organizational scale). Distinct from national staff compensation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` (
    `disciplinary_case_id` BIGINT COMMENT 'Unique identifier for the disciplinary case record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated disciplinary reviewing staff member entity.',
    `investigation_id` BIGINT COMMENT 'Reference identifier linking to the associated investigation entity.',
    `primary_disciplinary_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary disciplinary staff member entity.',
    `allegation_category` STRING COMMENT 'Attribute capturing the allegation category information for the disciplinary case entity.',
    `allegation_date` DATE COMMENT 'Date and time when the allegation event occurred for this disciplinary case.',
    `allegation_description` STRING COMMENT 'Detailed textual description providing context about the allegation.',
    `appeal_deadline_date` DATE COMMENT 'Date and time when the appeal deadline event occurred for this disciplinary case.',
    `appeal_outcome` STRING COMMENT 'Attribute capturing the appeal outcome information for the disciplinary case entity.',
    `appeal_submitted_date` DATE COMMENT 'Date and time when the appeal submitted event occurred for this disciplinary case.',
    `case_number` STRING COMMENT 'Count or number of case items associated with this record.',
    `case_opened_date` DATE COMMENT 'Date and time when the case opened event occurred for this disciplinary case.',
    `case_status` STRING COMMENT 'Current status indicator for the case workflow state.',
    `closure_date` DATE COMMENT 'Date and time when the closure event occurred for this disciplinary case.',
    `closure_reason` STRING COMMENT 'Attribute capturing the closure reason information for the disciplinary case entity.',
    `confidentiality_level` STRING COMMENT 'Attribute capturing the confidentiality level information for the disciplinary case entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this disciplinary case.',
    `decision_date` DATE COMMENT 'Date and time when the decision event occurred for this disciplinary case.',
    `decision_outcome` STRING COMMENT 'Attribute capturing the decision outcome information for the disciplinary case entity.',
    `duty_station` STRING COMMENT 'Attribute capturing the duty station information for the disciplinary case entity.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `hearing_date` DATE COMMENT 'Date and time when the hearing event occurred for this disciplinary case.',
    `is_psea_related` BOOLEAN COMMENT 'Boolean indicator specifying whether the record psea related.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this disciplinary case.',
    `legal_counsel_engaged` BOOLEAN COMMENT 'Attribute capturing the legal counsel engaged information for the disciplinary case entity.',
    `misconduct_type` STRING COMMENT 'Classification type categorizing the misconduct for this record.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the disciplinary case entity.',
    `outcome_effective_date` DATE COMMENT 'Date and time when the outcome effective event occurred for this disciplinary case.',
    `preliminary_finding` STRING COMMENT 'Attribute capturing the preliminary finding information for the disciplinary case entity.',
    `sanction_applied` STRING COMMENT 'Attribute capturing the sanction applied information for the disciplinary case entity.',
    `sanction_duration_days` STRING COMMENT 'Attribute capturing the sanction duration days information for the disciplinary case entity.',
    `severity_level` STRING COMMENT 'Attribute capturing the severity level information for the disciplinary case entity.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the disciplinary case entity.',
    `suspension_end_date` DATE COMMENT 'Date and time when the suspension end event occurred for this disciplinary case.',
    `suspension_start_date` DATE COMMENT 'Date and time when the suspension start event occurred for this disciplinary case.',
    `union_representative_present` BOOLEAN COMMENT 'Attribute capturing the union representative present information for the disciplinary case entity.',
    `witness_count` STRING COMMENT 'Count or number of witness items associated with this record.',
    CONSTRAINT pk_disciplinary_case PRIMARY KEY(`disciplinary_case_id`)
) COMMENT 'Record of a formal disciplinary, grievance, or safeguarding investigation case involving a staff member. Captures case type (misconduct, PSEA/SEA violation, fraud, harassment, bullying, performance), case reference number, complainant type (anonymous, named, self-referral), investigation start and end dates, investigator assignment, investigation outcome, sanctions applied (warning, suspension, termination, referral to authorities), appeal status, and case closure date. Supports CHS (Core Humanitarian Standard) accountability obligations, IASC safeguarding compliance, and mandatory donor incident reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`separation_event` (
    `separation_event_id` BIGINT COMMENT 'Unique identifier for the separation event record.',
    `employment_contract_id` BIGINT COMMENT 'Reference identifier linking to the associated employment contract entity.',
    `position_id` BIGINT COMMENT 'Reference identifier linking to the associated position entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary separation staff member entity.',
    `asset_return_completed` BOOLEAN COMMENT 'Attribute capturing the asset return completed information for the separation event entity.',
    `clearance_completed_date` DATE COMMENT 'Date and time when the clearance completed event occurred for this separation event.',
    `clearance_status` STRING COMMENT 'Current status indicator for the clearance workflow state.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this separation event.',
    `duty_station_country_code` STRING COMMENT 'Standardized code representing the duty station country classification or category.',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this separation event.',
    `exit_interview_completed` BOOLEAN COMMENT 'Attribute capturing the exit interview completed information for the separation event entity.',
    `exit_interview_date` DATE COMMENT 'Date and time when the exit interview event occurred for this separation event.',
    `exit_interview_notes` STRING COMMENT 'Attribute capturing the exit interview notes information for the separation event entity.',
    `final_pay_date` DATE COMMENT 'Date and time when the final pay event occurred for this separation event.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the final settlement quantity or measurement.',
    `final_settlement_currency` STRING COMMENT 'Attribute capturing the final settlement currency information for the separation event entity.',
    `handover_completed` BOOLEAN COMMENT 'Attribute capturing the handover completed information for the separation event entity.',
    `handover_document_ref` STRING COMMENT 'Attribute capturing the handover document ref information for the separation event entity.',
    `initiated_by` STRING COMMENT 'Reference to the user or entity that performed the initiated action.',
    `is_involuntary` BOOLEAN COMMENT 'Boolean indicator specifying whether the record involuntary.',
    `knowledge_transfer_completed` BOOLEAN COMMENT 'Attribute capturing the knowledge transfer completed information for the separation event entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this separation event.',
    `last_working_day` DATE COMMENT 'Attribute capturing the last working day information for the separation event entity.',
    `leave_encashment_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the leave encashment quantity or measurement.',
    `leave_encashment_days` DECIMAL(18,2) COMMENT 'Attribute capturing the leave encashment days information for the separation event entity.',
    `notice_period_days` STRING COMMENT 'Attribute capturing the notice period days information for the separation event entity.',
    `notification_date` DATE COMMENT 'Date and time when the notification event occurred for this separation event.',
    `rehire_eligible` BOOLEAN COMMENT 'Attribute capturing the rehire eligible information for the separation event entity.',
    `repatriation_grant_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the repatriation grant quantity or measurement.',
    `repatriation_required` BOOLEAN COMMENT 'Attribute capturing the repatriation required information for the separation event entity.',
    `security_debriefing_completed` BOOLEAN COMMENT 'Attribute capturing the security debriefing completed information for the separation event entity.',
    `separation_number` STRING COMMENT 'Count or number of separation items associated with this record.',
    `separation_reason` STRING COMMENT 'Attribute capturing the separation reason information for the separation event entity.',
    `separation_type` STRING COMMENT 'Classification type categorizing the separation for this record.',
    `severance_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the severance quantity or measurement.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the separation event entity.',
    `system_access_revoked_date` DATE COMMENT 'Date and time when the system access revoked event occurred for this separation event.',
    CONSTRAINT pk_separation_event PRIMARY KEY(`separation_event_id`)
) COMMENT 'Record of a staff members separation from Ngo, capturing separation type (resignation, end of contract, redundancy, termination, retirement, death in service), effective date, notice period served, exit interview completion, final settlement amount, and rehire eligibility. Supports workforce attrition analysis and talent retention tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` (
    `staff_certification_id` BIGINT COMMENT 'Unique identifier for the staff certification record.',
    `learning_course_id` BIGINT COMMENT 'Reference identifier linking to the associated learning course entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary staff cert staff member entity.',
    `accreditation_body` STRING COMMENT 'Attribute capturing the accreditation body information for the staff certification entity.',
    `certificate_number` STRING COMMENT 'Count or number of certificate items associated with this record.',
    `certification_name` STRING COMMENT 'Human-readable name or label for the certification.',
    `certification_type` STRING COMMENT 'Classification type categorizing the certification for this record.',
    `compliance_category` STRING COMMENT 'Attribute capturing the compliance category information for the staff certification entity.',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the continuing education hours information for the staff certification entity.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the cost quantity or measurement.',
    `cost_currency` DECIMAL(18,2) COMMENT 'Attribute capturing the cost currency information for the staff certification entity.',
    `country_of_issue` STRING COMMENT 'Attribute capturing the country of issue information for the staff certification entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this staff certification.',
    `evidence_document_url` STRING COMMENT 'Attribute capturing the evidence document url information for the staff certification entity.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this staff certification.',
    `is_mandatory_for_role` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mandatory for role.',
    `issue_date` DATE COMMENT 'Date and time when the issue event occurred for this staff certification.',
    `issuing_body` STRING COMMENT 'Attribute capturing the issuing body information for the staff certification entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this staff certification.',
    `last_verified_date` DATE COMMENT 'Date and time when the last verified event occurred for this staff certification.',
    `proficiency_level` STRING COMMENT 'Attribute capturing the proficiency level information for the staff certification entity.',
    `renewal_frequency_months` STRING COMMENT 'Attribute capturing the renewal frequency months information for the staff certification entity.',
    `renewal_required` BOOLEAN COMMENT 'Attribute capturing the renewal required information for the staff certification entity.',
    `skill_category` STRING COMMENT 'Attribute capturing the skill category information for the staff certification entity.',
    `verification_status` STRING COMMENT 'Current status indicator for the verification workflow state.',
    CONSTRAINT pk_staff_certification PRIMARY KEY(`staff_certification_id`)
) COMMENT 'Record of professional certifications, licenses, and mandatory clearances held by a staff member, including certification name, issuing body, issue date, expiry date, renewal status, and whether the certification is required for the current role (e.g., security clearance, medical fitness certificate, driving license, professional accreditation). Supports field deployment eligibility checks.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated approver staff member entity.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `intervention_id` BIGINT COMMENT 'Reference identifier linking to the associated intervention entity.',
    `primary_timesheet_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary timesheet staff member entity.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this timesheet.',
    `approval_status` STRING COMMENT 'Current status indicator for the approval workflow state.',
    `billable_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the billable hours information for the timesheet entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this timesheet.',
    `effort_certification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the effort certification condition applies.',
    `grant_code` DECIMAL(18,2) COMMENT 'Standardized code representing the grant classification or category.',
    `is_overtime` BOOLEAN COMMENT 'Boolean indicator specifying whether the record overtime.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this timesheet.',
    `non_billable_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the non billable hours information for the timesheet entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the timesheet entity.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the overtime hours information for the timesheet entity.',
    `period_end_date` DATE COMMENT 'Date and time when the period end event occurred for this timesheet.',
    `period_start_date` DATE COMMENT 'Date and time when the period start event occurred for this timesheet.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `submission_date` DATE COMMENT 'Date and time when the submission event occurred for this timesheet.',
    `timesheet_number` STRING COMMENT 'Count or number of timesheet items associated with this record.',
    `timesheet_status` STRING COMMENT 'Current status indicator for the timesheet workflow state.',
    `total_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the total hours information for the timesheet entity.',
    `work_location` STRING COMMENT 'Attribute capturing the work location information for the timesheet entity.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Time tracking record for staff members capturing hours worked per day, project/grant allocation of time, overtime, and approval status. Essential for donor-compliant cost allocation where multiple grants fund a single position, and for tracking field staff working hours in hardship locations with TOIL (Time Off In Lieu) accrual. Supports BvA reporting and audit-ready grant charging.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this candidate.',
    `current_employer` STRING COMMENT 'Attribute capturing the current employer information for the candidate entity.',
    `current_job_title` STRING COMMENT 'Attribute capturing the current job title information for the candidate entity.',
    `date_of_birth` DATE COMMENT 'Attribute capturing the date of birth information for the candidate entity.',
    `email` STRING COMMENT 'Attribute capturing the email information for the candidate entity.',
    `first_name` STRING COMMENT 'Human-readable name or label for the first.',
    `gender` STRING COMMENT 'Attribute capturing the gender information for the candidate entity.',
    `highest_education_level` STRING COMMENT 'Attribute capturing the highest education level information for the candidate entity.',
    `languages_spoken` STRING COMMENT 'Attribute capturing the languages spoken information for the candidate entity.',
    `last_name` STRING COMMENT 'Human-readable name or label for the last.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this candidate.',
    `nationality_code` STRING COMMENT 'Standardized code representing the nationality classification or category.',
    `phone` STRING COMMENT 'Attribute capturing the phone information for the candidate entity.',
    `preferred_duty_station` STRING COMMENT 'Attribute capturing the preferred duty station information for the candidate entity.',
    `source_channel` STRING COMMENT 'Attribute capturing the source channel information for the candidate entity.',
    `candidate_status` STRING COMMENT 'Current status indicator for the candidate workflow state.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Attribute capturing the years of experience information for the candidate entity.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master reference table for candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Unique identifier for the review template record.',
    `competency_framework_id` BIGINT COMMENT 'Reference identifier linking to the associated competency framework entity.',
    `rating_scale_id` BIGINT COMMENT 'Reference identifier linking to the associated rating scale entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this review template.',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this review template.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this review template.',
    `includes_competency_section` BOOLEAN COMMENT 'Attribute capturing the includes competency section information for the review template entity.',
    `includes_development_plan` BOOLEAN COMMENT 'Attribute capturing the includes development plan information for the review template entity.',
    `includes_objectives_section` BOOLEAN COMMENT 'Attribute capturing the includes objectives section information for the review template entity.',
    `includes_self_assessment` BOOLEAN COMMENT 'Attribute capturing the includes self assessment information for the review template entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this review template.',
    `review_type` STRING COMMENT 'Classification type categorizing the review for this record.',
    `staff_category` STRING COMMENT 'Attribute capturing the staff category information for the review template entity.',
    `template_name` STRING COMMENT 'Human-readable name or label for the template.',
    `template_status` STRING COMMENT 'Current status indicator for the template workflow state.',
    `template_version` STRING COMMENT 'Attribute capturing the template version information for the review template entity.',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Master reference table for review_template. Referenced by review_template_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` (
    `performance_improvement_plan_id` BIGINT COMMENT 'Unique identifier for the performance improvement plan record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated performance supervisor staff member entity.',
    `primary_pip_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary pip staff member entity.',
    `checkin_frequency` STRING COMMENT 'Attribute capturing the checkin frequency information for the performance improvement plan entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this performance improvement plan.',
    `duration_days` STRING COMMENT 'Attribute capturing the duration days information for the performance improvement plan entity.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this performance improvement plan.',
    `extension_granted` DECIMAL(18,2) COMMENT 'Attribute capturing the extension granted information for the performance improvement plan entity.',
    `final_outcome` STRING COMMENT 'Attribute capturing the final outcome information for the performance improvement plan entity.',
    `hr_representative` STRING COMMENT 'Attribute capturing the hr representative information for the performance improvement plan entity.',
    `improvement_areas` STRING COMMENT 'Attribute capturing the improvement areas information for the performance improvement plan entity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this performance improvement plan.',
    `measurable_objectives` STRING COMMENT 'Attribute capturing the measurable objectives information for the performance improvement plan entity.',
    `midpoint_review_date` DATE COMMENT 'Date and time when the midpoint review event occurred for this performance improvement plan.',
    `midpoint_review_outcome` STRING COMMENT 'Attribute capturing the midpoint review outcome information for the performance improvement plan entity.',
    `pip_number` STRING COMMENT 'Count or number of pip items associated with this record.',
    `pip_status` STRING COMMENT 'Current status indicator for the pip workflow state.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this performance improvement plan.',
    `support_resources` STRING COMMENT 'Attribute capturing the support resources information for the performance improvement plan entity.',
    CONSTRAINT pk_performance_improvement_plan PRIMARY KEY(`performance_improvement_plan_id`)
) COMMENT 'Master reference table for performance_improvement_plan. Referenced by pip_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` (
    `calibration_session_id` BIGINT COMMENT 'Unique identifier for the calibration session record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated facilitator staff member entity.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `review_cycle_id` BIGINT COMMENT 'Reference identifier linking to the associated review cycle entity.',
    `calibration_date` DATE COMMENT 'Date and time when the calibration event occurred for this calibration session.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this calibration session.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this calibration session.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the calibration session entity.',
    `participant_count` STRING COMMENT 'Count or number of participant items associated with this record.',
    `ratings_adjusted_count` STRING COMMENT 'Count or number of ratings adjusted items associated with this record.',
    `review_period` STRING COMMENT 'Attribute capturing the review period information for the calibration session entity.',
    `session_number` STRING COMMENT 'Count or number of session items associated with this record.',
    `session_status` STRING COMMENT 'Current status indicator for the session workflow state.',
    `total_reviews_discussed` STRING COMMENT 'Attribute capturing the total reviews discussed information for the calibration session entity.',
    CONSTRAINT pk_calibration_session PRIMARY KEY(`calibration_session_id`)
) COMMENT 'Master reference table for calibration_session. Referenced by calibration_session_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Unique identifier for the competency framework record.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `competency_count` STRING COMMENT 'Count or number of competency items associated with this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this competency framework.',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this competency framework.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this competency framework.',
    `framework_code` STRING COMMENT 'Standardized code representing the framework classification or category.',
    `framework_name` STRING COMMENT 'Human-readable name or label for the framework.',
    `framework_status` STRING COMMENT 'Current status indicator for the framework workflow state.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this competency framework.',
    `proficiency_levels` STRING COMMENT 'Attribute capturing the proficiency levels information for the competency framework entity.',
    `version_number` STRING COMMENT 'Count or number of version items associated with this record.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` (
    `rating_scale_id` BIGINT COMMENT 'Unique identifier for the rating scale record.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this rating scale.',
    `effective_date` DATE COMMENT 'Date and time when the effective event occurred for this rating scale.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this rating scale.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this rating scale.',
    `max_value` DECIMAL(18,2) COMMENT 'Numeric value representing the max quantity or measurement.',
    `min_value` DECIMAL(18,2) COMMENT 'Numeric value representing the min quantity or measurement.',
    `scale_labels` STRING COMMENT 'Attribute capturing the scale labels information for the rating scale entity.',
    `scale_name` STRING COMMENT 'Human-readable name or label for the scale.',
    `scale_status` STRING COMMENT 'Current status indicator for the scale workflow state.',
    `scale_type` STRING COMMENT 'Classification type categorizing the scale for this record.',
    `steps_count` STRING COMMENT 'Count or number of steps items associated with this record.',
    CONSTRAINT pk_rating_scale PRIMARY KEY(`rating_scale_id`)
) COMMENT 'Master reference table for rating_scale. Referenced by rating_scale_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Unique identifier for the review cycle record.',
    `org_unit_id` BIGINT COMMENT 'Reference identifier linking to the associated org unit entity.',
    `calibration_deadline` DATE COMMENT 'Attribute capturing the calibration deadline information for the review cycle entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this review cycle.',
    `cycle_name` STRING COMMENT 'Human-readable name or label for the cycle.',
    `cycle_status` STRING COMMENT 'Current status indicator for the cycle workflow state.',
    `cycle_type` STRING COMMENT 'Classification type categorizing the cycle for this record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the last updated event occurred for this review cycle.',
    `manager_review_deadline` DATE COMMENT 'Attribute capturing the manager review deadline information for the review cycle entity.',
    `period_end_date` DATE COMMENT 'Date and time when the period end event occurred for this review cycle.',
    `period_start_date` DATE COMMENT 'Date and time when the period start event occurred for this review cycle.',
    `self_assessment_deadline` DATE COMMENT 'Attribute capturing the self assessment deadline information for the review cycle entity.',
    `year` STRING COMMENT 'Attribute capturing the year information for the review cycle entity.',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ADD CONSTRAINT `fk_workforce_staff_member_supervisor_staff_member_id` FOREIGN KEY (`supervisor_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_original_payslip_id` FOREIGN KEY (`original_payslip_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`payslip`(`payslip_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_recruiter_staff_member_id` FOREIGN KEY (`tertiary_recruitment_recruiter_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_calibration_session_id` FOREIGN KEY (`calibration_session_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`calibration_session`(`calibration_session_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_performance_improvement_plan_id` FOREIGN KEY (`performance_improvement_plan_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`performance_improvement_plan`(`performance_improvement_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_staff_member_id` FOREIGN KEY (`reviewer_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_staff_member_id` FOREIGN KEY (`primary_leave_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ADD CONSTRAINT `fk_workforce_workforce_staff_assignment_tertiary_workforce_approved_by_staff_member_id` FOREIGN KEY (`tertiary_workforce_approved_by_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ADD CONSTRAINT `fk_workforce_expat_package_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ADD CONSTRAINT `fk_workforce_expat_package_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ADD CONSTRAINT `fk_workforce_expat_package_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_primary_disciplinary_staff_member_id` FOREIGN KEY (`primary_disciplinary_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ADD CONSTRAINT `fk_workforce_staff_certification_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ADD CONSTRAINT `fk_workforce_staff_certification_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_primary_timesheet_staff_member_id` FOREIGN KEY (`primary_timesheet_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_primary_pip_staff_member_id` FOREIGN KEY (`primary_pip_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ADD CONSTRAINT `fk_workforce_rating_scale_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`workforce` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`workforce` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('pii_column_comment_framework' = 'IPSAS 25 + UN Staff Regulations');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `city_name` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `region_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_group_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('pii_column_comment_framework' = 'IPSAS 25 + US GAAP ASC 712 dual-framing');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_reference` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_dependent_coverage` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `hardship_location_applicable` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_grade` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_grade` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `candidate_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `disability_disclosure` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `gender_self_identified` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `nationality_country_code` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_grade` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_grade` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `department_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `provider_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `training_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `provider_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `emergency_contact_available` SET TAGS ('pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_ssot_scope' = 'workforce_hr_assignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_ssot_owner' = 'workforce');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_ssot_boundary' = 'hr_assignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('pii_disambiguated_from' = 'grant.grant_staff_assignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `primary_disciplinary_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `primary_disciplinary_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `certification_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` SET TAGS ('pii_subdomain' = 'staff_records');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `primary_timesheet_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `primary_timesheet_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `work_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` SET TAGS ('pii_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `email` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `gender` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `nationality_code` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `phone` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `primary_pip_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `primary_pip_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `framework_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` SET TAGS ('pii_subdomain' = 'performance_development');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_name` SET TAGS ('pii_type' = 'name');
