-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 09:03:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`workforce` COMMENT 'Human capital management for semiconductor workforce including fab operators, process engineers, design engineers, and EDA specialists. Manages employee profiles, organizational hierarchy, skills and certifications, headcount planning, shift scheduling, and workforce deployment across fab sites. Integrates with Workday HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'System-generated unique identifier for each employee record.',
    `position_id` BIGINT COMMENT 'FK to workforce.position.position_id — Employees fill positions. This is the core link between the person and the authorized headcount slot.',
    `employee_current_position_id` BIGINT COMMENT 'FK to workforce.position.position_id — Employees must reference their assigned position for headcount tracking.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager or supervisor.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit record within the employee workforce entity.',
    `address` STRING COMMENT 'Employees residential address for payroll and tax purposes.',
    `bank_account_number` STRING COMMENT 'Employees bank account for direct deposit.',
    `certifications` STRING COMMENT 'Comma-separated list of professional certifications held.',
    `clearance_level` STRING COMMENT 'Level of security clearance granted to the employee.. Valid values are `none|confidential|secret|top_secret`',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Base annual compensation amount before bonuses.',
    `cost_center` STRING COMMENT 'Financial cost center to which the employees labor is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the employee record in the workforce domain.',
    `currency` STRING COMMENT 'ISO 4217 currency code for compensation (e.g., USD).',
    `date_of_birth` DATE COMMENT 'Employees birth date, required for benefits eligibility and legal compliance.',
    `department` STRING COMMENT 'Organizational department where the employee works.',
    `disability_status` BOOLEAN COMMENT 'True if the employee has a recognized disability.',
    `ear_eligibility` BOOLEAN COMMENT 'True if the employee is eligible to access EAR-controlled technology.',
    `education_level` STRING COMMENT 'Highest completed education level of the employee.. Valid values are `high_school|associate|bachelor|master|doctorate`',
    `email` STRING COMMENT 'Primary corporate email address used for official communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_status` STRING COMMENT 'Current lifecycle status of the employee.. Valid values are `active|inactive|terminated|on_leave|retired`',
    `employment_type` STRING COMMENT 'Classification of the employment relationship.. Valid values are `full_time|contractor|intern|part_time|temporary`',
    `first_name` STRING COMMENT 'Employees given (first) name as recorded in HR.',
    `full_name` STRING COMMENT 'Concatenated legal name of the employee (first + middle + last).',
    `hire_date` DATE COMMENT 'Date the employee officially started employment with the company.',
    `itar_eligibility` BOOLEAN COMMENT 'True if the employee is eligible to access ITAR-controlled data.',
    `job_title` STRING COMMENT 'Official title or role assigned to the employee.',
    `language_proficiency` STRING COMMENT 'Languages spoken and proficiency levels.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the employee record in the workforce domain.',
    `last_name` STRING COMMENT 'Employees family (last) name as recorded in HR.',
    `location` STRING COMMENT 'Primary site or fab where the employee performs duties.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the employee record in the workforce domain.',
    `national_id_number` STRING COMMENT 'Government-issued personal identifier (e.g., SSN, SIN) used for tax reporting.',
    `org_unit` BIGINT COMMENT 'FK to workforce.org_unit.org_unit_id — Employee must reference their org unit for management hierarchy and cost center assignment.',
    `organization_level` STRING COMMENT 'Hierarchical level within the corporate structure (e.g., L1, L2).',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime compensation.',
    `passport_number` STRING COMMENT 'Passport identifier for employees requiring international travel clearance.',
    `phone_number` STRING COMMENT 'Primary telephone number for the employee (mobile or office).',
    `position` BIGINT COMMENT 'FK to workforce.position.position_id — Employee must reference their assigned position for headcount tracking and organizational placement.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `salary_grade` STRING COMMENT 'Internal salary band or grade assigned to the employee.',
    `security_clearance_expiration` DATE COMMENT 'Date when the employees security clearance expires.',
    `skills` STRING COMMENT 'Comma-separated list of core technical and soft skills.',
    `social_security_number` STRING COMMENT 'U.S. Social Security Number for payroll tax reporting.',
    `tax_id_number` STRING COMMENT 'Tax ID used for payroll tax withholdings.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `union_member_flag` BOOLEAN COMMENT 'True if the employee is a member of a labor union.',
    `veteran_status` STRING COMMENT 'Indicates military veteran status of the employee.. Valid values are `none|veteran|disabled_veteran`',
    `work_shift` STRING COMMENT 'Scheduled shift pattern for the employee.. Valid values are `day|night|swing|flex`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all semiconductor workforce personnel including fab operators, process engineers, IC design engineers, EDA specialists, metrology technicians, and corporate staff. SSOT for employee identity, employment status, job classification, cost center assignment, and organizational placement. Captures hire date, termination date, employment type (full-time, contractor, intern), work location (fab site, design center, office), clearance/export control eligibility (ITAR, EAR), and position assignment. Integrates with Workday HCM as the system of record. Central entity referenced by all workforce transactions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique system-generated identifier for the position record.',
    `org_unit_id` BIGINT COMMENT 'FK to workforce.org_unit.org_unit_id — Positions must be assigned to an org unit for headcount planning.',
    `job_id` BIGINT COMMENT 'Legacy or alternate identifier used by internal HR systems.',
    `position_job_id` BIGINT COMMENT 'Unique identifier for the primary job record within the position workforce entity.',
    `primary_position_org_unit_id` BIGINT COMMENT 'Reference to the department master record.',
    `reports_to_position_id` BIGINT COMMENT 'Reporting position',
    `site_id` BIGINT COMMENT 'Reference to the physical site record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved monetary budget allocated for this position.',
    `budget_approval_status` STRING COMMENT 'Current approval state of the positions budget.. Valid values are `approved|pending|rejected`',
    `certification_requirements` STRING COMMENT 'Professional certifications mandatory for the role.',
    `classification` STRING COMMENT 'Indicates whether the role is exempt or non‑exempt under labor regulations.. Valid values are `exempt|non_exempt`',
    `position_code` STRING COMMENT 'Coded value representing the code of the position workforce record.',
    `compensation_band` STRING COMMENT 'Compensation band or salary range classification for the position.',
    `competency_requirements` STRING COMMENT 'Key competencies and skill levels expected for the position.',
    `compliance_training_required` BOOLEAN COMMENT 'Indicates if mandatory compliance training is required for the position.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the positions expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for salary and budget amounts.',
    `department` STRING COMMENT 'Organizational department to which the position reports.',
    `position_description` STRING COMMENT 'Detailed narrative of responsibilities, scope, and expectations for the role.',
    `education_requirement` STRING COMMENT 'Minimum educational qualification required for the role.',
    `effective_date` DATE COMMENT 'Position effective date',
    `effective_end_date` DATE COMMENT 'Date when the position is scheduled to be retired or closed.',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active in the organization.',
    `employment_type` STRING COMMENT 'Nature of the employment contract.. Valid values are `full_time|contractor|part_time|temporary`',
    `export_control_required` BOOLEAN COMMENT 'Export control requirement',
    `fte` DECIMAL(18,2) COMMENT 'Standardized FTE value representing the workload of the position.',
    `grade_level` STRING COMMENT 'Organizational grade or band indicating seniority and compensation tier.',
    `headcount_budget` STRING COMMENT 'The headcount budget of the position record in the workforce domain.',
    `headcount_filled` STRING COMMENT 'Number of currently filled slots for the position.',
    `headcount_required` STRING COMMENT 'Number of employees approved for this position.',
    `headcount_type` STRING COMMENT 'The headcount type of the position record in the workforce domain.',
    `is_remote_allowed` BOOLEAN COMMENT 'Indicates whether the position permits remote or hybrid work arrangements.',
    `itar_access_required` BOOLEAN COMMENT 'ITAR access requirement',
    `job_family` STRING COMMENT 'Broad functional area to which the position belongs.. Valid values are `Fab Operations|Process Engineering|IC Design|EDA|Quality|Supply Chain`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the position record in the workforce domain.',
    `location` STRING COMMENT 'Identifier of the fab site, design center, or office where the position is based.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the position record in the workforce domain.',
    `org_unit` BIGINT COMMENT 'FK to workforce.org_unit.org_unit_id — Position must reference the org unit it belongs to for headcount planning.',
    `overtime_eligible` BOOLEAN COMMENT 'True if the position is eligible for overtime compensation.',
    `position_status` STRING COMMENT 'Current staffing status of the position.. Valid values are `filled|vacant|pending|closed`',
    `position_title` STRING COMMENT 'The position title of the position record in the workforce domain.',
    `position_type` STRING COMMENT 'High‑level categorization of the roles functional focus.. Valid values are `operational|design|support|management`',
    `profile` BIGINT COMMENT 'FK to workforce.job_profile.job_profile_id — Positions reference their job profile template for role specification.',
    `required_security_clearance` STRING COMMENT 'Level of security clearance required to perform the role.. Valid values are `none|confidential|secret|top_secret`',
    `salary_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the position, in the specified currency.',
    `salary_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the position, in the specified currency.',
    `security_clearance_level` STRING COMMENT 'Required clearance level',
    `shift_end_time` TIMESTAMP COMMENT 'Planned end time of the shift (HH:mm, 24‑hour).',
    `shift_required` STRING COMMENT 'Required shift',
    `shift_start_time` TIMESTAMP COMMENT 'Planned start time of the shift (HH:mm, 24‑hour).',
    `shift_type` STRING COMMENT 'Standard shift classification for the position.. Valid values are `day|night|swing`',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., hiring freeze, project delay).',
    `title` STRING COMMENT 'Official title of the position as displayed in job postings and internal directories.',
    `to_job_profile` BIGINT COMMENT 'FK to workforce.job_profile.job_profile_id — Positions are created from job profile templates. Links the headcount slot to the role specification.',
    `travel_required` BOOLEAN COMMENT 'True if the role requires regular travel beyond the primary location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount position master record defining approved roles within the semiconductor organization, including the job profile template specifications that define each role. Captures position title, job family (Fab Operations, Process Engineering, IC Design, EDA, Quality, Supply Chain), grade level, required headcount, filled/vacant status, fab site or design center assignment, budget approval status, job code, exempt/non-exempt classification, required education, standard competency requirements, and compensation benchmarking parameters. Supports headcount planning, workforce deployment across FAB sites and design centers, and serves as the template for hiring requisitions. Sourced from Workday HCM position management and job catalog.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'System-generated unique identifier for the organizational unit.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the org unit workforce entity.',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the hierarchy.',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the org unit workforce entity.',
    `employee_id` BIGINT COMMENT 'Head of org unit',
    `manager_employee_id` BIGINT COMMENT 'Unique identifier for the manager employee record within the org unit workforce entity.',
    `actual_headcount` STRING COMMENT 'The actual headcount of the org unit record in the workforce domain.',
    `address_line1` STRING COMMENT 'First line of the units physical address.',
    `address_line2` STRING COMMENT 'Second line of the units physical address, if applicable.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the unit for the fiscal year, in the specified currency.',
    `city` STRING COMMENT 'City where the unit is located.',
    `org_unit_code` STRING COMMENT 'Business code used to reference the unit in ERP and PLM systems.. Valid values are `^[A-Z0-9_]{1,10}$`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) that govern the units operations.. Valid values are `ITAR|EAR|RoHS|REACH|ISO9001|ISO14001`',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the units primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the org unit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|JPY|CNY|KRW|SGD`',
    `data_classification_level` STRING COMMENT 'Enterprise data classification assigned to the units data assets.. Valid values are `public|internal|confidential|restricted`',
    `org_unit_description` STRING COMMENT 'Free‑form description of the units purpose and scope.',
    `effective_date` DATE COMMENT 'The effective date associated with the org unit workforce record.',
    `effective_end_date` DATE COMMENT 'Date when the unit was retired or merged; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the unit became operational.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., legacy PLM) to reference the unit.',
    `functional_area` STRING COMMENT 'Primary business function of the unit. [ENUM-REF-CANDIDATE: Design|Fabrication|Quality|SupplyChain|Finance|HR|R&D|Sales — promote to reference product]',
    `headcount_actual` STRING COMMENT 'Current number of active employees assigned to the unit.',
    `headcount_budget` STRING COMMENT 'Budgeted headcount',
    `headcount_planned` STRING COMMENT 'Number of employees planned for the unit for the current fiscal period.',
    `hierarchy_level` STRING COMMENT 'Depth of the unit in the org chart (root = 0).',
    `is_cost_center` BOOLEAN COMMENT 'True if the unit functions as a cost center.',
    `is_global` BOOLEAN COMMENT 'True if the unit operates globally rather than at a single site.',
    `is_profit_center` BOOLEAN COMMENT 'True if the unit functions as a profit center.',
    `is_shared_service` BOOLEAN COMMENT 'Indicates whether the unit provides shared services across the enterprise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the org unit record in the workforce domain.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance or compliance review of the unit.',
    `location_code` STRING COMMENT 'Three‑letter code representing the primary site or fab where the unit operates.. Valid values are `^[A-Z]{3}$`',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the org unit record in the workforce domain.',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the organizational unit.',
    `operating_hours` STRING COMMENT 'Standard operating hours (e.g., "08:00‑17:00").',
    `org_chart_path` STRING COMMENT 'Delimited string representing the full hierarchy path (e.g., "Corporate>Engineering>Design").',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the unit.. Valid values are `active|inactive|planned|closed`',
    `org_unit_type` STRING COMMENT 'Category of the unit within the corporate hierarchy.. Valid values are `division|department|team|cost_center|profit_center|function`',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the units address.. Valid values are `^[0-9A-Z]{5,10}$`',
    `primary_contact_email` STRING COMMENT 'Email address for the units main point of contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Phone number for the units main point of contact.',
    `profit_center_code` STRING COMMENT 'Profit‑center identifier associated with the unit.. Valid values are `^[0-9]{4}$`',
    `region` STRING COMMENT 'Broad geographic region of the unit.. Valid values are `APAC|EMEA|AMER`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the units primary location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the org unit record.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy master record representing the management structure of the semiconductor enterprise. Captures business unit, department, cost center, division, and team nodes across fab operations, design engineering, process engineering, quality, supply chain, and corporate functions. Supports multi-level hierarchy traversal for reporting, headcount allocation, and workforce planning. Maps to SAP CO cost center hierarchy and Workday HCM supervisory organization.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`competency` (
    `competency_id` BIGINT COMMENT 'Primary key for competency',
    `certification_id` BIGINT COMMENT 'Identifier of the certification linked to the skill, if applicable.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee (person) to whom the skill record belongs.',
    `skill_id` BIGINT COMMENT 'Unique identifier of the competency or skill defined in the skill catalog.',
    `assessment_date` DATE COMMENT 'Date on which the most recent assessment was performed.',
    `assessment_method` STRING COMMENT 'Method used to evaluate the employees proficiency.. Valid values are `Self-Assessment|Manager Review|Certification|Test|Simulation`',
    `competency_category` STRING COMMENT 'The category of the competency record in the workforce domain.',
    `certification_expiry_date` DATE COMMENT 'Date the certification expires and must be renewed.',
    `certification_issue_date` DATE COMMENT 'Date the certification was originally issued to the employee.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether the skill requires a formal certification to be considered valid.',
    `certification_status` STRING COMMENT 'Current status of the employees certification for the skill.. Valid values are `Valid|Expired|Pending|Revoked`',
    `competency_code` STRING COMMENT 'Coded value representing the code of the competency workforce record.',
    `competency_status` STRING COMMENT 'Active/Deprecated',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the competency record in the workforce domain.',
    `competency_description` STRING COMMENT 'The description of the competency record in the workforce domain.',
    `export_control_relevant` BOOLEAN COMMENT 'Export control relevance',
    `last_assessed_date` DATE COMMENT 'Date of the last time the skill was formally assessed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the competency record in the workforce domain.',
    `competency_level` STRING COMMENT 'Proficiency level',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the competency record in the workforce domain.',
    `competency_name` STRING COMMENT 'The name of the competency record in the workforce domain.',
    `proficiency_level` STRING COMMENT 'Declared level of skill mastery for the employee.. Valid values are `Novice|Practitioner|Expert|Master`',
    `proficiency_scale` STRING COMMENT 'The proficiency scale of the competency record in the workforce domain.',
    `proficiency_score` DECIMAL(18,2) COMMENT 'Numeric rating (0.00‑5.00) representing the employees skill proficiency.',
    `recertification_period_months` STRING COMMENT 'Recertification period',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee‑skill record was first created.',
    `record_status` STRING COMMENT 'Current lifecycle status of the employee‑skill record.. Valid values are `active|inactive|archived`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this employee‑skill record.',
    `skill_attainment_date` DATE COMMENT 'Date when the employee first achieved the recorded proficiency level.',
    `skill_change_reason` STRING COMMENT 'Reason recorded for the most recent change to the skill definition.',
    `skill_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the skill definition was last changed.',
    `skill_criticality` STRING COMMENT 'Business impact rating of the skill for operations.. Valid values are `Low|Medium|High|Critical`',
    `skill_expiry_date` DATE COMMENT 'Date after which the skill proficiency is considered expired (e.g., for time‑limited certifications).',
    `skill_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the skill definition.',
    `skill_owner_department` STRING COMMENT 'Organizational department responsible for maintaining the skill definition.',
    `skill_owner_team` STRING COMMENT 'Team within the department that curates the skill.',
    `skill_required_for_role` STRING COMMENT 'Job role or function for which the skill is a prerequisite.',
    `skill_source_system` STRING COMMENT 'System of origin for the skill definition.. Valid values are `Workday HCM|Internal Skill DB`',
    `skill_training_hours` DECIMAL(18,2) COMMENT 'Total number of training hours logged for this skill.',
    `skill_training_method` STRING COMMENT 'Primary method used to deliver training for the skill.. Valid values are `On-the-Job|Classroom|Online|Workshop`',
    `skill_validated_by` STRING COMMENT 'Name or identifier of the person who validated the skill proficiency.',
    `skill_validated_date` DATE COMMENT 'Date when the skill proficiency was validated.',
    `skill_version` STRING COMMENT 'Version identifier of the skill definition (e.g., v1.2).',
    CONSTRAINT pk_competency PRIMARY KEY(`competency_id`)
) COMMENT 'Unified competency and skill management product for semiconductor workforce. Combines the skill catalog (defining all technical and functional competencies tracked across the organization) with individual employee skill proficiency records. Catalog entries capture skill name, category (EDA Tools, Process Technology, Lithography, CMP, CVD/PVD/ALD, Ion Implantation, Wafer Probing, Packaging, Quality/SPC, ATPG/DFT, RTL Design, Physical Design), proficiency scale definitions, and certification linkages. Employee records capture skill attainment date, proficiency level (Novice, Practitioner, Expert, Master), assessment method, last assessed date, and expiry for time-limited qualifications. Enables workforce capability mapping, skills gap analysis, and deployment decisions for specialized fab and design roles.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` (
    `workforce_qualification_id` BIGINT COMMENT 'Primary key for qualification',
    `competency_id` BIGINT COMMENT 'Unique identifier for the competency record within the workforce qualification workforce entity.',
    `skill_id` BIGINT COMMENT 'Unique identifier for the skill record within the workforce qualification workforce entity.',
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course record within the workforce qualification workforce entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the workforce assessor employee record within the workforce qualification workforce entity.',
    `workforce_employee_id` BIGINT COMMENT 'Unique identifier of the employee (from Workday HCM).',
    `assessor_name` STRING COMMENT 'The assessor name of the workforce qualification record in the workforce domain.',
    `audit_status` STRING COMMENT 'Status of the internal audit for the certification record.. Valid values are `pending|completed|failed`',
    `certificate_number` STRING COMMENT 'Unique certificate number assigned by the issuing body.',
    `certification_code` STRING COMMENT 'Short code or identifier for the certification.',
    `certification_name` STRING COMMENT 'Name of the certification as defined in the certification catalog.',
    `certification_number` STRING COMMENT 'The certification number of the workforce qualification record in the workforce domain.',
    `certification_type` STRING COMMENT 'Indicates whether the certification is mandatory, optional, or internal.. Valid values are `mandatory|optional|internal`',
    `certified_date` DATE COMMENT 'The certified date associated with the workforce qualification workforce record.',
    `certifying_body` STRING COMMENT 'The certifying body of the workforce qualification record in the workforce domain.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the certification meets regulatory compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was initially created.',
    `workforce_qualification_description` STRING COMMENT 'Detailed description of the certification purpose and scope.',
    `document_url` STRING COMMENT 'Link to the digital copy of the certification document.',
    `expiration_notice_sent` BOOLEAN COMMENT 'Indicates whether an expiration notice has been sent to the employee.',
    `expiry_date` DATE COMMENT 'Date when the certification expires.',
    `granted_date` DATE COMMENT 'The granted date associated with the workforce qualification workforce record.',
    `issue_date` DATE COMMENT 'Date when the certification was issued to the employee.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification.. Valid values are `SEMI|JEDEC|IEEE|IATF16949|ISO9001|internal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the workforce qualification record in the workforce domain.',
    `last_training_date` DATE COMMENT 'Date of the most recent training session for the certification.',
    `last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the workforce qualification record in the workforce domain.',
    `notes` STRING COMMENT 'Free-form notes related to the certification.',
    `proficiency_level` STRING COMMENT 'The proficiency level of the workforce qualification record in the workforce domain.',
    `qualification_code` STRING COMMENT 'Coded value representing the qualification code of the workforce qualification workforce record.',
    `qualification_date` DATE COMMENT 'Date qualified',
    `qualification_name` STRING COMMENT 'The qualification name of the workforce qualification record in the workforce domain.',
    `qualification_status` STRING COMMENT 'The qualification status of the workforce qualification record in the workforce domain.',
    `qualification_type` STRING COMMENT 'The qualification type of the workforce qualification record in the workforce domain.',
    `recertification_required` BOOLEAN COMMENT 'The recertification required of the workforce qualification record in the workforce domain.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'True if the certification is mandated by regulatory bodies (e.g., ITAR, IATF16949).',
    `renewal_notice_date` DATE COMMENT 'Date when a renewal notice was sent to the employee.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification requires renewal.',
    `scope` STRING COMMENT 'Scope of the certification (e.g., equipment qualification, cleanroom access).',
    `trainer_name` STRING COMMENT 'Name of the trainer or instructor who provided the certification training.',
    `training_hours` STRING COMMENT 'Number of training hours completed to obtain the certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the workforce qualification record in the workforce domain.',
    `validity_period_days` STRING COMMENT 'Number of days the certification is valid from issue date.',
    `version` STRING COMMENT 'Version identifier of the certification record.',
    `workforce_qualification_status` STRING COMMENT 'Current status of the certification for the employee.. Valid values are `active|expired|suspended|pending_renewal`',
    CONSTRAINT pk_workforce_qualification PRIMARY KEY(`workforce_qualification_id`)
) COMMENT 'Unified certification and qualification management product for semiconductor workforce compliance. Combines the certification catalog (defining all mandatory and optional certifications) with individual employee certification attainment records. Catalog entries capture certification name, issuing body (SEMI, JEDEC, IEEE, IATF 16949, ISO 9001, internal fab qualification), type, validity period, renewal requirements, and regulatory mandate flag. Employee records capture issue date, expiry date, certificate number, status (Active, Expired, Suspended, Pending Renewal), and compliance flag. Critical for fab operator equipment qualification, cleanroom access authorization, ITAR/EAR export control training compliance, and IATF 16949 quality auditor certification management.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Primary key for shift_schedule',
    `fab_site_id` BIGINT COMMENT 'Identifier of the fab site where the shift is scheduled.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the shift.',
    `shift_employee_id` BIGINT COMMENT 'Unique identifier for the shift employee record within the shift schedule workforce entity.',
    `shift_pattern_id` BIGINT COMMENT 'Identifier of the shift pattern (template) applied to this assignment.',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the shift schedule workforce entity.',
    `assignment_code` STRING COMMENT 'Human‑readable code used to reference the shift assignment in operational systems.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date‑time when the shift assignment becomes effective for the employee.',
    `break_schedule` STRING COMMENT 'Description of scheduled break times within the shift (e.g., 2×15 min).',
    `cost_center_code` STRING COMMENT 'Financial cost‑center to which the labor cost of the shift is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the shift schedule workforce record.',
    `effective_start_date` DATE COMMENT 'Start date',
    `end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time of the assigned shift.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'The hours per week of the shift schedule record in the workforce domain.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Labor cost allocated to the shift assignment (currency unit implied by corporate policy).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the shift schedule record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the shift schedule record in the workforce domain.',
    `notes` STRING COMMENT 'Free‑form notes or special instructions for the shift assignment.',
    `overtime_authorized` BOOLEAN COMMENT 'Indicates whether overtime work is permitted for this shift assignment.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Overtime eligible',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours approved for the shift.',
    `rotation_group` STRING COMMENT 'The rotation group of the shift schedule record in the workforce domain.',
    `schedule_date` DATE COMMENT 'The schedule date associated with the shift schedule workforce record.',
    `schedule_status` STRING COMMENT 'The schedule status of the shift schedule record in the workforce domain.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'The scheduled hours of the shift schedule record in the workforce domain.',
    `shift_end_time` TIMESTAMP COMMENT 'The shift end time of the shift schedule record in the workforce domain.',
    `shift_schedule_status` STRING COMMENT 'Current lifecycle state of the shift assignment.. Valid values are `active|inactive|cancelled|pending`',
    `shift_start_time` TIMESTAMP COMMENT 'The shift start time of the shift schedule record in the workforce domain.',
    `shift_type` STRING COMMENT 'Category of the shift pattern (e.g., Day, Swing, Night).. Valid values are `Day|Swing|Night|12h_Continental|4on4off`',
    `start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time of the assigned shift.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the shift assignment record.',
    `work_area` STRING COMMENT 'Functional area within the fab where the employee will work during the shift.. Valid values are `FEOL|BEOL|Metrology|Packaging|R&D`',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Unified shift scheduling product for semiconductor fab operations combining shift pattern definitions with individual employee shift assignments. Pattern definitions capture shift templates (Day, Swing, Night, 12-hour Continental, 4-on-4-off), start/end times, duration, break schedules, and site applicability. Assignment records capture employee-to-shift-pattern mapping, effective dates, fab site and work area (FEOL, BEOL, Metrology, Packaging), shift supervisor, assignment status, and overtime authorization. Supports 24/7 FAB operations staffing, shift handover management, and labor cost allocation to production cost centers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` (
    `talent_acquisition_id` BIGINT COMMENT 'Primary key for talent_acquisition',
    `job_id` BIGINT COMMENT 'Unique identifier for the job record within the talent acquisition workforce entity.',
    `location_id` BIGINT COMMENT 'Identifier of the fab site or design centre where the role is based.',
    `project_id` BIGINT COMMENT 'Identifier of the Non‑Recurring Engineering project linked to the hire, if applicable.',
    `position_id` BIGINT COMMENT 'Identifier of the standardized job profile (e.g., Fab Operator, Process Engineer).',
    `employee_id` BIGINT COMMENT 'Identifier of the manager who owns the requisition.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department requesting the hire.',
    `talent_hiring_manager_employee_id` BIGINT COMMENT 'Hiring manager',
    `talent_recruiter_employee_id` BIGINT COMMENT 'Unique identifier for the talent recruiter employee record within the talent acquisition workforce entity.',
    `application_date` DATE COMMENT 'The application date associated with the talent acquisition workforce record.',
    `application_stage` STRING COMMENT 'The application stage of the talent acquisition record in the workforce domain.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the hiring effort.',
    `candidate_count` STRING COMMENT 'Number of candidates',
    `candidate_email` STRING COMMENT 'The candidate email of the talent acquisition record in the workforce domain.',
    `candidate_name` STRING COMMENT 'The candidate name of the talent acquisition record in the workforce domain.',
    `close_date` DATE COMMENT 'Date closed',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition was closed (filled, cancelled, or otherwise completed).',
    `compliance_requirements` STRING COMMENT 'Any regulatory or export‑control constraints attached to the position (e.g., ITAR, EAR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the budget amount. [ENUM-REF-CANDIDATE: USD|EUR|JPY|CNY|GBP|CAD|AUD|CHF|HKD|SGD — promote to reference product]',
    `talent_acquisition_description` STRING COMMENT 'Detailed description of duties, responsibilities, and required qualifications.',
    `export_control_required` BOOLEAN COMMENT 'The export control required of the talent acquisition record in the workforce domain.',
    `headcount_filled` STRING COMMENT 'Number of positions already filled from this requisition.',
    `headcount_requested` STRING COMMENT 'Number of positions requested in this requisition.',
    `interview_count` STRING COMMENT 'Number of interviews',
    `interview_stage` STRING COMMENT 'The interview stage of the talent acquisition record in the workforce domain.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the role is classified as confidential (e.g., security‑sensitive projects).',
    `job_profile_name` STRING COMMENT 'Descriptive name of the job profile.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the talent acquisition record in the workforce domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the requisition.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the talent acquisition record in the workforce domain.',
    `offer_accepted_flag` BOOLEAN COMMENT 'Offer accepted',
    `offer_amount` DECIMAL(18,2) COMMENT 'The offer amount of the talent acquisition record in the workforce domain.',
    `offer_date` DATE COMMENT 'The offer date associated with the talent acquisition workforce record.',
    `offer_extended_flag` BOOLEAN COMMENT 'Offer extended',
    `offer_status` STRING COMMENT 'The offer status of the talent acquisition record in the workforce domain.',
    `open_date` DATE COMMENT 'Date opened',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition was made visible to candidates.',
    `posting_date` DATE COMMENT 'The posting date associated with the talent acquisition workforce record.',
    `priority` STRING COMMENT 'Business priority assigned to the requisition.. Valid values are `high|medium|low`',
    `requisition_number` STRING COMMENT 'Human‑readable business identifier for the requisition, used in reports and communications.',
    `requisition_status` STRING COMMENT 'The requisition status of the talent acquisition record in the workforce domain.',
    `requisition_type` STRING COMMENT 'Classifies the hiring need: new headcount, backfill, or contractor.. Valid values are `new_headcount|backfill|contractor`',
    `security_clearance_required` BOOLEAN COMMENT 'Clearance required',
    `source_channel` STRING COMMENT 'Origin of the requisition request.. Valid values are `internal|referral|recruiter|job_board|social_media|agency`',
    `start_date` DATE COMMENT 'The start date associated with the talent acquisition workforce record.',
    `talent_acquisition_status` STRING COMMENT 'Current lifecycle status of the requisition.. Valid values are `open|closed|cancelled|filled|on_hold`',
    `target_end_date` DATE COMMENT 'Planned end date for contract or temporary assignments.',
    `target_start_date` DATE COMMENT 'Planned start date for the new hire.',
    `title` STRING COMMENT 'Title of the position being recruited.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the talent acquisition record in the workforce domain.',
    CONSTRAINT pk_talent_acquisition PRIMARY KEY(`talent_acquisition_id`)
) COMMENT 'Unified talent acquisition product for semiconductor workforce covering the full hiring pipeline from approved requisition through candidate tracking to hire. Requisition data captures hiring request details including job profile, hiring manager, target org unit, fab site or design center, requisition type (New Headcount, Backfill, Contractor), priority, and NRE project linkage. Application data captures candidate pipeline including source channel, application status (Applied, Screening, Phone Interview, Technical Interview, Offer, Hired, Rejected, Withdrawn), interview stages, and offer details. Supports talent acquisition tracking for specialized semiconductor roles. Sourced from Workday HCM recruiting module.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` (
    `employment_event_id` BIGINT COMMENT 'System‑generated unique identifier for the employment lifecycle event.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved the employment event.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Employment lifecycle events must reference the employee they pertain to.',
    `employment_approved_by_employee_id` BIGINT COMMENT 'Unique identifier for the employment approved by employee record within the employment event workforce entity.',
    `org_unit_id` BIGINT COMMENT 'New org unit',
    `position_id` BIGINT COMMENT 'New position',
    `employment_org_unit_id` BIGINT COMMENT 'Unique identifier for the employment org unit record within the employment event workforce entity.',
    `employment_position_id` BIGINT COMMENT 'Unique identifier for the employment position record within the employment event workforce entity.',
    `employment_previous_org_unit_id` BIGINT COMMENT 'Previous org unit',
    `employment_previous_position_id` BIGINT COMMENT 'Unique identifier for the employment previous position record within the employment event workforce entity.',
    `primary_employment_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this event applies.',
    `event_employee_id` BIGINT COMMENT 'Unique identifier for the event employee record within the employment event workforce entity.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the event received final approval.',
    `approved_by` STRING COMMENT 'The approved by of the employment event record in the workforce domain.',
    `comments` STRING COMMENT 'Additional notes or remarks captured by HR during processing of the event.',
    `compensation_change_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the compensation adjustment associated with the event (positive for increase, negative for decrease).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employment event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the compensation change amount.',
    `effective_date` DATE COMMENT 'Date on which the employment change becomes effective.',
    `employee` BIGINT COMMENT 'FK to workforce.employee.employee_id — Employment lifecycle events must reference the employee they describe.',
    `event_date` DATE COMMENT 'The event date associated with the employment event workforce record.',
    `event_reason` STRING COMMENT 'The event reason of the employment event record in the workforce domain.',
    `event_status` STRING COMMENT 'Current processing state of the event.. Valid values are `pending|approved|rejected|completed`',
    `event_type` STRING COMMENT 'Category of the employment change (e.g., hire, transfer, promotion, demotion, job change, location change, leave of absence, return from leave, termination). [ENUM-REF-CANDIDATE: hire|transfer|promotion|demotion|job_change|location_change|leave_of_absence|return_from_leave|termination — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the employment event record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the employment event record in the workforce domain.',
    `new_compensation_grade` STRING COMMENT 'Compensation grade or band applicable to the employee after the event.',
    `new_location` STRING COMMENT 'Physical fab site or office location assigned to the employee after the event.',
    `new_organization` STRING COMMENT 'Organizational unit, department, or division assigned to the employee after the event.',
    `new_position` STRING COMMENT 'Job title or position assigned to the employee after the event.',
    `notes` STRING COMMENT 'The notes of the employment event record in the workforce domain.',
    `previous_compensation_grade` STRING COMMENT 'Compensation grade or band applicable to the employee before the event.',
    `previous_location` STRING COMMENT 'Physical fab site or office location where the employee was assigned before the event.',
    `previous_organization` STRING COMMENT 'Organizational unit, department, or division where the employee worked before the event.',
    `previous_position` STRING COMMENT 'Job title or position held by the employee before the event.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the employment change (e.g., business_need, performance, restructuring).',
    `reason_description` STRING COMMENT 'Free‑text explanation of why the employment event was initiated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the employment event record.',
    CONSTRAINT pk_employment_event PRIMARY KEY(`employment_event_id`)
) COMMENT 'Transactional record capturing all significant employment lifecycle events for semiconductor employees throughout their tenure. Covers hire, transfer, promotion, demotion, job change, location change (fab site transfer), leave of absence, return from leave, and termination events. Captures event type, effective date, previous and new values for changed attributes (position, org unit, compensation grade, location), reason code, and approver. Provides the complete employment history audit trail required for SOX compliance and workforce analytics.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique surrogate key for the compensation record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the approved by employee record within the compensation workforce entity.',
    `compensation_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Compensation records must reference the employee. Core payroll/HR FK.',
    `compensation_plan_id` BIGINT COMMENT 'Identifier of the compensation plan template applied.',
    `primary_compensation_employee_id` BIGINT COMMENT 'Unique identifier of the employee receiving the compensation.',
    `primary_compensation_plan_id` BIGINT COMMENT 'Unique identifier for the primary compensation plan record within the compensation workforce entity.',
    `to_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Compensation records must reference the employee. Required for labor cost allocation.',
    `base_amount` DECIMAL(18,2) COMMENT 'Base salary or hourly rate amount before bonuses or variable components.',
    `base_salary` DECIMAL(18,2) COMMENT 'The base salary of the compensation record in the workforce domain.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Actual bonus amount paid for the period.',
    `bonus_target_percent` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base compensation.',
    `change_reason` STRING COMMENT 'Reason for the latest change to the compensation record.',
    `compensation_code` STRING COMMENT 'External code used to reference the compensation record.',
    `compensation_status` STRING COMMENT 'Current lifecycle status of the compensation record.. Valid values are `active|inactive|pending|terminated|draft`',
    `compensation_type` STRING COMMENT 'Category of compensation applicable to the employee.. Valid values are `salary|hourly|bonus|equity|variable|shift_differential`',
    `cost_center_code` STRING COMMENT 'Cost center to which labor cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation record was created.',
    `currency` STRING COMMENT 'The currency of the compensation record in the workforce domain.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Department to which the employee belongs.',
    `effective_date` DATE COMMENT 'The effective date associated with the compensation workforce record.',
    `effective_end_date` DATE COMMENT 'Date when the compensation ends or is superseded; null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the compensation becomes effective.',
    `employee` BIGINT COMMENT 'FK to workforce.employee.employee_id — Compensation record must reference the employee it applies to.',
    `employment_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `full_time|part_time|contractor|temp|intern`',
    `end_date` DATE COMMENT 'The end date associated with the compensation workforce record.',
    `equity_amount` DECIMAL(18,2) COMMENT 'The equity amount of the compensation record in the workforce domain.',
    `equity_grant_amount` DECIMAL(18,2) COMMENT 'Monetary value of equity granted.',
    `equity_grant_eligibility` BOOLEAN COMMENT 'Indicates if the employee is eligible for equity grants.',
    `equity_grant_value` DECIMAL(18,2) COMMENT 'The equity grant value of the compensation record in the workforce domain.',
    `health_insurance_eligibility` BOOLEAN COMMENT 'Eligibility for health insurance benefits.',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this record reflects the employees current compensation.',
    `job_title` STRING COMMENT 'Employees job title associated with this compensation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the compensation record in the workforce domain.',
    `location_code` STRING COMMENT 'Code of the fab or site where the employee works.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the compensation record in the workforce domain.',
    `compensation_name` STRING COMMENT 'Descriptive name of the compensation plan or record.',
    `nre_project_code` STRING COMMENT 'Identifier of the NRE project associated with this compensation, if applicable.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime pay.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for overtime hours.',
    `pay_frequency` STRING COMMENT 'Frequency at which base compensation is paid.. Valid values are `monthly|biweekly|weekly|annually|quarterly`',
    `pay_grade` STRING COMMENT 'Internal pay grade or band assigned to the employee.',
    `payroll_group` STRING COMMENT 'Payroll group classification for processing.',
    `reason_code` STRING COMMENT 'Reason for change',
    `retirement_plan_eligibility` BOOLEAN COMMENT 'Eligibility for company retirement plan.',
    `review_date` DATE COMMENT 'Date of the most recent compensation review.',
    `salary_grade` STRING COMMENT 'The salary grade of the compensation record in the workforce domain.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional pay amount for non-standard shifts.',
    `shift_type` STRING COMMENT 'Classification of the shift for which differential applies.. Valid values are `night|weekend|holiday|flex|standard`',
    `tax_exempt` BOOLEAN COMMENT 'Indicates if compensation is tax-exempt for the employee.',
    `union_member` BOOLEAN COMMENT 'Indicates if the employee is a union member.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation record.',
    `variable_compensation_actual` DECIMAL(18,2) COMMENT 'Actual amount paid for variable compensation.',
    `variable_compensation_target` DECIMAL(18,2) COMMENT 'Target amount for variable compensation components.',
    `created_by` STRING COMMENT 'User or system that created the compensation record.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Employee compensation master record capturing the current and historical compensation details for semiconductor workforce. Tracks base salary, pay grade, pay frequency, currency, effective date, compensation plan type (salary, hourly, variable), bonus target percentage, equity grant eligibility, and shift differential pay for fab operators on non-standard shifts. Supports labor cost allocation to FAB cost centers, NRE project costing, and compensation benchmarking against semiconductor industry surveys.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique surrogate key for each time entry record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Every time entry must reference the employee who worked the hours. Fundamental for labor cost allocation.',
    `location_id` BIGINT COMMENT 'Identifier of the fab or site where the work was performed.',
    `primary_time_employee_id` BIGINT COMMENT 'Unique identifier of the employee who logged the time.',
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record within the time entry workforce entity.',
    `tertiary_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Time entries must reference the employee who worked the hours. Critical for labor cost allocation.',
    `time_approved_by_employee_id` BIGINT COMMENT 'Unique identifier for the time approved by employee record within the time entry workforce entity.',
    `absence_duration_hours` DECIMAL(18,2) COMMENT 'Number of hours attributed to the recorded absence.',
    `absence_type` STRING COMMENT 'Classification of the absence recorded for the employee.. Valid values are `none|vacation|sick|fmla|parental|military`',
    `approval_status` STRING COMMENT 'Current state of the time entry in the approval process.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The approved by of the time entry record in the workforce domain.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time the entry received approval.',
    `billing_status` STRING COMMENT 'Current financial posting state of the labor cost.. Valid values are `unbilled|billed|invoiced`',
    `clock_in_time` TIMESTAMP COMMENT 'The clock in time of the time entry record in the workforce domain.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact moment the employee started the shift or activity.',
    `clock_out_time` TIMESTAMP COMMENT 'The clock out time of the time entry record in the workforce domain.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact moment the employee ended the shift or activity.',
    `comments` STRING COMMENT 'Additional notes or remarks about the time entry.',
    `compliance_flag` STRING COMMENT 'Indicates whether the entry meets applicable labor law and safety compliance.. Valid values are `compliant|non_compliant`',
    `cost_center` STRING COMMENT 'Cost center charged',
    `cost_center_code` STRING COMMENT 'Financial cost center to which labor cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the time entry record in the workforce domain.',
    `end_time` TIMESTAMP COMMENT 'The end time of the time entry record in the workforce domain.',
    `entry_date` DATE COMMENT 'The entry date associated with the time entry workforce record.',
    `entry_source` STRING COMMENT 'Method by which the time entry was captured.. Valid values are `manual|system|mobile`',
    `entry_type` STRING COMMENT 'The entry type of the time entry record in the workforce domain.',
    `hours_worked` DECIMAL(18,2) COMMENT 'The hours worked of the time entry record in the workforce domain.',
    `is_billable` BOOLEAN COMMENT 'True if labor cost should be charged to a customer project.',
    `labor_amount` DECIMAL(18,2) COMMENT 'Monetary value of labor for the entry, used for cost posting.',
    `labor_category` STRING COMMENT 'Classification of labor type for cost allocation and reporting.. Valid values are `production|engineering|support|maintenance|admin|other`',
    `labor_grade` STRING COMMENT 'Pay band or grade associated with the employee for compensation rules.. Valid values are `G1|G2|G3|G4|G5|G6`',
    `labor_rate` DECIMAL(18,2) COMMENT 'Standard hourly cost rate for the employees labor category.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the time entry record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the time entry record in the workforce domain.',
    `notes` STRING COMMENT 'The notes of the time entry record in the workforce domain.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked, subject to overtime multiplier.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Factor (e.g., 1.5) used to calculate overtime pay.',
    `project_code` STRING COMMENT 'Identifier of the engineering or NRE project to which the labor is charged.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the time entry.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of standard (non‑overtime) hours worked.',
    `scheduled_shift_end` TIMESTAMP COMMENT 'Planned end time for the employees shift.',
    `scheduled_shift_start` TIMESTAMP COMMENT 'Planned start time for the employees shift.',
    `shift_code` STRING COMMENT 'Identifier of the shift schedule (e.g., A‑shift, B‑shift).. Valid values are `A|B|C|D|E|F`',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Hours worked during a shift that carries a differential premium.',
    `start_time` TIMESTAMP COMMENT 'The start time of the time entry record in the workforce domain.',
    `time_entry_type` STRING COMMENT 'Denotes whether the record represents regular work, an absence, or an adjustment.. Valid values are `regular|absence|adjustment`',
    `time_type` STRING COMMENT 'Regular/Overtime/PTO',
    `union_member` BOOLEAN COMMENT 'True if the employee is a member of a labor union, affecting overtime rules.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the time entry record in the workforce domain.',
    `work_date` DATE COMMENT 'Calendar date for which the time entry applies.',
    `work_order_code` STRING COMMENT 'Identifier of the manufacturing work order or production order associated with the labor.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Transactional time, attendance, and absence management record capturing all hours worked and not worked by semiconductor employees and contractors. Tracks work date, clock-in/clock-out timestamps, regular hours, overtime hours, shift differential hours, work order or project code (for NRE project labor tracking), cost center, and approval status. Also captures planned and unplanned absences (Vacation, Sick Leave, FMLA, Parental Leave, Military Leave) with absence type, duration, and impact on shift coverage. Critical for FAB labor cost allocation to wafer lot WIP, NRE project billing, 24/7 shift coverage planning, and compliance with labor regulations. Integrates with SAP CO for cost center labor posting.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`training` (
    `training_id` BIGINT COMMENT 'Primary key for training',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary employee record within the training workforce entity.',
    `primary_training_course_id` BIGINT COMMENT 'Unique identifier for the primary training course record within the training workforce entity.',
    `primary_training_employee_id` BIGINT COMMENT 'Unique identifier of the employee who is enrolled in the training.',
    `tertiary_training_trainer_employee_id` BIGINT COMMENT 'Identifier of the trainer or instructor delivering the course.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course from the catalog.',
    `assessment_max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for the assessment.',
    `assessment_pass_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the assessment.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment, expressed as a percentage.',
    `assessment_type` STRING COMMENT 'Type of assessment used to evaluate the employees learning.. Valid values are `Quiz|Practical|Exam`',
    `training_category` STRING COMMENT 'High‑level classification of the training (e.g., Technical, Safety, Leadership).. Valid values are `Technical|Process|Safety|Leadership|Compliance|Quality`',
    `certificate_number` STRING COMMENT 'The certificate number of the training record in the workforce domain.',
    `completion_date` DATE COMMENT 'Date the employee completed the training (if completed).',
    `compliance_deadline` DATE COMMENT 'Date by which the employee must complete the training to satisfy regulatory or internal requirements.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance regime that mandates the training.. Valid values are `ITAR|ISO9001|IATF16949|None`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `delivery_mode` STRING COMMENT 'Method by which the training is delivered to the employee.. Valid values are `Online|In-Person|Hybrid|On-The-Job`',
    `enrollment_date` DATE COMMENT 'Date the employee was enrolled in the training.',
    `enrollment_number` STRING COMMENT 'Business identifier assigned to the enrollment, used for tracking and reporting.',
    `expiration_date` DATE COMMENT 'Date when the training certification expires and must be renewed.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the training workforce record.',
    `instructor_name` STRING COMMENT 'The instructor name of the training record in the workforce domain.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the enrollment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the training record in the workforce domain.',
    `location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training is required for the employees role or compliance.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the training record in the workforce domain.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the enrollment.',
    `pass_fail_result` STRING COMMENT 'The pass fail result of the training record in the workforce domain.',
    `pass_fail_status` STRING COMMENT 'Result of the assessment indicating whether the employee passed, failed, or has not yet completed the assessment.. Valid values are `Pass|Fail|Incomplete`',
    `pass_flag` BOOLEAN COMMENT 'The pass flag of the training record in the workforce domain.',
    `recurrence_interval` STRING COMMENT 'How often the training must be repeated to stay current (e.g., Annual).. Valid values are `Annual|Biennial|None`',
    `score` DECIMAL(18,2) COMMENT 'The score of the training record in the workforce domain.',
    `training_location` STRING COMMENT 'The training location of the training record in the workforce domain.',
    `training_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `Enrolled|InProgress|Completed|Cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Unified training management product for semiconductor workforce combining the training course catalog with employee enrollment and completion records. Course catalog captures course definitions, training categories (Technical/Process, EDA Tools, Safety/EHS, Quality/SPC, Export Control/ITAR, Leadership, Compliance), delivery modes, passing criteria, mandatory flags, regulatory linkages, and recurrence intervals. Enrollment records capture employee enrollment date, completion date, assessment score, pass/fail status, delivery location, and compliance deadline. Critical for ITAR/EAR export control compliance, ISO 9001/IATF 16949 quality system requirements, and fab operator process qualification sign-off.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` (
    `fab_operator_qualification_id` BIGINT COMMENT 'System generated unique identifier for each fab operator qualification record.',
    `competency_id` BIGINT COMMENT 'Unique identifier for the competency record within the fab operator qualification workforce entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Fab operator qualifications must reference the operator/employee. Gates MES work order assignment.',
    `fab_assessor_employee_id` BIGINT COMMENT 'Unique identifier for the fab assessor employee record within the fab operator qualification workforce entity.',
    `fab_facility_id` BIGINT COMMENT 'add column fab_facility_id (BIGINT) with FK to fabrication.fab_facility.fab_facility_id - operator qualifications are facility specific',
    `fab_tool_id` BIGINT COMMENT 'Restricted identifier of the fab tool or equipment for which the operator is qualified.',
    `location_id` BIGINT COMMENT 'Identifier of the fab site or cleanroom where the qualification applies.',
    `primary_fab_employee_id` BIGINT COMMENT 'Restricted identifier of the fab operator or technician who holds the qualification.',
    `skill_id` BIGINT COMMENT 'Unique identifier for the skill record within the fab operator qualification workforce entity.',
    `tertiary_fab_operator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `certification_document_name` STRING COMMENT 'File name or title of the attached certification document.',
    `certified_by` STRING COMMENT 'The certified by of the fab operator qualification record in the workforce domain.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the qualification (e.g., ISO 9001, ITAR).. Valid values are `ISO9001|ITAR|EAR|RoHS|REACH`',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the fab operator qualification record in the workforce domain.',
    `equipment_group_code` STRING COMMENT 'Coded value representing the equipment group code of the fab operator qualification workforce record.',
    `equipment_name` STRING COMMENT 'Human‑readable name of the equipment (e.g., "EUV Scanner 1A").',
    `expiry_date` DATE COMMENT 'The expiry date associated with the fab operator qualification workforce record.',
    `fab_qualified_operator` BIGINT COMMENT 'FK to workforce.employee.employee_id — Fab operator qualifications must reference the employee/operator. Gates MES work order assignment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the fab operator qualification record in the workforce domain.',
    `last_requalification_date` DATE COMMENT 'Date of the most recent re‑qualification, if any.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the fab operator qualification record in the workforce domain.',
    `notes` STRING COMMENT 'Additional remarks, observations, or special instructions related to the qualification.',
    `process_area` STRING COMMENT 'The process area of the fab operator qualification record in the workforce domain.',
    `process_step_code` STRING COMMENT 'Standard code for the semiconductor process step (e.g., "EUV_EXPOSE", "CMP_POLISH").',
    `process_step_description` STRING COMMENT 'Verbose description of the process step associated with the qualification.',
    `qualification_code` STRING COMMENT 'Unique alphanumeric code assigned to the qualification record for reference in MES and PLM systems.',
    `qualification_date` DATE COMMENT 'Date the operator successfully completed the qualification.',
    `qualification_level` STRING COMMENT 'Level indicating depth of competence: Trainee, Qualified, or Senior Qualified.. Valid values are `trainee|qualified|senior_qualified`',
    `qualification_name` STRING COMMENT 'Human‑readable name describing the qualification, e.g., "EUV Lithography Exposure – Level 2".',
    `qualification_status` STRING COMMENT 'Current lifecycle state of the qualification.. Valid values are `active|suspended|revoked|expired`',
    `qualification_type` STRING COMMENT 'Category of qualification – e.g., Process, Equipment, Safety, or Quality.',
    `qualification_validity_years` STRING COMMENT 'Number of years the qualification remains valid from the qualification date.',
    `qualified_date` DATE COMMENT 'The qualified date associated with the fab operator qualification workforce record.',
    `quinary_fab_qual_employee` BIGINT COMMENT 'FK to workforce.employee.employee_id — Fab operator qualification must reference the qualified operator. Gates MES work order assignment.',
    `recertification_due_date` DATE COMMENT 'The recertification due date associated with the fab operator qualification workforce record.',
    `recertification_required_flag` BOOLEAN COMMENT 'The recertification required flag of the fab operator qualification record in the workforce domain.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `related_competency` BIGINT COMMENT 'FK to workforce.employee_skill.employee_skill_id — Fab operator qualifications relate to the broader competency/skill framework for the operator.',
    `requalification_due_date` DATE COMMENT 'Date by which the operator must be re‑qualified to retain authorization.',
    `requalification_required_flag` BOOLEAN COMMENT 'Requalification needed',
    `shift_qualification` STRING COMMENT 'Indicates which work shifts the operator is qualified for.. Valid values are `day|night|both`',
    `skill_category` STRING COMMENT 'Broad skill area associated with the qualification (e.g., Lithography, CMP, Metrology).',
    `suspension_flag` BOOLEAN COMMENT 'Indicates whether the qualification is currently suspended.',
    `suspension_reason` STRING COMMENT 'Free‑text explanation for why the qualification was suspended.',
    `training_hours` STRING COMMENT 'Total number of training hours completed for this qualification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the fab operator qualification record in the workforce domain.',
    CONSTRAINT pk_fab_operator_qualification PRIMARY KEY(`fab_operator_qualification_id`)
) COMMENT 'Semiconductor-specific operational qualification record certifying that a fab operator or technician is authorized to perform specific process steps or operate specific equipment in the cleanroom. Captures operator employee reference, qualified process step (e.g., EUV Lithography Exposure, CMP Polish, CVD Deposition, Ion Implantation), qualified equipment tool ID, qualification date, qualified-by supervisor, qualification level (Trainee, Qualified, Senior Qualified), requalification due date, and suspension flag. Directly gates MES work order assignment in Camstar/SmartFactory.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` (
    `site_assignment_id` BIGINT COMMENT 'Primary key for site_assignment',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary employee record within the site assignment workforce entity.',
    `primary_site_employee_id` BIGINT COMMENT 'Unique identifier of the employee (person) assigned to the site.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the shift schedule applied to this assignment.',
    `site_id` BIGINT COMMENT 'Unique identifier of the fab, design centre, or office location.',
    `access_card_number` STRING COMMENT 'Identifier of the physical access card issued for site entry.',
    `access_level` STRING COMMENT 'The access level of the site assignment record in the workforce domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Portion of the employees time allocated to this site (0‑100%).',
    `assignment_code` STRING COMMENT 'Internal code used to reference the assignment in HR and operational systems.',
    `assignment_end_date` DATE COMMENT 'The assignment end date associated with the site assignment workforce record.',
    `assignment_name` STRING COMMENT 'Human‑readable name for the assignment (e.g., "Fab A – Process Engineer").',
    `assignment_reason` STRING COMMENT 'Business justification for the assignment (e.g., project support, capacity fill, skill development).',
    `assignment_start_date` DATE COMMENT 'The assignment start date associated with the site assignment workforce record.',
    `assignment_status` STRING COMMENT 'The assignment status of the site assignment record in the workforce domain.',
    `assignment_type` STRING COMMENT 'Classification of the assignment (permanent, temporary rotation, or project‑based secondment).. Valid values are `permanent|temporary|project_based`',
    `badge_number` STRING COMMENT 'The badge number of the site assignment record in the workforce domain.',
    `building_code` STRING COMMENT 'Coded value representing the building code of the site assignment workforce record.',
    `cleanroom_access_level` STRING COMMENT 'Authorized cleanroom access tier for the employee at this site.. Valid values are `level1|level2|level3|none`',
    `compliance_training_completed` BOOLEAN COMMENT 'Indicates whether required compliance training has been finished for this site.',
    `compliance_training_date` DATE COMMENT 'Date on which compliance training was completed.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center to which labor costs for this assignment are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the assignment ends or is scheduled to end; null for open‑ended assignments.',
    `effective_start_date` DATE COMMENT 'Date on which the assignment becomes active.',
    `end_date` DATE COMMENT 'The end date associated with the site assignment workforce record.',
    `floor_level` STRING COMMENT 'The floor level of the site assignment record in the workforce domain.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'Planned weekly work hours for the assignment.',
    `is_primary_site` BOOLEAN COMMENT 'The is primary site of the site assignment record in the workforce domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the site assignment record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the site assignment record in the workforce domain.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special conditions.',
    `payroll_grade` STRING COMMENT 'Payroll grade or band applicable to the employee for this assignment.',
    `primary_site_flag` BOOLEAN COMMENT 'Indicates whether this site is the employees primary work location (True) or a secondary assignment (False).',
    `remote_work_allowed` BOOLEAN COMMENT 'Flag indicating if the employee may perform duties remotely for this assignment.',
    `safety_induction_completed` BOOLEAN COMMENT 'Indicates whether the employee has completed site‑specific safety induction.',
    `safety_induction_date` DATE COMMENT 'Date on which the safety induction was completed.',
    `site_assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|pending|terminated`',
    `start_date` DATE COMMENT 'The start date associated with the site assignment workforce record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `work_shift` STRING COMMENT 'Standard shift designation for the assignment.. Valid values are `day|night|swing`',
    CONSTRAINT pk_site_assignment PRIMARY KEY(`site_assignment_id`)
) COMMENT 'Master record capturing the assignment of semiconductor employees to specific fab sites, design centers, or office locations. Tracks primary work site (fab name, design center, office), secondary site assignments for multi-site roles, effective start and end dates, assignment type (Permanent, Temporary Rotation, Project-Based Secondment), cleanroom access authorization level, and site-specific safety induction completion status. Supports multi-site workforce deployment for engineers supporting multiple FAB nodes or design centers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` (
    `contractor_engagement_id` BIGINT COMMENT 'System-generated unique identifier for the contractor engagement record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the contractor employee record within the contractor engagement workforce entity.',
    `org_unit_id` BIGINT COMMENT 'FK to workforce.org_unit.org_unit_id — Contractor engagements must reference the org unit they are assigned to for cost allocation and management.',
    `primary_contractor_employee_id` BIGINT COMMENT 'Unique identifier for the primary contractor employee record within the contractor engagement workforce entity.',
    `primary_org_unit_id` BIGINT COMMENT 'FK to workforce.org_unit.org_unit_id — Contractors are engaged by specific org units. Required for contingent workforce management and cost allocation.',
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record within the contractor engagement workforce entity.',
    `agency_name` STRING COMMENT 'Name of the staffing or recruiting agency providing the contractor.',
    `background_check_status` STRING COMMENT 'Result of the contractors background screening.. Valid values are `cleared|pending|failed|exempt`',
    `bill_rate` DECIMAL(18,2) COMMENT 'The bill rate of the contractor engagement record in the workforce domain.',
    `billing_rate` DECIMAL(18,2) COMMENT 'Hourly or daily billing rate agreed for the contractor.',
    `cleanroom_access_authorization` STRING COMMENT 'Authorization status for contractor to access cleanroom environments.. Valid values are `granted|pending|denied`',
    `compliance_notes` STRING COMMENT 'Free-text field for any additional compliance-related observations.',
    `contract_effective_from` TIMESTAMP COMMENT 'Exact timestamp when the contract became effective.',
    `contract_effective_until` TIMESTAMP COMMENT 'Exact timestamp when the contract expires or is terminated.',
    `contract_end_date` DATE COMMENT 'Date when the contractor engagement is scheduled to end.',
    `contract_manager` STRING COMMENT 'Name of the internal employee responsible for managing the contractor agreement.',
    `contract_number` STRING COMMENT 'Unique identifier assigned to the contractor agreement.',
    `contract_start_date` DATE COMMENT 'Date when the contractor engagement becomes effective.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contractor agreement.. Valid values are `draft|active|suspended|terminated|expired`',
    `contractor_address` STRING COMMENT 'Physical address of the contractor for correspondence.',
    `contractor_email` STRING COMMENT 'Primary email address for contractor communication.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contractor_engagement_status` STRING COMMENT 'Active/Completed/Terminated',
    `contractor_name` STRING COMMENT 'Legal full name of the contractor individual or organization.',
    `contractor_phone` STRING COMMENT 'Primary contact phone number for the contractor.',
    `contractor_type` STRING COMMENT 'Indicates whether the contractor is an individual consultant or a corporate entity.. Valid values are `individual|organization`',
    `cost_center` STRING COMMENT 'The cost center of the contractor engagement record in the workforce domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor engagement record was created in the system.',
    `currency` STRING COMMENT 'The currency of the contractor engagement record in the workforce domain.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for billing.. Valid values are `[A-Z]{3}`',
    `end_date` DATE COMMENT 'The end date associated with the contractor engagement workforce record.',
    `engagement_number` STRING COMMENT 'The engagement number of the contractor engagement record in the workforce domain.',
    `engagement_status` STRING COMMENT 'The engagement status of the contractor engagement record in the workforce domain.',
    `engagement_type` STRING COMMENT 'Category of contractor engagement model.. Valid values are `staff_augmentation|sow_based|managed_service`',
    `export_control_cleared` BOOLEAN COMMENT 'The export control cleared of the contractor engagement record in the workforce domain.',
    `export_control_status` STRING COMMENT 'Status of ITAR/EAR export control screening for the contractor.. Valid values are `cleared|pending|failed|exempt`',
    `fab_site` STRING COMMENT 'Location/fab where the contractor will work.',
    `headcount_classification` STRING COMMENT 'Whether the contractor headcount is recorded on or off the companys balance sheet.. Valid values are `on_balance_sheet|off_balance_sheet`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly rate of the contractor engagement record in the workforce domain.',
    `invoice_frequency` STRING COMMENT 'How often invoices are issued for the contractor services.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `is_ear_contract` BOOLEAN COMMENT 'Indicates whether the contract is subject to EAR regulations.',
    `is_it_ar_contract` BOOLEAN COMMENT 'Indicates whether the contract is subject to ITAR regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the contractor engagement record in the workforce domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contractor engagement record.',
    `max_hours_per_week` DECIMAL(18,2) COMMENT 'The max hours per week of the contractor engagement record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the contractor engagement record in the workforce domain.',
    `nda_signed_flag` BOOLEAN COMMENT 'NDA signed',
    `nda_status` STRING COMMENT 'Current status of the Non-Disclosure Agreement with the contractor.. Valid values are `signed|pending|exempt|revoked`',
    `payment_terms` STRING COMMENT 'Terms governing payment schedule and invoicing for the contractor.',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order linked to the contractor engagement.',
    `renewal_option` STRING COMMENT 'Indicates if the contract includes an automatic renewal clause.. Valid values are `auto|manual|none`',
    `risk_assessment_score` STRING COMMENT 'Numeric score representing the risk level of the contractor engagement.',
    `start_date` DATE COMMENT 'The start date associated with the contractor engagement workforce record.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination of the contractor engagement.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract over its term.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the contractor engagement record in the workforce domain.',
    CONSTRAINT pk_contractor_engagement PRIMARY KEY(`contractor_engagement_id`)
) COMMENT 'Master record managing contingent workforce and contractor engagements for semiconductor operations. Captures contractor name, agency name, contract start and end dates, engagement type (Staff Augmentation, SOW-Based, Managed Service), assigned org unit and fab site, billing rate, purchase order reference, NDA status, background check status, export control screening status (ITAR/EAR), cleanroom access authorization, and headcount classification (on-balance-sheet vs off-balance-sheet). Tracks the significant contractor population in semiconductor fabs and design centers.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` (
    `cleanroom_access_id` BIGINT COMMENT 'Unique identifier for the cleanroom access record.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Cleanroom access authorization must reference the employee/contractor granted access.',
    `fab_facility_id` BIGINT COMMENT 'add column fab_facility_id (BIGINT) with FK to fabrication.fab_facility.fab_facility_id - cleanroom access is granted per facility',
    `fab_site_id` BIGINT COMMENT 'Identifier of the fab site where the cleanroom is located.',
    `primary_cleanroom_employee_id` BIGINT COMMENT 'Unique identifier of the employee or contractor granted cleanroom access.',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the cleanroom access workforce entity.',
    `to_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Cleanroom access records must reference the employee/contractor granted access.',
    `access_expiry_date` DATE COMMENT 'The access expiry date associated with the cleanroom access workforce record.',
    `access_granted_date` DATE COMMENT 'The access granted date associated with the cleanroom access workforce record.',
    `access_level` STRING COMMENT 'Access level granted defining permissible activities within the cleanroom.. Valid values are `Level 1|Level 2|Level 3|Level 4`',
    `access_status` STRING COMMENT 'The access status of the cleanroom access record in the workforce domain.',
    `authorization_date` DATE COMMENT 'The authorization date associated with the cleanroom access workforce record.',
    `badge_number` STRING COMMENT 'The badge number of the cleanroom access record in the workforce domain.',
    `cleanroom_access_status` STRING COMMENT 'Current lifecycle status of the cleanroom access record.. Valid values are `active|revoked|expired|pending`',
    `cleanroom_class` STRING COMMENT 'The cleanroom class of the cleanroom access record in the workforce domain.',
    `cleanroom_employee` BIGINT COMMENT 'FK to workforce.employee.employee_id — Cleanroom access authorization must reference the employee/contractor granted access.',
    `cleanroom_zone` STRING COMMENT 'The cleanroom zone of the cleanroom access record in the workforce domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the access record was initially created.',
    `ehs_clearance_status` BOOLEAN COMMENT 'Indicates if Environmental Health and Safety clearance is approved for the employee.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the cleanroom access workforce record.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Timestamp when the cleanroom access expires.',
    `export_control_category` STRING COMMENT 'Export control category applicable to the individual under ITAR/EAR.. Valid values are `EAR|ITAR|None`',
    `fab_area` STRING COMMENT 'The fab area of the cleanroom access record in the workforce domain.',
    `foreign_national` BOOLEAN COMMENT 'Indicates if the employee is a foreign national subject to export control regulations.',
    `gowning_certification_date` DATE COMMENT 'The gowning certification date associated with the cleanroom access workforce record.',
    `gowning_certification_flag` BOOLEAN COMMENT 'The gowning certification flag of the cleanroom access record in the workforce domain.',
    `gowning_certification_status` STRING COMMENT 'The gowning certification status of the cleanroom access record in the workforce domain.',
    `gowning_qualified_flag` BOOLEAN COMMENT 'Gowning qualified',
    `grant_timestamp` TIMESTAMP COMMENT 'Timestamp when the cleanroom access was granted.',
    `granted_date` DATE COMMENT 'The granted date associated with the cleanroom access workforce record.',
    `is_temporary` BOOLEAN COMMENT 'Indicates if the granted access is temporary (e.g., for a specific project or time window).',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this access record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the cleanroom access record in the workforce domain.',
    `medical_clearance_flag` BOOLEAN COMMENT 'Medical clearance',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the cleanroom access record in the workforce domain.',
    `notes` STRING COMMENT 'Free-form notes or comments related to the cleanroom access.',
    `project_code` STRING COMMENT 'Code of the project or design requiring the cleanroom access.',
    `qualification_status` STRING COMMENT 'Gowning qualification status of the personnel for cleanroom entry.. Valid values are `Qualified|Not Qualified|Pending`',
    `revocation_reason` STRING COMMENT 'Reason provided for revoking the cleanroom access.',
    `revocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the cleanroom access was revoked, if applicable.',
    `safety_induction_completed` BOOLEAN COMMENT 'Indicates if the employee has completed the required safety induction.',
    `training_completed_flag` BOOLEAN COMMENT 'Training completed',
    `training_completion_date` DATE COMMENT 'Date when required cleanroom training was completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the access record.',
    `zone` STRING COMMENT 'Designated cleanroom zone for the access grant.. Valid values are `FEOL|BEOL|MOL|Metrology|Packaging`',
    CONSTRAINT pk_cleanroom_access PRIMARY KEY(`cleanroom_access_id`)
) COMMENT 'Transactional record managing cleanroom access authorization for semiconductor fab personnel. Captures employee or contractor reference, fab site, cleanroom zone (FEOL, BEOL, MOL, Metrology, Packaging), access level granted, gowning qualification status, access grant date, expiry date, access revocation date and reason, safety induction completion, and EHS clearance status. Cleanroom access is strictly controlled in semiconductor fabs due to contamination risk, safety requirements, and export control restrictions on foreign nationals.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` (
    `export_control_id` BIGINT COMMENT 'Primary key for export_control',
    `employee_id` BIGINT COMMENT 'Unique identifier for the export employee record within the export control workforce entity.',
    `export_technology_control_plan_id` BIGINT COMMENT 'Unique identifier for the export technology control plan record within the export control workforce entity.',
    `primary_export_employee_id` BIGINT COMMENT 'Internal identifier of the employee or contractor being screened.',
    `technology_control_plan_id` BIGINT COMMENT 'Technology access plan',
    `authorization_expiry_date` DATE COMMENT 'Authorization expiry',
    `authorized_technology_areas` STRING COMMENT 'Comma‑separated list of technology domains the individual is cleared to access.',
    `authorized_technology_scope` STRING COMMENT 'The authorized technology scope of the export control record in the workforce domain.',
    `citizenship_country` STRING COMMENT 'The citizenship country of the export control record in the workforce domain.',
    `classification` STRING COMMENT 'Classification of the individual under US export control rules.. Valid values are `US_Person|Foreign_National|Deemed_Export_Risk`',
    `control_status` STRING COMMENT 'The control status of the export control record in the workforce domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the export control record in the workforce domain.',
    `deemed_export_authorization` STRING COMMENT 'The deemed export authorization of the export control record in the workforce domain.',
    `deemed_export_flag` BOOLEAN COMMENT 'The deemed export flag of the export control record in the workforce domain.',
    `deemed_export_license_required` BOOLEAN COMMENT 'The deemed export license required of the export control record in the workforce domain.',
    `ear_eligible` BOOLEAN COMMENT 'The ear eligible of the export control record in the workforce domain.',
    `ear_license_required` BOOLEAN COMMENT 'Indicates whether an EAR export license is required for the individuals access.',
    `ear_license_status` STRING COMMENT 'Current status of any required EAR license.. Valid values are `Licensed|Not_Licensed|Pending`',
    `eccn_code` STRING COMMENT 'Coded value representing the eccn code of the export control workforce record.',
    `employee_phone` STRING COMMENT 'Contact telephone number for the employee or contractor.',
    `expiry_date` DATE COMMENT 'The expiry date associated with the export control workforce record.',
    `export_control_status` STRING COMMENT 'Current lifecycle status of the screening record.. Valid values are `active|inactive|archived`',
    `itar_authorization_status` STRING COMMENT 'Current ITAR authorization state for the individual.. Valid values are `Authorized|Not_Authorized|Pending`',
    `itar_eligible` BOOLEAN COMMENT 'The itar eligible of the export control record in the workforce domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the export control record in the workforce domain.',
    `license_number` STRING COMMENT 'The license number of the export control record in the workforce domain.',
    `license_required_flag` BOOLEAN COMMENT 'The license required flag of the export control record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the export control record in the workforce domain.',
    `nationality` STRING COMMENT 'Country of citizenship or permanent residence, expressed as ISO 3166‑1 alpha‑3 code.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the screening.',
    `periodic_rescreening_due_date` DATE COMMENT 'Date by which the next mandatory export control rescreening must be completed.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the screening record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the screening record.',
    `restricted_technology_list` STRING COMMENT 'Restricted technologies',
    `review_date` DATE COMMENT 'The review date associated with the export control workforce record.',
    `screening_conducted_by` STRING COMMENT 'Name of the compliance officer or system that performed the screening.',
    `screening_date` DATE COMMENT 'Date on which the export control screening was performed.',
    `screening_outcome` STRING COMMENT 'Result of the export control screening.. Valid values are `Pass|Fail|Conditional|Pending`',
    `screening_result` STRING COMMENT 'Clear/Flagged/Denied',
    `screening_status` STRING COMMENT 'The screening status of the export control record in the workforce domain.',
    `technology_access_restrictions` STRING COMMENT 'Narrative description of any technology access limitations imposed on the individual.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the export control record in the workforce domain.',
    `visa_type` STRING COMMENT 'Type of work visa held by the employee, if applicable.. Valid values are `H1B|L1|O1|TN|E3|Other`',
    CONSTRAINT pk_export_control PRIMARY KEY(`export_control_id`)
) COMMENT 'Export control compliance screening record for semiconductor workforce personnel tracking ITAR and EAR authorization status. Captures employee or contractor nationality, visa type, export control classification (US Person, Foreign National, Deemed Export Risk), ITAR authorization status, EAR license requirement flag, technology access restrictions, screening date, screening outcome, authorized technology areas, and periodic re-screening due date. Critical for semiconductor companies handling controlled technology under ITAR and EAR regulations governing advanced IC design and fab processes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` (
    `safety_event_id` BIGINT COMMENT 'Primary key for safety_event',
    `fab_facility_id` BIGINT COMMENT 'add column fab_facility_id (BIGINT) with FK to fabrication.fab_facility.fab_facility_id - safety events occur at specific facilities',
    `fab_site_id` BIGINT COMMENT 'Identifier of the fab site where the incident took place.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the org unit record within the safety event workforce entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee directly impacted by the incident.',
    `safety_employee_id` BIGINT COMMENT 'Unique identifier for the safety employee record within the safety event workforce entity.',
    `safety_reported_by_employee_id` BIGINT COMMENT 'Unique identifier for the safety reported by employee record within the safety event workforce entity.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the work shift during which the incident occurred.',
    `site_id` BIGINT COMMENT 'Unique identifier for the site record within the safety event workforce entity.',
    `chemical_involved` STRING COMMENT 'Chemical involved if any',
    `cleanroom_zone` STRING COMMENT 'Specific cleanroom zone or area within the fab where the incident occurred.',
    `corrective_action` STRING COMMENT 'Planned or executed corrective actions to prevent recurrence.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost associated with the incident (medical, lost productivity, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `safety_event_description` STRING COMMENT 'Narrative description of what happened, including context and observations.',
    `event_date` DATE COMMENT 'The event date associated with the safety event workforce record.',
    `event_description` STRING COMMENT 'The event description of the safety event record in the workforce domain.',
    `event_number` STRING COMMENT 'The event number of the safety event record in the workforce domain.',
    `event_status` STRING COMMENT 'The event status of the safety event record in the workforce domain.',
    `event_type` STRING COMMENT 'The event type of the safety event record in the workforce domain.',
    `exposure_chemical` STRING COMMENT 'Name of the chemical involved in a chemical exposure incident.',
    `exposure_level` STRING COMMENT 'Severity level of chemical exposure.. Valid values are `low|medium|high|unknown`',
    `incident_status` STRING COMMENT 'Overall status of the incident record.. Valid values are `open|closed|reopened`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the safety incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the safety incident.. Valid values are `chemical_exposure|ergonomic_injury|electrical_hazard|slip_fall|near_miss|other`',
    `injury_body_part` STRING COMMENT 'Body part(s) injured, if applicable.',
    `injury_type` STRING COMMENT 'Medical classification of the injury (e.g., laceration, burn).',
    `investigation_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation was concluded.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation.. Valid values are `open|in_progress|closed`',
    `lab_name` STRING COMMENT 'Name of the laboratory (if the incident occurred in a lab environment).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the safety event record in the workforce domain.',
    `location_description` STRING COMMENT 'The location description of the safety event record in the workforce domain.',
    `lost_time_days` STRING COMMENT 'Number of work days lost due to the injury.',
    `lost_time_flag` BOOLEAN COMMENT 'The lost time flag of the safety event record in the workforce domain.',
    `medical_treatment_provided` STRING COMMENT 'Details of medical treatment administered after the incident.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the safety event record in the workforce domain.',
    `near_miss_flag` BOOLEAN COMMENT 'Indicates whether the record represents a near‑miss event.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident is recordable under OSHA regulations.',
    `regulatory_reporting_status` STRING COMMENT 'Status of required regulatory reporting (e.g., OSHA, ISO 45001).. Valid values are `not_required|pending|submitted|completed`',
    `report_date` DATE COMMENT 'Date when the incident was formally reported.',
    `reported_by` STRING COMMENT 'Name of the person who reported the incident.',
    `root_cause` STRING COMMENT 'Root cause analysis result identifying why the incident occurred.',
    `severity` STRING COMMENT 'The severity of the safety event record in the workforce domain.',
    `severity_level` STRING COMMENT 'Severity of the incident based on impact to employee health and operations.. Valid values are `first_aid|recordable|lost_time|fatality`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_safety_event PRIMARY KEY(`safety_event_id`)
) COMMENT 'Occupational health and safety incident record for semiconductor workforce capturing workplace injuries, near-misses, chemical exposures, and EHS events in fab and design center environments. Tracks incident date and time, location (fab site, cleanroom zone, lab), incident type (Chemical Exposure, Ergonomic Injury, Electrical Hazard, Slip/Fall, Near Miss), affected employee, severity level (First Aid, Recordable, Lost Time, Fatality), root cause, corrective actions, OSHA recordable flag, and regulatory reporting status. Supports ISO 45001 and OSHA compliance.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Primary key for compensation_plan',
    `employee_id` BIGINT COMMENT 'Unique identifier for the owner employee record within the compensation plan workforce entity.',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the plan within the governance workflow.',
    `base_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount associated with the plan (e.g., base salary).',
    `bonus_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to the base amount to calculate bonus payouts.',
    `bonus_target_percent` DECIMAL(18,2) COMMENT 'The bonus target percent of the compensation plan record in the workforce domain.',
    `compensation_frequency` STRING COMMENT 'How often compensation under the plan is paid or awarded.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was first created.',
    `currency` STRING COMMENT 'The currency of the compensation plan record in the workforce domain.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `department` STRING COMMENT 'Organizational department to which the plan applies.',
    `effective_end_date` DATE COMMENT 'The effective end date associated with the compensation plan workforce record.',
    `effective_from` DATE COMMENT 'Date when the compensation plan becomes effective.',
    `effective_start_date` DATE COMMENT 'The effective start date associated with the compensation plan workforce record.',
    `effective_until` DATE COMMENT 'Date when the compensation plan expires or is superseded; null for open‑ended plans.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the rules that determine employee eligibility for the plan.',
    `eligibility_grade` STRING COMMENT 'Job grade or level required for an employee to qualify for the plan.',
    `equity_eligible` BOOLEAN COMMENT 'The equity eligible of the compensation plan record in the workforce domain.',
    `equity_eligible_flag` BOOLEAN COMMENT 'Equity eligible',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the plan is currently eligible for assignment to employees.',
    `job_family` STRING COMMENT 'Broad job family classification (e.g., engineering, manufacturing, R&D) for plan applicability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the compensation plan record in the workforce domain.',
    `last_review_date` DATE COMMENT 'Date when the plan was last reviewed for compliance or market alignment.',
    `location` STRING COMMENT 'Geographic site or fab location code where the plan is valid.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum salary',
    `midpoint_salary` DECIMAL(18,2) COMMENT 'The midpoint salary of the compensation plan record in the workforce domain.',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum salary',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the compensation plan record in the workforce domain.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the compensation plan.',
    `plan_category` STRING COMMENT 'Higher‑level grouping of plans (e.g., executive, staff, hourly).',
    `plan_code` STRING COMMENT 'External business identifier or code used to reference the plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the compensation plan.',
    `plan_scope` STRING COMMENT 'Geographic or organizational scope of the plan (global, regional, site‑specific).',
    `plan_status` STRING COMMENT 'The plan status of the compensation plan record in the workforce domain.',
    `plan_type` STRING COMMENT 'Category of the plan indicating the compensation mechanism.',
    `plan_version` STRING COMMENT 'Version identifier for the plan to track revisions.',
    `salary_band_max` DECIMAL(18,2) COMMENT 'The salary band max of the compensation plan record in the workforce domain.',
    `salary_band_min` DECIMAL(18,2) COMMENT 'The salary band min of the compensation plan record in the workforce domain.',
    `target_amount` DECIMAL(18,2) COMMENT 'Target monetary amount for variable components such as bonuses or incentives.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the compensation plan record.',
    `vesting_schedule` STRING COMMENT 'Description of equity or bonus vesting timeline and conditions.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master reference table for compensation_plan. Referenced by plan_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`skill` (
    `skill_id` BIGINT COMMENT 'Primary key for skill',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for maintaining the skill definition.',
    `parent_skill_id` BIGINT COMMENT 'Self-referencing FK on skill (parent_skill_id)',
    `skill_category` STRING COMMENT 'The category of the skill record in the workforce domain.',
    `certification_required` BOOLEAN COMMENT 'The certification required of the skill record in the workforce domain.',
    `certification_required_flag` BOOLEAN COMMENT 'Certification required',
    `skill_code` STRING COMMENT 'Unique alphanumeric code used to reference the skill across systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the skill record was first created in the system.',
    `skill_description` STRING COMMENT 'Detailed textual description of the skill, its purpose and typical tasks.',
    `domain` STRING COMMENT 'Business domain or functional area where the skill is applied.',
    `effective_from` DATE COMMENT 'Date when the skill becomes valid for assignment.',
    `effective_until` DATE COMMENT 'Date when the skill is retired or no longer valid (null if open‑ended).',
    `export_control_relevant` BOOLEAN COMMENT 'The export control relevant of the skill record in the workforce domain.',
    `family` STRING COMMENT 'Higher‑level grouping of related skills (e.g., "Process Engineering").',
    `is_active` BOOLEAN COMMENT 'The is active of the skill record in the workforce domain.',
    `is_core_skill` BOOLEAN COMMENT 'True if the skill is considered core to semiconductor operations.',
    `is_critical` BOOLEAN COMMENT 'The is critical of the skill record in the workforce domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the skill record in the workforce domain.',
    `last_review_date` DATE COMMENT 'Date when the skill definition was last reviewed for relevance.',
    `skill_level` STRING COMMENT 'Beginner/Intermediate/Expert',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the skill record in the workforce domain.',
    `skill_name` STRING COMMENT 'Human‑readable name of the skill (e.g., "Lithography Process Engineer").',
    `proficiency_level` STRING COMMENT 'Numeric representation of the skill proficiency (e.g., 1‑5).',
    `proficiency_scale` STRING COMMENT 'Scale used for the proficiency_level value.',
    `skill_group` STRING COMMENT 'Sub‑group within a family for more granular classification.',
    `skill_status` STRING COMMENT 'Current lifecycle state of the skill.',
    `skill_type` STRING COMMENT 'Category that describes the nature of the skill.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., "Retired due to technology shift").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the skill record.',
    `version` STRING COMMENT 'Version string for the skill definition to support change management.',
    CONSTRAINT pk_skill PRIMARY KEY(`skill_id`)
) COMMENT 'Master reference table for skill. Referenced by skill_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`job` (
    `job_id` BIGINT COMMENT 'Primary key for job',
    `location_id` BIGINT COMMENT 'Reference to the primary fab or office location where the job is based.',
    `parent_job_id` BIGINT COMMENT 'Self-referencing FK on job (parent_job_id)',
    `primary_reports_to_job_id` BIGINT COMMENT 'Identifier of the supervisory job to which this role reports.',
    `benefits` STRING COMMENT 'Standard benefits package associated with the position (e.g., health, retirement).',
    `job_category` STRING COMMENT 'Category that classifies the job by function such as Operator, Engineer, Manager.',
    `cleanroom_access_required` BOOLEAN COMMENT 'The cleanroom access required of the job record in the workforce domain.',
    `job_code` STRING COMMENT 'Unique alphanumeric code used to reference the job across systems.',
    `compensation_band` STRING COMMENT 'Broad compensation range grouping used for budgeting and equity analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job record was first created in the system.',
    `currency` STRING COMMENT 'The currency of the job record in the workforce domain.',
    `job_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and key duties of the job.',
    `education_requirement` STRING COMMENT 'The education requirement of the job record in the workforce domain.',
    `eeo_category` STRING COMMENT 'The eeo category of the job record in the workforce domain.',
    `effective_end_date` DATE COMMENT 'Date when the job is retired or no longer available for staffing (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the job becomes active and eligible for staffing.',
    `employment_type` STRING COMMENT 'Contractual relationship of the employee to the company.',
    `exempt_flag` BOOLEAN COMMENT 'The exempt flag of the job record in the workforce domain.',
    `experience_requirement` STRING COMMENT 'The experience requirement of the job record in the workforce domain.',
    `export_control_required` BOOLEAN COMMENT 'The export control required of the job record in the workforce domain.',
    `family` STRING COMMENT 'High‑level grouping of jobs that share similar skill sets or functional area (e.g., Manufacturing, Design, Test).',
    `flsa_status` STRING COMMENT 'The flsa status of the job record in the workforce domain.',
    `grade_level` STRING COMMENT 'The grade level of the job record in the workforce domain.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Base hourly compensation for hourly‑paid positions.',
    `internal_job_code` STRING COMMENT 'Legacy identifier used by internal HR systems for cross‑system reconciliation.',
    `is_active` BOOLEAN COMMENT 'The is active of the job record in the workforce domain.',
    `is_manager` BOOLEAN COMMENT 'Flag indicating whether the job includes managerial responsibilities.',
    `job_status` STRING COMMENT 'Current lifecycle state of the job position.',
    `job_type` STRING COMMENT 'Broad type of work performed, used for reporting and workforce planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the job record in the workforce domain.',
    `job_level` STRING COMMENT 'Organizational level indicating seniority or responsibility (e.g., L1, L2, Senior).',
    `minimum_education` STRING COMMENT 'The minimum education of the job record in the workforce domain.',
    `minimum_experience_years` STRING COMMENT 'The minimum experience years of the job record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the job record in the workforce domain.',
    `opening_number` BIGINT COMMENT 'Link to the specific opening request that created this job definition.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for overtime compensation.',
    `remote_allowed` BOOLEAN COMMENT 'Flag indicating if the job can be performed remotely, fully or partially.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of mandatory certifications or clearances for the job.',
    `requirements` STRING COMMENT 'Essential qualifications, experience, and education needed for the role.',
    `responsibilities` STRING COMMENT 'Detailed list of primary duties and accountabilities for the position.',
    `salary_grade` STRING COMMENT 'Internal salary band identifier used for compensation planning.',
    `salary_max` DECIMAL(18,2) COMMENT 'The salary max of the job record in the workforce domain.',
    `salary_min` DECIMAL(18,2) COMMENT 'The salary min of the job record in the workforce domain.',
    `security_clearance_required` BOOLEAN COMMENT 'Clearance required',
    `shift_hours` STRING COMMENT 'Standard number of work hours scheduled per week for the shift.',
    `shift_type` STRING COMMENT 'Classification of the work shift pattern for the role.',
    `skill_set` STRING COMMENT 'Key technical and soft skills required to perform the job successfully.',
    `summary` STRING COMMENT 'Brief overview of the role used in job postings and internal catalogs.',
    `title` STRING COMMENT 'Official title of the position as displayed to employees and candidates.',
    `travel_percentage` DECIMAL(18,2) COMMENT 'Estimated proportion of time spent traveling for the role.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether the role requires travel away from the primary location.',
    `union_member` BOOLEAN COMMENT 'Flag showing if the employee in this role is covered by a labor union.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the job record.',
    CONSTRAINT pk_job PRIMARY KEY(`job_id`)
) COMMENT 'Master reference table for job. Referenced by internal_job_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` (
    `shift_pattern_id` BIGINT COMMENT 'Primary key for shift_pattern',
    `rotated_from_shift_pattern_id` BIGINT COMMENT 'Self-referencing FK on shift_pattern (rotated_from_shift_pattern_id)',
    `break_duration_minutes` STRING COMMENT 'Total allotted break time within the shift, expressed in minutes.',
    `shift_pattern_code` STRING COMMENT 'Short alphanumeric code used to reference the shift pattern in scheduling systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift pattern record was first created in the system.',
    `cycle_length_days` STRING COMMENT 'The cycle length days of the shift pattern record in the workforce domain.',
    `days_off` STRING COMMENT 'The days off of the shift pattern record in the workforce domain.',
    `days_on` STRING COMMENT 'The days on of the shift pattern record in the workforce domain.',
    `shift_pattern_description` STRING COMMENT 'Detailed free‑text description of the shift pattern, including any special rules.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total length of the shift in hours, including paid time.',
    `effective_from` DATE COMMENT 'Date on which the shift pattern becomes valid for scheduling.',
    `effective_until` DATE COMMENT 'Date after which the shift pattern is no longer valid (null if open‑ended).',
    `end_time` TIMESTAMP COMMENT 'Clock‑time when the shift ends (HH:MM, 24‑hour format).',
    `hours_per_shift` DECIMAL(18,2) COMMENT 'The hours per shift of the shift pattern record in the workforce domain.',
    `is_active` BOOLEAN COMMENT 'The is active of the shift pattern record in the workforce domain.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this pattern is the default for new workforce assignments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the shift pattern record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the shift pattern record in the workforce domain.',
    `shift_pattern_name` STRING COMMENT 'Human‑readable name of the shift pattern (e.g., "Day Shift", "Night Shift").',
    `night_shift_flag` BOOLEAN COMMENT 'The night shift flag of the shift pattern record in the workforce domain.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the shift pattern.',
    `pattern_code` STRING COMMENT 'Coded value representing the pattern code of the shift pattern workforce record.',
    `pattern_description` STRING COMMENT 'The pattern description of the shift pattern record in the workforce domain.',
    `pattern_name` STRING COMMENT 'The pattern name of the shift pattern record in the workforce domain.',
    `pattern_status` STRING COMMENT 'The pattern status of the shift pattern record in the workforce domain.',
    `rotation_flag` BOOLEAN COMMENT 'The rotation flag of the shift pattern record in the workforce domain.',
    `rotation_type` STRING COMMENT 'The rotation type of the shift pattern record in the workforce domain.',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'The shift duration hours of the shift pattern record in the workforce domain.',
    `shift_end_time` TIMESTAMP COMMENT 'The shift end time of the shift pattern record in the workforce domain.',
    `shift_pattern_status` STRING COMMENT 'Current lifecycle status of the shift pattern.',
    `shift_pattern_type` STRING COMMENT 'Category of the shift pattern indicating its scheduling model.',
    `shift_start_time` TIMESTAMP COMMENT 'The shift start time of the shift pattern record in the workforce domain.',
    `shift_type` STRING COMMENT 'The shift type of the shift pattern record in the workforce domain.',
    `start_time` TIMESTAMP COMMENT 'Clock‑time when the shift begins (HH:MM, 24‑hour format).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift pattern record.',
    CONSTRAINT pk_shift_pattern PRIMARY KEY(`shift_pattern_id`)
) COMMENT 'Master reference table for shift_pattern. Referenced by shift_pattern_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Primary key for training_course',
    `competency_id` BIGINT COMMENT 'Unique identifier for the competency record within the training course workforce entity.',
    `fab_facility_id` BIGINT COMMENT 'add column fab_facility_id (BIGINT) with FK to fabrication.fab_facility.fab_facility_id - training courses may be facility specific',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the owner org unit record within the training course workforce entity.',
    `primary_prerequisite_training_course_id` BIGINT COMMENT 'Self-referencing FK on training_course (prerequisite_training_course_id)',
    `skill_id` BIGINT COMMENT 'Unique identifier for the skill record within the training course workforce entity.',
    `training_prerequisite_course_id` BIGINT COMMENT 'Prerequisite course',
    `certification_flag` BOOLEAN COMMENT 'The certification flag of the training course record in the workforce domain.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether successful completion awards a certification.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost charged to the employee or department for the course.',
    `course_category` STRING COMMENT 'The course category of the training course record in the workforce domain.',
    `course_code` STRING COMMENT 'External catalog code used to reference the course in HR and LMS systems.',
    `course_description` STRING COMMENT 'The course description of the training course record in the workforce domain.',
    `course_name` STRING COMMENT 'Human‑readable name of the training course.',
    `course_status` STRING COMMENT 'The course status of the training course record in the workforce domain.',
    `course_type` STRING COMMENT 'Category of the course indicating its primary focus area.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the course record was first created in the system.',
    `credit_units` DECIMAL(18,2) COMMENT 'Number of credit units awarded upon successful completion.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost amount.',
    `delivery_method` STRING COMMENT 'Mode in which the course is delivered to participants.',
    `training_course_description` STRING COMMENT 'Detailed textual description of the course content and objectives.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time of the course expressed in hours.',
    `effective_end_date` DATE COMMENT 'Date after which the course is no longer offered (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment.',
    `export_control_relevant` BOOLEAN COMMENT 'The export control relevant of the training course record in the workforce domain.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator.',
    `is_active` BOOLEAN COMMENT 'The is active of the training course record in the workforce domain.',
    `is_mandatory` BOOLEAN COMMENT 'The is mandatory of the training course record in the workforce domain.',
    `language` STRING COMMENT 'Primary language in which the course material is delivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the training course record in the workforce domain.',
    `training_course_level` STRING COMMENT 'Complexity level of the course content.',
    `mandatory_flag` BOOLEAN COMMENT 'The mandatory flag of the training course record in the workforce domain.',
    `model_lineage_source` STRING COMMENT 'The model lineage source of the training course record in the workforce domain.',
    `passing_score` DECIMAL(18,2) COMMENT 'The passing score of the training course record in the workforce domain.',
    `prerequisite_courses` STRING COMMENT 'Comma‑separated list of course_codes that must be completed before enrolling.',
    `provider_name` STRING COMMENT 'The provider name of the training course record in the workforce domain.',
    `recertification_interval_months` STRING COMMENT 'The recertification interval months of the training course record in the workforce domain.',
    `recertification_period_months` STRING COMMENT 'Recertification period',
    `skill_tags` STRING COMMENT 'Semicolon‑separated skill identifiers associated with the course (e.g., lithography, python).',
    `target_audience` STRING COMMENT 'Intended employee groups or roles for the course (e.g., fab operators, engineers).',
    `training_course_status` STRING COMMENT 'Current lifecycle state of the course.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the course record.',
    `validity_months` STRING COMMENT 'The validity months of the training course record in the workforce domain.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master reference table for training_course. Referenced by course_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_current_position_id` FOREIGN KEY (`employee_current_position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_id` FOREIGN KEY (`job_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`job`(`job_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_job_id` FOREIGN KEY (`position_job_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`job`(`job_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_primary_position_org_unit_id` FOREIGN KEY (`primary_position_org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ADD CONSTRAINT `fk_workforce_workforce_qualification_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ADD CONSTRAINT `fk_workforce_workforce_qualification_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ADD CONSTRAINT `fk_workforce_workforce_qualification_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ADD CONSTRAINT `fk_workforce_workforce_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ADD CONSTRAINT `fk_workforce_workforce_qualification_workforce_employee_id` FOREIGN KEY (`workforce_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_shift_employee_id` FOREIGN KEY (`shift_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_shift_pattern_id` FOREIGN KEY (`shift_pattern_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_job_id` FOREIGN KEY (`job_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`job`(`job_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_talent_hiring_manager_employee_id` FOREIGN KEY (`talent_hiring_manager_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_talent_recruiter_employee_id` FOREIGN KEY (`talent_recruiter_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_approved_by_employee_id` FOREIGN KEY (`employment_approved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_org_unit_id` FOREIGN KEY (`employment_org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_position_id` FOREIGN KEY (`employment_position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_previous_org_unit_id` FOREIGN KEY (`employment_previous_org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_previous_position_id` FOREIGN KEY (`employment_previous_position_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_primary_employment_employee_id` FOREIGN KEY (`primary_employment_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_event_employee_id` FOREIGN KEY (`event_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_employee_id` FOREIGN KEY (`compensation_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_primary_compensation_employee_id` FOREIGN KEY (`primary_compensation_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_primary_compensation_plan_id` FOREIGN KEY (`primary_compensation_plan_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_to_employee_id` FOREIGN KEY (`to_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_time_approved_by_employee_id` FOREIGN KEY (`time_approved_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ADD CONSTRAINT `fk_workforce_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ADD CONSTRAINT `fk_workforce_training_primary_training_course_id` FOREIGN KEY (`primary_training_course_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ADD CONSTRAINT `fk_workforce_training_primary_training_employee_id` FOREIGN KEY (`primary_training_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ADD CONSTRAINT `fk_workforce_training_tertiary_training_trainer_employee_id` FOREIGN KEY (`tertiary_training_trainer_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ADD CONSTRAINT `fk_workforce_training_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_fab_assessor_employee_id` FOREIGN KEY (`fab_assessor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_primary_fab_employee_id` FOREIGN KEY (`primary_fab_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ADD CONSTRAINT `fk_workforce_fab_operator_qualification_tertiary_fab_operator_employee_id` FOREIGN KEY (`tertiary_fab_operator_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ADD CONSTRAINT `fk_workforce_site_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ADD CONSTRAINT `fk_workforce_site_assignment_primary_site_employee_id` FOREIGN KEY (`primary_site_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ADD CONSTRAINT `fk_workforce_site_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ADD CONSTRAINT `fk_workforce_contractor_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ADD CONSTRAINT `fk_workforce_contractor_engagement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ADD CONSTRAINT `fk_workforce_contractor_engagement_primary_contractor_employee_id` FOREIGN KEY (`primary_contractor_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ADD CONSTRAINT `fk_workforce_contractor_engagement_primary_org_unit_id` FOREIGN KEY (`primary_org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_primary_cleanroom_employee_id` FOREIGN KEY (`primary_cleanroom_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ADD CONSTRAINT `fk_workforce_cleanroom_access_to_employee_id` FOREIGN KEY (`to_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ADD CONSTRAINT `fk_workforce_export_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ADD CONSTRAINT `fk_workforce_export_control_primary_export_employee_id` FOREIGN KEY (`primary_export_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_safety_employee_id` FOREIGN KEY (`safety_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_safety_reported_by_employee_id` FOREIGN KEY (`safety_reported_by_employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ADD CONSTRAINT `fk_workforce_skill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ADD CONSTRAINT `fk_workforce_skill_parent_skill_id` FOREIGN KEY (`parent_skill_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ADD CONSTRAINT `fk_workforce_job_parent_job_id` FOREIGN KEY (`parent_job_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`job`(`job_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ADD CONSTRAINT `fk_workforce_job_primary_reports_to_job_id` FOREIGN KEY (`primary_reports_to_job_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`job`(`job_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ADD CONSTRAINT `fk_workforce_shift_pattern_rotated_from_shift_pattern_id` FOREIGN KEY (`rotated_from_shift_pattern_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`shift_pattern`(`shift_pattern_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_primary_prerequisite_training_course_id` FOREIGN KEY (`primary_prerequisite_training_course_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_training_prerequisite_course_id` FOREIGN KEY (`training_prerequisite_course_id`) REFERENCES `vibe_semiconductors_v1`.`workforce`.`training_course`(`training_course_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_semiconductors_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_current_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Identifier (MID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Home Address (HA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BAN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Certifications (CERT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level (SCL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `clearance_level` SET TAGS ('dbx_value_regex' = 'none|confidential|secret|top_secret');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount (CA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CCY)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DP)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status (DS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `ear_eligibility` SET TAGS ('dbx_business_glossary_term' = 'EAR Eligibility (EE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level (EL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address (WEM)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Status (ES)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|on_leave|retired');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (ET)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|contractor|intern|part_time|temporary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (FN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Legal Name (FLN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `itar_eligibility` SET TAGS ('dbx_business_glossary_term' = 'ITAR Eligibility (IE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (JT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency (LP)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (LN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Work Location (WL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National ID Number (NID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `org_unit` SET TAGS ('dbx_business_glossary_term' = 'Employee Org Unit');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `organization_level` SET TAGS ('dbx_business_glossary_term' = 'Organization Level (OL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility (OE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number (PN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Employee Position');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade (SG)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `security_clearance_expiration` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date (CED)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `skills` SET TAGS ('dbx_business_glossary_term' = 'Skills (SKL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag (UMF)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status (VS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'none|veteran|disabled_veteran');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift (WS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employee` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|flex');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `job_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Job Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_job_id` SET TAGS ('dbx_business_glossary_term' = 'Job Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `primary_position_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Exempt Classification');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `competency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Competency Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `compliance_training_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Education Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|contractor|part_time|temporary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `export_control_required` SET TAGS ('dbx_business_glossary_term' = 'Export Control Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full‑Time Equivalent (FTE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `headcount_filled` SET TAGS ('dbx_business_glossary_term' = 'Filled Headcount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `headcount_required` SET TAGS ('dbx_business_glossary_term' = 'Required Headcount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `is_remote_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `itar_access_required` SET TAGS ('dbx_business_glossary_term' = 'Itar Access Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_value_regex' = 'Fab Operations|Process Engineering|IC Design|EDA|Quality|Supply Chain');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `org_unit` SET TAGS ('dbx_business_glossary_term' = 'Position Org Unit');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'filled|vacant|pending|closed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'operational|design|support|management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `profile` SET TAGS ('dbx_business_glossary_term' = 'Profile');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `required_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `required_security_clearance` SET TAGS ('dbx_value_regex' = 'none|confidential|secret|top_secret');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `shift_required` SET TAGS ('dbx_business_glossary_term' = 'Shift Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Position Status Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `to_job_profile` SET TAGS ('dbx_business_glossary_term' = 'To Job Profile');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ORG_UNIT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit Identifier (PARENT_ORG_UNIT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Head Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BUDGET_AMOUNT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code (ORG_UNIT_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation (COMPLIANCE_REGULATION)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ITAR|EAR|RoHS|REACH|ISO9001|ISO14001');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|SGD');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level (DATA_CLASSIFICATION_LEVEL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description (ORG_UNIT_DESCRIPTION)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (EXTERNAL_REFERENCE_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area (FUNCTIONAL_AREA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount (HEADCOUNT_ACTUAL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount (HEADCOUNT_PLANNED)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HIERARCHY_LEVEL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `is_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Flag (IS_COST_CENTER)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Unit Flag (IS_GLOBAL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `is_profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Flag (IS_PROFIT_CENTER)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `is_shared_service` SET TAGS ('dbx_business_glossary_term' = 'Shared Service Flag (IS_SHARED_SERVICE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LOCATION_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name (ORG_UNIT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (OPERATING_HOURS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_chart_path` SET TAGS ('dbx_business_glossary_term' = 'Org Chart Path (ORG_CHART_PATH)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status (ORG_UNIT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type (ORG_UNIT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|cost_center|profit_center|function');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{5,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PROFIT_CENTER_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (TIME_ZONE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'Self-Assessment|Manager Review|Certification|Test|Simulation');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Valid|Expired|Pending|Revoked');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_status` SET TAGS ('dbx_business_glossary_term' = 'Competency Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_description` SET TAGS ('dbx_business_glossary_term' = 'Competency Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `export_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Export Control Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `last_assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessed Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'Novice|Practitioner|Expert|Master');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `proficiency_scale` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Scale');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `proficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Score');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `recertification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Period Months');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_attainment_date` SET TAGS ('dbx_business_glossary_term' = 'Skill Attainment Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Skill Change Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Skill Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_criticality` SET TAGS ('dbx_business_glossary_term' = 'Skill Criticality');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_criticality` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Skill Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Skill Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Skill Owner Department');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_owner_team` SET TAGS ('dbx_business_glossary_term' = 'Skill Owner Team');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_required_for_role` SET TAGS ('dbx_business_glossary_term' = 'Skill Required For Role');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_source_system` SET TAGS ('dbx_business_glossary_term' = 'Skill Source System');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_source_system` SET TAGS ('dbx_value_regex' = 'Workday HCM|Internal Skill DB');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_training_hours` SET TAGS ('dbx_business_glossary_term' = 'Skill Training Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_training_method` SET TAGS ('dbx_business_glossary_term' = 'Skill Training Method');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_training_method` SET TAGS ('dbx_value_regex' = 'On-the-Job|Classroom|Online|Workshop');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_validated_by` SET TAGS ('dbx_business_glossary_term' = 'Skill Validation By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Skill Validation Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`competency` ALTER COLUMN `skill_version` SET TAGS ('dbx_business_glossary_term' = 'Skill Version');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|internal');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certified_date` SET TAGS ('dbx_business_glossary_term' = 'Certified Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_qualification_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Granted Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|IEEE|IATF16949|ISO9001|internal');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `last_updated` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`workforce_qualification` ALTER COLUMN `workforce_qualification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site ID (FSID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID (EID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern ID (SPI)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Code (SAC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Timestamp (AET)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_schedule` SET TAGS ('dbx_business_glossary_term' = 'Break Schedule (BS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp (SET)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes (AN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_authorized` SET TAGS ('dbx_business_glossary_term' = 'Overtime Authorized (OA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours (OT_H)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `rotation_group` SET TAGS ('dbx_business_glossary_term' = 'Rotation Group');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Status (SAS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|cancelled|pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type (ST)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'Day|Swing|Night|12h_Continental|4on4off');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp (SST)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_area` SET TAGS ('dbx_business_glossary_term' = 'Work Area (WA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_area` SET TAGS ('dbx_value_regex' = 'FEOL|BEOL|Metrology|Packaging|R&D');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Acquisition Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `job_id` SET TAGS ('dbx_business_glossary_term' = 'Job Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID (LOCID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Project ID (NREPID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID (JPID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID (HMID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID (DEPTID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `application_stage` SET TAGS ('dbx_business_glossary_term' = 'Application Stage');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BUDG_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_count` SET TAGS ('dbx_business_glossary_term' = 'Candidate Count');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Timestamp (CLS_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMP_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_acquisition_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description (DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `export_control_required` SET TAGS ('dbx_business_glossary_term' = 'Export Control Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `headcount_filled` SET TAGS ('dbx_business_glossary_term' = 'Headcount Filled (HC_FILLED)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `headcount_requested` SET TAGS ('dbx_business_glossary_term' = 'Headcount Requested (HC_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `interview_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Count');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Position Flag (CONF)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `job_profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name (JPNAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPD_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_extended_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Posted Timestamp (POST_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIO)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type (TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_headcount|backfill|contractor');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel (SRC_CHAN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'internal|referral|recruiter|job_board|social_media|agency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status (STAT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_acquisition_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled|filled|on_hold');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `target_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target End Date (END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date (START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (TITLE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`talent_acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'New Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'New Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_previous_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employment_previous_position_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Position Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Event Comments');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `employee` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Employee');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'New Compensation Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_location` SET TAGS ('dbx_business_glossary_term' = 'New Work Location');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_organization` SET TAGS ('dbx_business_glossary_term' = 'New Organization Unit');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `new_position` SET TAGS ('dbx_business_glossary_term' = 'New Position Title');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Previous Compensation Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_location` SET TAGS ('dbx_business_glossary_term' = 'Previous Work Location');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_organization` SET TAGS ('dbx_business_glossary_term' = 'Previous Organization Unit');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `previous_position` SET TAGS ('dbx_business_glossary_term' = 'Previous Position Title');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`employment_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID (CPI)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'To Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Compensation Amount (BCA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_compensation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount (BA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage (BTP)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Reason (CCR)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status (CS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|draft');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type (CT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|bonus|equity|variable|shift_differential');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employee` SET TAGS ('dbx_business_glossary_term' = 'Compensation Employee');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (ET)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temp|intern');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Amount (EGA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_grant_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_grant_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_grant_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligibility (EGE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Value');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `health_insurance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Eligibility (HIE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `health_insurance_eligibility` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `health_insurance_eligibility` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Compensation (ICC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (JT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name (CPN)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `nre_project_code` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering Project Code (NREPC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility (OTE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier (ORM)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency (PF)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|annually|quarterly');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade (PG)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `payroll_group` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group (PG)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `retirement_plan_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Eligibility (RPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Date (CRD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `salary_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_compensation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount (SDA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type (ST)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'night|weekend|holiday|flex|standard');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TEF)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag (UMF)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_actual` SET TAGS ('dbx_business_glossary_term' = 'Variable Compensation Actual (VCA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_actual` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_target` SET TAGS ('dbx_business_glossary_term' = 'Variable Compensation Target (VCT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `variable_compensation_target` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_value_regex' = 'none|vacation|sick|fmla|parental|military');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'unbilled|billed|invoiced');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_time` SET TAGS ('dbx_business_glossary_term' = 'Clock In Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑In Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_time` SET TAGS ('dbx_business_glossary_term' = 'Clock Out Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑Out Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_source` SET TAGS ('dbx_business_glossary_term' = 'Entry Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_source` SET TAGS ('dbx_value_regex' = 'manual|system|mobile');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Amount (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category (LAB_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'production|engineering|support|maintenance|admin|other');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_grade` SET TAGS ('dbx_business_glossary_term' = 'Labor Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_grade` SET TAGS ('dbx_value_regex' = 'G1|G2|G3|G4|G5|G6');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (USD per hour)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PRJ_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `scheduled_shift_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `scheduled_shift_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'regular|absence|adjustment');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`time_entry` ALTER COLUMN `work_order_code` SET TAGS ('dbx_business_glossary_term' = 'Work Order Code (WO_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `primary_training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `assessment_max_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Maximum Score');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `assessment_pass_threshold` SET TAGS ('dbx_business_glossary_term' = 'Assessment Pass Threshold');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'Quiz|Practical|Exam');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'Technical|Process|Safety|Leadership|Compliance|Quality');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'ITAR|ISO9001|IATF16949|None');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'Online|In-Person|Hybrid|On-The-Job');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Result');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Incomplete');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_value_regex' = 'Annual|Biennial|None');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'Enrolled|InProgress|Completed|Cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_operator_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Operator Qualification ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID (EQUIP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID (LOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `primary_fab_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID (EMP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `primary_fab_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `primary_fab_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `tertiary_fab_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Fab Operator Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `tertiary_fab_operator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `tertiary_fab_operator_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `tertiary_fab_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `tertiary_fab_operator_employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `certification_document_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Document Name (CERT_DOC_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `certified_by` SET TAGS ('dbx_business_glossary_term' = 'Certified By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (COMPLIANCE_REG)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ISO9001|ITAR|EAR|RoHS|REACH');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `equipment_group_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Group Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name (EQUIP_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `fab_qualified_operator` SET TAGS ('dbx_business_glossary_term' = 'Fab Qualified Operator');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `last_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Requalification Date (LAST_REQUAL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (QUAL_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `process_step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code (PROC_STEP_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `process_step_description` SET TAGS ('dbx_business_glossary_term' = 'Process Step Description (PROC_STEP_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code (QUAL_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QUAL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level (QUAL_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_level` SET TAGS ('dbx_value_regex' = 'trainee|qualified|senior_qualified');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name (QUAL_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualification_validity_years` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validity (YEARS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualified Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `quinary_fab_qual_employee` SET TAGS ('dbx_business_glossary_term' = 'Quinary Fab Qual Employee');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `related_competency` SET TAGS ('dbx_business_glossary_term' = 'Related Competency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date (REQUAL_DUE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `shift_qualification` SET TAGS ('dbx_business_glossary_term' = 'Shift Qualification (SHIFT_QUAL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `shift_qualification` SET TAGS ('dbx_value_regex' = 'day|night|both');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category (SKILL_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Flag (SUSPENDED)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason (SUSP_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours (TRAIN_HRS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `site_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Site Assignment Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `primary_site_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `primary_site_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `primary_site_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `access_card_number` SET TAGS ('dbx_business_glossary_term' = 'Access Card ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `access_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `access_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Assignment Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|project_based');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `cleanroom_access_level` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Access Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `cleanroom_access_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|none');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `compliance_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `compliance_training_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `is_primary_site` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Site');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `payroll_grade` SET TAGS ('dbx_business_glossary_term' = 'Payroll Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `primary_site_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Site Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `remote_work_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Allowed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `safety_induction_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Completed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `safety_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `site_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `site_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`site_assignment` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Engagement ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `primary_contractor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `primary_contractor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `primary_contractor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `primary_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name (AGENCY_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status (BG_CHECK_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate (BILLING_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `billing_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `cleanroom_access_authorization` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Access Authorization (CLEANROOM_AUTH)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `cleanroom_access_authorization` SET TAGS ('dbx_value_regex' = 'granted|pending|denied');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMPLIANCE_NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp (EFFECTIVE_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (END_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_manager` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager (CONTRACT_MANAGER)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CONTRACT_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (START_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status (CONTRACT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_address` SET TAGS ('dbx_business_glossary_term' = 'Contractor Address (CONTRACTOR_ADDRESS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_email` SET TAGS ('dbx_business_glossary_term' = 'Contractor Email Address (CONTRACTOR_EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Contractor Engagement Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full Name (CONTRACTOR_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_phone` SET TAGS ('dbx_business_glossary_term' = 'Contractor Phone Number (CONTRACTOR_PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_type` SET TAGS ('dbx_business_glossary_term' = 'Contractor Type (CONTRACTOR_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `contractor_type` SET TAGS ('dbx_value_regex' = 'individual|organization');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type (ENGAGEMENT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'staff_augmentation|sow_based|managed_service');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `export_control_cleared` SET TAGS ('dbx_business_glossary_term' = 'Export Control Cleared');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Screening Status (EXPORT_CONTROL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `fab_site` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site (FAB_SITE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `headcount_classification` SET TAGS ('dbx_business_glossary_term' = 'Headcount Classification (HEADCOUNT_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `headcount_classification` SET TAGS ('dbx_value_regex' = 'on_balance_sheet|off_balance_sheet');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Frequency (INVOICE_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `is_ear_contract` SET TAGS ('dbx_business_glossary_term' = 'Is EAR Contract (EAR_CONTRACT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `is_it_ar_contract` SET TAGS ('dbx_business_glossary_term' = 'Is ITAR Contract (ITAR_CONTRACT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `max_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Max Hours Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `nda_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Nda Signed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `nda_status` SET TAGS ('dbx_business_glossary_term' = 'NDA Status (NDA_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `nda_status` SET TAGS ('dbx_value_regex' = 'signed|pending|exempt|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RENEWAL_OPTION)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score (RISK_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERMINATION_REASON)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TOTAL_VALUE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`contractor_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_access_id` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Access Record ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `primary_cleanroom_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `primary_cleanroom_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `primary_cleanroom_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'To Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `access_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `access_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'Level 1|Level 2|Level 3|Level 4');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_access_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_employee` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Employee');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `cleanroom_zone` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Zone');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `ehs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'EHS Clearance Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Expiry Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `export_control_category` SET TAGS ('dbx_business_glossary_term' = 'Export Control Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `export_control_category` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `fab_area` SET TAGS ('dbx_business_glossary_term' = 'Fab Area');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `foreign_national` SET TAGS ('dbx_business_glossary_term' = 'Foreign National Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `foreign_national` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `foreign_national` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `gowning_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Gowning Certification Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `gowning_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Gowning Certification Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `gowning_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Gowning Certification Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `gowning_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gowning Qualified Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `granted_date` SET TAGS ('dbx_business_glossary_term' = 'Granted Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Temporary Access Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `medical_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `medical_clearance_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `medical_clearance_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Access Record Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Associated Project Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Gowning Qualification Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'Qualified|Not Qualified|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `safety_induction_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Completed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Zone');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`cleanroom_access` ALTER COLUMN `zone` SET TAGS ('dbx_value_regex' = 'FEOL|BEOL|MOL|Metrology|Packaging');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `export_control_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `export_technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `primary_export_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `primary_export_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `primary_export_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Access Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `authorized_technology_areas` SET TAGS ('dbx_business_glossary_term' = 'Authorized Technology Areas (TECH_AREAS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `authorized_technology_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorized Technology Scope');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `citizenship_country` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Country');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `citizenship_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `citizenship_country` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (ECC)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'US_Person|Foreign_National|Deemed_Export_Risk');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `deemed_export_authorization` SET TAGS ('dbx_business_glossary_term' = 'Deemed Export Authorization');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `deemed_export_flag` SET TAGS ('dbx_business_glossary_term' = 'Deemed Export Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `deemed_export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Deemed Export License Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `ear_eligible` SET TAGS ('dbx_business_glossary_term' = 'Ear Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `ear_license_required` SET TAGS ('dbx_business_glossary_term' = 'EAR License Required Flag (EAR_LICENSE_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `ear_license_status` SET TAGS ('dbx_business_glossary_term' = 'EAR License Status (EAR_LICENSE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `ear_license_status` SET TAGS ('dbx_value_regex' = 'Licensed|Not_Licensed|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Eccn Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_phone` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number (PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `employee_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `itar_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'ITAR Authorization Status (ITAR_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `itar_authorization_status` SET TAGS ('dbx_value_regex' = 'Authorized|Not_Authorized|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `itar_eligible` SET TAGS ('dbx_business_glossary_term' = 'Itar Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (NAT)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `periodic_rescreening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Rescreening Due Date (RESCREEN_DUE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `restricted_technology_list` SET TAGS ('dbx_business_glossary_term' = 'Restricted Technology List');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Screening Conducted By (CONDUCTED_BY)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date (SCREEN_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_outcome` SET TAGS ('dbx_business_glossary_term' = 'Screening Outcome (OUTCOME)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Conditional|Pending');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `technology_access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Technology Access Restrictions (TECH_RESTRICTION)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type (VISA)');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`export_control` ALTER COLUMN `visa_type` SET TAGS ('dbx_value_regex' = 'H1B|L1|O1|TN|E3|Other');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Event Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `fab_site_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Employee ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `chemical_involved` SET TAGS ('dbx_business_glossary_term' = 'Chemical Involved');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `cleanroom_zone` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Zone');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `safety_event_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `exposure_chemical` SET TAGS ('dbx_business_glossary_term' = 'Exposure Chemical');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `exposure_level` SET TAGS ('dbx_business_glossary_term' = 'Exposure Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `exposure_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|unknown');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|closed|reopened');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'chemical_exposure|ergonomic_injury|electrical_hazard|slip_fall|near_miss|other');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `injury_body_part` SET TAGS ('dbx_business_glossary_term' = 'Injury Body Part');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `investigation_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `lost_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `lost_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Provided');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `near_miss_flag` SET TAGS ('dbx_business_glossary_term' = 'Near Miss Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|completed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'first_aid|recordable|lost_time|fatality');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`safety_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Compensation Plan Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Multiplier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_pii_compensation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percent');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_pii_compensation' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percent` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_grade` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Max Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `max_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `max_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Min Salary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `min_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `min_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_scope` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Max');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Min');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`compensation_plan` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `parent_skill_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Skill Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `parent_skill_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Skill Domain');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `export_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Export Control Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `family` SET TAGS ('dbx_business_glossary_term' = 'Skill Family');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `is_core_skill` SET TAGS ('dbx_business_glossary_term' = 'Is Core Skill');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `proficiency_scale` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Scale');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_group` SET TAGS ('dbx_business_glossary_term' = 'Skill Group');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `skill_type` SET TAGS ('dbx_business_glossary_term' = 'Skill Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`skill` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Skill Version');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_id` SET TAGS ('dbx_business_glossary_term' = 'Job Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `parent_job_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Job Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `parent_job_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `primary_reports_to_job_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `benefits` SET TAGS ('dbx_business_glossary_term' = 'Job Benefits');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `cleanroom_access_required` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Access Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `compensation_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `compensation_band` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `compensation_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Education Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Eeo Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Exempt Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `experience_requirement` SET TAGS ('dbx_business_glossary_term' = 'Experience Requirement');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `export_control_required` SET TAGS ('dbx_business_glossary_term' = 'Export Control Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Flsa Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `internal_job_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Job Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `is_manager` SET TAGS ('dbx_business_glossary_term' = 'Is Manager');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `minimum_education` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `opening_number` SET TAGS ('dbx_business_glossary_term' = 'Job Opening Number');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `remote_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Allowed');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `requirements` SET TAGS ('dbx_business_glossary_term' = 'Job Requirements');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Job Responsibilities');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Max');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Min');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `shift_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `skill_set` SET TAGS ('dbx_business_glossary_term' = 'Skill Set');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Job Summary');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `travel_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`job` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotated_from_shift_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Rotated From Shift Pattern Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotated_from_shift_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `cycle_length_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Length Days');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `days_off` SET TAGS ('dbx_business_glossary_term' = 'Days Off');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `days_on` SET TAGS ('dbx_business_glossary_term' = 'Days On');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `hours_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Shift');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `night_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Night Shift Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Pattern Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `pattern_description` SET TAGS ('dbx_business_glossary_term' = 'Pattern Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `pattern_name` SET TAGS ('dbx_business_glossary_term' = 'Pattern Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `pattern_status` SET TAGS ('dbx_business_glossary_term' = 'Pattern Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotation_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `rotation_type` SET TAGS ('dbx_business_glossary_term' = 'Rotation Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`shift_pattern` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'operational_compliance');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `primary_prerequisite_training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Training Course Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `primary_prerequisite_training_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `training_prerequisite_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Id');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `credit_units` SET TAGS ('dbx_business_glossary_term' = 'Credit Units');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `export_control_relevant` SET TAGS ('dbx_business_glossary_term' = 'Export Control Relevant');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_level` SET TAGS ('dbx_business_glossary_term' = 'Level');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `model_lineage_source` SET TAGS ('dbx_business_glossary_term' = 'Model Lineage Source');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `recertification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval Months');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `recertification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Period Months');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `skill_tags` SET TAGS ('dbx_business_glossary_term' = 'Skill Tags');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`workforce`.`training_course` ALTER COLUMN `validity_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Months');
